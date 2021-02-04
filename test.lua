-- just a test file

myglobalvariable = 10
function myglobalfunction()
  local myx = 10
end

local M = {}

function M.test()
  local f = 10
  return f
end

return M
