import { BadRequestException, Injectable } from '@nestjs/common';
import { GetCommentDTO } from 'src/comments/dto/getCommentDTO';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { GetCommentReportDTO } from './dto/getCommentReportDTO';

interface ReportCommentProps {
  commentId: string;
  postId: string;
  userId: string;
  content?: string;
}

@Injectable()
export class CommentsReportService {
  constructor(private prisma: PrismaService) {}

  async createCommentReport({
    postId,
    userId,
    commentId,
    content,
  }: ReportCommentProps): Promise<GetCommentReportDTO> {
    const comment = await this.prisma.comment.findUnique({
      where: {
        id: commentId,
      },
    });

    const post = await this.prisma.post.findUnique({
      where: { id: postId },
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

    try {
      return await this.prisma.commentReport.create({
        data: {
          commentId,
          postId,
          userId,
          content,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to create a comment report.',
      );
    }
  }

  async getAllReportedComments(): Promise<GetCommentReportDTO[]> {
    try {
      return await this.prisma.commentReport.findMany({
        include: {
          comment: true,
          post: true,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all reported comments.',
      );
    }
  }

  async getAllReportedCommentsByUserId(
    userId: string,
  ): Promise<GetCommentReportDTO[]> {
    try {
      return await this.prisma.commentReport.findMany({
        where: {
          userId,
        },
        include: {
          post: true,
          comment: true,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get reported comments from this user.',
      );
    }
  }

  async getAllReportedCommentsByPostId(
    postId: string,
  ): Promise<GetCommentReportDTO[]> {
    try {
      return await this.prisma.commentReport.findMany({
        where: {
          postId,
        },
        include: {
          post: true,
          comment: true,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get reported comments from this post.',
      );
    }
  }

  async getReportedComment(
    commentReportId: string,
  ): Promise<GetCommentReportDTO> {
    const commentReport = await this.prisma.commentReport.findUnique({
      where: {
        id: commentReportId,
      },
      include: {
        post: true,
        comment: true,
      },
    });

    if (!commentReport) {
      throw new BadRequestException('Comment report does not exists');
    }

    return commentReport;
  }

  async dismissReportComment(
    commentReportId: string,
  ): Promise<GetCommentReportDTO> {
    const checkIfCommentReportExists =
      await this.prisma.commentReport.findUnique({
        where: {
          id: commentReportId,
        },
      });

    if (!checkIfCommentReportExists) {
      throw new BadRequestException('Comment Report does no exists');
    }

    try {
      return await this.prisma.commentReport.delete({
        where: {
          id: commentReportId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get this reported comment.',
      );
    }
  }

  async acceptReportComment(commentReportId: string): Promise<GetCommentDTO> {
    const commentReport = await this.prisma.commentReport.findUnique({
      where: {
        id: commentReportId,
      },
    });

    if (!commentReport) {
      throw new BadRequestException('Comment Report does no exists');
    }

    try {
      await this.prisma.commentReport.deleteMany({
        where: {
          commentId: commentReport.commentId,
        },
      });

      return await this.prisma.comment.delete({
        where: {
          id: commentReport.commentId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get this reported comment.',
      );
    }
  }
}
