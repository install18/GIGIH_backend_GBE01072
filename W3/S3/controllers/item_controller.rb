# frozen_string_literal: true

require_relative '../models/item'
require_relative '../models/category'

class ItemController
  def list_items
    items = Item.find
    renderer = ERB.new(File.read('./views/index.erb'))
    renderer.result(binding)
  end

  def add_item
    categories = Category.find
    renderer = ERB.new(File.read('./views/add_item.erb'))
    renderer.result(binding)
  end

  def detail_item(id)
    item = Item.find_by_id(id)
    renderer = ERB.new(File.read('./views/detail_item.erb'))
    renderer.result(binding)
  end

  def create_item(name, price, category)
    item = Item.new(id = nil, name, price, category)
    item.save
  end

  def delete_item(id)
    item = Item.find_by_id(id)
    item.delete_item
  end

  def edit_item(id)
    item = Item.find_by_id(id)
    categories = Category.find
    renderer = ERB.new(File.read('./views/edit_item.erb'))
    renderer.result(binding)
  end

  def update_item(id, name, price, category)
    item = Item.new(id, name, price, category)
    item.update
  end
end
