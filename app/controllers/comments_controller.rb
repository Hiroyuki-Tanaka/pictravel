class CommentsController < ApplicationController

 def new
   @picture = Picture.find(params[:picture_id])
   @comment = Comment.new
 end

 def create
   Comment.create(comment_params)

 array = Comment.where(picture_id: params[:picture_id])

   a_ranks =[]
 array.each do |ele|
   a_ranks << ele.rank.to_i
 end


 picture = Picture.find(params[:picture_id])
 picture.ave_rank = a_ranks.inject(0.0){|r,i| r+=i }/array.size
 picture.save


 redirect_to controller: :pictures, action: :index
end

  private
  def comment_params
    params.require(:comment).permit(:rank, :comment).merge(picture_id: params[:picture_id], user_id: current_user.id)
  end

end



