module Volt
  class HashDependency
    def initialize
      @hash_depedencies = {}
    end

    def depend(key)
      ensure_key(key).depend
    end

    def changed!(key)
      dep = @hash_depedencies.delete(key)

      if dep
        dep.changed!
        dep.remove
      end
    end

    def delete(key)
      dep = @hash_depedencies.delete(key)

      puts "Delete DEP: #{key} - #{dep.inspect}"

      if dep
        dep.changed!
        dep.remove
      end
    end

    def changed_all!
      @hash_depedencies.each_pair do |key, value|
        value.changed!
        value.remove
      end

      @hash_depedencies = {}
    end

    private

    def ensure_key(key)
      @hash_depedencies[key] ||= Dependency.new
    end
  end
end
