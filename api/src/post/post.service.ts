import {
  BadRequestException,
  NotFoundException,
  Injectable,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../database/prisma/prisma.service';
import { PostDTO } from './dto/get-post-output.dto';

interface CreatePostProps {
  authorId: string;
  to?: string;
  content: string;
}

interface UpdatePostProps {
  id: string;
  published: boolean;
}

interface PaginationProps {
  take?: number;
  cursor?: Prisma.PostWhereUniqueInput;
}

@Injectable()
export class PostService {
  constructor(private prisma: PrismaService) {}

  async getAllPosts({ take, cursor }: PaginationProps): Promise<PostDTO[]> {
    const posts = await this.prisma.post.findMany({
      take,
      skip: cursor ? 1 : 0,
      cursor,
      orderBy: {
        createdAt: 'desc',
      },
      where: {
        published: true,
      },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        to: true,
        published: true,
      },
    });

    return posts;
  }

  async getPostById(id: string): Promise<PostDTO> {
    const post = await this.prisma.post.findUnique({
      where: { id },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        to: true,
        published: true,
      },
    });

    if (!post) {
      throw new NotFoundException('Post not found.');
    }
    return post;
  }

  async getUnauthorizedPost(): Promise<PostDTO[]> {
    const posts = await this.prisma.post.findMany({
      where: {
        published: false,
      },
      orderBy: {
        createdAt: 'desc',
      },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        published: true,
      },
    });

    return posts;
  }

  async createPost({
    authorId,
    content,
    to,
  }: CreatePostProps): Promise<PostDTO> {
    if (!authorId) throw new BadRequestException('AuthorId is required.');

    const checkIfAuthorExists = await this.prisma.user.findUnique({
      where: {
        id: authorId,
      },
    });

    if (!checkIfAuthorExists) {
      throw new BadRequestException('Author does not exists.');
    }

    try {
      return await this.prisma.post.create({
        data: {
          content,
          to,
          authorId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException('There was an error when creating a post.');
    }
  }

  async updatePostStatus({ id, published }: UpdatePostProps): Promise<PostDTO> {
    if (!id) {
      throw new BadRequestException('Post Id is required.');
    }

    const postInDB = await this.prisma.post.findUnique({
      where: {
        id,
      },
    });

    if (!postInDB) {
      throw new NotFoundException('Post not found.');
    }

    try {
      return await this.prisma.post.update({
        where: {
          id,
        },
        data: {
          published,
        },
      });
    } catch (err: any) {
      throw new BadRequestException('There was an error when editing a post.');
    }
  }

  async deletePost(id: string): Promise<void> {
    const post = await this.prisma.post.findUnique({
      where: { id },
    });

    if (!post) {
      throw new NotFoundException('Post not found.');
    }

    await this.prisma.post.delete({ where: { id } });
  }
}
