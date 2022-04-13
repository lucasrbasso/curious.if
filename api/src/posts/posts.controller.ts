import { Controller, Get } from "@nestjs/common";
import { PostService } from "./posts.service";

@Controller()
export class PostsController{
    constructor(private readonly postService: PostService) {}

    // Métodos HTTP - POST GET PUT
    // Chama os métodos do service dentro dos métodos HTTP
    @Get()
    getHello(): string {
    return this.postService.getHello();
  }
}