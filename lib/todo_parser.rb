# This class is used to parse an expression from the input field.
#
# Here's the syntax for expressions : 
#
#   ~i: removes todo 'i' from the list
#   [i] text : changes todo 'i' text
#   @i+ : increases todo 'i' priority
#   @i- : decreases todo 'i' priority
#
# Everything else is simply added as a new todo !
class TodoParser

  attr_accessor :expr, :params, :action

  def initialize(expr)
    @expr   = expr
    @params = {}
    @action = nil
  end
  
  def parse
    @params = {}
    @action = nil
    case @expr
      when /^~(\d+)$/
        @params[:id] = $~[1]
        @action      = :delete
      when /^\[(\d+)\](.+)$/
        @params[:id]   = $~[1]
        @params[:text] = $~[2].strip
        @action        = :edit
      when /^@(\d+)\+$/
        @params[:id]   = $~[1]
        @action        = :increase_priority
      when /^@(\d+)-$/
        @params[:id]   = $~[1]
        @action        = :decrease_priority
      when /^\+\+(.+)/
        @action = :add
        @params[:priority] = 4
        @params[:text]     = $~[1].strip
      when /^\+(.+)/
        @action = :add
        @params[:priority] = 3
        @params[:text]     = $~[1].strip
      when /^--(.+)/
        @action = :add
        @params[:priority] = 0
        @params[:text]     = $~[1].strip
      when /^-(.+)/
        @action = :add
        @params[:priority] = 1
        @params[:text]     = $~[1].strip
      else
        @action = :add
        @params[:priority] = 2
        @params[:text]     = @expr
    end
    {:action => @action, :params => @params}
  end

end
