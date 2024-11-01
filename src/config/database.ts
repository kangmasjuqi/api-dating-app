import mysql from 'mysql2/promise';

const pool = mysql.createPool({
  host: 'localhost',
  user: 'root',
  password: 'Marjuqi2024$',
  database: 'api_dating_app',
  waitForConnections: true,
  connectionLimit: 10,
});

export default pool;