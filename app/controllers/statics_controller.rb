class StaticsController < ApplicationController
  def home
    if user_signed_in?
      @entry = current_user.entries.build
      @entries = current_user.entries.paginate page: params[:page]
    else
      @entries = Entry.paginate page: params[:page]
    end
  end
end
