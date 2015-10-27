require 'will_paginate/view_helpers/action_view'

module Grasshopper
  module Paginate
    class Renderer < ::WillPaginate::ActionView::LinkRenderer
	
      @@per_page_options =  [2,5,10]
      
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
        prev_html = current_page > 1 ? previous_or_next_page(current_page-1, @options[:previous_label], :previous_page) : ""
        next_html = current_page < total_pages ? previous_or_next_page(current_page+1, @options[:next_label], :next_page) : ""
        
        input     = tag(:li, tag(:input, nil, { class: 'jump-page', value: current_page, url: url('page_number'),total: total_pages }))
        input_msg = tag(:li, "of total #{total_pages} pages")
        input_html =  input + input_msg
        
        view_per_page  = tag :li, 'View per page:'

        @@per_page_options.each do |opt|
          view_per_page += tag :li, tag(:a,opt, { href: first_page_w_per_page(opt) })
        end

        content = tag(:ul, view_per_page + prev_html + input_html +next_html , container_attributes)
        tag :div, content, class: 'grasshopper-pagination'
			end

      private

      def first_page_w_per_page(per_page)
        merge_per_page(per_page)
      end

      def merge_per_page(per_page)
        original_url = url(1)
        u = URI(original_url)
        merged_params = Rack::Utils.parse_nested_query(u.query).merge({"per_page"=> per_page})
        merged_query  = Rack::Utils.build_nested_query(merged_params)
        u.query = merged_query
        u.to_s
      end

      def goto_input
        class_list = 'pagination goto hide'
        class_list += ' ajax' if @options[:ajax]
        tag :ul, page_input, class: class_list
      end

      def page_input
        input = tag :input, nil, input_data
        hidden_link = tag :a, nil, class: 'hidden-link'
        input += hidden_link
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
