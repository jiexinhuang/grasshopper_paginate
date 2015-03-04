require 'grasshopper_paginate/version'
require 'grasshopper_paginate/renderer'
require 'grasshopper_paginate/helper'
require 'grasshopper_paginate/engine'

ActiveSupport.on_load(:action_view) do
  include Grasshopper::Paginate::Helper
end

module Grasshopper
  module Paginate
  end
end
