class TasksController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user , only: [:destroy , :edit]
  before_action :set_task, only: [:show, :update, :destroy, :edit]

  def new
    @task = Task.new
  end
  
  def create
    @task = current_user.tasks.build(task_params)
    @tasks=current_user.tasks.order("created_at DESC").page(params[:page])
    if @task.save
      flash[:success] = "タスクが正常に追加されました"
     redirect_to root_url
    else
      flash[:danger]="タスクの追加に失敗しました"
      render  "toppages/index"
    end
  end
  
  def edit
    @task=Task.find(params[:id])
  end
  
  def update
    @task=Task.find(params[:id])
    
    if @task.update(task_params)
      flash[:success]="タスクを更新しました"
      redirect_to root_url
    else
      flash[:danger]="タスクの更新に失敗しました"
      render :edit
    end
  end
  
  def destroy
    @task.destroy
    
    flash[:success]= "タスクが削除されました"
    redirect_back(fallback_location: root_path)
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def task_params
    params.require(:task).permit(:content , :status)
  end
  
  def correct_user
    @task= current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
