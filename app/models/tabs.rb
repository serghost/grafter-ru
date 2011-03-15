class Tabs
  attr_accessor :tabs
  attr_reader :active

  def initialize(tabs = {})
    @tabs = tabs
  end

  def each
    @tabs.each do |title, link|
      yield title.capitalize, link, (title.to_s == @active.to_s)
    end
  end

  def active!(tab)
    if @tabs.keys.include? tab
      @active = tab
    else
      @active = nil
    end
  end

  def self.model_name
    self
  end

  def self.partial_path
    "shared/#{self.to_s.downcase}"
  end
end
