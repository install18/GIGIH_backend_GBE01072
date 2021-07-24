# frozen_string_literal: true

require_relative '../models/category'
require_relative '../models/item'

class CategoryController
  def list_categories
    categories = Category.find
    renderer = ERB.new(File.read('./views/list_categories.erb'))
    renderer.result(binding)
  end

  def add_category
    renderer = ERB.new(File.read('./views/add_category.erb'))
    renderer.result(binding)
  end

  def detail_category(id)
    category = Category.find_by_id(id)
    items = Item.find_by_category(id)
    renderer = ERB.new(File.read('./views/detail_category.erb'))
    renderer.result(binding)
  end

  def create_category(name)
    category = Category.new(id = nil, name)
    category.save
  end

  def delete_category(id)
    category = Category.find_by_id(id)
    category.delete_category
  end

  def edit_category(id)
    category = Category.find_by_id(id)
    renderer = ERB.new(File.read('./views/edit_category.erb'))
    renderer.result(binding)
  end

  def update_category(id, name)
    category = Category.new(id, name)
    category.update
  end
end
