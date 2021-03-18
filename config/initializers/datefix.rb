module SimpleCalendar
  class MonthCalendar < SimpleCalendar::Calendar
    
      def url_for_next_view
        view_context.url_for(@params.merge(start_date_param => ((date_range.last + 1).beginning_of_month).iso8601).except(:selected_date))
      end
  
      def url_for_previous_view
        p date_range
        view_context.url_for(@params.merge(start_date_param => ((date_range.first - 1).beginning_of_month).iso8601).except(:selected_date))
      end
  end
end