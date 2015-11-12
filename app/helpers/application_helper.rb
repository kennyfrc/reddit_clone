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

# add a helper method that allows you to convert markdown text to html

    def markdown_to_html(markdown)
      renderer = Redcarpet::Render::HTML.new
      extensions = {fenced_code_blocks: true}
      redcarpet = Redcarpet::Markdown.new(renderer, extensions)
      (redcarpet.render markdown).html_safe
    end
end
