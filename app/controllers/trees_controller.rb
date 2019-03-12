class TreesController < ApplicationController
  skip_before_action :authorized, only: [:index, :show]

  QUERY_LIMIT = 500

  def index
    query = generate_query(params)
    if params[:bbox].present?
      coords = params[:bbox].split(',')
    end

    if params[:bbox].present?
      render json: spatial_query(coords, query), serializer: TreesSerializer
    else
      render json: normal_query(query), serializer: TreesSerializer
    end
  end

  def show
  end

  private

  def spatial_query(coords, query)
    Tree.bbox(coords[0], coords[1], coords[2], coords[3]).where(query).limit(QUERY_LIMIT)
  end

  def normal_query(query)
    Tree.where(query).limit(QUERY_LIMIT)
  end

  def generate_query(params)
    query = {}
    [:ward,:condition, :common_name, :fam_name, :genus_name, :scientific_name].each do |key|
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
