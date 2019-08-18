class DropRecipeIngredients < ActiveRecord::Migration[5.2]
  def change
    drop_table :recipe_ingredients do |t|
      t.string "quantity"
      t.string "unit"
      t.integer "recipe_id"
      t.integer "ingredient_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  end
end
