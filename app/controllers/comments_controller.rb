class CommentsController < ApplicationController


  def edit
  end

  def update
    if @comment.update(comments_params)
      redirect_to commnets_path, notice: "トピックを更新しました！"
    else
      render 'edit'
    end
  end

  # コメントを保存、投稿するためのアクションです。
  def create
    # ログインユーザーに紐付けてインスタンス生成するためbuildメソッドを使用します。
    @comment = current_user.comments.build(comment_params)
    @topic = @comment.topic

    # クライアント要求に応じてフォーマットを変更
    # respond_toは、クライアントからの要求に応じてレスポンスのフォーマットを変更します。
    respond_to do |format|
      if @comment.save
        format.html { redirect_to topic_path(@topic), notice: 'コメントを投稿しました。' }
        format.json { render :show, status: :created, location: @comment }
        # JS形式でレスポンスを返します。
        format.js { render :index }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
      @comment = Comment.find(params[:id])
      @comment.destroy

      # respond_toは、クライアントからの要求に応じてレスポンスのフォーマットを変更します。
      respond_to do |format|
         if @comment.delete
           format.html { redirect_to topic_path(@topic), notice: 'コメントを削除しました。' }
           format.json { render :show, status: :created, location: @comment }
           # JS形式でレスポンスを返します。
           format.js { render :index }
         else
           format.html { render :new }
           format.json { render json: @comment.errors, status: :unprocessable_entity }
         end
       end
  end

  private
    # ストロングパラメーター
    def comment_params
      params.require(:comment).permit(:topic_id, :content)
    end
end
