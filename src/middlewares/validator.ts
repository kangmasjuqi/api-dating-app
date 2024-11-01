import { Request, Response, NextFunction } from 'express';

export const validateSignup = (req: Request, res: Response, next: NextFunction) => {
  const { name, email, password, gender, label } = req.body;
  
  if (!name || !email || !password || !gender) {
    return res.status(400).json({
      status: 'error',
      message: 'Missing required fields'
    });
  }

  if (!['Male', 'Female', 'Other'].includes(gender)) {
    return res.status(400).json({
      status: 'error',
      message: 'Invalid gender value'
    });
  }

  if (label && typeof label !== 'string') {
    return res.status(400).json({
      status: 'error',
      message: 'Label must be a string'
    });
  }

  if (label && label.length > 20) {
    return res.status(400).json({
      status: 'error',
      message: 'Label must not exceed 20 characters'
    });
  }

  next();
};

export const validateLogin = (req: Request, res: Response, next: NextFunction) => {
  const { email, password } = req.body;
  
  if (!email || !password) {
    return res.status(400).json({
      status: 'error',
      message: 'Email and password are required'
    });
  }

  next();
};

export const validateSwipe = (req: Request, res: Response, next: NextFunction) => {
  const { action } = req.body;
  
  if (!action || !['like', 'pass'].includes(action)) {
    return res.status(400).json({
      status: 'error',
      message: 'Invalid swipe action'
    });
  }

  next();
};

export const validatePackagePurchase = (req: Request, res: Response, next: NextFunction) => {
  const packageId = parseInt(req.params.packageId);
  
  if (!packageId || isNaN(packageId)) {
      return res.status(400).json({
          status: 'error',
          message: 'Invalid package ID'
      });
  }

  next();
};