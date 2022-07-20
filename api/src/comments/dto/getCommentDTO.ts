export class GetCommentDTO {
  id: string;
  content: string;
  postId: string;
  authorId: string;
  createdAt: Date;
  updatedAt: Date;
  isOwner?: boolean;
  isLiked?: boolean;
  authorName?: string;
}
