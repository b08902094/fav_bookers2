class PostCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.book_id = book.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @book = Book.find(params[:id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end