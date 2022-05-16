import { Injectable } from '@nestjs/common';
import { User } from '@prisma/client';
import * as bcrypt from 'bcrypt';
import { UsersService } from '../users/users.service';
import { JwtService } from '@nestjs/jwt';

interface AuthProps {
  email: string;
  pass: string;
}

interface RequestUserProps {
  id: string;
<<<<<<< HEAD
  name: string;
  email: string;
  roles: string[];
  permissions: string[];
  isValidated: boolean;
=======
  email: string;
>>>>>>> 8a92927b268ada7b14101e1c4b3f59ca279180ca
}

@Injectable()
export class AuthService {
  constructor(
    private usersService: UsersService,
    private jwtService: JwtService,
  ) {}

  async validateUser({
    email,
    pass,
  }: AuthProps): Promise<Omit<User, 'password'> | null> {
    const user = await this.usersService.getUserByEmail(email);

    if (user) {
      const checkCredentials = await bcrypt.compare(pass, user.password);

      if (checkCredentials) {
<<<<<<< HEAD
        const { ...result } = user;
=======
        const { password, ...result } = user;
>>>>>>> 8a92927b268ada7b14101e1c4b3f59ca279180ca

        return result;
      }
    }
    return null;
  }

  async login(user: RequestUserProps) {
<<<<<<< HEAD
    const payload = {
      email: user.email,
      sub: user.id,
      roles: user.roles,
      permissions: user.permissions,
    };

    const userReturn = {
      id: user.id,
      name: user.name,
      email: user.email,
      sub: user.id,
      roles: user.roles,
      permissions: user.permissions,
      isValidated: user.isValidated,
    };

    return {
      ...userReturn,
=======
    const payload = { email: user.email, sub: user.id };
    return {
>>>>>>> 8a92927b268ada7b14101e1c4b3f59ca279180ca
      access_token: this.jwtService.sign(payload),
    };
  }
}
