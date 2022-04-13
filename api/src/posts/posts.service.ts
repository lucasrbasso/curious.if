import { Injectable } from "@nestjs/common";

@Injectable()
export class PostService {
  // Métodos para manipulação dos posts
  getHello(): string {
      return 'Oi';
  }
}