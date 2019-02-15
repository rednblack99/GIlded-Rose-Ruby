require_relative './item'

class GildedRose

  def initialize(items)
    @items = items
  end

  def update_quality()
    @items.each do |item|
      if sulfuras?(item)
      elsif aged_brie?(item)
        item.quality = update_aged_brie(item.quality)
      elsif backstage_passes?(item)
        item.quality = update_backstage_passes(item.quality, item.sell_in)
      else
        item.quality = reduce_quality(item.quality)
      end
      item.sell_in = item.sell_in - 1 unless sulfuras?(item)
        
        
      if item.sell_in < 0
        if item.name != "Aged Brie"
          if item.name != "Backstage passes to a TAFKAL80ETC concert"
            if item.quality > 0
              item.quality = item.quality - 1
            end
          else
            item.quality = item.quality - item.quality
          end
        else
          if item.quality < 50
            item.quality = item.quality + 1
          end
        end
      end
    end
  end

  def sulfuras?(item)
    item.name == "Sulfuras, Hand of Ragnaros"
  end

  def reduce_quality(item_quality)
    item_quality.between?(1, 50) ? item_quality-1 : item_quality
  end

  def aged_brie?(item)
    item.name == "Aged Brie"
  end

  def update_aged_brie(item_quality)
    item_quality < 50 ? item_quality + 1 : item_quality
  end

  def backstage_passes?(item)
    item.name == "Backstage passes to a TAFKAL80ETC concert"
  end

  def update_backstage_passes(item_quality, item_sell_in)
    if item_sell_in < 0
      0
    elsif item_sell_in.between?(0, 5)
      item_quality + 3
    elsif item_sell_in.between?(0, 10)
      item_quality + 2
    else
      item_quality < 50 ? item_quality + 1 : item_quality
    end

  end

end
