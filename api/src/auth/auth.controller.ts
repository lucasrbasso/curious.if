import { Controller, Request, Post, UseGuards } from '@nestjs/common';
import { LocalAuthGuard } from './local-auth.guard';
import { AuthService } from './auth.service';
import { ApiTags } from '@nestjs/swagger';

interface RequestProps {
  user: {
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
  };
}

@ApiTags('Login')
@Controller('/auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @UseGuards(LocalAuthGuard)
  @Post('/login')
  async login(@Request() req: RequestProps) {
    return this.authService.login(req.user);
  }
}
