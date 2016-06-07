class Search
  def self.current=(images)
    @current = images
  end
  def self.current
    current = @current
    @current = nil
    return current
  end
end
