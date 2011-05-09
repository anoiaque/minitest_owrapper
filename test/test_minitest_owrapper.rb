# Tested with macruby => eval() is macruby eval()
# So TestResult implements macruby minitest test result interface (#puke)
# ENV['RUBY'] = 'MACRUBY'
# ENV['MACRUBY_TESTING'] = '1'

require "minitest/autorun"
require 'minitest_owrapper'

class TestMinitestOwrapper <  MiniTest::Unit::TestCase
  
  describe MinitestOwrapper do
    
    before do
      @test_file = File.join(File.dirname(__FILE__), '../fixtures/fake_test.rb')
    end
    
    it 'should get klass name of test from file content' do
      code = File.new(@test_file).read
      klass_name = MinitestOwrapper.test_klass_name(code)
      
      assert_equal 'FakeTest', klass_name
    end
    
    it 'should run FakeTest and get TestResult object whith  2 failure, 1 error, 1 success, 1 skip ' do
      load_path =  File.expand_path(File.join(File.dirname(__FILE__), '../fixtures'))

      result = MinitestOwrapper.run(@test_file, load_path) do |test_result|
        puts test_result.current
      end

      assert_equal 1, result.errors.count
      assert_equal 2, result.failures.count
      assert_equal 1, result.skips.count
      assert_equal 1, result.successes.count
      
      assert_equal 5, result.tests
      assert_in_delta result.duration, 1, 1
      assert_equal 4, result.assertions
    end

  end
  
end