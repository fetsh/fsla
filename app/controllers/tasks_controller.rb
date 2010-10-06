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
      text << append_boolean(task, "HydroStage", "1", "0")
      text << append_boolean(task, "HeatStage", "1", "0")
      text << append_boolean(task, "ExchangeStage", "1", "0")
      text << "IonizationStage = 0\n\n"
      text << append_boolean(task, "source", "Al", "Al_glass")
      text << "tauPulse = " + task.tauPulse.to_s + "e-15\n"
      text << "fluence = " + task.fluence.to_s + "\n"
      text << "deltaSkin = " + task.deltaSkin.to_s + "e-9\n\n"
      text << "courant = " + task.courant.to_s + "\n"
      text << "viscosity = 1\n\n"
      text << "maxTime = " + task.maxTime.to_s + "e-12\n\n"
      text << "nZones = " + task.nzones.count.to_s + "\n\n"
      
      task.nzones.each do |nzone|
        text << "l = " + nzone.l.to_s + "e-9\n"
        text << "nSize = " + nzone.nSize.to_s + "\n"
        text << "ro = " + nzone.ro.to_s + "\n"
        text << "ti = " + nzone.ti.to_s + "\n"
        text << "te = " + nzone.te.to_s + "\n"
        text << "v = " + nzone.v.to_s + "\n"
        text << "exp = " + nzone.exp.to_s + "\n\n"
      end
      
      text
    end

    def append_boolean(task, name, trueval, falseval)
      name + ' = ' + ( task.attributes[name] ? trueval.to_s : falseval.to_s ) + "\n"
    end
end
