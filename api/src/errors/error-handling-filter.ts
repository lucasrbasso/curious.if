import {
  ArgumentsHost,
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

    const message =
      exception instanceof HttpException
        ? exception.message || exception.message
        : 'Internal server error';
    const errorResponse: any = {
      statusCode,
      message,
    };

    response.status(statusCode).json(errorResponse);
  }
}
