import { Module } from '@nestjs/common';
import { DatabaseModule } from './database/database.module';
import { UsersModule } from './users/users.module';
import { PostModule } from './post/post.module';
import { AuthModule } from './auth/auth.module';
import { CommentsModule } from './comments/comments.module';
import { ReportsModule } from './reports/reports.module';

@Module({
  imports: [
    DatabaseModule,
    UsersModule,
    PostModule,
    AuthModule,
    CommentsModule,
    ReportsModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
