
import { HttpException, HttpStatus, Injectable } from '@nestjs/common';
import { PrismaService } from '../database/prisma/prisma.service';
import { Post as PostModel } from '@prisma/client';
import { User } from '@prisma/client';

@Injectable()
export class PostService {
    constructor(private prisma: PrismaService) {}

    async getAllPosts(): Promise<PostModel[]> {
        const posts = await this.prisma.post.findMany();

        if(posts.length === 0){
            throw new HttpException('No posts found.', HttpStatus.NOT_FOUND);
        }

        return posts;
    }

    async getPostById(id: string): Promise<PostModel> {
        const post = await this.prisma.post.findUnique({ where: { id: Number(id) } });

        if(post === null){
            throw new HttpException('Post not found.', HttpStatus.NOT_FOUND);
        }
        return post;
    }
    
    async createPost(newPost: {authorId: number, content: string}): Promise<PostModel> {
        if(newPost.authorId == null) 
          throw new HttpException('AuthorId is required.', HttpStatus.BAD_REQUEST)  ;

        // Remover try/catch ao adicionar um middleware para tratar as exceções
        try{
            return this.prisma.post.create({
                data: {
                  content: newPost.content,
                  author: {
                    connect: { id: newPost.authorId },
                  },
                },
            });
        } catch(err: any){
            throw new HttpException('There was an error when creating a post.', HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    async deletePost(id: string): Promise<PostModel> {
        const post = await this.prisma.post.findUnique({ where: { id: Number(id) }});

        if(post === null) {
            throw new HttpException('Post not found.', HttpStatus.NOT_FOUND);
        }

        return this.prisma.post.delete({ where: { id: Number(id) }});
    }

    async criaUsuario(): Promise<User>{
        return this.prisma.user.create({
            data: {
                name: 'Heriklys',
            }
        });
    }
}