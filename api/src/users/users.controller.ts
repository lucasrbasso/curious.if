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
  Patch,
} from '@nestjs/common';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { CreateUserDTO } from './dto/createUserDTO';
import { GetUserDTO } from './dto/getUserDTO';
import { UpdateUserDTO } from './dto/updateUserDTO';
import { Permission } from './permissions/permission.enum';
import { Permissions } from './permissions/permissions.decorator';
import { PermissionsGuard } from './permissions/permissions.guard';
import { Role } from './roles/role.enum';
import { RolesGuard } from './roles/role.guard';
import { Roles } from './roles/roles.decorator';
import { UsersService } from './users.service';

interface RequestProps {
  user: {
    userId: string;
    email: string;
  };
}

interface ValidateUserParams {
  isValid: boolean;
  id: string;
}

@Controller('api/users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin, Role.Mod)
  @Get()
  async getAllUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllUsers();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin, Role.Mod)
  @Get('/pending')
  async getAllPendingUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllPendingUsers();
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Get('/me')
  async getUserById(@Request() req: RequestProps): Promise<GetUserDTO> {
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

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin, Role.Mod)
  @Patch('/:id')
  async validateUser(
    @Body() { id, isValid }: ValidateUserParams,
  ): Promise<GetUserDTO> {
    return this.usersService.validateUser(id, isValid);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.usersService.deleteUser(id);
  }
}
