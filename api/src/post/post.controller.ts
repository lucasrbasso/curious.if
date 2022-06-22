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
  Request,
  Headers,
} from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostInputDTO } from './dto/create-post-input.dto';
import { UpdatePostStatusDTO } from './dto/update-post-status.dto';
import { PostDTO, UserPostDTO } from './dto/get-post-output.dto';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { ApiOperation, ApiTags } from '@nestjs/swagger';
import { PermissionsGuard } from 'src/users/permissions/permissions.guard';
import { Permissions } from 'src/users/permissions/permissions.decorator';
import { Permission } from 'src/users/permissions/permission.enum';
import { RolesGuard } from 'src/users/roles/role.guard';
import { Role } from 'src/users/roles/role.enum';
import { Roles } from 'src/users/roles/roles.decorator';

@ApiTags('Posts')
@Controller('api/posts')
export class PostController {
  constructor(private readonly postService: PostService) {}

  @Get()
  @ApiOperation({ summary: 'Retorna todos os Posts' })
  async getAllPosts(
    @Headers() headers,
    @Query('cursor') cursor?: string,
    @Query('take') take?: string,
  ): Promise<PostDTO[]> {
    return this.postService.getAllPosts({
      user_id: headers.user_id || '',
      take: take ? Number(take) : 2,
      cursor: cursor ? { id: cursor } : undefined,
    });
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Get('/:id')
  @ApiOperation({ summary: 'Retorna Post por ID' })
  async getPostById(
    @Param('id') id: string,
    @Request() req,
  ): Promise<UserPostDTO> {
    const postData = {
      postId: id,
      userId: req.user.userId,
    };

    return this.postService.getPostById(postData);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Post('/like/:id')
  @ApiOperation({ summary: 'Like Post' })
  async likePost(
    @Param('id') id: string,
    @Request() req,
  ): Promise<UserPostDTO> {
    const likePostData = {
      postId: id,
      userId: req.user.userId,
    };
    return this.postService.likePost(likePostData);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Delete('/like/:id')
  @ApiOperation({ summary: 'Remove like from Post' })
  async removeLike(
    @Param('id') id: string,
    @Request() req,
  ): Promise<UserPostDTO> {
    const likePostData = {
      postId: id,
      userId: req.user.userId,
    };
    return this.postService.removeLike(likePostData);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Post()
  @ApiOperation({ summary: 'Cria Post' })
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
  @Get('filter/UnauthorizedPost')
  @Roles(Role.Admin, Role.Mod)
  @ApiOperation({ summary: 'Retorna Post não aprovados' })
  async getUnauthorizedPost(): Promise<PostDTO[]> {
    return this.postService.getUnauthorizedPost();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Patch()
  @ApiOperation({ summary: 'Atualiza status do Post' })
  async updatePostStatus(
    @Body() updatePostStatusDTO: UpdatePostStatusDTO,
  ): Promise<PostDTO> {
    return this.postService.updatePostStatus(updatePostStatusDTO);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('/:id')
  @ApiOperation({ summary: 'Deleta Post por ID' })
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.postService.deletePost(id);
  }
}
