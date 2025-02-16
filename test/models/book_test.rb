require 'test_helper'

class BookTest < ActiveSupport::TestCase
  test "should not save book without title" do
    book = Book.new(author: "Author Name", isbn: "1234567890")
    assert_not book.save, "Saved the book without a title"
  end

  test "should not save book without author" do
    book = Book.new(title: "Book Title", isbn: "1234567890")
    assert_not book.save, "Saved the book without an author"
  end

  test "should not save book without isbn" do
    book = Book.new(title: "Book Title", author: "Author Name")
    assert_not book.save, "Saved the book without an ISBN"
  end

  test "should not save book with duplicate isbn" do
    Book.create(title: "Book 1", author: "Author 1", isbn: "1234567890")
    book = Book.new(title: "Book 2", author: "Author 2", isbn: "1234567890")
    assert_not book.save, "Saved the book with a duplicate ISBN"
  end

  test "book should be available if not borrowed" do
    book = Book.create(title: "Available Book", author: "Author", isbn: "1234567891")
    assert book.available?, "Book should be available"
  end

  test "book should not be available if borrowed" do
    book = Book.create(title: "Borrowed Book", author: "Author", isbn: "1234567892")
    user = User.create(first_name: "John", last_name: "Doe", email_address: "john@example.com", password: "password")
    Borrowing.create(user: user, book: book, due_date: 2.weeks.from_now)
    assert_not book.available?, "Book should not be available"
  end
end