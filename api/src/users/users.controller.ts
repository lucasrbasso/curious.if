import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  Put,
} from '@nestjs/common';
import { CreateUserDTO } from './dto/createUserDTO';
import { GetUserDTO } from './dto/getUserDTO';
import { UpdateUserDTO } from './dto/updateUserDTO';
import { UsersService } from './users.service';

@Controller('api/users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Get()
  async getAllUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllUsers();
  }

  @Get('/:id')
  async getUserById(@Param('id') id: string): Promise<GetUserDTO> {
    return this.usersService.getUserById(id);
  }

  @Post()
  async createUser(@Body() createUserDTO: CreateUserDTO): Promise<GetUserDTO> {
    return this.usersService.createUser(createUserDTO);
  }

  @Put('/:id')
  async updateUser(@Body() updateUserDto: UpdateUserDTO): Promise<GetUserDTO> {
    return this.usersService.updateUser(updateUserDto);
  }

  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.usersService.deleteUser(id);
  }
}
