class User < ApplicationRecord
  validates :email, presence: true, format: { with: /\w+@\w+\.{1}[a-zA-Z]{2,}/, message: "address invalid"}, uniqueness: true
  has_many :inquiries
end
