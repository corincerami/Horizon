class BoundingArea
  def initialize(boxes)
    @boxes = boxes
  end

  def contains_point?(x, y)
    @boxes.any? { |box| box.contains_point?(x, y) }
  end
end
