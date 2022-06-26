import { Module } from '@nestjs/common';
import { DatabaseModule } from './database/database.module';
import { UsersModule } from './users/users.module';
import { PostModule } from './post/post.module';
import { AuthModule } from './auth/auth.module';
import { CommentsModule } from './comments/comments.module';
import { CommentsReportModule } from './comments-report/comments-report.module';

@Module({
  imports: [DatabaseModule, UsersModule, PostModule, AuthModule, CommentsModule, CommentsReportModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
