import { BadRequestException, Injectable } from '@nestjs/common';
import { User } from '@prisma/client';
import * as bcrypt from 'bcrypt';

import { PrismaService } from '../database/prisma/prisma.service';
import { GetUserDTO } from './dto/getUserDTO';

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

const returnUserData = {
  id: true,
  name: true,
  email: true,
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
    } catch (err: any) {
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
