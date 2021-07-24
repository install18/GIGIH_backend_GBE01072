# frozen_string_literal: true

require_relative '../db/db_connect'

class Category
  attr_reader :id, :name

  # @param [Integer] id
  # @param [String] name
  def initialize(id, name)
    @id = id
    @name = name
  end

  def save
    client = create_db_client
    client.query("INSERT INTO categories(name) VALUES('#{@name}')")
  end

  def update
    client = create_db_client
    client.query("UPDATE categories SET name = '#{@name}' WHERE id = #{@id}")
  end

  def delete_category
    client = create_db_client
    client.query("DELETE FROM categories WHERE id = #{@id}")
    client.query("DELETE FROM item_categories WHERE categories_id = #{@id}")
  end

  # @param [Integer] id
  def self.find_by_id(id)
    client = create_db_client
    raw_data = client.query("SELECT * FROM categories WHERE id = #{id}")
    categories = []
    raw_data.each do |data|
      category = Category.new(data['id'], data['name'])
      categories.push(category)
    end
    categories[0]
  end

  # @return [Array]
  def self.find
    client = create_db_client
    raw_data = client.query('SELECT * FROM categories')
    categories = []
    raw_data.each do |data|
      category = Category.new(data['id'], data['name'])
      categories.push(category)
    end
    categories
  end

  # @return [Boolean]
  def valid?
    return false if @id.nil?
    return false if @name.nil?

    true
  end
end
