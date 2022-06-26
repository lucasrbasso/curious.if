import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsUUID, MinLength } from 'class-validator';

export class CreateCommentDTO {
  @ApiProperty()
  @IsNotEmpty()
  @MinLength(1, {
    message: 'Content should have at least 1 character',
  })
  content: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsUUID()
  postId: string;
}
