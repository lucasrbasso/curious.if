import { BadRequestException, Body, Controller, Post } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  async register(
    @Body() registerRequest: { username: string; password: string; email: string, name: string},
  ) {
    return await this.authService.registerUser(registerRequest);
  }

  @Post('login')
  async login(@Body() authenticateRequest: { username: string; password: string }) {
    try {
      return await this.authService.authenticateUser(authenticateRequest);
    } catch (e) {
      throw new BadRequestException(e.message);
    }
  }
}
