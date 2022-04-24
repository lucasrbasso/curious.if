import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  Query,
} from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostInputDTO } from './dto/create-post-input.dto';
import { PostDTO } from './dto/get-post-output.dto';

@Controller('api/posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @Get()
  async getAllPosts(
    @Query('cursor') cursor?: string,
    @Query('take') take?: string,
  ): Promise<PostDTO[]> {
    return this.postService.getAllPosts({
      take: take ? Number(take) : 2,
      cursor: cursor ? { id: cursor } : undefined,
    });
  }

  @Get('/:id')
  async getPostById(@Param('id') id: string): Promise<PostDTO> {
    return this.postService.getPostById(id);
  }

  @Post()
  async createPost(
    @Body() createPostInputDto: CreatePostInputDTO,
  ): Promise<PostDTO> {
    return this.postService.createPost(createPostInputDto);
  }

  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.postService.deletePost(id);
  }
}
