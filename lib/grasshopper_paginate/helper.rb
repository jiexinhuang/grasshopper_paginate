module Grasshopper
  module Paginate
	  module Helper
	    def grasshopper_paginate(pages, options={})
	      will_paginate pages, options.merge(default_options)
	    end

      private

      def default_options
        { 
	        :inner_window => 1,
          :outer_window => 0,
          :renderer => Grasshopper::Paginate::Renderer,
          :previous_label => '&lsaquo;'.html_safe,
          :next_label => '&rsaquo;'.html_safe,
          :last_label => '&raquo;'.html_safe,
          :first_label => '&laquo;'.html_safe
        }
      end
	  end
	end
end
