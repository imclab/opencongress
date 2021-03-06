require 'o_c_logger'
require 'json'
require 'time'
require 'active_support'
require 'united_states/import_guard'
require 'united_states/bills'
require 'united_states/committees'
require 'united_states/votes'
require 'united_states/legislators'
require 'united_states/congress'
require 'united_states/contact_congress'

##
# Provides methods to parse and decode files from the
# @unitedstates repositories.
module UnitedStates

  class Error < StandardError
  end

  class DataValidationError < Error
  end

  class ImportExpiredError < Error
  end

  class MissingRequiredElement < DataValidationError
  end

end