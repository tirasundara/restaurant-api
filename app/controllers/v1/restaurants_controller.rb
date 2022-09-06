class V1::RestaurantsController < V1::BaseApi
  def index
    restaurants = restaurant_query_service.call(params)

    render json: RestaurantSerializer.new(restaurants).serializable_hash, status: :ok
  end

  def create
    new_restaurant = Restaurant.new(restaurant_params)

    if new_restaurant.save

      render json: { success: true }, status: :created
    else

      render json: { success: false, messages: new_restaurant.errors.messages }, status: :unprocessable_entity
    end
  end

  def show
    render json: RestaurantSerializer.new(restaurant).serializable_hash, status: :ok
  end

  def update
    if restaurant.update(restaurant_params)

      render json: RestaurantSerializer.new(restaurant).serializable_hash, status: :ok
    else

      render json: { success: false, messages: restaurant.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    restaurant.destroy
    render json: { success: true }, status: :ok
  end


  private

  def restaurant_params
    params.require(:restaurant).permit(:name, :email, :phone_number, :address)
  end

  def restaurant
    return @restaurant if defined? @restaurant

    @restaurant = Restaurant.find(params[:id])  # ActiveRecord::RecordNotFound error already handled in BaseAPI
  end

  def restaurant_query_service
    @restaurant_query_service ||= RestaurantQueryService.new(Restaurant.all)
  end
end
