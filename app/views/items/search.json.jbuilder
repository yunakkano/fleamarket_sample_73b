json.array! @childrens do |child|
  json.id child.id
  json.category child.category
end

json.array! @grandChilds do |gc|
  json.id gc.id
  json.category gc.category
end