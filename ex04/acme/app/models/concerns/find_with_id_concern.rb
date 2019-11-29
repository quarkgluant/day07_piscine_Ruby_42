module FindWithIdConcern
  extend ActiveSupport::Concern

  module ClassMethods
    def all
      ObjectSpace.each_object(self).to_a
    end

    def find_by(id:)
      all.select { |instance| instance.id == id }&.first
    end
  end
end
