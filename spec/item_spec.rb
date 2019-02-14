require 'item'

describe Item do
  before(:each) do
    @item = Item.new("Cat", 10, 5)
  end
  
  it "has a name" do
    expect(@item.name).to eq "Cat"
  end

  it "has a sell_in value" do
    expect(@item.sell_in).to eq 10
  end

  it "has a quality" do
    expect(@item.quality).to eq 5
  end

  it "has method to turn values to string" do
    expect(@item.to_s).to eq "Cat, 10, 5"
  end
end
