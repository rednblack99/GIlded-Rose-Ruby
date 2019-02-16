require_relative './item'
require_relative './constants'
require_relative './update_quality'

class GildedRose

  include Constants

  def initialize(items)
    @items = items
  end

  def update_quality
    @items.each do |item|
      quality_change = UpdateQuality.new(item).determine_quality_change
      item.quality = quality_change unless sulfuras?(item)
      item.sell_in = item.sell_in - REDUCE_NORMAL unless sulfuras?(item)
    end
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end
end
