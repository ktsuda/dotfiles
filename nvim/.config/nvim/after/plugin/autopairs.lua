local ap_status, ap = pcall(require, 'nvim-autopairs')
if not ap_status then
  return
end

local cmp_ap_status, cmp_ap = pcall(require, 'nvim-autopairs.completion.cmp')
if not cmp_ap_status then
  return
end

local cmp_status, cmp = pcall(require, 'cmp')
if not cmp_status then
  return
end

ap.setup()
cmp.event:on('confirm_done', cmp_ap.on_confirm_done())
