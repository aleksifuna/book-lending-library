require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @book = Book.create(title: "Test Book", author: "Test Author", isbn: "1234567894")
    @user = User.create(first_name: "Test", last_name: "User", email_address: "test@example.com", password: "password")

    # Simulate logging in the user by setting the session
    post session_url, params: { email_address: @user.email_address, password: "password" }
  end

  test "should get index" do
    get books_url
    assert_response :success
  end

  test "should get show" do
    get book_url(@book)
    assert_response :success
  end

  test "should borrow a book" do
    post borrow_book_url(@book)
    assert_redirected_to book_url(@book)
    assert_equal "Book borrowed successfully.", flash[:notice]
  end

  test "should not borrow an unavailable book" do
    Borrowing.create(user: @user, book: @book, due_date: 2.weeks.from_now)
    post borrow_book_url(@book)
    assert_redirected_to book_url(@book)
    assert_equal "Book is not available", flash[:alert]
  end

  test "should return a book" do
    Borrowing.create(user: @user, book: @book, due_date: 2.weeks.from_now)
    post return_book_url(@book)
    assert_redirected_to book_url(@book)
    assert_equal "Book returned successfully.", flash[:notice]
  end

  test "should not return a book not borrowed by the user" do
    post return_book_url(@book)
    assert_redirected_to book_url(@book)
    assert_equal "Book not found in your borrowings.", flash[:alert]
  end
end