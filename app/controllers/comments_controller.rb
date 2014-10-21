class CommentsController < ApplicationController
  before_action :signed_in_user_check, except: [:index]

  def create
    @comment = current_user.comments.build comment_params
    if @comment.save
      flash[:success] = 'Your comment has been added.'
      redirect_to @comment
    else
      flash[:danger] = @comment.errors.full_messages[0]
      redirect_to Entry.find(params[:comment][:entry_id])
    end
  end

  private
    def comment_params
      params.require(:comment).permit(:content, :entry_id)
    end
end
