import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsNotEmpty, MinLength } from 'class-validator';

export class UpdateUserDTO {
  @ApiProperty()
  @IsNotEmpty()
  id: string;

  @ApiProperty()
  @IsNotEmpty()
  name: string;

  @ApiProperty()
  @IsNotEmpty()
  @IsEmail()
  email: string;

  @ApiProperty()
  @IsNotEmpty()
  @MinLength(6, {
    message: 'Password should have more than 5 characters',
  })
  password?: string;

  @ApiProperty()
  @MinLength(6, {
    message: 'Password should have more than 5 characters',
  })
  old_password?: string;
}
