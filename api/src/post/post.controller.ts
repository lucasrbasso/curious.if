import {
  Controller,
  Get,
  Patch,
  Post,
  Body,
  Delete,
  Param,
  UseGuards,
  Query,
} from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostInputDTO } from './dto/create-post-input.dto';
import { UpdatePostStatusDTO } from './dto/update-post-status.dto';
import { PostDTO } from './dto/get-post-output.dto';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ApiOperation, ApiTags } from '@nestjs/swagger';

@ApiTags('Posts')
@Controller('api/posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @UseGuards(JwtAuthGuard)
  @Get()
  @ApiOperation({summary: 'Retorna todos os Posts'})
  async getAllPosts(
    @Query('cursor') cursor?: string,
    @Query('take') take?: string,
  ): Promise<PostDTO[]> {
    return this.postService.getAllPosts({
      take: take ? Number(take) : 2,
      cursor: cursor ? { id: cursor } : undefined,
    });
  }

  @UseGuards(JwtAuthGuard)
  @Get('/:id')
  @ApiOperation({summary: 'Retorna Post por ID'})
  async getPostById(@Param('id') id: string): Promise<PostDTO> {
    return this.postService.getPostById(id);
  }

  @UseGuards(JwtAuthGuard)
  @Post()
  @ApiOperation({summary: 'Cria Post'})
  async createPost(@Body() createPostInputDTO: CreatePostInputDTO): Promise<PostDTO> {
    return this.postService.createPost(createPostInputDTO);
  }

  @UseGuards(JwtAuthGuard)
  @Patch('/:id')
  @ApiOperation({summary: 'Atualiza status do Post'})
  async updatePostStatus(@Body() updatePostStatusDTO: UpdatePostStatusDTO): Promise<PostDTO> {
    return this.postService.updatePostStatus(updatePostStatusDTO);
  }

  @UseGuards(JwtAuthGuard)
  @Delete('/:id')
  @ApiOperation({summary: 'Deleta Post por ID'})
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.postService.deletePost(id);
  }
}
