import {
  Controller,
  Get,
  Post,
  Req,
  Body,
} from '@nestjs/common';
import { Post as PostEntity } from './post.entity';
import { PostsService } from "./posts.service";

@Controller()
export class PostsController{
  constructor(private readonly postService: PostsService) {}

  // Métodos HTTP - POST GET PUT
  // Chama os métodos do service dentro dos métodos HTTP
  @Get()
  getHello(): string {
    return this.postService.getHello();
  }

  // @route  POST
  // @desc   Cria um novo Post
  // @access Private
  @Post()
  async createPost(@Req() req, @Body() body): Promise<PostEntity> {
    try {
      return await this.postService.createPost(
        req.user.id,
        body.text,
      );
    } catch (err) {
      throw err;
    }
  }
}