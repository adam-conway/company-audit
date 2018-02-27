require './modules/date_handler'
require 'csv'
require 'pry'

class Company
  attr_reader :employees,
              :projects,
              :timesheets

  def initialize
    @employees = []
    @projects = []
    @timesheets = []
  end

  def load_employees(filename)
    quality = quality_of_file(filename)
    return quality if quality[success] == false
    CSV.foreach(filename, headers: false) do |row|

    end
  end

  def quality_of_file(filename)
    quality_check = {success: true, error: nil}
    CSV.foreach(filename, headers: false) do |row|
      binding.pry
    end
  end
end
