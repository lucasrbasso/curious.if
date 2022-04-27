import { HttpException } from '@nestjs/common';
import { ValidationError, ValidatorOptions } from 'class-validator';

export interface ValidationPipeOptions extends ValidatorOptions {
  transform: true;
  disableErrorMessages: false;
  exceptionFactory: (errors: ValidationError[]) => HttpException;
}
