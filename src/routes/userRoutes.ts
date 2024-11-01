import { Router } from 'express';
import { UserController } from '../controllers/userController';
import { authenticate } from '../middlewares/auth';
import { validateSignup, validateLogin, validateSwipe } from '../middlewares/validator';

const router = Router();
const userController = new UserController();

// Auth routes
router.post('/signup', validateSignup, userController.signup.bind(userController));
router.post('/login', validateLogin, userController.login.bind(userController));

// Protected routes
router.get(
  '/matches',
  authenticate,
  userController.getPotentialMatches.bind(userController)
);
router.post(
  '/swipe/:userId',
  authenticate,
  validateSwipe,
  userController.swipe.bind(userController)
);

export default router;