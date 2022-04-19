import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { PrismaService } from './database/prisma/prisma.service';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { ErrorHandlingFilter } from './errors/error-handling-filter';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  app.useGlobalFilters(new ErrorHandlingFilter());

  const config = new DocumentBuilder()
  .setTitle('Curious.IF')
  .setDescription('API para envio de spotted')
  .setVersion('1.0')
  .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api', app, document);

  const prismaService = app.get(PrismaService);
  await app.listen(3000);
  await prismaService.enableShutdownHooks(app);
}
bootstrap();
