local M = {}
local cmp = package.loaded.cmp
local luasnip = package.loaded.luasnip

function M.next_expand_jump(fallback)
  if cmp.visible() then
    cmp.complete_common_string()
    cmp.select_next_item()
  elseif luasnip.expand_or_jumpable() then
    luasnip.expand_or_jump()
  else
    fallback()
  end
end

function M.prev_expand_jump(fallback)
  if cmp.visible() then
    cmp.complete_common_string()
    cmp.select_prev_item()
  elseif luasnip.jumpable(-1) then
    luasnip.jump(-1)
  else
    fallback()
  end
end

function M.complete_common(fallback)
  if cmp.visible() then
    return cmp.complete_common_string()
  end
  fallback()
end

return M
