class MenuBlueprint < Blueprinter::Base
  identifier :id
  
  fields :name

  association :dishes, blueprint: DishBlueprint
end
