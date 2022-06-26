import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsOptional, IsUUID } from 'class-validator';

export class CreateCommentReportDTO {
  @ApiProperty()
  @IsOptional()
  content: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsUUID()
  postId: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsUUID()
  commentId: string;
}
