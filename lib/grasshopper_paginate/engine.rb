# Rails::Engine is a Railtie, extend rails inside
require 'grasshopper_paginate/renderer'
require 'grasshopper_paginate/helper'

module Grasshopper
  module Paginate
    class Engine < ::Rails::Engine
      initializer 'view helpers' do |app|
        ActiveSupport.on_load(:action_view) do
          include Grasshopper::Paginate::Helper
        end
      end

      initializer 'active record extention' do |app|
        ActiveSupport.on_load(:active_record) do
          require 'grasshopper_paginate/active_record'
        end
      end
    end
  end
end
