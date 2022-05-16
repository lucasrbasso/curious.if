export class PostDTO {
  id: string;
  content: string;
  to?: string;
  published: boolean;
  createdAt: Date;
  updatedAt: Date;
}
