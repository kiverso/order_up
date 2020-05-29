require 'rails_helper'

RSpec.describe 'Chef show page', type: :feature do
  it "has a link to the chef's ingredients" do
    chef1 = Chef.create(name: "Chef1")
    dish1 = Dish.create(name: "Dish1",
                        description: "Mm Food",
                        chef_id: chef1.id,)

    ingredient1 = Ingredient.create(name: "Cheetos",
                                    calories: 200)
    ingredient2 = Ingredient.create(name: "Fritos",
                                    calories: 200)
    ingredient3 = Ingredient.create(name: "Doritos",
                                    calories: 200)

    DishIngredient.create(dish_id: dish1.id,
                          ingredient_id: ingredient1.id)
    DishIngredient.create(dish_id: dish1.id,
                          ingredient_id: ingredient2.id)
    DishIngredient.create(dish_id: dish1.id,
                          ingredient_id: ingredient3.id)

    visit("/chefs/#{chef1.id}")
    expect(page).to have_content("#{chef1.name}")
    expect(page).to have_link("View Ingredients")
    click_link 'View Ingredients'
    expect(current_path).to eq("/chefs/#{chef1.id}/ingredients")
  end
end
