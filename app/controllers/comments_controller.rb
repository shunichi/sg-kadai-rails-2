class CommentsController < ApplicationController
  before_action :set_comment, only: [:destroy, :approve]

  def create
    @comment = Comment.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to blog_entry_path(@comment.entry.blog_id, @comment.entry), notice: 'Comment was successfully added.' }
        format.json { render json: @comment, status: :created }

        @mail = Notifications.comment_mail(@comment).deliver
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

  def approve
    respond_to do |format|
      if @comment.update(status: 'approved')
        format.html { redirect_to blog_entry_path(@comment.entry.blog_id, @comment.entry), notice: 'Comment was succcessfully approved.' }
        format.json { render json: @comment, status: :ok }
      else
        format.html { render blog_entry_path(@comment.entry.blog_id, @comment.entry) }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
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