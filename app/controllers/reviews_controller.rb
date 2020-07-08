class ReviewsController < ApplicationController
  
 require 'net/http'
 require 'json'
 require 'uri'
 
 API_BASE_URL='https://api.gnavi.co.jp/PhotoSearchAPI/v3/'
 
  def index
  keyword = params[:search]
  keyword || (keyword = "美味しい")

  param = {
    "keyid"         => "2591a7e3ba2c49fa50cf56339ec3441e",
    "comment"       => URI.encode(keyword),
    "hit_per_page"  => 10,
    "sort"          => 1
  }

  uri = URI(API_BASE_URL + '?' + param.map{|k,v| "#{k}=#{v}"}.join('&'))

  response_json = Net::HTTP.get(uri)

  @response_data = JSON.parse(response_json)
  
  end

  def show
  end
end
