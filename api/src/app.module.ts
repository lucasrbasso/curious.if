import { Module } from '@nestjs/common';
import { DatabaseModule } from './database/database.module';
import { UsersModule } from './users/users.module';
import { PostModule } from './post/post.module';
import { AuthModule } from './auth/auth.module';
import { RolesGuard } from './users/roles/role.guard';
import { APP_GUARD } from '@nestjs/core';

@Module({
  imports: [DatabaseModule, UsersModule, PostModule, AuthModule],
  controllers: [],
  providers: [],
})
export class AppModule {}
