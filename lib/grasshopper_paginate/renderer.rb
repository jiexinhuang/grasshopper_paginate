require 'will_paginate/view_helpers/action_view'

module Grasshopper
  module Paginate
    class Renderer < ::WillPaginate::ActionView::LinkRenderer
      
      def to_html
        if  @options[:enable_per_page_input]
              tag :div, per_page_html + navigation_html, class: 'grasshopper-pagination'
        else
          super
        end
      end
	
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

      def per_page_html
        # User options for per page
        view_per_page = tag :li, tag(:h6, 'View per page: ')
        Grasshopper::Paginate.per_page_options.each do |per_page|
          view_per_page += tag(
            :li,
            tag(:a, per_page, href: first_page_w_per_page(per_page)),
            class: (per_page == @collection.per_page ? "current":"" )
          )
        end
        content = tag(:ul, view_per_page , class: 'pagination per-page')
      end

      def navigation_html
        # First page link
        first = previous_or_next_page(current_page > 1 ? 1 : nil, @options[:first_label], :first_page)

        # Previous page link
        previous  = previous_or_next_page(current_page > 1 ?  current_page-1 : nil, @options[:previous_label], :previous_label) 

        # Page input from user
        page_input = tag(:li, tag(:input, nil, { class: 'default-goto-page goto-page', value: current_page, url: url('page_number'),total: total_pages }))
        page_input_message  = tag(:li, tag(:h6," of #{total_pages} pages"))
        p_input =  page_input + page_input_message

        # Next page link
        nextt = previous_or_next_page(current_page < total_pages ? current_page+1 : nil, @options[:next_label], :next_label)

        # Last page link
        last  = previous_or_next_page(current_page < total_pages ? total_pages : nil , @options[:last_label], :last_page) 

        # Putting all links together
        content = tag(:ul , first + previous + p_input + nextt + last , class: 'pagination page-navigation')
      end

      def first_page_w_per_page(per_page)
        first_page_url = url(1)
        merge_per_page(first_page_url, per_page)
      end

      def merge_per_page(original_url, per_page)
        uri = URI(original_url)
        merged_params = Rack::Utils.parse_nested_query(uri.query).merge({"per_page"=> per_page})
        merged_query  = Rack::Utils.build_nested_query(merged_params)
        uri.query = merged_query
        uri.to_s
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
