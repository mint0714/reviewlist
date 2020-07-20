class ReviewsController < ApplicationController

  require 'net/http'
  require 'json'
  require 'uri'
  
  API_BASE_URL='https://api.gnavi.co.jp/PhotoSearchAPI/v3/'
   
  def index
    keyword = params[:search]
    keyword ||= "美味しい"
    
    if keyword == ""
      keyword = "美味しい"
    end
  
    param = {
      "keyid"         => "2591a7e3ba2c49fa50cf56339ec3441e",
      "comment"       => URI.encode(keyword),
      "hit_per_page"  => 50,
      "sort"          => 1
    }
  
    uri = URI(API_BASE_URL + '?' + param.map{|k,v| "#{k}=#{v}"}.join('&'))
  
    response_json = Net::HTTP.get(uri)
  
    @response_data = JSON.parse(response_json)
    
    @review = Review.new
  end
    
  def create
    review = Review.find_by(vote_id: params[:vote_id])
    
    #レビューを保存する処理
    unless review
      @review = Review.create(vote_id: params[:vote_id],image_url: params[:image_url],menu_name: params[:menu_name],shop_url: params[:shop_url],update_date: params[:update_date],shop_name: params[:shop_name],comment: params[:comment])
      @review.save
    end
     
    #レビューをお気に入りにする処理
    current_user.favorite(review)
     
    flash[:success] = 'お気に入りに追加しました'
    redirect_back(fallback_location: root_path)
  end
    
  def delete
    #お気に入りを解除する処理
    review = Review.find_by(vote_id: params[:vote_id])
    current_user.unfavorite(review)
     
    flash[:success] = 'お気に入りを解除しました'
    redirect_back(fallback_location: root_path)
  end
end
