import { BadRequestException, Injectable } from '@nestjs/common';
import { User } from '@prisma/client';
import * as bcrypt from 'bcrypt';

import { PrismaService } from '../database/prisma/prisma.service';
import { GetUserDTO } from './dto/getUserDTO';

import { Role } from './roles/role.enum';
import { Permission } from './permissions/permission.enum';

interface CreateUserProps {
  name: string;
  email: string;
  password: string;
}

interface UpdateUserProps {
  id: string;
  name: string;
  email: string;
  old_password?: string;
  password?: string;
}

interface UpdateRolesAndPermissions {
  roles: string[];
  permissions: string[];
}

const returnUserData = {
  id: true,
  name: true,
  email: true,
  isValidated: true,
  permissions: true,
  roles: true,
  createdAt: true,
  updatedAt: true,
};

@Injectable()
export class UsersService {
  constructor(private prisma: PrismaService) {}

  async getAllUsers(): Promise<GetUserDTO[]> {
    const users = await this.prisma.user.findMany({
      select: {
        ...returnUserData,
      },
    });

    return users;
  }

  async getUserByEmail(email: string): Promise<User> {
    const user = await this.prisma.user.findUnique({
      where: { email },
    });

    if (!user) {
      throw new BadRequestException('User not found.');
    }
    return user;
  }

  async getAllPendingUsers(): Promise<GetUserDTO[]> {
    const user = await this.prisma.user.findMany({
      where: { isValidated: false },
      select: {
        ...returnUserData,
      },
    });

    return user;
  }

  async getAllRolesAndPermissions(): Promise<UpdateRolesAndPermissions> {
    const rolesArray = Object.keys(Role).map((key) => Role[key]);
    const permissionsArray = Object.keys(Permission).map(
      (key) => Permission[key],
    );

    return {
      roles: rolesArray,
      permissions: permissionsArray,
    };
  }

  async getUserById(id: string): Promise<GetUserDTO> {
    const user = await this.prisma.user.findUnique({
      where: { id },
      select: {
        ...returnUserData,
      },
    });

    if (!user) {
      throw new BadRequestException('User not found.');
    }
    return user;
  }

  async createUser({
    email,
    name,
    password,
  }: CreateUserProps): Promise<GetUserDTO> {
    const checkIfEmailIsAlreadyUsed = await this.prisma.user.findUnique({
      where: {
        email,
      },
    });

    if (checkIfEmailIsAlreadyUsed) {
      throw new BadRequestException('Email is already used.');
    }

    try {
      const hash = await bcrypt.hash(password, 10);
      return this.prisma.user.create({
        select: {
          ...returnUserData,
        },
        data: {
          name,
          email,
          password: hash,
          permissions: ['USER.CAN_READ'],
          roles: [],
        },
      });
    } catch (err: any) {
      throw new BadRequestException('There was an error when creating a user.');
    }
  }

  async updateUser({
    id,
    email,
    name,
    password,
    old_password,
  }: UpdateUserProps): Promise<GetUserDTO> {
    const user = await this.prisma.user.findFirst({
      where: {
        id,
      },
    });

    if (!user) {
      throw new BadRequestException('User not found.');
    }

    const findUserByEmail = await this.prisma.user.findUnique({
      where: {
        email,
      },
    });

    if (findUserByEmail && findUserByEmail.id !== id) {
      throw new BadRequestException('Email already in use.');
    }

    if (password && !old_password) {
      throw new BadRequestException(
        'You need to inform the old password to set a new password.',
      );
    }

    if (password && old_password) {
      const checkOldPassword = await bcrypt.compare(
        old_password,
        user.password,
      );

      if (!checkOldPassword) {
        throw new BadRequestException('Incorrect old password.');
      }

      const hash = await bcrypt.hash(password, 10);

      user.password = hash;
    }

    user.email = email;
    user.name = name;

    try {
      return await this.prisma.user.update({
        where: {
          id,
        },
        select: {
          ...returnUserData,
        },
        data: {
          ...user,
        },
      });
    } catch (err) {
      throw new BadRequestException('There was an error when updating a user.');
    }
  }

  async updateRolesAndPermissions(
    id: string,
    roles?: string[],
    permissions?: string[],
  ): Promise<GetUserDTO> {
    const user = await this.prisma.user.findFirst({
      where: {
        id,
      },
    });

    if (!user) {
      throw new BadRequestException('User not found.');
    }

    const validRoles = ['USER.ADMIN', 'USER.MOD'];
    const validPermissions = ['USER.CAN_READ', 'USER.CAN_POST'];

    if (roles) {
      if (roles.length > 0) {
        roles.forEach((role) => {
          if (!validRoles.includes(role)) {
            throw new BadRequestException('Invalid role.');
          }
        });
      }
      user.roles = roles;
    }

    if (permissions) {
      if (permissions.length > 0) {
        permissions.forEach((permission) => {
          if (!validPermissions.includes(permission)) {
            throw new BadRequestException('Invalid role.');
          }
        });
      }
      user.permissions = permissions;
    }

    try {
      return await this.prisma.user.update({
        where: {
          id,
        },
        select: {
          ...returnUserData,
        },
        data: {
          ...user,
        },
      });
    } catch (err) {
      throw new BadRequestException('There was an error when updating a user.');
    }
  }

  async validateUser(id: string, isValid = false): Promise<GetUserDTO> {
    const user = await this.prisma.user.findFirst({
      where: {
        id,
      },
    });

    if (!user) {
      throw new BadRequestException('User not found.');
    }

    if (isValid) {
      if (!user.permissions.includes('USER.CAN_POST')) {
        user.permissions.push('USER.CAN_POST');
      }
    }

    user.isValidated = true;

    try {
      return await this.prisma.user.update({
        where: {
          id,
        },
        select: {
          ...returnUserData,
        },
        data: {
          ...user,
        },
      });
    } catch (err) {
      throw new BadRequestException('There was an error when updating a user.');
    }
  }

  async deleteUser(id: string): Promise<void> {
    const user = await this.prisma.user.findUnique({
      where: { id },
    });

    if (!user) {
      throw new BadRequestException('User not found.');
    }

    await this.prisma.user.delete({ where: { id } });
  }
}
