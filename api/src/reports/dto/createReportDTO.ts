import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsNotEmpty, IsOptional, IsUUID } from 'class-validator';

enum ReportType {
  COMMENT = 'COMMENT',
  POST = 'POST',
}

export class CreateReportDTO {
  @ApiProperty()
  @IsOptional()
  content: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsEnum(ReportType)
  type: 'COMMENT' | 'POST';

  @ApiProperty()
  @IsOptional()
  @IsUUID()
  postId: string;

  @ApiProperty()
  @IsOptional()
  @IsUUID()
  commentId: string;
}
