class AttrAccessorObject
  # splat converts args to array of args
  def self.my_attr_accessor(*names)
    names.each do |name|
      define_method("#{name}=") do |value|
        instance_variable_set("@#{name}", value)
      end
      define_method("#{name}") do
        instance_variable_get("@#{name}")
      end
    end
  end
end
# class AttrWriterObject
#   def self.my_attr_writer(*names)
#     names.each do |name|
#       define_method("#{name}") do
#         instance_variable_set("@#{name}")
#       end
#     end
#   end
# end
