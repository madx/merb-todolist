require 'dm-validations'
class Todo
  include DataMapper::Resource

  property :id,         Integer,  :serial => true
  property :text,       String
  property :created_at, DateTime
  property :priority,   Integer
  
  validates_present     :text, :priority
  validates_is_number   :priority, :only_integer => true
  validates_with_block do
    @priority.is_a?(Integer) && (0..4).include?(@priority)
  end
  
  def priority_text
    {
      0 => '<span class="lowprio">--</span>',
      1 => '<span class="lowprio">-</span>',
      2 => '',
      3 => '<span class="highprio">+</span>',
      4 => '<span class="highprio">++</span>'
    }[priority]
  end
  
end
