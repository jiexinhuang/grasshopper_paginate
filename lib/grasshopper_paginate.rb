require 'grasshopper_paginate/array'
require 'grasshopper_paginate/engine'

module Grasshopper
  module Paginate
    cattr_accessor :per_page_options
    @@per_page_options =  [10,20]
  end
end
