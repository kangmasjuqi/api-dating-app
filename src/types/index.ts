export interface User {
    id: number;
    name: string;
    email: string;
    gender: 'Male' | 'Female' | 'Other';
    label?: string;  // Optional label field
    created_at: Date;
    updated_at: Date;
}

export interface UserSwipe {
    id: number;
    user_id: number;
    target_user_id: number;
    action: 'like' | 'pass';
    created_at: Date;
}

export interface LoginCredentials {
    email: string;
    password: string;
}

export interface SignupData {
    name: string;
    email: string;
    password: string;
    gender: 'Male' | 'Female' | 'Other';
    label?: string;  // Optional label field
}

export interface PremiumPackage {
    id: number;
    name: string;
    description?: string;
    price: number;
    benefits: string[];
    created_at: Date;
    updated_at: Date;
}

export interface UserPremiumPackage {
    id: number;
    user_id: number;
    package_id: number;
    purchased_at: Date;
    expires_at: Date;
}
export interface ExtendedUser extends User {
    premium_packages?: UserPremiumPackage[];
}