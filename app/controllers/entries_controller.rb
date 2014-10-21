class EntriesController < ApplicationController
  before_action :signed_in_user_check, only: [:new, :create]
  before_action :set_entry, only: [:show]

  respond_to :html
  
  def index
    @entries = Entry.paginate page: params[:page]
  end

  def show
    @comments = @entry.comments.paginate page: params[:page]
  end

  def create
    @entry = current_user.entries.build entry_params
    if @entry.save
      flash[:success] = 'You just posted a new entry.'
      redirect_to root_path
    else
      render 'statics/home'
    end
  end

  private
    def set_entry
      @entry = Entry.find(params[:id])
    end

    def entry_params
      params.require(:entry).permit(:title, :body)
    end
end
