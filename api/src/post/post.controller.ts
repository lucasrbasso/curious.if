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
} from '@nestjs/common';
import { PostService } from './post.service';
import { CreatePostInputDTO } from './dto/create-post-input.dto';
import { UpdatePostStatusDTO } from './dto/update-post-status.dto';
import { PostDTO } from './dto/get-post-output.dto';
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

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
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

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Get('/:id')
  @ApiOperation({summary: 'Retorna Post por ID'})
  async getPostById(@Param('id') id: string): Promise<PostDTO> {
    return this.postService.getPostById(id);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Post()
  @ApiOperation({summary: 'Cria Post'})
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
  @ApiOperation({summary: 'Retorna Post não aprovados'})
  async getUnauthorizedPost(): Promise<PostDTO[]> {
    return this.postService.getUnauthorizedPost();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Patch()
  @ApiOperation({summary: 'Atualiza status do Post'})
  async updatePostStatus(@Body() updatePostStatusDTO: UpdatePostStatusDTO): Promise<PostDTO> {
    return this.postService.updatePostStatus(updatePostStatusDTO);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('/:id')
  @ApiOperation({summary: 'Deleta Post por ID'})
  async deletePost(@Param('id') id: string): Promise<void> {
    return this.postService.deletePost(id);
  }
}
