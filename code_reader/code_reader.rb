class CodeReader
 
  attr_accessor :code,:test,:result,:errors
  
  def initialize
    @code = ""
    @result = ""
    @time_takem = 0
    @test = ""
    @errors=false
  end


  def run_tests
   code_with_test_suite = _serve_test
   result = eval_code(code_with_test_suite)
  end

  def eval_code(code)
    old_stdout = $stdout
    out = StringIO.new
    $stdout = out
    begin
      eval(code)
    rescue Exception => exc
     @errors = true
    end
    $stdout = old_stdout
    out.string
  end
  
  def run_test_case 

  end

 private 
  def parse_code

  end

  def build_code

  end
  
  def  _serve_test
  %" #{@code} 
     
     #{@test}
   "
  end
 	
end

require "test/unit"
require "rubygems"


class CodeReaderTest < Test::Unit::TestCase

 def setup
   @code_reader = CodeReader.new
   @code_reader_err = CodeReader.new
   @code_reader.code = %"
                  class CheckList 
                    def initialize  
                      @crap=\"1\"
                    end
                    def crap
                      @crap
                    end                       
                  end 
    "
    @code_reader.test= %"
                 class CheckListTest < Test::Unit::TestCase  
                   def test_works
                     check_list = CheckList.new 
                     assert_equal(\"1\",check_list.crap,\"check list stuff is not equal\")
                   end 
                 end
    "
    @code_reader_err.code = %"
                  class CheckList 
                    def initialize  
                      @crap=\"1\"
                    end
                    def crap
                      @crap
                    end 
                  end                      
    "
    @code_reader_err.test= %"
                 class CheckListTest < Test::Unit::TestCase  
                   def test_works
                     check_list = CheckList.new 
                     assert_equal(\"1\",check_list.crap,\"check list stuff is not equal\")
                   end 
                 end
    "
  end
  
  def test_no_errors
    @code_reader.run_tests
    assert(!@code_reader.errors)
  end
 
  def test_syntax_error
     @code_reader_err.run_tests
     assert(@code_reader_err.errors)
  end

end

