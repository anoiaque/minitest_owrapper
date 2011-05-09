require 'macruby_test_result'

module MinitestOwrapper
  
  def self.run test_file, load_path='', &block
     load_path.split(":").each{ |path| $: << path }
     code = File.new(test_file).read
     test_result = TestResult.new  
     
     injection = %q{
       test_result.start
       klass = self.const_get(test_klass_name(code))
       klass.instance_methods.grep(/^test_/).each do |method|
        runner = klass.new(method) 
        runner.run(test_result)
        block.call(test_result) if block
        test_result.assertions += runner._assertions
        test_result.reset
       end
       test_result.stop
       test_result
     }
     eval(code + injection)
  end
   
  def self.test_klass_name content
    content.match /class\s*(.*?)\s*</
    $1
  end
  
end

