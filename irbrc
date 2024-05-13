# frozen_string_literal: true

def cd(object = nil)
  if object.nil?
    popws until workspaces.empty?
  else
    pushws object
  end
end
