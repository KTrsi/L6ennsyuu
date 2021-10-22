class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all
  end

  def new
    @tweet = Tweet.new
  end

  def create
    #ログイン中にしたツイートリンクが表示されないのでsession[:user_id]が空であることは考慮しなくてよい
    user = User.find_by(uid: current_user.uid)
    @tweet = Tweet.new(message: params[:tweet][:message], user_id: user.id)
    if @tweet.save
      flash[:notice] = '1レコード追加しました'
      #TODO: ツイートが成功したことをユーザに知らせる
      redirect_to root_path
    else
      render 'new'
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    tweet.destroy
    redirect_to root_path
  end
end
