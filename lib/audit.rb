require './lib/company'
require './modules/date_handler'

class Audit
  attr_reader :company,
              :invalid_days

  def load_company(company)
    @company = company
  end

  def were_invalid_days_worked
    @invalid_days = []
    @company.timesheets.each do |timesheet|
      find_timesheet_attributes(timesheet)
      invalid_employee(timesheet) if @employee.nil?
      invalid_project(timesheet) if @project.nil?
      start_end(timesheet) if timesheet.date < @start_date || timesheet.date > @end_date
      weekend(timesheet) if timesheet.date.saturday? || timesheet.date.sunday?
    end
    output(@invalid_days)
  end

  def output(invalid_days)
    puts 'Invalid Days Worked:'
    return 'None' if invalid_days.empty?
    invalid_days.each do |invalid_day|
      puts invalid_day
    end
  end

  def find_timesheet_attributes(timesheet)
    @employee = @company.find_employee_by_id(timesheet.employee_id)
    @project = @company.find_project_by_id(timesheet.project_id)
    @start_date = @project.start_date
    @end_date = @project.end_date
  end

  def invalid_employee(timesheet)
    binding.pry
    string = "Someone worked on #{@project.name} on #{timesheet.date},
    it was not a valid employee"
    @invalid_days << string
  end

  def invalid_project(timesheet)
    string = "#{@employee.name} worked on #{@project.name} on #{timesheet.date},
    it was not a valid project"
    @invalid_days << string
  end

  def weekend(timesheet)
    string = "#{@employee.name} worked on #{@project.name} on #{timesheet.date},
    it was the weekend"
    @invalid_days << string
  end

  def start_end(timesheet)
    string = "#{@employee.name} worked on #{@project.name} on #{timesheet.date},
    it was not between the project start/end dates"
    @invalid_days << string
  end
end
