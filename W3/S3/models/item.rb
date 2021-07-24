# frozen_string_literal: true

require_relative '../db/db_connect'

class Item
  attr_reader :id, :name, :price, :category

  # @param [Integer] id
  # @param [String] name
  # @param [Integer] price
  # @param [Object, Integer] category
  def initialize(id, name, price, category = nil)
    @id = id
    @name = name
    @price = price
    @category = category
  end

  def save
    client = create_db_client
    client.query("INSERT INTO items(name, price) VALUES('#{@name}', #{@price})")
    id = client.last_id
    client.query("INSERT INTO item_categories(item_id, category_id) VALUES(#{id}, #{category})")
  end

  def update
    client = create_db_client
    client.query("UPDATE items SET name = '#{@name}', price = #{@price} WHERE id = #{@id}")
    client.query("UPDATE item_categories SET category_id = #{@category} WHERE item_id = #{@id}")
  end

  def delete_item
    client = create_db_client
    client.query("DELETE FROM items WHERE id = #{@id}")
    client.query("DELETE FROM item_categories WHERE item_id = #{@id}")
  end

  # @param [Integer] id
  # @return [Object]
  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT items.id AS 'id', items.name AS 'name', items.price AS 'price',
categories.id AS 'category_id', categories.name AS 'category_name'
FROM item_categories
JOIN items on items.id = item_categories.item_id
JOIN categories on categories.id = item_categories.category_id
WHERE items.id = #{id}")
    items = []
    raw_data.each do |data|
      category = Category.new(data['category_id'], data['category_name'])
      item = Item.new(data['id'], data['name'], data['price'], category)
      items.push(item)
    end
    items[0]
  end

  # @return [Array]
  def self.find_by_category(id)
    client = create_db_client
    raw_data = client.query("SELECT items.id AS 'id', items.name AS 'name', items.price AS 'price'
FROM item_categories
JOIN items on items.id = item_categories.item_id
JOIN categories on categories.id = item_categories.category_id
WHERE categories.id = #{id}")
    items = []
    raw_data.each do |data|
      item = Item.new(data['id'], data['name'], data['price'])
      items.push(item)
    end
    items
  end

  # @return [Array]
  def self.find
    client = create_db_client
    raw_data = client.query("SELECT items.id AS 'id', items.name AS 'name', items.price AS 'price',
categories.id AS 'category_id', categories.name AS 'category_name'
FROM item_categories
JOIN items on items.id = item_categories.item_id
JOIN categories on categories.id = item_categories.category_id;")
    items = []
    raw_data.each do |data|
      category = Category.new(data['category_id'], data['category_name'])
      item = Item.new(data['id'], data['name'], data['price'], category)
      items.push(item)
    end
    items
  end

  # @return [Boolean]
  def valid?
    return false if @id.nil?
    return false if @name.nil?
    return false if @price.nil?

    true
  end
end
