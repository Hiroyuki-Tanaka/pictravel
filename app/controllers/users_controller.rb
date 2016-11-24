class UsersController < ApplicationController


def show
  @user = User.find(params[:id])
  @pictures = @user.pictures.order("created_at DESC")
  @ave_ranks = []
  @user.pictures.each do |picture|
    if picture.ave_rank
  @ave_ranks << picture.ave_rank.to_i
    end
  end
  @sum_ranks = 0
  @ave_ranks.each do |ave_rank|
  @sum_ranks = @sum_ranks + ave_rank
  end
    unless @ave_ranks.length == 0
  @total_ave_ranks = @sum_ranks / @ave_ranks.length
    else
  @total_ave_ranks = "評価なし"
    end
end

end