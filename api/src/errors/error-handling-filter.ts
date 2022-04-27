import {
  ArgumentsHost,
  BadRequestException,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';

@Catch()
export class ErrorHandlingFilter implements ExceptionFilter {
  catch(exception: any, host: ArgumentsHost): any {
    const context = host.switchToHttp();
    const response = context.getResponse();

    const statusCode =
      exception instanceof HttpException
        ? exception.getStatus()
        : HttpStatus.INTERNAL_SERVER_ERROR;

    if (exception instanceof PrismaClientKnownRequestError) {
      response.status(statusCode).json({
        statusCode,
        message: `Prisma Error - ${exception.code} ${
          exception.meta['cause'] ? '- ' + exception.meta['cause'] : ''
        }`,
      });
    }
    let message = 'Internal server error';
    if (exception instanceof BadRequestException) {
      const err: any = exception.getResponse();

      if (typeof err === 'string') {
        message = err;
      } else {
        message = err.message;
      }
    }
    const errorResponse: any = {
      statusCode,
      message,
    };

    response.status(statusCode).json(errorResponse);
  }
}
