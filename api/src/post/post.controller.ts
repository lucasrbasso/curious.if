import {
  Controller,
  Get,
  Post,
  Body,
  Delete,
  Param,
  UseGuards,
  Query,
  Request,
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
  async getAllPosts(
    @Query('cursor') cursor?: string,
    @Query('take') take?: string,
  ): Promise<PostDTO[]> {
    return this.postService.getAllPosts({
      take: take ? Number(take) : 2,
      cursor: cursor ? { id: cursor } : undefined,
    });
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Get('/:id')
  async getPostById(@Param('id') id: string): Promise<PostDTO> {
    return this.postService.getPostById(id);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Post()
  async createPost(
    @Body() createPostInputDto: CreatePostInputDTO,
    @Request() req,
  ): Promise<PostDTO> {
    const postData = {
      ...createPostInputDto,
      authorId: req.user.userId,
    };
    return this.postService.createPost(postData);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('/:id')
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.postService.deletePost(id);
  }
}
