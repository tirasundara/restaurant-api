class RestaurantQueryService < BaseQueryService

  def initialize(scope=nil)
    @scope = scope || Restaurant.all
  end

  def call(filters)
    return @scope.extending(Scopes).
            by_name(filters[:name]).
            by_email(filters[:email]).
            by_phone_number(filters[:phone_number]).
            by_address(filters[:address])
  end
end

module Scopes

  def by_name(name)
    return self if name.blank?

    where("name ILIKE ?", "%#{name}%")
  end

  def by_email(email)
    return self if email.blank?

    where("email ILIKE ?", "%#{email}%")
  end

  def by_phone_number(phone_number)
    return self if phone_number.blank?

    where("phone_number ILIKE ?", "%#{phone_number}%")
  end

  def by_address(address)
    return self if address.blank?

    where("address ILIKE ?", "%#{address}%")
  end

end

