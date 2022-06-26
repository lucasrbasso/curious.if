-- AlterTable
ALTER TABLE "Comment" ADD COLUMN     "numberOfLikes" INTEGER NOT NULL DEFAULT 0;

-- CreateTable
CREATE TABLE "CommentLike" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "commentId" TEXT NOT NULL,
    "postId" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "CommentLike_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "CommentLike" ADD CONSTRAINT "CommentLike_postId_fkey" FOREIGN KEY ("postId") REFERENCES "Post"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommentLike" ADD CONSTRAINT "CommentLike_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CommentLike" ADD CONSTRAINT "CommentLike_commentId_fkey" FOREIGN KEY ("commentId") REFERENCES "Comment"("id") ON DELETE CASCADE ON UPDATE CASCADE;
