# frozen_string_literal: true

require 'sinatra'
require_relative 'controllers/item_controller'
require_relative 'controllers/category_controller'

# Items
get '/' do
  controller = ItemController.new
  controller.list_items
end

get '/items/new' do
  controller = ItemController.new
  controller.add_item
end

get '/items/detail/:id' do
  id = params['id']
  controller = ItemController.new
  controller.detail_item(id)
end

get '/items/edit/:id' do
  id = params['id']
  controller = ItemController.new
  controller.edit_item(id)
end

post '/items/create' do
  controller = ItemController.new
  name = params['name']
  price = params['price']
  category = params['category']
  controller.create_item(name, price, category)
  redirect '/'
end

post '/items/update' do
  controller = ItemController.new
  id = params['id']
  name = params['name']
  price = params['price']
  category = params['category']
  controller.update_item(id, name, price, category)
  redirect '/'
end

delete '/items/delete/:id' do
  id = params['id']
  controller = ItemController.new
  controller.delete_item(id)
end

# Categories
get '/categories' do
  controller = CategoryController.new
  controller.list_categories
end

get '/categories/new' do
  controller = CategoryController.new
  controller.add_category
end

get '/categories/detail/:id' do
  id = params['id']
  controller = CategoryController.new
  controller.detail_category(id)
end

get '/categories/edit/:id' do
  id = params['id']
  controller = CategoryController.new
  controller.edit_category(id)
end

post '/categories/create' do
  controller = CategoryController.new
  name = params['name']
  controller.create_category(name)
  redirect '/'
end

post '/categories/update' do
  controller = CategoryController.new
  id = params['id']
  name = params['name']
  controller.update_category(id, name)
  redirect '/'
end

delete '/categories/delete/:id' do
  id = params['id']
  controller = CategoryController.new
  controller.delete_category(id)
end
