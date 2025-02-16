require 'test_helper'

class UserFlowsTest < ActionDispatch::IntegrationTest
  test "user can borrow and return a book" do
    # Create a user and a book
    user = User.create(first_name: "Test", last_name: "User", email_address: "test@example.com", password: "password")
    book = Book.create(title: "Test Book", author: "Test Author", isbn: "1234567895")

    # Simulate logging in the user by setting the session
    post session_url, params: { email_address: user.email_address, password: "password" }
    assert_redirected_to root_url
    assert_equal "Logged in successfully.", flash[:notice]

    # Borrow the book
    post borrow_book_url(book)
    assert_redirected_to book_url(book)
    assert_equal "Book borrowed successfully.", flash[:notice]

    # Return the book
    post return_book_url(book)
    assert_redirected_to book_url(book)
    assert_equal "Book returned successfully.", flash[:notice]
  end
end