{ pkgs, ...}:{
	programs.nixvim = {
		enable = true;
		globals.mapleader = ";";
		extraConfigLua = ''
			vim.diagnostic.config( { virtual_text = false} )
		'';
		keymaps = [
			{
				action = "<cmd>Neotree toggle<CR>";
				key = "<leader>e";
			}
			{
				action = "<cmd>ToggleTerm<CR>";
				key = "<C-\\>";
			}
		];
		opts = {
			nu = true;
			autochdir = true;
			# hlsearch = false;
			mouse = "a";
			path = "./**,path";
			signcolumn = "yes";
			ignorecase = true;
			smartcase = true;
			tabstop = 4;
			shiftwidth = 4;
			softtabstop = -1;
			smarttab = true;
			undofile = true;
			clipboard = "unnamedplus";
			gdefault = true;
			scrolloff = 5;
		};
		colorschemes.catppuccin = {
			enable = true;
			settings = {
				no_bold = false;
				no_italic = false;
				no_underline = false;
				transparent_background = true;
				integrations = {
					cmp = true;
					noice = true;
					notify = true;
					neotree = true;
					harpoon = true;
					gitsigns = true;
					which_key = true;
					illuminate.enabled = true;
					treesitter = true;
					treesitter_context = true;
					telescope.enabled = true;
					indent_blankline.enabled = true;
					mini.enabled = true;
					native_lsp = {
						enabled = true;
						inlay_hints = {
							background = true;
						};
						underlines = {
							errors = ["underline"];
							hints = ["underline"];
							information = ["underline"];
							warnings = ["underline"];
						};
					};
				};
			};
		};
		plugins = {
			indent-blankline.enable = true;
			treesitter.enable = true;
			ts-autotag.enable = true;
			lualine.enable = true;
			# bufferline.enable = true;
			gitsigns = {
				enable = true;
				# settings.current_line_blame = true;
			};
			toggleterm = {
				enable = true;
				settings = {
					hide_numbers = false;
					autochdir = true;
					# close_on_exit = true;
					# direction = "vertical";
				};
			};
			neo-tree = {
				enable = true;
				enableDiagnostics = true;
				enableGitStatus = true;
				enableModifiedMarkers = true;
				enableRefreshOnWrite = true;
				closeIfLastWindow = true;
				popupBorderStyle = "rounded"; # Type: null or one of “NC”, “double”, “none”, “rounded”, “shadow”, “single”, “solid” or raw lua code
				buffers = {
					bindToCwd = false;
					followCurrentFile = { enabled = true; };
				};
				window = {
					width = 40;
					height = 15;
					autoExpandWidth = false;
					mappings = { "<space>" = "none"; };
				};
			};
			none-ls = {
				enable = true;
				settings = {
					cmd = ["bash -c nvim"];
					debug = true;
				};
				sources = {
					code_actions = {
						statix.enable = true;
						gitsigns.enable = true;
					};
					# diagnostics = {
					# 	statix.enable = true;
					# 	deadnix.enable = true;
					# 	pylint.enable = true;
					# 	checkstyle.enable = true;
					# };
					formatting = {
						alejandra.enable = true;
						stylua.enable = true;
						shfmt.enable = true;
						nixpkgs_fmt.enable = true;
						google_java_format.enable = false;
						prettier = {
							enable = true;
							disableTsServerFormatter = true;
						};
						black = {
							enable = true;
							settings = ''
							{
								extra_args = { "--fast" },
							}
							'';
						};
					};
					completion = {
						luasnip.enable = true;
						spell.enable = true;
					};
				};
			};
			lsp = {
				enable = true;
				servers = {
					pyright.enable = true;
					rust-analyzer = {
						enable = true;
						installRustc = true;
						installCargo = true;
					};
					lua-ls = {
						enable = true;
						settings.telemetry.enable = false;
					};
					nil-ls.enable = true;
					bashls.enable = true;
				};
				keymaps = {
					silent = true;
					lspBuf = {
						gd = {
							action = "definition";
							desc = "Goto Definition";
						};
						gr = {
							action = "references";
							desc = "Goto References";
						};
						gD = {
							action = "declaration";
							desc = "Goto Declaration";
						};
						gI = {
							action = "implementation";
							desc = "Goto Implementation";
						};
						gT = {
							action = "type_definition";
							desc = "Type Definition";
						};
						K = {
							action = "hover";
							desc = "Hover";
						};
						"<leader>cw" = {
							action = "workspace_symbol";
							desc = "Workspace Symbol";
						};
						"<leader>cr" = {
							action = "rename";
							desc = "Rename";
						};
					};
					diagnostic = {
						"<leader>cd" = {
							action = "open_float";
							desc = "Line Diagnostics";
						};
						"[d" = {
							action = "goto_next";
							desc = "Next Diagnostic";
						};
						"]d" = {
							action = "goto_prev";
							desc = "Previous Diagnostic";
						};
					};
				};
			};
			cmp = {
				enable = true;
				settings = {
					autoEnableSources = true;
					# experimental = { ghost_text = true; };
					performance = {
						debounce = 60;
						fetchingTimeout = 200;
						maxViewEntries = 30;
					};
					snippet = { expand = "luasnip"; };
					formatting = { fields = [ "kind" "abbr" "menu" ]; };
					sources = [
						{ name = "nvim_lsp"; }
						{ name = "emoji"; }
						{
							name = "buffer"; # text within current buffer
							option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
							keywordLength = 3;
						}
						{
							name = "path"; # file system paths
							keywordLength = 3;
						}
						{
							name = "luasnip"; # snippets
							keywordLength = 3;
						}
					];

					window = {
						completion = { border = "solid"; };
						documentation = { border = "solid"; };
					};

					mapping = {
						"<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
						"<C-j>" = "cmp.mapping.select_next_item()";
						"<C-k>" = "cmp.mapping.select_prev_item()";
						"<C-e>" = "cmp.mapping.abort()";
						"<C-b>" = "cmp.mapping.scroll_docs(-4)";
						"<C-f>" = "cmp.mapping.scroll_docs(4)";
						"<C-Space>" = "cmp.mapping.complete()";
						"<CR>" = "cmp.mapping.confirm({ select = true })";
						"<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
					};
				};
			};
			cmp-nvim-lsp.enable = true; 
			cmp-buffer.enable = true; 
			cmp-path.enable = true; 
			cmp_luasnip.enable = true; 
			cmp-cmdline.enable = true;

			lspkind = {
				enable = true;
				symbolMap = {
					Copilot = "";
				};
				extraOptions = {
					maxwidth = 50;
					ellipsis_char = "...";
				};
			};
		};
	};
}
