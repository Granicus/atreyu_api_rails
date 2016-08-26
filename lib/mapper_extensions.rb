module AtreyuAPIRails
  module MapperExtensions
    def bulk_index(resource, opts)
      opts[:to] ||= "#{resource}#bulk_index"
      put resource, opts
    end

    def count(resource, opts)
      opts[:to] ||= "#{resource}#count"
      get resource, opts
    end

    def atreyu_resources(*resources, &block)
      original_resources = resources.dup
      options = resources.extract_options!.dup
      resource = resources.pop.to_s

      base_actions = [:bulk_index, :count]
      actions = nil

      if options[:only]
        actions = options[:only].select { |action| base_actions.include? action }
      elsif options[:except]
        actions = base_actions.select { |action| options[:except].include? action }
      else
        actions = base_actions
      end

      mapper = self

      actions.each do |action|
        mapper.send(action, resource, { to: "#{controller}##{action}" })

        put resource
      end

      resources(*original_resources, &block)
    end
  end
end
