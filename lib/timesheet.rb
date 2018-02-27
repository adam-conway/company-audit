require './modules/date_handler'

class Timesheet
  attr_reader :employee_id,
              :project_id,
              :date,
              :minutes

  def initialize(employee_id, project_id, date, minutes)
    @employee_id = employee_id.to_i
    @project_id = project_id.to_i
    date = date.split('-')
    @date = Date.new(date[0].to_i, date[1].to_i, date[2].to_i)
    @minutes = minutes.to_i
  end
end
