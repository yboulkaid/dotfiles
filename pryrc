Pry.config.editor = 'nvim'
Pry.config.history_file = '.pry_history'

# https://stackoverflow.com/questions/27261378/how-might-i-pass-text-data-from-the-ruby-console-into-my-clipboard-without-savin
def pbcopy(arg)
  out = arg.is_a?(String) ? arg : arg.inspect
  IO.popen('pbcopy', 'w') { |io| io.puts out }
  puts out
  true
end

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
