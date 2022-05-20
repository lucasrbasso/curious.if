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
import { ApiOperation, ApiTags } from '@nestjs/swagger';
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

interface UpdateRolesAndPermissions {
  roles: string[];
  permissions: string[];
}

@ApiTags('Users')
@Controller('api/users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin, Role.Mod)
  @Get()
  @ApiOperation({ summary: 'Retorna todos os Usuários' })
  async getAllUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllUsers();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin, Role.Mod)
  @Get('/pending')
  async getAllPendingUsers(): Promise<GetUserDTO[]> {
    return this.usersService.getAllPendingUsers();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin, Role.Mod)
  @Get('/roles-and-permissions')
  async getAllRolesAndPermissions(): Promise<UpdateRolesAndPermissions> {
    return this.usersService.getAllRolesAndPermissions();
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
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

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Put('/allowing/:id')
  @ApiOperation({ summary: 'Atualiza informações do Usuário' })
  async updateRolesAndPermissions(
    @Body() updateUserDto: UpdateRolesAndPermissions,
    @Param('id') id: string,
  ): Promise<GetUserDTO> {
    const { roles, permissions } = updateUserDto;
    return this.usersService.updateRolesAndPermissions(id, roles, permissions);
  }

  @UseGuards(JwtAuthGuard)
  @Put('/:id')
  async update(@Body() updateUserDto: UpdateUserDTO): Promise<GetUserDTO> {
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
  @ApiOperation({ summary: 'Deleta Usuário por ID' })
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.usersService.deleteUser(id);
  }
}
