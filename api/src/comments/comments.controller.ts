import {
  Body,
  Request,
  Controller,
  Post,
  UseGuards,
  Delete,
  Param,
  Headers,
  Get,
} from '@nestjs/common';
import { ApiOperation } from '@nestjs/swagger';
import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { Permission } from 'src/users/permissions/permission.enum';
import { Permissions } from 'src/users/permissions/permissions.decorator';
import { PermissionsGuard } from 'src/users/permissions/permissions.guard';
import { Role } from 'src/users/roles/role.enum';
import { RolesGuard } from 'src/users/roles/role.guard';
import { Roles } from 'src/users/roles/roles.decorator';
import { CommentsService } from './comments.service';
import { CreateCommentDTO } from './dto/createCommentDTO';
import { GetCommentDTO } from './dto/getCommentDTO';

@Controller('api/comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get()
  @ApiOperation({ summary: 'Retorna todos os Comentários' })
  async getAllComments(): Promise<GetCommentDTO[]> {
    return this.commentsService.getAllComments();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('/user/:id')
  @ApiOperation({ summary: 'Retorna todos os Comentários de um usuário' })
  async getCommentsByUserId(
    @Param('id') authorId: string,
  ): Promise<GetCommentDTO[]> {
    return this.commentsService.getCommentsByAuthorId(authorId);
  }

  @Get('/post/:id')
  @ApiOperation({ summary: 'Retorna todos os Comentários de um post' })
  async getCommentsByPostId(
    @Headers() headers,
    @Param('id') postId: string,
  ): Promise<GetCommentDTO[]> {
    return this.commentsService.getCommentsByPostId({
      postId,
      userId: headers.user_id || '',
    });
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('/:id')
  @ApiOperation({ summary: 'Retorna um Comentário especifico' })
  async getCommentById(@Param('id') commentId: string): Promise<GetCommentDTO> {
    return this.commentsService.getCommentById(commentId);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Post()
  @ApiOperation({ summary: 'Cria Comentário' })
  async createComment(
    @Body() createCommentDTO: CreateCommentDTO,
    @Request() req,
  ): Promise<GetCommentDTO> {
    const commentData = {
      ...createCommentDTO,
      authorId: req.user.userId,
    };

    return this.commentsService.createComment(commentData);
  }

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Post)
  @Delete('/:id')
  @ApiOperation({ summary: 'Deleta um Comentário pelo ID' })
  async deleteComment(
    @Param('id') commentId: string,
    @Request() req,
  ): Promise<void> {
    const commentData = {
      commentId,
      authorId: req.user.userId,
    };
    await this.commentsService.deleteComment(commentData);
  }
}
