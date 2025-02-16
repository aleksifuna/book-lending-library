require 'test_helper'

class BorrowingTest < ActiveSupport::TestCase
  test "should not allow borrowing an unavailable book" do
    book = Book.create(title: "Unavailable Book", author: "Author", isbn: "1234567893")
    user = User.create(first_name: "Jane", last_name: "Doe", email_address: "jane@example.com", password: "password")
    Borrowing.create(user: user, book: book, due_date: 2.weeks.from_now)
    borrowing = Borrowing.new(user: user, book: book, due_date: 2.weeks.from_now)
    assert_not borrowing.save, "Borrowed an unavailable book"
  end
end