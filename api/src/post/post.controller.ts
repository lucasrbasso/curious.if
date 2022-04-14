import {
  Controller,
  Get,
  Post,
  Req,
  Body,
} from '@nestjs/common';
import { PostService } from "./post.service";

@Controller()
export class PostController{
  constructor(private readonly postService: PostService) {}

  // Métodos HTTP - POST GET PUT
  // Chama os métodos do service dentro dos métodos HTTP
  @Get()
  getHello(): string {
    return 'Hello World';
  }

  // @
}