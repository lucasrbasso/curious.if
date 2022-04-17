import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { PostService } from './post/post.service';
import { DatabaseModule } from './database/database.module';
import { PostController } from './post/post.controller';
import { APP_FILTER } from '@nestjs/core';
import { ErrorHandlingFilter } from './errors/error-handling-filter';

@Module({
  imports: [DatabaseModule],
  controllers: [AppController, PostController],
  providers: [
    AppService, 
    PostService,
    {
      provide: APP_FILTER,
      useClass: ErrorHandlingFilter,
    }],
})
export class AppModule {}
