import { Injectable } from "@nestjs/common";
import { InjectRepository } from '@nestjs/typeorm';
import { Post } from './post.entity';
import { Repository, InsertResult } from 'typeorm';


@Injectable()
export class PostsService {
  constructor(
    @InjectRepository(Post) private readonly postRepository: Repository<Post>
  ) {}

  // Métodos para manipulação dos posts
  getHello(): string {
    return 'Oi';
  }

  // Get post by postId
  async getPostById(id: string): Promise<Post> {
    try {
      const post = await this.postRepository
        .createQueryBuilder('post')
        .where('post.id = :id', { id })
        .getOne();
    return post;
    } catch (err) {
      throw err;
    }
  }

  // Create a new post
  async createPost(id: string, text: string): Promise<Post> {
    try {
      const insertResult = await this.postRepository
        .createQueryBuilder()
        .insert()
        .into(Post)
        .values([
          {
            text,
          },
        ])
        .execute();
      const postId = insertResult.identifiers[0].id;
      const newPost = await this.getPostById(postId.toString());

    return newPost;
    } catch (err) {
      throw err;
    }
  }
}