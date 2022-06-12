import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';

import { PrismaService } from 'src/database/prisma/prisma.service';
import { GetCommentDTO } from './dto/getCommentDTO';

interface CreateCommentProps {
  authorId: string;
  postId: string;
  content: string;
}

interface DeleteCommentProps {
  commentId: string;
  authorId: string;
}

interface GetCommentsByPostProps {
  postId: string;
  userId: string;
}

@Injectable()
export class CommentsService {
  constructor(private prisma: PrismaService) {}

  async getAllComments(): Promise<GetCommentDTO[]> {
    try {
      return await this.prisma.comment.findMany();
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all comments.',
      );
    }
  }

  async getCommentsByAuthorId(authorId: string): Promise<GetCommentDTO[]> {
    try {
      return await this.prisma.comment.findMany({
        where: {
          authorId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all comments from this user.',
      );
    }
  }

  async getCommentsByPostId({
    postId,
    userId,
  }: GetCommentsByPostProps): Promise<GetCommentDTO[]> {
    try {
      const comments = await this.prisma.comment.findMany({
        where: {
          postId,
        },
      });

      const formattedComments = comments.map((comment) => {
        if (comment.authorId === userId) {
          return {
            ...comment,
            isOwner: true,
          };
        }

        return { ...comment, isOwner: false };
      });

      return formattedComments;
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all comments from this post.',
      );
    }
  }

  async getCommentById(commentId: string): Promise<GetCommentDTO> {
    try {
      return await this.prisma.comment.findUnique({
        where: {
          id: commentId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get the comment.',
      );
    }
  }

  async createComment({
    authorId,
    postId,
    content,
  }: CreateCommentProps): Promise<GetCommentDTO> {
    if (!authorId) throw new BadRequestException('AuthorId is required.');

    const checkIfAuthorExists = await this.prisma.user.findUnique({
      where: {
        id: authorId,
      },
    });

    if (!checkIfAuthorExists) {
      throw new NotFoundException('Author does not exists.');
    }

    if (!postId) throw new BadRequestException('PostId is required.');

    const checkIfPostExists = await this.prisma.post.findUnique({
      where: {
        id: postId,
      },
    });

    if (!checkIfPostExists) {
      throw new NotFoundException('Post does not exists.');
    }

    try {
      return await this.prisma.comment.create({
        data: {
          postId,
          authorId,
          content,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to create a comment.',
      );
    }
  }

  async deleteComment({
    commentId,
    authorId,
  }: DeleteCommentProps): Promise<void> {
    if (!authorId) throw new BadRequestException('AuthorId is required.');

    const checkIfAuthorExists = await this.prisma.user.findUnique({
      where: {
        id: authorId,
      },
    });

    if (!checkIfAuthorExists) {
      throw new NotFoundException('Author does not exists.');
    }

    if (!commentId) throw new BadRequestException('Comment ID is required.');

    const checkIfCommentExists = await this.prisma.comment.findUnique({
      where: {
        id: commentId,
      },
    });

    if (!checkIfCommentExists) {
      throw new NotFoundException('Comment does not exists.');
    }

    const isAdmin = checkIfAuthorExists.roles.some((role) =>
      role.includes('USER.ADMIN'),
    );
    const isMod = checkIfAuthorExists.roles.some((role) =>
      role.includes('USER.MOD'),
    );

    if (!isAdmin && !isMod && checkIfCommentExists.authorId !== authorId) {
      throw new BadRequestException('Not enough role to delete this comment.');
    }

    try {
      await this.prisma.comment.delete({ where: { id: commentId } });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to delete a comment.',
      );
    }
  }
}
