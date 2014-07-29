class TweetsController < ApplicationController
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]
def index  

    @tweets = current_user.timeline_tweets.page(params[:page]).per(10)
   # puts "\n\n\n\nTimeline Tweets\n#{@tweets.inspect}\n\n\n\n\n\n"

  end


  def show
  #  puts "\n\nSHOW action\n\n"
  end

  def new
    @tweet = Tweet.new

  end

  def edit
  end

  def create
     puts "\n\nCREATE action\n\n"
    @tweet = Tweet.new(tweet_params)

      if @tweet.save
        @msg = "Successfull"
        current_user.tweets << @tweet
        current_user.save
        redirect_to my_tweets_path('me'), notice: 'Tweet was successfully created.'
    
      else
        @msg = "Unsuccessfull"
        render action: 'new'
     
      end
 
  end

  def update
    #puts "\n\nUPDATE action\n\n"
    #puts "#{@tweet.inspect}\n\n\n"
    #puts "#{tweet_params[:tweet]}\n\n\n"
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to user_tweet_path(current_user,@tweet), notice: 'Tweet was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  def destroy
    puts "\n\n\n#{@tweet.user.inspect}   #{current_user.inspect}\n\n\n"
    if @tweet.user == current_user
      @tweet.destroy
      msg = 'Tweet deleted successfully'
    else
      msg = 'Permission denied !'
    end

   
   redirect_to user_tweets_url(current_user),:notice => msg
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tweet_params
      params.require(:tweet).permit(:content,:tweet)
    end
end
