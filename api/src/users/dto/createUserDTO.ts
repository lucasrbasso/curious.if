import { Exclude } from 'class-transformer';
import { IsEmail, IsNotEmpty, MinLength } from 'class-validator';

export class CreateUserDTO {
  @IsNotEmpty()
  @MinLength(3, {
    message: 'Name should have more than 3 characters',
  })
  name: string;

  @IsNotEmpty()
  @Exclude()
  @MinLength(6, {
    message: 'Password should have more than 5 characters',
  })
  password: string;

  @IsEmail()
  @IsNotEmpty()
  email: string;
}
