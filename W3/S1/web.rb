require 'sinatra'
require_relative './db_connect'

get '/' do
  items = get_items_categories

  erb :index, locals: {
    items: items
  }
end

get '/items/new' do
  categories = get_all_categories

  erb :new, locals: {
    categories: categories
  }
end

post '/items/create' do
  name = params['name']
  price = params['price']
  category = params['category']
  insert_item(name, price, category)
  redirect '/'
end