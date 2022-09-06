class Restaurant < ApplicationRecord
  VALID_EMAIL_FORMAT = /[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]/

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false },
            format: { with: VALID_EMAIL_FORMAT, message: I18n.t("error.invalid_email") }
  validates :phone_number, presence: true, uniqueness: true,
            phone: { possible: true, types: :fixed_or_mobile }
  validates :address, presence: true
end
