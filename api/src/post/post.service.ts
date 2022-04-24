import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from '../database/prisma/prisma.service';
import { User } from '@prisma/client';
import { PostDTO } from './dto/get-post-output.dto';

interface CreatePostProps {
  authorId: string;
  content: string;
}
@Injectable()
export class PostService {
  constructor(private prisma: PrismaService) {}

  async getAllPosts(): Promise<PostDTO[]> {
    const posts = await this.prisma.post.findMany({
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

  async getPostById(id: string): Promise<PostDTO> {
    const post = await this.prisma.post.findUnique({
      where: { id },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        published: true,
      },
    });

    if (!post) {
      throw new HttpException('Post not found.', HttpStatus.NOT_FOUND);
    }
    return post;
  }

  async createPost({ authorId, content }: CreatePostProps): Promise<PostDTO> {
    if (!authorId)
      throw new HttpException('AuthorId is required.', HttpStatus.BAD_REQUEST);

    try {
      return this.prisma.post.create({
        data: {
          content,
          authorId,
        },
      });
    } catch (err: any) {
      throw new HttpException(
        'There was an error when creating a post.',
        HttpStatus.INTERNAL_SERVER_ERROR,
      );
    }
  }

  async deletePost(id: string): Promise<void> {
    const post = await this.prisma.post.findUnique({
      where: { id },
    });

    if (!post) {
      throw new HttpException('Post not found.', HttpStatus.NOT_FOUND);
    }

    await this.prisma.post.delete({ where: { id } });
  }

  async createUser(): Promise<User> {
    return this.prisma.user.create({
      data: {
        name: 'Heriklys',
      },
    });
  }
}
