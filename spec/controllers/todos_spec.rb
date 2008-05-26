require File.join(File.dirname(__FILE__), "..", 'spec_helper.rb')

describe Todos, "#index" do
  before(:each) do
    dispatch_to(Todos, :index)
  end
end
