require 'gilded_rose'

describe GildedRose do

  let(:item) { double :item, name: "foo", sell_in: 0, quality: 0 }

  describe "#update_quality" do
    it "does not change the name" do
      items = [Item.new("foo", 0, 0)]
      GildedRose.new(items).update_quality()
      expect(items[0].name).to eq "foo"
    end
  end

  describe '#sulfuras?' do

    it "returns true is item name is sulfuras" do
      items = [Item.new("Sulfuras, Hand of Ragnaros", 0, 0)]
      expect(GildedRose.new(items).sulfuras?(items[0])).to eq true
    end

    it "returns false is item name is not sulfuras" do
      items = [Item.new("foo", 0, 0)]
      expect(GildedRose.new(items).sulfuras?(items[0])).to eq false
    end
  end

end
