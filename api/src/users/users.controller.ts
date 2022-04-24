import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  Put,
  UseGuards,
  Request,
} from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { CreateUserDTO } from './dto/createUserDTO';
import { GetUserDTO } from './dto/getUserDTO';
import { UpdateUserDTO } from './dto/updateUserDTO';
import { UsersService } from './users.service';

interface RequestProps {
  user: {
    userId: string;
    email: string;
  };
}
@Controller('api/users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @UseGuards(JwtAuthGuard)
  @Get()
  async getAllUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllUsers();
  }

  @UseGuards(JwtAuthGuard)
  @Get('/me')
  async getUserById(@Request() req: RequestProps): Promise<GetUserDTO> {
    console.log(req);
    return this.usersService.getUserById(req.user.userId);
  }

  @Post()
  async createUser(@Body() createUserDTO: CreateUserDTO): Promise<GetUserDTO> {
    return this.usersService.createUser(createUserDTO);
  }

  @UseGuards(JwtAuthGuard)
  @Put('/:id')
  async updateUser(@Body() updateUserDto: UpdateUserDTO): Promise<GetUserDTO> {
    return this.usersService.updateUser(updateUserDto);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.usersService.deleteUser(id);
  }
}
