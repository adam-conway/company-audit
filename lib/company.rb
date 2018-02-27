require './modules/date_handler'
require 'csv'

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
    return quality if quality[:success] == false
    CSV.foreach(filename, headers: false) do |row|
      @employees << Employee.new(row[0], row[1], row[2], row[3], row[4])
    end
    quality
  end

  def load_projects(filename)
    quality = quality_of_file(filename)
    return quality if quality[:success] == false
    CSV.foreach(filename, headers: false) do |row|
      @projects << Project.new(row[0], row[1], row[2], row[3])
    end
    quality
  end

  def load_timesheets(filename)
    quality = quality_of_file(filename)
    return quality if quality[:success] == false
    CSV.foreach(filename, headers: false) do |row|
      @timesheets << Timesheet.new(row[0], row[1], row[2], row[3])
    end
    quality
  end

  def quality_of_file(filename)
    quality_check = { success: true, error: nil }
    CSV.foreach(filename, headers: false) do |row|
      if row.include?(nil)
        quality_check[:success] = false
        quality_check[:error] = 'bad data'
      end
    end
    quality_check
  end
end
