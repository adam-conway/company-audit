require './test/test_helper'
require './lib/audit'
require './modules/date_handler'
require './lib/company'

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
end
