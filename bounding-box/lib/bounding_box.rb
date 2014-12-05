class BoundingBox
  attr_reader :width, :height, :left, :right, :top, :bottom
  def initialize(left, bottom, width, height)
    @width = width
    @height = height
    @left = left
    @right = left + width
    @top = bottom + height
    @bottom = bottom
  end

  def contains_point?(x, y)
    (x >= @left && x <= @right) &&
    (y >= @bottom && y <= @top)
  end
end
