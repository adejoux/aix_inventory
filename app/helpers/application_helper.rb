# -*- encoding : utf-8 -*-
module ApplicationHelper
  def link_to_add_fields(name, f, type)
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send("#{type}_fields", new_object, child_index: id) do |builder|
      render(type.to_s + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields btn btn-info", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_add_report_fields(name, f, association)
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to(name, '#', class: "add_fields  btn btn-info", data: {id: id, fields: fields.gsub("\n", "")})
  end

  def link_to_servers_search(field, search)
    link_to search, :controller => "servers", :q => {"c" => {"0" =>{"a" =>{"0" =>{"name"=>field}}, "p"=>"eq", "v" =>{"0"=>{"value" => search}}}}}
  end

  def current_user_scope
    current_user.customer_scope
  end
  # method below allow using devise sign in every where in application
  def resource_name
    :user
  end

  def recommended_firmware(model)
    unless Firmware.find_by_model(model).nil?
      Firmware.find_by_model(model).recommended
    else
      "Not found"
    end
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
