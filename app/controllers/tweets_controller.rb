class TweetsController < ApplicationController
  before_action :authenticate_user!
    def index
     
      if params[:search] == nil
        @tweets= Tweet.all
    elsif params[:search] == ''
        @tweets= Tweet.all
    else
        @tweets = Tweet.where("target LIKE ? ",'%' + params[:search] + '%')
    end
      if params[:tag_ids]
        @tweets = []
        params[:tag_ids].each do |key, value|
            if value == "1"
                tag_tweets = Tag.find_by(name: key).tweets
                @tweets = @tweets.empty? ? tag_tweets : @tweets & tag_tweets
            end
           
          
          
        end
    end
      if params[:tag]
        Tag.create(name: params[:tag])
      end
    end
    #追加箇所
  def new
    @tweet = Tweet.new
  end

  def create
    tweet = Tweet.new(tweet_params)
    tweet.user_id = current_user.id
    if tweet.save!
      redirect_to :action => "index"
    else
      redirect_to :action => "new"
    end
  end
  def show
    @tweet = Tweet.find(params[:id])
    @comments = @tweet.comments
    @comment = Comment.new
end
  private
  def tweet_params
    params.require(:tweet).permit(:target, :about, :image, :deadline, tag_ids: [])
  end
 #ここまで
 
 
end
