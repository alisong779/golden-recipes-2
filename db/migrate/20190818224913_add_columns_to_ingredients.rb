class AddColumnsToIngredients < ActiveRecord::Migration[5.2]
  def change
    add_column :ingredients, :quantity, :string
    add_column :ingredients, :unit, :string
    add_column :ingredients, :recipe_id, :integer
  end
end
