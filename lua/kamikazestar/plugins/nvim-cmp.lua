-- For some reason advices arent preserved during
-- Crtl+p and Ctrl+n actions and instead filenames
-- from the path text from the buffer is added
-- Snippets also does not work
-- TODO: Figure out why it's working in such way and apply workarround
local cmp_status, cmp = pcall(require, "cmp")
if not cmp_status then
  return
end

local luasnip_status, luasnip = pcall(require, "luasnip")
if not luasnip_status then
  return
end

local lspkind_status, lspkind = pcall(require, "lspkind")
if not lspkind_status then
  return
end

-- load frendly-snippets
require("luasnip/loaders/from_vscode").lazy_load()

vim.opt.completeopt = "menuone"

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mappings = cmp.mapping.preset.insert({
    -- For some reason Ctrl+k and Ctrl-j are not working
    -- This is probabl related to Fish, Kitty or Starship configuration
    -- As an workarround keys was remapped to Ctrl+p and Ctrl+n
    -- TODO: Figure out how to change configuration to allow those shortcut to work
    ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
		["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
		["<C-e>"] = cmp.mapping.abort(), -- close completion window
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	}),
	-- sources for autocompletion
	sources = cmp.config.sources({
	  { name = "nvim_lsp" }, -- lsp
		{ name = "luasnip" }, -- snippets
		{ name = "buffer" }, -- text within current buffer
		{ name = "path" }, -- file system paths
	}),
	-- configure lspkind for vs-code like icons
	formatting = {
		format = lspkind.cmp_format({
			maxwidth = 50,
			ellipsis_char = "...",
		}),
	},
})
