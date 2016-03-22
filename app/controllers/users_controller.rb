class UsersController < ApplicationController
  def preferences
    @user = current_user
  end
end
