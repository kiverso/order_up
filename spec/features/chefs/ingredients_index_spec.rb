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

  xit "ingredient index has all unique ingredients for chef" do
    chef1 = Chef.create(name: "Chef1")
    chef2 = Chef.create(name: "Chef2")

    dish1 = Dish.create(name: "Dish1",
                        description: "Mm Food",
                        chef_id: chef1.id,)
    dish2 = Dish.create(name: "Dish2",
                        description: " Food",
                        chef_id: chef1.id,)
    dish3 = Dish.create(name: "Dish3",
                        description: "Mm Food",
                        chef_id: chef2.id,)

    ingredient1 = Ingredient.create(name: "Cheetos",
                                    calories: 200)
    ingredient2 = Ingredient.create(name: "Fritos",
                                    calories: 200)
    ingredient3 = Ingredient.create(name: "Doritos",
                                    calories: 200)
    ingredient4 = Ingredient.create(name: "Apples",
                                    calories: 200)
    ingredient5 = Ingredient.create(name: "Chcken",
                                    calories: 200)

    DishIngredient.create(dish_id: dish1.id,
                          ingredient_id: ingredient1.id)
    DishIngredient.create(dish_id: dish1.id,
                          ingredient_id: ingredient2.id)
    DishIngredient.create(dish_id: dish1.id,
                          ingredient_id: ingredient3.id)
    DishIngredient.create(dish_id: dish2.id,
                          ingredient_id: ingredient3.id)
    DishIngredient.create(dish_id: dish2.id,
                          ingredient_id: ingredient5.id)
    DishIngredient.create(dish_id: dish3.id,
                          ingredient_id: ingredient4.id)


    visit("/chefs/#{chef1.id}")
    click_link 'View Ingredients'
    expect(current_path).to eq("/chefs/#{chef1.id}/ingredients")
    expect(page).to have_content("#{ingredient1.name}", count: 1)
    expect(page).to have_content("#{ingredient2.name}", count: 1)
    expect(page).to have_content("#{ingredient3.name}", count: 1)
    expect(page).to have_content("#{ingredient5.name}", count: 1)
    expect(page).to_not have_content("#{ingredient4.name}")
  end
end
