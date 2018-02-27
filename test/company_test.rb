require './test/test_helper'
require './lib/company'
require './modules/date_handler'

class CompanyTest < Minitest::Test
  def test_instantiation
    company = Company.new

    assert_instance_of Company, company
  end

  def test_attributes
    company = Company.new

    assert_instance_of Array, company.employees
    assert_instance_of Array, company.projects
    assert_instance_of Array, company.timesheets
  end

  def test_loading_bad_employees_csv
    company = Company.new
    filename = './data/bad_employees.csv'
    failure_hash = {
      success: false,
      error: 'bad data'
    }
    expected = company.load_employees(filename)

    assert_equal failure_hash, expected
    assert_equal 0, company.employees.length
  end

  def test_loading_good_employees_csv
    company = Company.new
    filename = './data/employees.csv'
    success_hash = {
      success: true,
      error: nil
    }
    expected = company.load_employees(filename)

    assert_equal success_hash, expected
    assert_equal 2, company.employees.length
    assert_instance_of Employee, company.employees.first
    assert_equal 'Susan Smith', company.employees.first.name
  end

  def test_loading_bad_projects_csv
    company = Company.new
    filename = './data/bad_projects.csv'
    failure_hash = {
      success: false,
      error: 'bad data'
    }
    expected = company.load_projects(filename)

    assert_equal failure_hash, expected
    assert_equal 0, company.projects.length
  end

  def test_loading_good_projects_csv
    company = Company.new
    filename = './data/projects.csv'
    success_hash = {
      success: true,
      error: nil
    }
    expected = company.load_projects(filename)

    assert_equal success_hash, expected
    assert_equal 3, company.projects.length
    assert_instance_of Project, company.projects.first
    assert_equal 'Widgets', company.projects.first.name
  end

  def test_loading_bad_timesheets_csv
    company = Company.new
    filename = './data/bad_timesheets.csv'
    failure_hash = {
      success: false,
      error: 'bad data'
    }
    expected = company.load_timesheets(filename)

    assert_equal failure_hash, expected
    assert_equal 0, company.timesheets.length
  end

  def test_loading_good_timesheets_csv
    company = Company.new
    filename = './data/timesheets.csv'
    success_hash = {
      success: true,
      error: nil
    }
    expected = company.load_timesheets(filename)

    assert_equal success_hash, expected
    assert_equal 25, company.timesheets.length
    assert_instance_of Timesheet, company.timesheets.first
    assert_equal 480, company.timesheets.first.minutes
  end

  def test_quality_of_file
    company = Company.new
    bad_filename = './data/bad_timesheets.csv'
    good_filename = './data/timesheets.csv'
    failure_hash = {
      success: false,
      error: 'bad data'
    }
    success_hash = {
      success: true,
      error: nil
    }

    assert_equal failure_hash, company.quality_of_file(bad_filename)
    assert_equal success_hash, company.quality_of_file(good_filename)
  end
end
