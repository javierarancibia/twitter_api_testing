class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]
  require 'twitter'

  # GET /tweets or /tweets.json
  def index
    
    client = Twitter::REST::Client.new do |config|
      config.consumer_key        = "4EXgkUAnATyGrv0pqLdSIQ9Ev"
      config.consumer_secret     = "hytsneSdUB7WkG89I0dwo9YD3qeWwSKvZENiTcCldU7B7D6bCq"
      config.access_token        = "AAAAAAAAAAAAAAAAAAAAAIWENQEAAAAAryE4E9Sjvjq%2FQ788q%2BIEugSRqrY%3D6BHx8nXPxEyhejS2MuttGmQQaD92FGkgISReSIHdNwmlIpMLeU"
      # config.access_token_secret = "AAAAAAAAAAAAAAAAAAAAAIWENQEAAAAAryE4E9Sjvjq%2FQ788q%2BIEugSRqrY%3D6BHx8nXPxEyhejS2MuttGmQQaD92FGkgISReSIHdNwmlIpMLeU"
    end
    
    @tweets = client.search('#coronavirus').take(50)
    
    
    respond_to do |format|
      format.html {}
      format.js {@tweets}
    end

    


  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :hashtag, :user)
    end
end
