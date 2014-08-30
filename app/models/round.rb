class Round < ActiveRecord::Base
  include Workflow
  workflow {}
  before_create :set_ordinal

  belongs_to :game

  def to_param
    ordinal.try(:to_s)
  end

  private
  def set_ordinal
    self.ordinal = (Round.where(game_id: game_id).maximum("ordinal") || 0) + 1
    logger.info "ORDINAL SET TO #{self.ordinal}"
  end

end
