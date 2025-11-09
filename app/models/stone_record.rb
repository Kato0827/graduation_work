# frozen_string_literal: true

class StoneRecord < ApplicationRecord
  validates :title, presence: true, length: { maximum: 255 }
  validates :body, presence: true, length: { maximum: 65_535 }
  validates :stone_size, presence: true,
                         inclusion: { in: 0.1..20.0, message: '0.1mmから20mmの間で入力してください' }
  validates :record_date, presence: true

  belongs_to :user
end
