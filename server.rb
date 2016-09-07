require 'sinatra'
require 'csv'

get "/" do
  "<h1>News Aggregator</h1>"
  redirect "/articles"
end

get "/articles" do
  @file = File.readlines("articles.csv")
  erb :articles
end

post "/articles/new" do
  @title = params[:title]
  @url = params[:url]
  @description = params[:description]

  @error = nil

  if @title != '' && @url != '' && @description != ''
    if @description.length > 20
      file = CSV.open("articles.csv", "ab") do |csv|
        csv << [@title, @url, @description]
      end
      redirect "/articles"
    else
      @error = "Description length must be greater than 20 characters"
    end
  else
    @error = "Please fill out all fields"
  end
  erb :submit_article
end

get "/articles/new" do
  erb :submit_article
end
