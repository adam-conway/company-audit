require './test/test_helper'
require './lib/audit'
require './modules/date_handler'
require './lib/company'
require './lib/timesheet'
require './lib/project'


class AuditTest < Minitest::Test
  def test_instantiation
    audit = Audit.new

    assert_instance_of Audit, audit
  end

  def test_loading_company_to_audit
    audit = Audit.new
    company = Company.new
    success_hash = {
      success: true,
      error: nil
    }

    assert_equal success_hash, company.load_employees('./data/employees.csv')
    assert_equal success_hash, company.load_projects('./data/projects.csv')
    assert_equal success_hash, company.load_timesheets('./data/timesheets.csv')

    audit.load_company(company)

    assert_instance_of Company, audit.company
  end

  def test_were_invalid_days_work
    skip
    audit = Audit.new
    company = Company.new
    company.load_employees('./data/employees.csv')
    company.load_projects('./data/projects.csv')
    company.load_timesheets('./data/timesheets.csv')
    audit.load_company(company)
    result = audit.were_invalid_days_worked
    first_error = "Susan Smith worked on Widgets on 2016-01-02,
    it was the weekend"
    invalid_employee = "Someone worked on Acme Project on 2017-04-04,
    it was not a valid employee"

    assert_equal 13, result.length
    assert_equal first_error, result[0]
    assert_equal invalid_employee, result[-2]
  end

  def test_output
    audit = Audit.new
    invalid_days = ['testing', '123']

    assert_equal ['testing', '123'], audit.output(invalid_days)

    invalid_days = []

    assert_equal 'None', audit.output(invalid_days)
  end

  def test_find_timesheet_attributes
    skip
    audit = Audit.new
    company = Company.new
    company.load_employees('./data/employees.csv')
    company.load_projects('./data/projects.csv')
    company.load_timesheets('./data/timesheets.csv')
    audit.load_company(company)

    audit.find_timesheet_attributes(company.timesheet)
  end

  def test_invalid_employee
    skip
    audit = Audit.new
    @employee = stub(name: 'Jon')
    @project = stub(name: 'Black Thursday')
    timesheet = stub(date: '1/1')
    @invalid_days = []
    audit.invalid_employee(timesheet)

    assert_equal 1, @invalid_days.length
    assert_instance_of String, @invalid_days.first
  end

  def test_invalid_project
    skip
    audit = Audit.new
    @employee = stub(name: 'Jon')
    @project = stub(name: 'Black Thursday')
    timesheet = stub(date: '1/1')
    @invalid_days = []
    audit.invalid_project(timesheet)

    assert_equal 1, @invalid_days.length
    assert_instance_of String, @invalid_days.first
  end

  def test_weekend
    skip
    audit = Audit.new
    @employee = stub(name: 'Jon')
    @project = stub(name: 'Black Thursday')
    timesheet = stub(date: '1/1')
    @invalid_days = []
    audit.weekend(timesheet)

    assert_equal 1, @invalid_days.length
    assert_instance_of String, @invalid_days.first
  end

  def test_start_end
    skip
    audit = Audit.new
    @employee = stub(name: 'Jon')
    @project = stub(name: 'Black Thursday')
    timesheet = stub(date: '1/1')
    @invalid_days = []
    audit.start_end(timesheet)

    assert_equal 1, @invalid_days.length
    assert_instance_of String, @invalid_days.first
  end
end
