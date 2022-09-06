module V1
  class BaseApi < ApplicationController

    rescue_from ActiveRecord::RecordNotFound do
      render json: { success: false, message: I18n.t("error.not_found") }, status: :not_found
    end
  end
end
