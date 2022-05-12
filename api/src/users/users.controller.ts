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
import { ApiOperation, ApiTags } from '@nestjs/swagger';
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

@ApiTags('Users')
@Controller('api/users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @UseGuards(JwtAuthGuard)
  @Get()
  @ApiOperation({ summary: 'Retorna todos os Usuários' })
  async getAllUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllUsers();
  }

  @UseGuards(JwtAuthGuard)
  @Get('/me')
  @ApiOperation({ summary: 'Retorna Usuário conectado' })
  async getUserById(@Request() req: RequestProps): Promise<GetUserDTO> {
    return this.usersService.getUserById(req.user.userId);
  }

  @Post()
  @ApiOperation({ summary: 'Cria Usuário' })
  async createUser(@Body() createUserDTO: CreateUserDTO): Promise<GetUserDTO> {
    return this.usersService.createUser(createUserDTO);
  }

  @UseGuards(JwtAuthGuard)
  @Put('/:id')
  @ApiOperation({ summary: 'Atualiza informações do Usuário' })
  async updateUser(@Body() updateUserDTO: UpdateUserDTO): Promise<GetUserDTO> {
    return this.usersService.updateUser(updateUserDTO);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('/:id')
  @ApiOperation({ summary: 'Deleta Usuário por ID' })
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.usersService.deleteUser(id);
  }
}
