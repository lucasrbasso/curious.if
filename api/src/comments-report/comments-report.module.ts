import { Module } from '@nestjs/common';
import { CommentsReportService } from './comments-report.service';
import { CommentsReportController } from './comments-report.controller';
import { DatabaseModule } from 'src/database/database.module';
import { APP_FILTER } from '@nestjs/core';
import { ErrorHandlingFilter } from 'src/errors/error-handling-filter';

@Module({
  imports: [DatabaseModule],
  controllers: [CommentsReportController],
  providers: [
    CommentsReportService,
    {
      provide: APP_FILTER,
      useClass: ErrorHandlingFilter,
    },
  ],
})
export class CommentsReportModule {}
