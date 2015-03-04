require "grasshopper_paginate/version"
require "grasshopper_paginate/renderer"
require "grasshopper_paginate/helper"

ActiveSupport.on_load(:action_view) do
  include Grasshopper::Paginate::Helper
end
