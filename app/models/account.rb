class Account < ApplicationRecord
  default_scope -> { where(active: true).order(order: :asc) }

  belongs_to :created_by, class_name: 'User'

  # name: string
  validates :name,
    presence: true

  # code: integer
  validates :code,
    numericality: {greater_than: 0},
    uniqueness: true

  # order: integer
  validates :order,
    numericality: {greater_than: 0}

  # active:boolean
  validates :active,
    inclusion: {in: [true, false]}

  # description: text
  validates :description,
    length: {maximum: 255},
    allow_nil: true
end