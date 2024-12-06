class FriendRequestsController < ApplicationController
  before_action :authenticate_user!

  def create
    @friend_request = current_user.sent_friend_requests.build(receiver_id: params[:receiver_id], status: 'pending')

    if @friend_request.save
      flash[:notice] = "Friend request sent."
    else
      flash[:alert] = "Unable to send friend request."
    end
    redirect_to users_path
  end

  def update
    @friend_request = FriendRequest.find(params[:id])
    if @friend_request.update(status: params[:status])
      flash[:notice] = "Friend request #{params[:status]}."
    else
      flash[:alert] = "Unable to update friend request."
    end
    redirect_to users_path
  end

  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    flash[:notice] = "Friend request canceled."
    redirect_to users_path
  end
end
