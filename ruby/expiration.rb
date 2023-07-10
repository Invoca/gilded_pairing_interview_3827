# frozen_string_literal: true

##
# This module provides a system to manage and query whether an item expires.
# By default, items are assumed to expire unless explicitly set otherwise.
# It provides class-level methods to define whether an item type expires.
# 
# Once included in a class, it gives instances of that class the ability to check
# if they expire by calling the instance method `expires?`.
#
module Expiration
  def self.included(base)
    base.extend ClassMethods
  end

  def expires?
    self.class.expires?
  end

  ##
  # This module provides class level methods for managing expiration.
  #
  module ClassMethods
    def expires?
      @expires = true if @expires.nil?
      @expires
    end

    # Sets that instances of the class do not expire.
    def does_not_expire
      @expires = false
    end
  end
end
