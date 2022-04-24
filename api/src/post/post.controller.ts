import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  UseGuards,
} from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostInputDTO } from './dto/create-post-input.dto';
import { PostDTO } from './dto/get-post-output.dto';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { PermissionsGuard } from 'src/users/permissions/permissions.guard';
import { Permissions } from 'src/users/permissions/permissions.decorator';
import { Permission } from 'src/users/permissions/permission.enum';
import { RolesGuard } from 'src/users/roles/role.guard';
import { Role } from 'src/users/roles/role.enum';
import { Roles } from 'src/users/roles/roles.decorator';

@Controller('api/posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Get()
  async getAllPosts(): Promise<PostDTO[]> {
    return this.postService.getAllPosts();
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Get('/:id')
  async getPostById(@Param('id') id: string): Promise<PostDTO> {
    return this.postService.getPostById(id);
  }

  // Adicionar mapeamentos para as DTOs

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Post()
  async createPost(
    @Body() createPostInputDto: CreatePostInputDTO,
  ): Promise<PostDTO> {
    return this.postService.createPost(createPostInputDto);
  }

  // Mudar para mensagem na criação e na deleção

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.postService.deletePost(id);
  }
}
