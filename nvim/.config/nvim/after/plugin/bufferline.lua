local bufferline_status, bufferline = pcall(require, 'bufferline')
if not bufferline_status then return end
bufferline.setup({})
