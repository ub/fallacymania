class Sprite
  include ActiveModel::Model
  attr_accessor :id
  def self.all
    all_ids=(0..37).to_a + (40..50).to_a + (53..58).to_a

    all_ids.collect do | i |
      self.new(id: i)
    end
  end

end