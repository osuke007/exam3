class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy]

  def index
    # @topics = Topic.all
    @topics=Topic.order("updated_at desc")
  end

  def show
    @comment = @topic.comments.build
    @comments = @topic.comments
  end

  def new
    if params[:back]
      @topic = Topic.new(topics_params)
    else
      @topic = Topic.new
    end
  end

  def edit
  end

  def confirm
    @topic = Topic.new(topics_params)
    render :new if @topic.invalid?
  end

  def update
    if @topic.update(topics_params)
      redirect_to topics_path, notice: "トピックを更新しました！"
    else
      render 'edit'
    end
  end

  def destroy
    @topic.destroy
    redirect_to topics_path
  end

  def create
    @topic=Topic.new(topics_params)
    @topic.user_id = current_user.id
    if @topic.save
      redirect_to topics_path, notice: "トピックを作成しました！"
    else
      render 'new'
    end
  end

  private
   def topics_params
     params.require(:topic).permit(:title, :content)
   end

   def set_topic
     @topic=Topic.find(params[:id])
   end
end
