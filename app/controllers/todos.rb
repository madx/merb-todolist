class Todos < Application

  provides :html, :xml

  def index
    @todos = Todo.all :order => 'priority DESC, created_at ASC'
    render
  end

  def create
  
    t = TodoParser.new(params[:todo_expr]).parse
    Merb.logger.info t.inspect
    case t[:action]
    
      when :add
        @todo = Todo.new t[:params]
        @todo.save
        redirect url(:todos)
        
      when :delete
        redirect url(:delete_todo, Todo.first(t[:params][:id]))
        
      when :edit
        @todo = Todo.first t[:params][:id]
        if @todo
          @todo.text = t[:params][:text]
          @todo.save
        end
        redirect url(:todos)
        
      when :increase_priority
        @todo = Todo.first t[:params][:id]
        if @todo && @todo.priority < 4
          @todo.priority += 1
          @todo.save
        end
        redirect url(:todos)
        
      when :decrease_priority
        @todo = Todo.first t[:params][:id]
        if @todo && @todo.priority > 0
          @todo.priority -= 1
          @todo.save
        end
        redirect url(:todos)
    end
    
  end

  def delete
    @todo = Todo.first(params[:id])
    raise NotFound unless @todo
    if @todo.destroy!
      redirect url(:todos)
    else
      raise BadRequest
    end
  end

end
