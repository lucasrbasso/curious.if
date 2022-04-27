import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { DatabaseModule } from 'src/database/database.module';
import { ErrorHandlingFilter } from 'src/errors/error-handling-filter';
import { PostController } from './post.controller';
import { PostService } from './post.service';

@Module({
  imports: [DatabaseModule],
  controllers: [PostController],
  providers: [
    PostService,
    {
      provide: APP_FILTER,
      useClass: ErrorHandlingFilter,
    },
  ],
})
export class PostModule {}
