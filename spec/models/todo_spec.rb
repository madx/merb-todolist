require File.join( File.dirname(__FILE__), "..", "spec_helper" )

describe Todo do

  before(:each) do 
    @todo = Todo.new
  end
  
  def todo_has_text!
    @todo.text = 'This is a valid todo'
  end
  
  def todo_has_priority!
    @todo.priority = 2
  end

  it "should not be valid when there is no text" do
    todo_has_priority!
    @todo.should_not be_valid
  end
  
  it "should not be valid when there is no priority" do
    todo_has_text!
    @todo.should_not be_valid
  end
  
  it "should not be valid with non numeric priority" do
    todo_has_text!
    @todo.priority = 'Foo'
    @todo.should_not be_valid
  end
  
  it "should not be valid for negative, floating or > 5 priority values" do
    todo_has_text!
    [-1, 5, 0.5].each do |n|
      @todo.priority = n
      @todo.should_not be_valid
    end
  end
  
  it "should be valid for integer values in 0..4" do
    todo_has_text!
    (0..4).each do |i|
      @todo.priority = i
      @todo.should be_valid
    end
  end
    
  it "should be valid with text and numeric priority" do
    todo_has_text!
    todo_has_priority!
    @todo.should be_valid
  end

end
