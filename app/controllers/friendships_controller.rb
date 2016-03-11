class FriendshipsController < ApplicationController
  before_action :set_friendship, only: [ :destroy]



  def create
    @friendship = Friendship.new(friendship_params)
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to :back, notice: 'Friendship was successfully created.' }
        format.json { render :show, status: :created, location: @friendship }
      else
        format.html { render :new }
        format.json { render json: @friendship.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Friendship was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_friendship
      @friendship = Friendship.find(params[:id])
    end

    def friendship_params
      params.require(:friendship).permit(:friender_id, :friended_id)
    end
end
