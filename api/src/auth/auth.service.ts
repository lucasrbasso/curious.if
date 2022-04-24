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
  email: string;
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

    console.log(user);

    if (user) {
      const checkCredentials = await bcrypt.compare(pass, user.password);

      if (checkCredentials) {
        const { password, ...result } = user;

        return result;
      }
    }
    return null;
  }

  async login(user: RequestUserProps) {
    console.log(user);
    const payload = { email: user.email, sub: user.id };
    return {
      access_token: this.jwtService.sign(payload),
    };
  }
}
