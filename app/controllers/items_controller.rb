class ItemsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  def index
    if params[:user_id]
      user_id = User.find(params[:user_id])
      items = user_id.items
    else
    items = Item.all
    end
    render json: items, include: :user
  end

  def show
    items =  Item.find(params[:id])
    render json:items, include: :user
  end

  def create
    item = Item.create(create_params)
    render json: item ,status: :created

  end
   
  private
  def create_params
    params.permit(:name,:description,:price,:user_id)
  end

   def render_not_found_response
    render json: {error: "user not found"},status: :not_found
   end

end
