import {
  BadRequestException,
  NotFoundException,
  Injectable,
} from '@nestjs/common';
import { Prisma } from '@prisma/client';
import { PrismaService } from '../database/prisma/prisma.service';
import { PostDTO, UserPostDTO } from './dto/get-post-output.dto';

interface CreatePostProps {
  authorId: string;
  to?: string;
  content: string;
}

interface GetPostProps {
  postId: string;
  userId: string;
}

interface UpdatePostProps {
  id: string;
  published: boolean;
}

interface PaginationProps {
  user_id: string;
  take?: number;
  cursor?: Prisma.PostWhereUniqueInput;
}

interface LikePostProps {
  postId: string;
  userId: string;
}

@Injectable()
export class PostService {
  constructor(private prisma: PrismaService) {}

  async getAllPosts({
    user_id,
    take,
    cursor,
  }: PaginationProps): Promise<UserPostDTO[]> {
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
        comments: true,
        updatedAt: true,
        content: true,
        to: true,
        published: true,
        numberOfLikes: true,
        likes: {
          where: {
            userId: user_id,
          },
        },
      },
    });

    const formattedPosts = posts.map((post) => {
      const numberOfComments = post.comments.length;
      const isLiked = post.likes.length > 0;

      delete post.comments;
      delete post.likes;

      return {
        ...post,
        isLiked,
        numberOfComments,
      };
    });

    return formattedPosts;
  }

  async getPostById({ postId, userId }: GetPostProps): Promise<UserPostDTO> {
    if (!postId) {
      throw new BadRequestException('Post Id is required.');
    }

    const isLiked = await this.prisma.like.findFirst({
      where: {
        postId,
        userId,
      },
    });

    const post = await this.prisma.post.findUnique({
      where: { id: postId },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        to: true,
        published: true,
        numberOfLikes: true,
      },
    });

    if (!post) {
      throw new NotFoundException('Post not found.');
    }

    return {
      ...post,
      isLiked: !!isLiked,
    };
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
        to: true,
        published: true,
        numberOfLikes: true,
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
      throw new NotFoundException('Author does not exists.');
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
        select: {
          id: true,
          createdAt: true,
          updatedAt: true,
          content: true,
          to: true,
          published: true,
          numberOfLikes: true,
        },
      });
    } catch (err: any) {
      throw new BadRequestException('There was an error when editing a post.');
    }
  }

  async deletePost(id: string): Promise<void> {
    if (!id) throw new BadRequestException('Post Id is required.');

    const post = await this.prisma.post.findUnique({
      where: { id },
    });

    if (!post) {
      throw new NotFoundException('Post not found.');
    }

    await this.prisma.post.delete({ where: { id } });
  }

  async likePost(likePostData: LikePostProps): Promise<UserPostDTO> {
    const { postId, userId } = likePostData;

    const post = await this.prisma.post.findUnique({
      where: { id: postId },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        to: true,
        published: true,
        numberOfLikes: true,
      },
    });

    const isLiked = await this.prisma.like.findFirst({
      where: {
        postId,
        userId,
      },
    });

    if (!post) {
      throw new BadRequestException('Post not found.');
    }

    try {
      if (isLiked) {
        return {
          ...post,
          isLiked: true,
        };
      }

      await this.prisma.like.create({
        data: {
          postId,
          userId,
        },
      });

      const finalPost = await this.prisma.post.update({
        where: {
          id: postId,
        },
        data: {
          numberOfLikes: post.numberOfLikes + 1,
        },
        select: {
          id: true,
          createdAt: true,
          updatedAt: true,
          content: true,
          to: true,
          published: true,
          numberOfLikes: true,
        },
      });

      return {
        ...finalPost,
        isLiked: true,
      };
    } catch (err: any) {
      throw new BadRequestException('There was an error when creating a like.');
    }
  }

  async removeLike(likePostData: LikePostProps): Promise<UserPostDTO> {
    const { postId, userId } = likePostData;

    const isLiked = await this.prisma.like.findFirst({
      where: {
        postId,
        userId,
      },
    });

    const post = await this.prisma.post.findUnique({
      where: { id: postId },
      select: {
        id: true,
        createdAt: true,
        updatedAt: true,
        content: true,
        to: true,
        published: true,
        numberOfLikes: true,
      },
    });

    if (!post) {
      throw new BadRequestException('Post not found.');
    }

    if (!isLiked) {
      return {
        ...post,
        isLiked: false,
      };
    }

    try {
      await this.prisma.like.deleteMany({
        where: {
          userId,
          postId,
        },
      });

      const finalPost = await this.prisma.post.update({
        where: {
          id: postId,
        },
        data: {
          numberOfLikes: post.numberOfLikes - 1,
        },
        select: {
          id: true,
          createdAt: true,
          updatedAt: true,
          content: true,
          to: true,
          published: true,
          numberOfLikes: true,
        },
      });

      return {
        ...finalPost,
        isLiked: false,
      };
    } catch (err: any) {
      throw new BadRequestException('There was an error when creating a like.');
    }
  }
}
