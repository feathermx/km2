module BlockStreetable
  
  extend ActiveSupport::Concern
  
  included do
    
    scope :street_base, ->{ select("streets.research_id as street_research") }
    scope :block_base, ->{ select("blocks.research_id as block_research") }
    
    attr_protected :street_id
    attr_accessor :street_research, :block_research
    
    validates :street_research, numericality: { only_integer: true } , presence: true
    validates :block_research, numericality: { only_integer: true }, presence: true
    
    before_save :block_streetable_on_before_save
    
    def block_streetable_on_before_save
      unless self.street_research.nil? || self.block_research.nil?
        block = Block.find_or_generate(self.block_research)
        unless block.nil?
          street = Street.find_or_generate(self.street_research, { block_id: block.id })
          self.street_id = street.id unless street.nil?
        end
      end
    end
    
  end
  
  module ClassMethods
    
    def include_street
      self.street_base.joins("JOIN streets ON streets.id = #{self.table_name}.street_id")
    end
    
    def include_block
      self.block_base.joins("JOIN blocks ON blocks.id = streets.block_id")
    end
    
  end
  
  
  
end