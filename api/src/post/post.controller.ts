import { Controller, Get, Post, Body, Delete, Param } from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostInputDTO } from './dto/create-post-input.dto';
import { GetPostDTO } from './dto/get-post-output.dto';

@Controller('api/posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @Get()
  async getAllPosts(): Promise<GetPostDTO[]> {
    return this.postService.getAllPosts();
  }

  @Get('/:id')
  async getPostById(@Param('id') id: string): Promise<GetPostDTO> {
    return this.postService.getPostById(id);
  }

  // Adicionar mapeamentos para as DTOs
  @Post()
  async createPost(
    @Body() createPostInputDto: CreatePostInputDTO,
  ): Promise<GetPostDTO> {
    return this.postService.createPost(createPostInputDto);
  }

  // Mudar para mensagem na criação e na deleção
  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<GetPostDTO> {
    return this.postService.deletePost(id);
  }
}
