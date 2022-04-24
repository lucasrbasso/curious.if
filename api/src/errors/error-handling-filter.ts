import {
  ArgumentsHost,
  BadRequestException,
  Catch,
  ExceptionFilter,
  ForbiddenException,
  HttpException,
  HttpStatus,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaClientKnownRequestError } from '@prisma/client/runtime';

@Catch()
export class ErrorHandlingFilter implements ExceptionFilter {
  catch(exception: any, host: ArgumentsHost): any {
    console.log(exception);

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

    if (exception instanceof HttpException) {
      const err: any = exception.getResponse();

      switch (exception.constructor) {
        case BadRequestException:
          if (typeof err === 'string') {
            message = err;
          } else {
            message = err.message;
          }
          break;
        case UnauthorizedException:
          message = err.message;
          break;
        case ForbiddenException:
          message = err.message;
          break;
        default:
          message = 'Internal server error';
          break;
      }
    }

    const errorResponse: any = {
      statusCode,
      message,
    };

    response.status(statusCode).json(errorResponse);
  }
}
