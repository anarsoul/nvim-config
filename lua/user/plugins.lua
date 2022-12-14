local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use { "wbthomason/packer.nvim", commit = "6afb674" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim", commit = "4b7e520" }
  use { "nvim-tree/nvim-web-devicons", commit = "3b1b794" }
  use { "nvim-tree/nvim-tree.lua", commit = "68a2a09" }
  use { "akinsho/bufferline.nvim", tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' } -- Nice buffer line on top
  use { "moll/vim-bbye", commit = "25ef93a" } -- Provides Bdelete command
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb" } -- Provides indent lines
  use { "nvim-lualine/lualine.nvim", commit = "3325d5d" }
  use { "Darazaki/indent-o-matic", commit = "749b7cb" } -- Detect indent style (tabs/spaces/3/4/8) automatically
  use { "lewis6991/impatient.nvim", commit = "d3dd30f" } -- Speeds up nvim startup
  use { "akinsho/toggleterm.nvim", commit = "3ba6838" } -- Terminal, try ctrl+\
  use { "folke/which-key.nvim", commit = "61553ae" }
  use { "windwp/nvim-autopairs", commit = "99f6963" }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "62b4e89" }
  use { "lunarvim/darkplus.nvim", commit = "d308e95" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp", commit = "93f385c" } -- The completion plugin
  use { "hrsh7th/cmp-buffer", commit = "3022dbc" } -- buffer completions
  use { "hrsh7th/cmp-path", commit = "91ff86c" } -- path completions
  -- use { "saadparwaiz1/cmp_luasnip", commit = "1809552" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp", comcmit = "5922477" }
  --use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  -- LSP
  use { "neovim/nvim-lspconfig", commit = "c720632" } -- enable LSP
  --use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  --use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters
  --use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }
  use { "simrat39/rust-tools.nvim", commit = "99fd123"}

  -- Telescope
  use { "nvim-telescope/telescope.nvim", commit = "7a4ffef" }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "4f07518" } -- Advanced syntax highlighting

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
