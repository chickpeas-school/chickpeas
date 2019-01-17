module ApplicationHelper
  def datepicker_input form, field
    content_tag :div, class: 'datepicker', data: { 'date-format': 'yyyy-mm-dd' }  do
      form.hidden_field field
    end
  end
end
