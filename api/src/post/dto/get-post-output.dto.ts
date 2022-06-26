export class PostDTO {
  id: string;
  content: string;
  to?: string;
  numberOfLikes: number;
  published: boolean;
  createdAt: Date;
  updatedAt: Date;
}

export class UserPostDTO {
  id: string;
  content: string;
  to?: string;
  numberOfLikes: number;
  isLiked: boolean;
  published: boolean;
  createdAt: Date;
  updatedAt: Date;
}
