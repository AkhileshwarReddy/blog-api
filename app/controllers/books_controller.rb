class BooksController < ApplicationController
    before_action :book, only: [:borrow]
    before_action :user, only: [:borrow]

    def create
        book = Book.new(book_params)
        if book.valid?
            book.save
            render json: { book: book }, status: :created
        else
            render json: { errors: book.errors.full_messages }, status: :unprocessible_entity
        end
    end

    def borrow
        borrow_history = Borrow.where(book: @book, actual_return_date: nil)
        
        no_of_copies_available = @book.copies - borrow_history.count

        if no_of_copies_available <= @book.copies
            if !borrow_history.find_by(user: @user)
                borrow = Borrow.new(user: @user, book: @book, borrowed_date: DateTime.now, estimated_return_date: DateTime.now + @book.max_read_days.days)

                if borrow.valid?
                    borrow.save
                    render json: { borrow: borrow }, status: :ok
                else
                    render json: { errors: borrow.errors.full_messages }, status: :unprocessible_entity
                end
            else
                render json: { message: "It seems you already have a copy of this book" }, status: :ok
            end
        else
            render json: { message: "This book is currently not available" }, status: :ok
        end
    end

    private

    def book_params
        params.require(:book).permit(:name, :isbn, :copies , :max_read_days, :late_return_penalty, :publisher_author_id )
    end

    def book
        @book = Book.find(params[:book_id])
    end

    def user
        @user = User.find(params[:user_id])
    end
end
