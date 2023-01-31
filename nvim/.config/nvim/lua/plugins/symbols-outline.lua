local outline_status, outline = pcall(require, 'symbols-outline')
if not outline_status then
  return
end

outline.setup({})
