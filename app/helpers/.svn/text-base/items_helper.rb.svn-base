module ItemsHelper

  def add_image(form_builder)
    link_to_function "Add Images", :id  => "add_image" do |page|
      form_builder.fields_for :images, Image.new, :child_index => 'NEW_RECORD' do |image_form|
        html = render(:partial => 'image', :locals => { :f => image_form })
        page << "$('add_image').insert({ before: '#{escape_javascript(html)}'.replace(/NEW_RECORD/g, new Date().getTime()) });"
      end
    end
  end
  
  def delete_image(form_builder)
    if form_builder.object.new_record?
      link_to_function("Remove this Image", "this.up('fieldset').remove()")
    else
      form_builder.hidden_field(:_delete) +
      link_to_function("Remove this Image", "this.up('fieldset').hide(); $(this).previous().value = '1'")
    end
  end

end
