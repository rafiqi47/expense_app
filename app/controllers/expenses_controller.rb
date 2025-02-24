# app/controllers/expenses_controller.rb
class ExpensesController < ApplicationController
  before_action :set_expense, only: [ :show, :edit, :update, :destroy ]
  before_action :set_categories, only: [ :new, :create, :edit, :update ]

  def index
    @month = Date.parse(params[:month] || Date.today.strftime("%Y-%m-01"))
    @expenses = Expense.where("date >= ? AND date <= ?", @month.beginning_of_month, @month.end_of_month).order(date: :desc)
  end

  def show;end

  def new
    @expense = Expense.new
  end

  def edit;end

  def create
    @expense = Expense.new(expense_params)

    if @expense.save
      redirect_to expenses_path, notice: "Expense was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @expense.update(expense_params)
      redirect_to expenses_path, notice: "Expense was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    redirect_to expenses_path, notice: "Expense was successfully destroyed."
  end

  private

    def set_expense
      @expense = Expense.find(params[:id])
    end

    def set_categories
      @categories = Expense.categories
    end


    def expense_params
      params.require(:expense).permit(:amount, :category, :date)
    end
end
