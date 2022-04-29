class ExpensesController < ApplicationController

  def create
    @expense = Expense.create!(expense_params)
  end

  def update
    @expense = Expense.find(params[:id])
    @expense.update_attirbutes!(expense_params)
  end

  def destroy
    @expense = Expense.find(params[:id])
    @expense.destroy!
  end

  private

  def expense_params
    params.permit(:amount, :name, :description, :type, :date)
  end

end
