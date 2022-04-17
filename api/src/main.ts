import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PrismaService } from './database/prisma/prisma.service';
import { ErrorHandlingFilter } from './errors/error-handling-filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalFilters(new ErrorHandlingFilter());

  const prismaService = app.get(PrismaService);
  await app.listen(3000);
  await prismaService.enableShutdownHooks(app);
}
bootstrap();
