import {
  Body,
  Request,
  Controller,
  Post,
  UseGuards,
  Delete,
  Param,
  Get,
} from '@nestjs/common';
import { ApiOperation } from '@nestjs/swagger';

import { JwtAuthGuard } from 'src/auth/jwt-auth.guard';
import { Permission } from 'src/users/permissions/permission.enum';
import { PermissionsGuard } from 'src/users/permissions/permissions.guard';
import { Permissions } from 'src/users/permissions/permissions.decorator';

import { CommentsReportService } from './comments-report.service';
import { CreateCommentReportDTO } from './dto/createCommentReportDTO';
import { GetCommentReportDTO } from './dto/getCommentReportDTO';
import { RolesGuard } from 'src/users/roles/role.guard';
import { Roles } from 'src/users/roles/roles.decorator';
import { Role } from 'src/users/roles/role.enum';
import { GetCommentDTO } from 'src/comments/dto/getCommentDTO';

@Controller('api/comments-report')
export class CommentsReportController {
  constructor(private readonly commentsReportService: CommentsReportService) {}

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Post()
  @ApiOperation({ summary: 'Cria um report sobre um comentário' })
  async createCommentReport(
    @Body() { postId, commentId, content }: CreateCommentReportDTO,
    @Request() req,
  ): Promise<GetCommentReportDTO> {
    return this.commentsReportService.createCommentReport({
      userId: req.user.userId,
      commentId,
      postId,
      content,
    });
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get()
  @ApiOperation({ summary: 'Retorna todos os comentários reportados' })
  async getAllReportedComments(): Promise<GetCommentReportDTO[]> {
    return this.commentsReportService.getAllReportedComments();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('/user/:id')
  @ApiOperation({
    summary: 'Retorna todos os comentários reportados de um usuário específico',
  })
  async getAllReportedCommentsByUserId(
    @Param('id') userId: string,
  ): Promise<GetCommentReportDTO[]> {
    return this.commentsReportService.getAllReportedCommentsByUserId(userId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('/post/:id')
  @ApiOperation({
    summary: 'Retorna todos os comentários reportados de um post específico',
  })
  async getAllReportedCommentsByPostId(
    @Param('id') postId: string,
  ): Promise<GetCommentReportDTO[]> {
    return this.commentsReportService.getAllReportedCommentsByPostId(postId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('/:id')
  @ApiOperation({
    summary: 'Retorna um comentário reportado específico',
  })
  async getReportedComment(
    @Param('id') commentReportId: string,
  ): Promise<GetCommentReportDTO> {
    return this.commentsReportService.getReportedComment(commentReportId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('dismiss/:id')
  @ApiOperation({
    summary: 'Deleta o report de um comentário',
  })
  async dismissReportComment(
    @Param('id') commentReportId: string,
  ): Promise<GetCommentReportDTO> {
    return this.commentsReportService.dismissReportComment(commentReportId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('accept/:id')
  @ApiOperation({
    summary: 'Aceita o report de um comentário',
  })
  async acceptReportComment(
    @Param('id') commentReportId: string,
  ): Promise<GetCommentDTO> {
    return this.commentsReportService.acceptReportComment(commentReportId);
  }
}
