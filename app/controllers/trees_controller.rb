class TreesController < ApplicationController

  def index
    # construct a filter based on tree_params

    query = generate_query(params)
    if params[:bbox].present?
      # do the bounding box query
      coords = params[:bbox].split(',')
    end

    if params[:bbox].present?
      render json: spatial_query(coords, query)
    else
      render json: normal_query(query)
    end
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

  def spatial_query(coords, query)
    Tree.bbox(coords[0], coords[1], coords[2], coords[3]).where(query).limit(2000)
  end

  def normal_query(query)
    Tree.where(query).limit(2000)
  end

  def generate_query(params)
    query = {}
    [:ward,:condition, :common_name, :fam_name, :genus_name].each do |key|
      if params[key].present?
        query[key] = params[key]
      end
    end
    query
  end

  def tree_params
    params.require(:tree).permit(:xy, :bbox, :address, :ward, :scientific_name, :common_name, :disease, :pests, :condition, :fam_name, :genus_name)
  end


end
