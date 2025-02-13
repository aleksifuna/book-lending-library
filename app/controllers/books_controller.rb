class BooksController < ApplicationController

    before_action :set_book, only: %i[show borrow return]
    def index
        @books = Book.all
    end

    def show
    end

    def borrow
        borrowing = Current.user.borrowings.create(book: @book, due_date: 2.weeks.from_now)
        if borrowing.persisted?
            redirect_to @book, notice: 'Book borrowed successfully.'
        else
            redirect_to @book, alert: borrowing.errors.full_messages.join(', ')
        end
    end

    def return
        borrowing = Current.user.borrowings.find_by(book: @book, returned_date: nil)
        if borrowing
            borrowing.update(returned_date: Date.today)
            redirect_to @book, notice: 'Book returned successfully.'
        else
            redirect_to @book, alert: 'Book not found in your borrowings.'
        end
    end

    private

    def set_book
        @book = Book.find(params[:id])
    end
end
