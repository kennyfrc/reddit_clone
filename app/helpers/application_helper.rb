module ApplicationHelper
=begin
  the form_group_tag method returns a content_tag (which renders <div> </div>) so it should be used to wrap a small-ish form group  
=end

   def form_group_tag(errors, &block)
     if errors.any?
       content_tag :div, capture(&block), class: 'form-group has-error'
     else
       content_tag :div, capture(&block), class: 'form-group'
     end
   end
end
