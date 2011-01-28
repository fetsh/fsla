class PagesController < ApplicationController
  def about
    @title = 'FSLA'
  end
  
  def help
    @title = 'FSLA — Help'
  end

end
