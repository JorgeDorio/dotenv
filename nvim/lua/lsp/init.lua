local lsp_installer = require("nvim-lsp-installer")

local signs = {
	{ name = "DiagnosticSignError", text = "" },
	{ name = "DiagnosticSignWarn", text = "" },
	{ name = "DiagnosticSignHint", text = "" },
	{ name = "DiagnosticSignInfo", text = "" },
}

for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
	virtual_text = false,
	signs = {
		active = signs,
	},
	update_in_insert = true,
	underline = true,
	severity_sort = true,
	float = {
		focusable = false,
		style = "minimal",
		border = "rounded",
		source = "always",
		header = "",
		prefix = "",
	},
}

vim.diagnostic.config(config)

local on_attach = function(client, bufnr)
	local function buf_set_keymap(...)
		vim.api.nvim_buf_set_keymap(bufnr, ...)
	end
	local function buf_set_option(...)
		vim.api.nvim_buf_set_option(bufnr, ...)
	end

	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")

	local opts = { noremap = true, silent = true }

	buf_set_keymap("n", "gl", ":lua vim.diagnostic.open_float()<CR>", opts)
end

local servers = {
	"bashls",
	"cssls",
	"emmet_ls",
	"sumneko_lua",
	"tsserver",
	"pyright",
	"omnisharp",
}

for _, name in pairs(servers) do
	local server_is_found, server = lsp_installer.get_server(name)
	if server_is_found then
		if not server:is_installed() then
			print("Installing " .. name)
			server:install()
		end
	end
end


lsp_installer.on_server_ready(function(server)
	local opts = {
		on_attach = on_attach,
		capabilities = capabilities,
	}
	 if server.name == "sumneko_lua" then
	 	local sumneko_opts = require("lsp.cfg.sumneko_lua")
	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	 end

	 if server.name == "tsserver" then
	 	local tsserver_opts = require("lsp.cfg.tsserver")
	 	opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
	 end

	 if server.name == "omnisharp" then
	 	local omnisharp_opts = require("lsp.cfg.omnisharp")
	 	opts = vim.tbl_deep_extend("force", omnisharp_opts, opts)
	 end

	server:setup(opts)
end)
