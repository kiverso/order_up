require 'rails_helper'

RSpec.describe 'Dish show page', type: :feature do
  it "can show ingredients and chefs name" do
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

    visit("/dishes/#{dish1.id}")
    expect(page).to have_content("#{ingredient1.name}")
    expect(page).to have_content("#{ingredient2.name}")
    expect(page).to have_content("#{ingredient3.name}")
    expect(page).to have_content("#{chef1.name}")
  end
end