require_relative './constants'

class AgedBrie

  include Constants

  def initialize(item_quality, item_sell_in)
    @item_quality = item_quality
    @item_sell_in = item_sell_in
  end

  def determine_quality_change
    if @item_sell_in.negative?
      @item_quality + INCREASE_DOUBLE unless @item_quality + INCREASE_DOUBLE > 50
    else
      @item_quality < 50 ? @item_quality + INCREASE_NORMAL : @item_quality
    end

  end

end
