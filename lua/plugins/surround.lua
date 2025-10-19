return {
	{
		"tpope/vim-surround", 
		event = { "BufReadPost", "BufNewFile" },
		keys = {
			-- Enhanced surround operations (VS Code style hints)
			{ "ys", desc = "󰅪 Add surround" },
			{ "cs", desc = "󰛔 Change surround" },
			{ "ds", desc = "󰅙 Delete surround" },
			{ "yS", desc = "󰅪 Add surround (line)" },
			{ "yss", desc = "󰅪 Add surround (whole line)" },
			{ "ySS", desc = "󰅪 Add surround (whole line, indented)" },
			-- Visual mode
			{ "S", desc = "󰅪 Add surround", mode = "v" },
			{ "gS", desc = "󰅪 Add surround (line)", mode = "v" },
		},
		config = function()
			-- Enhanced surround patterns for cloud security engineering
			vim.g.surround_no_mappings = 0 -- Keep default mappings
			
			-- Custom surround patterns for common cloud security file types
			local surround_patterns = {
				-- YAML/Kubernetes patterns
				["121"] = "{{ \\r }}", -- y (YAML template)
				["75"] = "\\${{ \\r }}", -- K (Kubernetes variable)
				
				-- Terraform patterns  
				["116"] = "\\${ \\r }", -- t (Terraform interpolation)
				["118"] = "var.\\r", -- v (Terraform variable)
				
				-- Docker patterns
				["100"] = "\\${ \\r }", -- d (Docker variable)
				["69"] = "ENV \\r=", -- E (Environment variable)
				
				-- Security patterns
				["115"] = "\\${{ secrets.\\r }}", -- s (GitHub secrets)
				["97"] = "\\${{ env.\\r }}", -- a (GitHub env)
				
				-- Code patterns
				["102"] = "function \\r() {\\n\\t\\n}", -- f (function)
				["99"] = "/* \\r */", -- c (comment)
				["108"] = "console.log(\\r)", -- l (log)
			}
			
			-- Apply custom patterns
			for key, value in pairs(surround_patterns) do
				vim.g["surround_" .. key] = value
			end
			
			-- Enhanced feedback for surround operations
			local function enhance_surround_feedback()
				vim.api.nvim_create_autocmd("User", {
					pattern = "SurroundOperation",
					callback = function(event)
						local operation = event.data and event.data.operation or "unknown"
						local surround_char = event.data and event.data.char or ""
						
						local messages = {
							add = "󰅪 Added surround: " .. surround_char,
							change = "󰛔 Changed surround: " .. surround_char,
							delete = "󰅙 Deleted surround: " .. surround_char,
						}
						
						local message = messages[operation] or "󰅪 Surround operation completed"
						vim.notify(message, vim.log.levels.INFO, {
							title = "󰅪 Surround",
							timeout = 1000
						})
					end,
				})
			end
			
			-- Apply enhancements
			enhance_surround_feedback()
			
			-- User commands for common cloud security surrounds
			vim.api.nvim_create_user_command("SurroundYaml", function()
				vim.notify("Use 'ys' followed by motion and 'y' for YAML template", vim.log.levels.INFO, {
					title = "󰅪 YAML Surround Help"
				})
			end, { desc = "Show YAML surround help" })
			
			vim.api.nvim_create_user_command("SurroundTerraform", function()
				vim.notify("Use 'ys' followed by motion and 't' for Terraform interpolation", vim.log.levels.INFO, {
					title = "󰅪 Terraform Surround Help"
				})
			end, { desc = "Show Terraform surround help" })
			
			vim.api.nvim_create_user_command("SurroundDocker", function()
				vim.notify("Use 'ys' followed by motion and 'd' for Docker variables", vim.log.levels.INFO, {
					title = "󰅪 Docker Surround Help"
				})
			end, { desc = "Show Docker surround help" })
			
			vim.api.nvim_create_user_command("SurroundSecrets", function()
				vim.notify("Use 'ys' followed by motion and 's' for GitHub secrets", vim.log.levels.INFO, {
					title = "󰅪 Secrets Surround Help"
				})
			end, { desc = "Show secrets surround help" })
		end,
	},
}
