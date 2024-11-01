import pool from '../config/database';
import bcrypt from 'bcrypt';
import jwt from 'jsonwebtoken';
import { User, SignupData, LoginCredentials } from '../types';

const JWT_SECRET = 'db58c33b2210bbbd1e897fab94828011668602d8680b539b05096752e81511b02a49b7659a8471159367f46dfdbab20b86d8774283ce4b098b202de5131e8d8e';

export class UserService {
  async signup(data: SignupData): Promise<{ token: string }> {
    const [existingUsers] = await pool.execute(
      'SELECT id FROM users WHERE email = ?',
      [data.email]
    );

    if ((existingUsers as any[]).length > 0) {
      throw new Error('Email already exists');
    }

    const hashedPassword = await bcrypt.hash(data.password, 10);
    
    const [result] = await pool.execute(
      'INSERT INTO users (name, email, password, gender, label) VALUES (?, ?, ?, ?, ?)',
      [data.name, data.email, hashedPassword, data.gender, data.label || null]
    );

    const userId = (result as any).insertId;
    const token = jwt.sign({ id: userId, email: data.email }, JWT_SECRET);
    
    return { token };
  }

  async login(credentials: LoginCredentials): Promise<{ token: string }> {
    const [users] = await pool.execute(
      'SELECT * FROM users WHERE email = ?',
      [credentials.email]
    );

    const user = (users as any[])[0];
    if (!user) {
      throw new Error('Invalid credentials');
    }

    const validPassword = await bcrypt.compare(credentials.password, user.password);
    if (!validPassword) {
      throw new Error('Invalid credentials');
    }

    const token = jwt.sign(
      { id: user.id, email: user.email },
      JWT_SECRET
    );

    return { token };
  }

  async getPotentialMatches(userId: number): Promise<User[]> {
    const today = new Date().toISOString().split('T')[0];
    
    // First, get the user's gender
    const [userResult] = await pool.execute(
      'SELECT gender FROM users WHERE id = ?',
      [userId]
    );

    if ((userResult as any[]).length === 0) {
      throw new Error('User not found');
    }

    const userGender = (userResult as any[])[0].gender;
    
    // Get count of today's swipes
    const [swipeCount] = await pool.execute(
      `SELECT COUNT(*) as count FROM user_swipes 
       WHERE user_id = ? AND DATE(created_at) = ?`,
      [userId, today]
    );

    if ((swipeCount as any[])[0].count >= 10) {
      throw new Error('Daily swipe limit reached');
    }

    // Get opposite gender users not yet swiped today
    const [users] = await pool.execute(
      `SELECT id, name, gender, label, created_at, updated_at 
       FROM users 
       WHERE id != ? 
       AND gender = ?
       AND id NOT IN (
         SELECT target_user_id 
         FROM user_swipes 
         WHERE user_id = ? AND DATE(created_at) = ?
       )
       ORDER BY RAND()
       LIMIT 10`,
      [
        userId,
        userGender === 'Male' ? 'Female' : 'Male',
        userId,
        today
      ]
    );

    return users as User[];
  }

  async swipe(
    userId: number,
    targetUserId: number,
    action: 'like' | 'pass'
  ): Promise<void> {
    const today = new Date().toISOString().split('T')[0];
    
    // Check daily limit
    const [swipeCount] = await pool.execute(
      `SELECT COUNT(*) as count FROM user_swipes 
       WHERE user_id = ? AND DATE(created_at) = ?`,
      [userId, today]
    );

    if ((swipeCount as any[])[0].count >= 10) {
      throw new Error('Daily swipe limit reached');
    }

    // Check if already swiped
    const [existingSwipe] = await pool.execute(
      'SELECT id FROM user_swipes WHERE user_id = ? AND target_user_id = ?',
      [userId, targetUserId]
    );

    if ((existingSwipe as any[]).length > 0) {
      throw new Error('Already swiped on this user');
    }

    // Record swipe
    await pool.execute(
      'INSERT INTO user_swipes (user_id, target_user_id, action) VALUES (?, ?, ?)',
      [userId, targetUserId, action]
    );
  }
}