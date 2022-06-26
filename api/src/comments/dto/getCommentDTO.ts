export class GetCommentDTO {
  id: string;
  content: string;
  postId: string;
  authorId: string;
  createdAt: Date;
  updatedAt: Date;
  isLiked?: boolean;
  authorName?: string;
}
