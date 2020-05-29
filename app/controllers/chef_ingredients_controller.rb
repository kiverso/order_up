class ChefIngredientsController < ApplicationController
  def index
    @chef = Chef.find(params[:id])
    @chef.ingredients
  end
end