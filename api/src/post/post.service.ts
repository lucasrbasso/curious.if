import { BadRequestException, Injectable } from '@nestjs/common';
import { PrismaService } from '../database/prisma/prisma.service';
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
      throw new BadRequestException('Post not found.');
    }
    return post;
  }

  async createPost({ authorId, content }: CreatePostProps): Promise<PostDTO> {
    if (!authorId) throw new BadRequestException('AuthorId is required.');

    try {
      return this.prisma.post.create({
        data: {
          content,
          authorId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException('There was an error when creating a post.');
    }
  }

  async deletePost(id: string): Promise<void> {
    const post = await this.prisma.post.findUnique({
      where: { id },
    });

    if (!post) {
      throw new BadRequestException('Post not found.');
    }

    await this.prisma.post.delete({ where: { id } });
  }
}