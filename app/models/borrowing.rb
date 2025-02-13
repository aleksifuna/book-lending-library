class Borrowing < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validate :book_availability, on: :create

  def book_availability
    errors.add(:book, 'is not available') unless book.available?
  end
end
