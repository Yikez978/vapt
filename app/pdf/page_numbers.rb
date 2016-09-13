module PageNumbers
  def generate
    recipe
  end

  def recipe
    number_pages "<page>",
    {
      :page_filter => lambda{ |pg| pg != 1 },
      :at => [bounds.right - 50, 0],
      :align => :right,
      :size => 14
    }


  end
end
