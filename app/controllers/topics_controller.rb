class TopicsController < ApplicationController
  def index
    @topics = Topic.all
  end

  def new
    @topics = Topic.new
  end

  def edit
      @topic = Topic.find(params[:id])
  end

  def create
    Topic.create(topics_params)
    redirect_to topics_path
  end

  private
   def topics_params
     params.require(:topic).permit(:title, :content)
   end
end
