class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :edit, :update]
  def index
    @todos = current_user.todos
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def create 
    @todo = current_user.todos.new(todo_params)
    if @todo.save
      flash[:success] = "To-do Created"
      redirect_to todos_path
    else
      flash[:error] = "Error #{@todo.errors.full_messages.join('\n')}" 
      render :new
    end
  end

  def edit
  end

  def update
    if @todo.update(todo_params)
      redirect_to todos_path 
    else
      render :edit
    end

  end
  
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy
    redirect_to todos_path
  end

  private
  def todo_params
    params.require(:todo).permit(:name, :time)
  end

  def set_todo
    @todo = current_user.todos.find(params[:id])
  end
end
