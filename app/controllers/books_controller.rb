class BooksController < ApplicationController
    before_action :require_authentication
    before_action :set_book, only: %i[show borrow return]
    def index
        @books = Book.all
    end

    def show
    end

    def new
        @book = Book.new
    end

    def create
        @book = Book.new(params.require(:book).permit(:title, :author, :isbn))
        if @book.save
            redirect_to @book, notice: 'Book created successfully.'
        else
            render :new
        end
    end

    def edit
        @book = Book.find(params[:id])
      end

      def update
        @book = Book.find(params[:id])
        if @book.update(params.require(:book).permit(:title, :author, :isbn))
          redirect_to @book, notice: 'Book updated successfully.'
        else
          render :edit
        end
      end

      def destroy
        @book = Book.find(params[:id])
        @book.destroy
        redirect_to books_path, notice: 'Book deleted successfully.'
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

    def require_admin
        unless Current.user&.admin?
            redirect_to books_path, alert: 'You are not authorized to perform this action.'
        end
    end
end
