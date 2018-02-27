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
end
