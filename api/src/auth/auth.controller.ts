import { Controller, Request, Post, UseGuards } from '@nestjs/common';
import { LocalAuthGuard } from './local-auth.guard';
import { AuthService } from './auth.service';
import { ApiTags } from '@nestjs/swagger';

interface RequestProps {
  user: {
    id: string;
    name: string;
    email: string;
    roles: string[];
    permissions: string[];
    isValidated: boolean;
  };
}

@ApiTags('Login')
@Controller('api/auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @UseGuards(LocalAuthGuard)
  @Post('/login')
  async login(@Request() req: RequestProps) {
    return this.authService.login(req.user);
  }
}
