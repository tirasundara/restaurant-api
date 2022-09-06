class RestaurantSerializer
  include JSONAPI::Serializer

  attributes :id, :name, :email, :phone_number, :address
end
