class StaticsController < ApplicationController
  def home
    if user_signed_in?
      @entry = current_user.entries.build
      @entries = Entry.latest_by_followings_users_and(current_user).paginate page: params[:page]
    else
      @entries = Entry.paginate page: params[:page]
    end
  end
end
