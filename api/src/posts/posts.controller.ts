import {
  Controller,
  Get,
  Post,
  Req,
  Body,
} from '@nestjs/common';
import { PostsService } from "./posts.service";

@Controller()
export class PostsController{
  constructor(private readonly postService: PostsService) {}

  // Métodos HTTP - POST GET PUT
  // Chama os métodos do service dentro dos métodos HTTP
  @Get()
  getHello(): string {
    return 'Hello World';
  }

  // @
}