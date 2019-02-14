require 'gilded_rose'

describe GildedRose do

  context "normal items" do

    before(:each) do
      @items = [Item.new("cat", 1, 2)]
      @gilded_rose = GildedRose.new(@items)
      @gilded_rose.update_quality
    end

    it "quality drops by 1 per day" do
      expect(@items[0].quality).to eq 1
    end

    it "sell-in value drops by 1 per day" do
      expect(@items[0].sell_in).to eq 0
    end

    it "quality drops twice as fast when sell-in has passed" do
      @gilded_rose.update_quality
      expect(@items[0].quality).to eq 0
    end

    it "quality is never negative" do
      @gilded_rose.update_quality
      @gilded_rose.update_quality
      expect(@items[0].quality).to eq 0
    end
  end

  context "Aged Brie" do
    before(:each) do
      @items = [Item.new("Aged Brie", 1, 49)]
      @gilded_rose = GildedRose.new(@items)
      @gilded_rose.update_quality
    end

    it "increases in value" do
      expect(@items[0].quality).to eq 50
    end

    it "never goes beyond quality 50" do
      @gilded_rose.update_quality
      expect(@items[0].quality).to eq 50
    end
  end

  context "Sulfuras" do
    before(:each) do
      @items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 50)]
      @gilded_rose = GildedRose.new(@items)
      @gilded_rose.update_quality
    end

    it "quality doesn't drop" do
      expect(@items[0].quality).to eq 50
    end

    it "sell-in value drops by 1 per day" do
      expect(@items[0].sell_in).to eq 0
    end
  end

  context "Backstage passes" do
    before(:each) do
      @items = [Item.new("Backstage passes to a TAFKAL80ETC concert", 12, 5)]
      @gilded_rose = GildedRose.new(@items)
      @gilded_rose.update_quality
    end

    it "Drop to 0 quality after the concert" do
      13.times { @gilded_rose.update_quality }
      expect(@items[0].quality).to eq 0
    end

    context "increases in value" do
      it "by 1 with more than 10 days until concert" do
        expect(@items[0].quality).to eq 6
      end  

      it "by 2 with 9 days until the concert" do
        @gilded_rose.update_quality
        @gilded_rose.update_quality
        expect(@items[0].quality).to eq 9
      end

      it "by 3 with 4 days until the concert" do
        8.times { @gilded_rose.update_quality }
        expect(@items[0].quality).to eq 23
      end
    end
  end
end
