class ChangeQuantityToStringInRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    change_column :recipe_ingredients, :quantity, :string
  end
end
