class CommentsController < ApplicationController
  def create
    @report = Report.find(params[:report_id])
    @comment = Comment.new(comment_params)
    @comment.report = @report
    authorize @comment
    if @comment.save
      redirect_to request.referrer
    else
      render 'shared/comments'
    end
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize @comment
    @comment.destroy
    redirect_to request.referrer
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :category, :title)
  end
end
