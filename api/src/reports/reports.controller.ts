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

import { ReportsService } from './reports.service';
import { CreateReportDTO } from './dto/createReportDTO';
import { GetReportDTO } from './dto/getReportDTO';
import { RolesGuard } from 'src/users/roles/role.guard';
import { Roles } from 'src/users/roles/roles.decorator';
import { Role } from 'src/users/roles/role.enum';
import { GetCommentDTO } from 'src/comments/dto/getCommentDTO';
import { PostDTO } from 'src/post/dto/get-post-output.dto';

@Controller('api/reports')
export class ReportsController {
  constructor(private readonly reportService: ReportsService) {}

  @UseGuards(JwtAuthGuard, PermissionsGuard)
  @Permissions(Permission.Read)
  @Post()
  @ApiOperation({ summary: 'Cria um report' })
  async createCommentReport(
    @Body() { postId, commentId, content, type }: CreateReportDTO,
    @Request() req,
  ): Promise<GetReportDTO> {
    return this.reportService.createReport({
      userId: req.user.userId,
      commentId,
      postId,
      content,
      type,
    });
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('comments')
  @ApiOperation({ summary: 'Retorna todos os comentários reportados' })
  async getAllReportedComments(): Promise<GetReportDTO[]> {
    return this.reportService.getAllReportedComments();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('posts')
  @ApiOperation({ summary: 'Retorna todos os posts reportados' })
  async getAllReportedPosts(): Promise<GetReportDTO[]> {
    return this.reportService.getAllReportedPosts();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get()
  @ApiOperation({ summary: 'Retorna todos os comentários/posts reportados' })
  async getAllReportedItems(): Promise<GetReportDTO[]> {
    return this.reportService.getAllReportedItems();
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('user/:id')
  @ApiOperation({
    summary: 'Retorna todos os reports de um usuário específico',
  })
  async getAllReportsByUserId(
    @Param('id') userId: string,
  ): Promise<GetReportDTO[]> {
    return this.reportService.getAllReportsByUserId(userId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('post/:id')
  @ApiOperation({
    summary: 'Retorna todos os reports de um post específico',
  })
  async getAllReportsByPostId(
    @Param('id') postId: string,
  ): Promise<GetReportDTO[]> {
    return this.reportService.getAllReportsByPostId(postId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Get('/:id')
  @ApiOperation({
    summary: 'Retorna um comentário reportado específico',
  })
  async getReportedItem(
    @Param('id') commentReportId: string,
  ): Promise<GetReportDTO> {
    return this.reportService.getReportedItem(commentReportId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('dismiss/:id')
  @ApiOperation({
    summary: 'Deleta um report',
  })
  async dismissReport(@Param('id') reportId: string): Promise<GetReportDTO> {
    return this.reportService.dismissReport(reportId);
  }

  @UseGuards(JwtAuthGuard, RolesGuard)
  @Roles(Role.Admin)
  @Delete('accept/:id')
  @ApiOperation({
    summary: 'Aprova um report',
  })
  async acceptReport(
    @Param('id') reportId: string,
  ): Promise<GetCommentDTO | PostDTO> {
    return this.reportService.acceptReport(reportId);
  }
}
