class TreesController < ApplicationController

  def index
  end

  def show
  end

  def create
  end

  def update
  end

  def destroy
  end

  private

  def tree_params
    params.require(:tree).permit(:xy, :address, :ward, :scientific_name, :common_name, :disease, :pests, :condition, :fam_name, :genus_name)
  end


end
