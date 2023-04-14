Pry.config.editor = 'nvim'
Pry.config.history_file = '.pry_history'

# https://stackoverflow.com/questions/27261378/how-might-i-pass-text-data-from-the-ruby-console-into-my-clipboard-without-savin
def pbcopy(arg)
  out = arg.is_a?(String) ? arg : arg.inspect
  IO.popen('pbcopy', 'w') { |io| io.puts out }
  puts out
  true
end

class Object
  def ivar(var_name)
    instance_variable_get("@#{var_name}")
  end
end
