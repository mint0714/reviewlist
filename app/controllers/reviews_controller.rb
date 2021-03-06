class ReviewsController < ApplicationController

  require 'net/http'
  require 'json'
  require 'uri'
  
  API_BASE_URL='https://api.gnavi.co.jp/PhotoSearchAPI/v3/'
   
  def index
    keyword = params[:search]
    keyword ||= "美味しい"
    
    area = params[:area]
    
    param = {
      "keyid"         => "2591a7e3ba2c49fa50cf56339ec3441e",
      "comment"       => URI.encode(keyword),
      "hit_per_page"  => 50,
      "sort"          => 1
    }
    
    if area
      param["area"] = URI.encode(area)
    end
  
    uri = URI(API_BASE_URL + '?' + param.map{|k,v| "#{k}=#{v}"}.join('&'))
  
    response_json = Net::HTTP.get(uri)
  
    @response_data = JSON.parse(response_json)
    
    @review = Review.new
  end
    
  def create
    review = Review.find_by(vote_id: params[:vote_id])
    
    #レビューを保存、お気に入りにする処理
    if review
      current_user.favorite(review)
    else
      @review = Review.create(vote_id: params[:vote_id],image_url: params[:image_url],menu_name: params[:menu_name],shop_url: params[:shop_url],update_date: params[:update_date],shop_name: params[:shop_name],comment: params[:comment])
      @review.save
      current_user.favorite(@review)
    end
    
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
