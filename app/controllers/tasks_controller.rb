class TasksController < ApplicationController
  
  include ServerTalking

  before_filter :authenticate_user!
  load_and_authorize_resource :except => :index

  def index
    @tasks = current_user.tasks
    @title = 'All your tasks'
  end

  def show
    @title = @task.title
    @text = prepare_text(@task)
    @current_time, @total_time, @human_progress = progress_thingy(@task)
  end

  def new
    @task = Task.new(Task::DEFAULTS)
    @title = 'Start new computation'
    @task.nzones.build(Nzone::DEFAULTS)
  end

  def edit
  end

  def create
    @task.user = current_user
    if @task.save
      resp = send_task @task
      if resp.code == "200"
        flash[:success] = "ME: Your computation is started; SERVER: #{resp.body}"
        redirect_to root_path
      else
        task.update_attribute(:status, "unable to launch")
        flash[:error] = "I think server is down, so your is created, but not launched."
        redirect_to @task
      end
    else
      @title = 'Start new computation'
      render 'new'
    end
    
  end

  def update
  end

  def destroy
    resp = remove_task @task
    if resp.code == "200"
      @task.destroy
      flash[:success] = "ME: Task is deleted; SERVER: #{resp.body}"
      redirect_to root_path
    else
      task.update_attribute(:status, "unable to delete from server")
      flash[:error] = "Something went wrong on server"
      render :show
    end
  end
  
  def show_all
    @tasks = Task.all
    @title = 'All your tasks'
    authorize! :read, Task
    render :index
  end
  
  def download
    @id = params[:id]
    response = ask_server( {'task' => @id}, 'zip' )
    send_data(response.read_body, :filename => "#{@id}.zip", :type => "application/zip")
  end
  
  def show_progress
    @task = Task.find_by_id(params[:id])
    @current_time, @total_time, @human_progress = progress_thingy(@task)
    unless @current_time == "server error"
      render "tasks/_progress", :layout => false 
    end
  end


  private
    
    def progress_thingy(task)
      current_time = task.progress
      if current_time == "server error"
        return "server error", "server error", "server error"
      end
      total_time = task.maxTime
      progress = ((current_time / total_time)*100).round
      progress = 0 if progress < 0
      human_progress = progress.to_s + '%'
      if (progress == 100 and task.status != "complete")
          task.update_attribute(:status, "complete")
      end
      return current_time, total_time, human_progress
    end

    
#    def prepare_file(task)
#     taskdir = Settings.computer_path + '/' + task.id.to_s
#      Dir.mkdir(taskdir)
#      File.open(taskdir + '/' + Settings.filename, 'w+'){|f| f.write prepare_text(task) }
#    end

end
