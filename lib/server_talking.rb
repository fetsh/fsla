module ServerTalking
private
 
    def send_task(task)
      data = {  'task' => task.id,
                'calculation_input' => prepare_text(task)}
      ask_server(data, 'run')
    end
    
    def remove_task(task)
      data = {'task' => task.id}
      ask_server(data, 'kill')
    end
    
    def get_progress(task)
      data = {'task' => task}
      ask_server(data, 'log')
    end
    
    def download_zip(task)
      data = {'task' => task}
      ask_server(data, 'zip')
    end
    
    def ask_server(data, action)
      require "net/http"
      require "uri"

      uri = URI.parse(get_server)
      http = Net::HTTP.new(uri.host, uri.port)
      get_params = '?action=' + action + '&token=' + get_token
      request = Net::HTTP::Post.new(uri.request_uri + get_params)
      request.set_form_data(data)
      response = http.request(request)
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
    
    def get_server
      Settings.server
    end
    
    def get_token
      Settings.token
    end
  
end
