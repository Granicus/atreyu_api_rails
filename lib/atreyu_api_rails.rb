require_relative 'mapper_extensions'
require 'action_dispatch/routing'

ActionDispatch::Routing::Mapper.send :include, AtreyuAPIRails::MapperExtensions
