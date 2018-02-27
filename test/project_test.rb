require './test/test_helper'
require './lib/project'
require './modules/date_handler'

class ProjectTest < Minitest::Test
  def test_instantiation
    project_id = '123'
    name = 'Widget Maker'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    project = Project.new(project_id, name, start_date, end_date)

    assert_instance_of Project, project
  end

  def test_attributes
    project_id = '123'
    name = 'Widget Maker'
    start_date = '2015-01-01'
    end_date = '2018-01-01'
    project = Project.new(project_id, name, start_date, end_date)

    assert_instance_of Integer, project.id
    assert_equal 123, project.id
    assert_equal 'Widget Maker', project.name
    assert_instance_of Date, project.start_date
    assert_equal Date.new(2015, 0o1, 0o1), project.start_date
    assert_instance_of Date, project.end_date
    assert_equal Date.new(2018, 0o1, 0o1), project.end_date
  end
end
