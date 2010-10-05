class TasksController < ApplicationController

  def index
    @title = 'All your tasks'
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
    @title = @task.title
  end

  def new
    @title = 'Start new computation'
    @task = Task.new
    @task.nzones.build
  end

  def edit
  end

  def create
    @task = Task.new(params[:task])
    
    if @task.save
    
      start_computing @task
      flash[:success] = "Your computation is started"
      redirect_to root_path
    else
      @title = 'Start new computation'
      render 'new'
    end
    
  end

  def update
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path
  end

  private

    def start_computing(task)
      prepare_file(task)
      system("/home/ilia/Desktop/tt")
    end
   
    def prepare_file(task)
      taskdir = Settings.computer_path + '/' + task.id.to_s
      Dir.mkdir(taskdir)
      File.open(taskdir + '/' + Settings.filename, 'w+'){|f| f.write prepare_text(task) }
    end
    
    def prepare_text(task)
      text = "EOSType = table\n	TableDir = new\n	TableFlag = extended\nMethod = lagrange\n"
      task.attribute_names.each do |a|
        text << a + " = " + task.attributes[a].to_s + "\n" if Settings.needed.include? a
      end
      text
    end
    
end
