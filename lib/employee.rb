require './modules/date_handler'

class Employee
  attr_reader :id,
              :name,
              :role,
              :start_date,
              :end_date
  def initialize(id, name, role, start_date, end_date)
    @id = id.to_i
    @name = name
    @role = role
    sd = start_date.split('-')
    @start_date = Date.new(sd[0].to_i, sd[1].to_i, sd[2].to_i)
    ed = end_date.split('-')
    @end_date = Date.new(ed[0].to_i, ed[1].to_i, ed[2].to_i)
  end
end
