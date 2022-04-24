import { ApiProperty } from '@nestjs/swagger';
import { Exclude } from 'class-transformer';
import { IsEmail, IsNotEmpty, MinLength } from 'class-validator';

export class CreateUserDTO {
  @ApiProperty()
  @IsNotEmpty()
  @MinLength(3, {
    message: 'Name should have more than 3 characters',
  })
  name: string;

  @ApiProperty()
  @IsNotEmpty()
  @MinLength(6, {
    message: 'Password should have more than 5 characters',
  })
  password: string;

  @ApiProperty()
  @IsEmail()
  @IsNotEmpty()
  email: string;
}
