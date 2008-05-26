class Todo < DataMapper::Base

  property :text,       :string
  property :created_at, :datetime
  property :priority,   :integer
  
  validates_presence_of     :text, :priority
  validates_numericality_of :priority, :only_integer => true
  validates_true_for        :priority, :logic => lambda {
    priority.is_a?(Integer) && (0..4).include?(priority)
  }
  
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
