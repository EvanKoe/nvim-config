return {
	{
		-- "neovim/nvim-lspconfig",
		"mason-org/mason-lspconfig.nvim",
		opts = {
			automatic_enable = {
				exclude = {
					'vue_ls'
				}
			},
			ensure_installed = {
				"vtsls@0.2.9"
			}
		},
		dependencies = {
			{
				"mason-org/mason.nvim",
				opts = {
					registries = {
						-- Pin the version to avoid breaking changes in updates
						'github:mason-org/mason-registry@2025-07-08-ritzy-fund'
					},
					ui = {
							icons = {
									package_installed = "✓",
									package_pending = "➜",
									package_uninstalled = "✗"
							}
					}
				}
			},
			"neovim/nvim-lspconfig"
		}
	}
}
