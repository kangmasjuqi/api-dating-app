import { Request, Response } from 'express';
import { UserService } from '../services/userService';
import { AuthRequest } from '../middlewares/auth';

export class UserController {
  private userService: UserService;

  constructor() {
    this.userService = new UserService();
  }

  async signup(req: Request, res: Response) {
    try {
      const token = await this.userService.signup(req.body);
      res.json(token);
    } catch (error) {
      res.status(400).json({ message: (error as Error).message });
    }
  }

  async login(req: Request, res: Response) {
    try {
      const token = await this.userService.login(req.body);
      res.json(token);
    } catch (error) {
      res.status(401).json({ message: (error as Error).message });
    }
  }

  async getPotentialMatches(req: AuthRequest, res: Response) {
    try {
      const users = await this.userService.getPotentialMatches(req.user!.id);
      res.json(users);
    } catch (error) {
      res.status(400).json({ message: (error as Error).message });
    }
  }

  async swipe(req: AuthRequest, res: Response) {
    try {
      await this.userService.swipe(
        req.user!.id,
        parseInt(req.params.userId),
        req.body.action
      );
      res.json({ message: 'Swipe recorded successfully' });
    } catch (error) {
      res.status(400).json({ message: (error as Error).message });
    }
  }

  async getPremiumPackages(req: Request, res: Response) {
      try {
          const packages = await this.userService.getPremiumPackages();
          res.json(packages);
      } catch (error) {
          res.status(400).json({ message: (error as Error).message });
      }
  }

  async purchasePackage(req: AuthRequest, res: Response) {
      try {
          const packageId = parseInt(req.params.packageId);
          const purchase = await this.userService.purchasePackage(
              req.user!.id, 
              packageId
          );
          res.json(purchase);
      } catch (error) {
          res.status(400).json({ message: (error as Error).message });
      }
  }
}