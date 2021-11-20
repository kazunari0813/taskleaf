class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  def index
    @tasks = current_user.tasks.order(created_at: :desc)
  end

  def show
    @task = current_user.tasks.find(params[:id])
  end

  def new
    @task = Task.new
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end
  
  def update
    task = current_user.tasks.find(params[:id])
    task.update!(task_paramas)
    redirect_to tasks_url, notice: "タスク「#{task.name}を変更しました。」"
  end
  
  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy
    redirect_to tasks_url, notice: "タスク「#{task.name}」を削除しました。"
  end
  
  def create
    @task = current_user.task.new(task_paramas)
    if @task.save
      redirect_to @task, notice: "タスク「#{@task.name}」を登録しました。"
    else
      render :new
    end
    
  end
  
  private
  
  def task_paramas
    params.require(:task).permit(:name, :description)
  end
end
