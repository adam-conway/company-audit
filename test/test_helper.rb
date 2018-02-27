require 'minitest'
require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require 'simplecov'
require 'pry'
SimpleCov.start do
  add_filter '/test/'
end
