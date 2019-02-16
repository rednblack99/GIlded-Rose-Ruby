require_relative './constants'

class BackstagePasses

  include Constants

  def initialize(item_quality, item_sell_in)
    @item_quality = item_quality
    @item_sell_in = item_sell_in
  end

  def determine_quality_change
    return 0 if @item_sell_in.negative?
    if @item_sell_in.between?(0, 5)
      @item_quality + INCREASE_TRIPLE
    elsif @item_sell_in.between?(0, 10)
      @item_quality + INCREASE_DOUBLE
    else
      @item_quality < 50 ? @item_quality + INCREASE_NORMAL : @item_quality
    end
  end

end
