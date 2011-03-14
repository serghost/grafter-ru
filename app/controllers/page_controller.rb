class PageController < ApplicationController
  def index

  end

  def search
    @universities = University.all
  end
end
