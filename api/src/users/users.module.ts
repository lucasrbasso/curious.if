import { Module } from '@nestjs/common';
import { APP_FILTER } from '@nestjs/core';
import { DatabaseModule } from 'src/database/database.module';
import { ErrorHandlingFilter } from 'src/errors/error-handling-filter';
import { UsersController } from './users.controller';
import { UsersService } from './users.service';

@Module({
  imports: [DatabaseModule],
  controllers: [UsersController],
  providers: [
    UsersService,
    {
      provide: APP_FILTER,
      useClass: ErrorHandlingFilter,
    },
  ],
  exports: [UsersService],
})
export class UsersModule {}
