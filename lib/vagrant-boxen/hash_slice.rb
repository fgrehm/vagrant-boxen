module HashSlice
  # From ActiveSupport
  def slice(*keys)
    keys = keys.map! { |key| convert_key(key) } if respond_to?(:convert_key)
    hash = self.class.new
    keys.each { |k| hash[k] = self[k] if has_key?(k) }
    hash
  end
end

Hash.instance_eval { include HashSlice } unless Hash.instance_methods.include?(:slice)
