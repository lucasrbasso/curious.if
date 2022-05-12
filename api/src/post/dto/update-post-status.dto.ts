import { ApiProperty } from '@nestjs/swagger';
import { IsNotEmpty, IsBoolean, IsString } from 'class-validator';

export class UpdatePostStatusDTO {
  @ApiProperty()
  @IsNotEmpty()
  @IsString()
  id: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsBoolean()
  published: boolean;
}
