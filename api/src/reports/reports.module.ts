import { Module } from '@nestjs/common';
import { ReportsService } from './reports.service';
import { ReportsController } from './reports.controller';
import { DatabaseModule } from 'src/database/database.module';
import { APP_FILTER } from '@nestjs/core';
import { ErrorHandlingFilter } from 'src/errors/error-handling-filter';

@Module({
  imports: [DatabaseModule],
  controllers: [ReportsController],
  providers: [
    ReportsService,
    {
      provide: APP_FILTER,
      useClass: ErrorHandlingFilter,
    },
  ],
})
export class ReportsModule {}
