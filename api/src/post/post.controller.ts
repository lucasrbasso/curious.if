import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
} from '@nestjs/common';
import { PostService } from "./post.service";
import { Post as PostModel, User } from '@prisma/client';

@Controller('api/posts')
export class PostController{
  constructor(private readonly postService: PostService) {}

  @Get()
  async getAllPosts(): Promise<PostModel[]> {
    return this.postService.getAllPosts();
  }

  @Get('/:id')
  async getPostById(@Param('id') id: string): Promise<PostModel> {
    return this.postService.getPostById(id);
  }

  // Adicionar mapeamentos para as DTOs
  @Post()
  async createPost(@Body() createPostInputDto: PostModel): Promise<PostModel> {
    return this.postService.createPost(createPostInputDto);
  }

  // Mudar para mensagem na criação e na deleção
  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<PostModel> {
    return this.postService.deletePost(id);
  }
}