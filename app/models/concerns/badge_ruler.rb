module BadgeRuler
  extend ActiveSupport::Concern

  included do
    validates :rule_name, presence: true
    validate :rule_not_selected
  end

  def reward!(test_passage)
    return unless respond_to?(rule_name, true)

    test_passage.user.badges << self if send(rule_name, test_passage)
  end

  def rule
    self.class.rule(rule_name)
  end

  def options
    rule[:options] || {}
  end

  def params
    options[:params] || []
  end

  def rule_not_selected
    errors.add(:rule) if rule == {}
  end

  module ClassMethods
    def add_rule(method_name, options = {})
      title = I18n.t(method_name, scope: [to_s.downcase, :rules])
      rules[method_name] = { title: title, options: options }
      define_methods(options[:params])
    end

    def rule(name)
      name ||= ''
      rules[name.to_sym] || {}
    end

    def rules
      @rules ||= {}
    end

    private

    def define_methods(params)
      return unless params

      params.each do |param|
        method_name = "has_#{param}?".to_sym
        next if respond_to?(method_name, true)

        define_method(method_name) do
          self.params.include?(param)
        end
      end
    end
  end
end
