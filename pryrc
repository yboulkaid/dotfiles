Pry.config.editor = 'nvim'
Pry.config.history_file = '.pry_history'

module ArrayEverything
  def method_missing(name, *args, &block)
    excluded = %i[
      to_a
      to_ary
      to_h
      to_hash
    ]
    if excluded.include?(name)
      super
    elsif all? { |item| item.respond_to?(name) }
      STDOUT.puts "This array doesn't really respond to \e[1;37m##{name}\e[0;39m, but it was applied to each item."
      map { |item| item.public_send(name, *args, &block) }
    else
      super
    end
  end
end
Array.send(:include, ArrayEverything)
