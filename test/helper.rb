unless defined? Medjool
  $:.unshift File.expand_path('../../lib', __FILE__)
  require 'medjool'
end

require 'minitest'
require 'minitest/autorun'
require 'active_support'
require 'active_support/core_ext/string'
require 'timecop'

class TestCase < MiniTest::Test
  def self.test(name, &block)
    define_method("test_#{name.gsub(/\W/, '_')}", &block) if block
  end
end
