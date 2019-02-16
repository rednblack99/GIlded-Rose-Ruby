require_relative './constants'
require_relative './aged_brie'
require_relative './backstage_passes'

class UpdateQuality

  include Constants

  def initialize(item)
    @item = item
  end

  def determine_quality_change
    if aged_brie?(@item)
      update_aged_brie(@item.quality, @item.sell_in)
    elsif backstage_passes?(@item)
      BackstagePasses.new(@item.quality, @item.sell_in).determine_quality_change
    else
      reduce_quality(@item.quality)
    end
  end

  private

  def reduce_quality(item_quality)
    if item_quality.negative?
      item_quality - REDUCE_DOUBLE
    else
      item_quality.between?(1, 50) ? item_quality - REDUCE_NORMAL : item_quality
    end
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def update_aged_brie(item_quality, item_sell_in)
    if item_sell_in.negative?
      item_quality + INCREASE_DOUBLE unless item_quality + INCREASE_DOUBLE > 50
    else
      item_quality < 50 ? item_quality + INCREASE_NORMAL : item_quality
    end
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def update_backstage_passes(item_quality, item_sell_in)
    return 0 if item_sell_in.negative?
    if item_sell_in.between?(0, 5)
      item_quality + INCREASE_TRIPLE
    elsif item_sell_in.between?(0, 10)
      item_quality + INCREASE_DOUBLE
    else
      item_quality < 50 ? item_quality + INCREASE_NORMAL : item_quality
    end
  end
end
