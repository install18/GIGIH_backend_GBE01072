# frozen_string_literal: true

require 'mysql2'
require_relative 'item'
require_relative 'category'

def create_db_client
  Mysql2::Client.new(
    host: '192.168.43.50',
    username: 'root',
    password: 'root',
    database: 'food_oms_db'
  )
end

def get_all_items
  client = create_db_client
  raw_data = client.query('select * from items')
  items = []
  raw_data.each do |data|
    item = Item.new(data["id"], data["name"], data["price"], data["category"])
    items.push(item)
  end
  items
end

def get_all_categories
  client = create_db_client
  raw_data = client.query('select * from categories')
  categories = []
  raw_data.each do |data|
    category = Category.new(data["id"], data["name"])
    categories.push(category)
  end
  categories
end

def get_items_categories
  client = create_db_client
  client.query(
    "SELECT items.name AS 'name', categories.name AS 'category', items.price AS 'price'
FROM item_categories
JOIN items on items.id = item_categories.item_id
JOIN categories on categories.id = item_categories.category_id"
  )
end

def insert_item(name, price, category)
  client = create_db_client
  client.query("INSERT INTO items(name, price) VALUES('#{name}', #{price})")
  id = client.last_id
  client.query("INSERT INTO item_categories(item_id, category_id) VALUES(#{id}, #{category})")
end
