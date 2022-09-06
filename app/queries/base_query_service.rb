class BaseQueryService
  def call(filters)
    raise NotImplementedError, "implement #{__method__} in subclass!"
  end
end
