class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy]

  def create
    @comment = Comment.new(comment_params)
    @comment.status = 'unapproved'

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_entry_path(@comment.entry.blog_id, @comment.entry), notice: 'Comment was successfully added.' }
        format.json { render json: @comment, status: :created }
      else
        format.html { render blog_entry_path(@comment.entry.blog_id, @comment.entry) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to blog_entry_path(@comment.entry.blog_id, @comment.entry), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:body, :entry_id)
    end
end