import { BadRequestException, Injectable } from '@nestjs/common';
import { Comment } from '@prisma/client';
import { GetCommentDTO } from 'src/comments/dto/getCommentDTO';
import { PrismaService } from 'src/database/prisma/prisma.service';
import { PostDTO } from 'src/post/dto/get-post-output.dto';
import { GetReportDTO } from './dto/getReportDTO';

interface ReportCommentProps {
  commentId: string;
  postId: string;
  userId: string;
  content?: string;
  type: 'COMMENT' | 'POST';
}

@Injectable()
export class ReportsService {
  constructor(private prisma: PrismaService) {}

  async createReport({
    postId,
    userId,
    commentId,
    content,
    type,
  }: ReportCommentProps): Promise<GetReportDTO> {
    if (!commentId && !postId) {
      throw new BadRequestException('CommentId or PostId should not be empty');
    }

    let comment: Comment;

    if (type === 'COMMENT') {
      comment = await this.prisma.comment.findUnique({
        where: {
          id: commentId,
        },
      });

      if (!commentId) {
        throw new BadRequestException('CommentId is required');
      }

      if (!comment) {
        throw new BadRequestException('Comment not found.');
      }
    }

    const post = await this.prisma.post.findUnique({
      where: { id: postId },
    });

    const user = await this.prisma.user.findUnique({
      where: {
        id: userId,
      },
    });

    if (!post) {
      throw new BadRequestException('Post not found.');
    }

    if (!user) {
      throw new BadRequestException('User not found.');
    }

    try {
      return await this.prisma.report.create({
        data: {
          commentId,
          postId: postId ? postId : comment.postId,
          userId,
          content,
          type,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to create a comment report.',
      );
    }
  }

  async getAllReportedItems(): Promise<GetReportDTO[]> {
    try {
      return await this.prisma.report.findMany({
        include: {
          comment: true,
          post: true,
        },
        orderBy: {
          createdAt: 'asc',
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all reported items.',
      );
    }
  }

  async getAllReportedComments(): Promise<GetReportDTO[]> {
    try {
      return await this.prisma.report.findMany({
        where: {
          type: 'COMMENT',
        },
        include: {
          comment: true,
          post: true,
        },
        orderBy: {
          createdAt: 'desc',
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all reported comments.',
      );
    }
  }

  async getAllReportedPosts(): Promise<GetReportDTO[]> {
    try {
      return await this.prisma.report.findMany({
        where: {
          type: 'POST',
        },
        include: {
          comment: true,
          post: true,
        },
        orderBy: {
          createdAt: 'desc',
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get all reported posts.',
      );
    }
  }

  async getAllReportsByUserId(userId: string): Promise<GetReportDTO[]> {
    try {
      return await this.prisma.report.findMany({
        where: {
          userId,
        },
        include: {
          post: true,
          comment: true,
        },
        orderBy: {
          createdAt: 'desc',
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to get reports from this user.',
      );
    }
  }

  async getAllReportsByPostId(postId: string): Promise<GetReportDTO[]> {
    try {
      return await this.prisma.report.findMany({
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

  async getReportedItem(itemReportId: string): Promise<GetReportDTO> {
    const reportedItem = await this.prisma.report.findUnique({
      where: {
        id: itemReportId,
      },
      include: {
        post: true,
        comment: true,
      },
    });

    if (!reportedItem) {
      throw new BadRequestException('Comment report does not exists');
    }

    return reportedItem;
  }

  async dismissReport(reportId: string): Promise<GetReportDTO> {
    try {
      return await this.prisma.report.delete({
        where: {
          id: reportId,
        },
      });
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to delete this reported comment.',
      );
    }
  }

  async acceptReport(reportId: string): Promise<GetCommentDTO | PostDTO> {
    const reportedItem = await this.prisma.report.findUnique({
      where: {
        id: reportId,
      },
    });

    if (!reportedItem) {
      throw new BadRequestException('Report does no exists');
    }

    try {
      if (reportedItem.type === 'COMMENT') {
        await this.prisma.report.deleteMany({
          where: {
            commentId: reportedItem.commentId,
          },
        });

        return await this.prisma.comment.delete({
          where: {
            id: reportedItem.commentId,
          },
        });
      } else {
        await this.prisma.report.deleteMany({
          where: {
            postId: reportedItem.postId,
          },
        });

        return await this.prisma.post.delete({
          where: {
            id: reportedItem.postId,
          },
        });
      }
    } catch (err: any) {
      throw new BadRequestException(
        'There was an error trying to delete this reported item.',
      );
    }
  }
}
