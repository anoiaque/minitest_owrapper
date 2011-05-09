module MinitestOwrapper
  
  class AssertionStatus
    attr_accessor :klass, :method, :line, :message
    
    def initialize args={}
      @klass = args[:klass]
      @method = args[:method]
      @line = args[:line]
      @message = args[:message]
    end
    
  end
  
  class Failure < AssertionStatus
  end
  
  class Error < AssertionStatus
  end
  
  class Skip < AssertionStatus
  end
  
  class Success < AssertionStatus
  end
  
  class TestResult

    attr_reader :skips, :failures, :errors, :successes
    attr_accessor :assertions

    def initialize
      @skips = []
      @failures = []
      @errors = []
      @successes = []
      @time = 0
      @assertions = 0
    end

    def current
      case
        when @skip then @skips.last
        when @fail then @failures.last
        when @error then @errors.last
        else Success.new
      end
    end
    
    def start
      @start = Time.now
    end
    
    def stop
      @time = Time.now - @start
    end
  
    def success?
      not (@skip || @fail || @error)
    end

    def reset
      @successes << Success.new if success? 
      @skip = @fail = @error = false
    end
    
    def tests
      [skips, failures, errors, successes].inject(0){|total, assertions| total += assertions.count }
    end
    
    def duration
      @time
    end

    def puke klass, method, e
      line = MiniTest::Unit.new.location(e)
      case e
      when MiniTest::Skip then
        @skips << Skip.new(:klass => klass, :method => method, :line => line, :message => e.message)
        @skip = true
      when MiniTest::Assertion then
        @failures << Failure.new(:klass => klass, :method => method, :line => line, :message => e.message)
        @fail = true
      else
        bt = MiniTest::filter_backtrace(e.backtrace).join("\n    ")
        message = "#{e.class}: #{e.message}\n #{bt}"
        @errors <<  Error.new(:klass => klass, :method => method, :line => line, :message => e.message)
        @error = true
      end
    end

  end
end