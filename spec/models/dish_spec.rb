require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe 'instance methods' do
    it 'can get total_calories' do
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

      expect(dish1.total_calories).to eq(600)
    end
  end
end
