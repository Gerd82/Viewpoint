# Custom extensions to the class Hash
class Hash
  def deep_compact()
    inject({}) do |new_hash, (k,v)|
      v = v.deep_compact() if v.class == Hash
      new_hash[k] = v if !v.nil? and !(v.respond_to?('empty?') and v.empty?)
      new_hash
    end
  end

  def deep_compact!
    delete_if{|k, v|
      (v.is_a?(Hash) and v.respond_to?('empty?') and v.deep_compact!.empty?) or
          (v.nil?)  or
          (v.is_a?(String) and v.empty?)
    }
  end
end # Hash
