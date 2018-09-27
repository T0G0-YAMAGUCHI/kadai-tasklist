class TasksController < ApplicationController
  
  before_action :set_task, only: [:show, :update, :destroy, :edit]
  
  def index
    @tasks = Task.all
  end
  
  def show
  end
  
  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = "タスクが正常に追加されました"
     redirect_to @task
    else
      flash[:dangerous]="タスクの追加に失敗しました"
      render :new
    end
  end
  
  def edit
  end
  
  def update
    
    if @task.update(task_params)
      flash[:success] ="タスクが更新されました"
      redirect_to @task
    else
      flash[:danger] = "タスクが変更されませんでした"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success]= "タスクが削除されました"
    redirect_to tasks_url
  end
  
  private
  
  
  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content)
  end
end
