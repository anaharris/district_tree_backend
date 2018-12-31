class CollectionsController < ApplicationController

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

  def collection_params
    params.require(:collection).permit(:tree_id, :user_id)
  end

end
