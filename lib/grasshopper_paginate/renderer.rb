require 'will_paginate/view_helpers/action_view'

module Grasshopper
  module Paginate
    class Renderer < ::WillPaginate::ActionView::LinkRenderer
	
			protected

			def gap
				tag :li, link(super, nil), :class => 'goto-gap'
			end

			def page_number(page)
				tag :li, link(page, page, :rel => rel_value(page)), :class => ('current' if page == current_page)
			end

			def previous_or_next_page(page, text, classname)
				tag :li, link(text, page || '#'), :class => [classname[0..3], classname, ('unavailable' unless page)].join(' ')
			end

			def html_container(html)
				content = tag(:ul, html, container_attributes) + goto_input
        tag :div, content, class: 'grasshopper-pagination'
			end

      private

      def goto_input
        tag :ul, page_input, class: 'pagination goto hide'
      end

      def page_input
        input = tag :input, nil, input_data
        input = tag :li, input
        total_count = tag :li, tag(:a, "&nbsp; / &nbsp; #{total_pages}".html_safe, class: 'total-pages'), class: 'unavailable'
        previous_page + input + total_count + next_page
      end

      def input_data
        {
          class: 'goto-page',
          value: current_page,
          url: url('page_number'),
          total: total_pages
        }
      end
		end
  end
end
