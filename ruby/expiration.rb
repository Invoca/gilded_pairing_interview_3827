module Expiration
  def self.included(base)
    base.extend ClassMethods
  end

  def expires?
    self.class.expires?
  end

  module ClassMethods
    def expires?
      @expires = true if @expires.nil?
      @expires
    end

    # prevent reducing sell_by for assets that do not expire
    def does_not_expire
      @expires = false
    end
  end
end