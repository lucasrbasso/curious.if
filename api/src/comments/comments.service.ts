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

interface LikeCommentProps {
  commentId: string;
  userId: string;
}

const commentsSelectConfig = {
  id: true,
  content: true,
  authorId: true,
  postId: true,
  numberOfLikes: true,
  createdAt: true,
  updatedAt: true,
};

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
        select: {
          ...commentsSelectConfig,
          author: true,
          like: {
            where: {
              userId,
            },
          },
        },
      });

      const formattedComments = comments.map((comment) => {
        const authorName = comment.author.name;
        const isLiked = comment.like.length > 0;

        delete comment.author;

        return {
          ...comment,
          authorName,
          isOwner: comment.authorId === userId,
          isLiked,
        };
      });

      return formattedComments;
    } catch (err: any) {
      console.log(err);
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
      const comment = await this.prisma.comment.create({
        data: {
          postId,
          authorId,
          content,
        },
      });

      return {
        ...comment,
        authorName: checkIfAuthorExists.name,
        isOwner: true,
      };
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

  async likeComment({
    userId,
    commentId,
  }: LikeCommentProps): Promise<GetCommentDTO> {
    const comment = await this.prisma.comment.findUnique({
      where: {
        id: commentId,
      },
    });

    const post = await this.prisma.post.findUnique({
      where: { id: comment.postId },
    });

    const isLiked = await this.prisma.like.findFirst({
      where: {
        postId: comment.postId,
        userId,
        commentId,
      },
    });

    if (!comment) {
      throw new BadRequestException('Comment not found.');
    }

    if (!post) {
      throw new BadRequestException('Post not found.');
    }

    try {
      if (isLiked) {
        return {
          ...comment,
          isLiked: true,
        };
      }

      await this.prisma.like.create({
        data: {
          commentId,
          postId: comment.postId,
          userId,
        },
      });

      const updatedComment = await this.prisma.comment.update({
        where: {
          id: commentId,
        },
        data: {
          numberOfLikes: comment.numberOfLikes + 1,
        },
      });

      return {
        ...updatedComment,
        isLiked: true,
      };
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to give a like.',
      );
    }
  }

  async removeCommentLike({
    userId,
    commentId,
  }: LikeCommentProps): Promise<GetCommentDTO> {
    const comment = await this.prisma.comment.findUnique({
      where: {
        id: commentId,
      },
    });

    const post = await this.prisma.post.findUnique({
      where: { id: comment.postId },
    });

    const user = await this.prisma.user.findUnique({
      where: {
        id: userId,
      },
    });

    if (!comment) {
      throw new BadRequestException('Comment not found.');
    }

    if (!post) {
      throw new BadRequestException('Post not found.');
    }

    if (!user) {
      throw new BadRequestException('User not found.');
    }

    const isLiked = await this.prisma.like.findFirst({
      where: {
        postId: comment.postId,
        userId,
        commentId,
      },
    });

    try {
      if (!isLiked) {
        return {
          ...comment,
          isLiked: false,
        };
      }

      await this.prisma.like.deleteMany({
        where: {
          commentId,
          postId: comment.postId,
          userId,
        },
      });

      const updatedComment = await this.prisma.comment.update({
        where: {
          id: commentId,
        },
        data: {
          numberOfLikes:
            comment.numberOfLikes > 0 ? comment.numberOfLikes - 1 : 0,
        },
      });

      return {
        ...updatedComment,
        isLiked: false,
      };
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to remove a like.',
      );
    }
  }
}
