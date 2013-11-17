module Examdown
  class Cache
    attr_reader :store
    private :store

    def initialize(path = '.examdown.yml')
      @store = YAML::Store.new(path)
    end

    def fetch(element)
      store.transaction do
        store[calculate_hash(element)] ||= yield(element)
      end
    end

    private

    def calculate_hash(element)
      Digest::SHA1.hexdigest(element.value)
    end
  end
end
