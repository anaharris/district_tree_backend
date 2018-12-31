class TreesController < ApplicationController

  def index
    # construct a filter based on tree_params

    query = params.except(:bbox)
    if params[:bbox].present?
      # do the bounding box query
      query[:bbox] = params[:bbox].split(',')
    end

    if params[:bbox].present?
      trees = Tree.bbox(coords[0], coords[1], coords[2], coords[3]).where(query).limit(2000)
    else
      trees = Tree.where(query).limit(2000)
    end

    render json: trees
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

  def generate_query(params)

  end

  def tree_params
    params.require(:tree).permit(:bbox, :ward, :scientific_name, :common_name, :condition, :fam_name, :genus_name)
  end


end
