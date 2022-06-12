import { Module } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CommentsController } from './comments.controller';
import { ErrorHandlingFilter } from 'src/errors/error-handling-filter';
import { APP_FILTER } from '@nestjs/core';
import { DatabaseModule } from 'src/database/database.module';

@Module({
  imports: [DatabaseModule],
  controllers: [CommentsController],
  providers: [
    CommentsService,
    {
      provide: APP_FILTER,
      useClass: ErrorHandlingFilter,
    },
  ],
})
export class CommentsModule {}
