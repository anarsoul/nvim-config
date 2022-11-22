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
  use { "nvim-tree/nvim-web-devicons", commit = "3b1b794" }
  use { "nvim-tree/nvim-tree.lua", commit = "68a2a09" }
  use { "akinsho/bufferline.nvim", tag = "v3.*", requires = 'nvim-tree/nvim-web-devicons' } -- Nice buffer line on top
  use { "moll/vim-bbye", commit = "25ef93a" } -- Provides Bdelete command
  use { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb" } -- Provides indent lines
  use { "nvim-lualine/lualine.nvim", commit = "3325d5d" }

  -- Colorschemes
  use { "folke/tokyonight.nvim", commit = "62b4e89" }
  use { "lunarvim/darkplus.nvim", commit = "d308e95" }

  -- cmp plugins
  --use { "hrsh7th/nvim-cmp", commit = "df6734aa018d6feb4d76ba6bda94b1aeac2b378a" } -- The completion plugin
  --use { "hrsh7th/cmp-buffer", commit = "62fc67a2b0205136bc3e312664624ba2ab4a9323" } -- buffer completions
  --use { "hrsh7th/cmp-path", commit = "466b6b8270f7ba89abd59f402c73f63c7331ff6e" } -- path completions
  --use { "saadparwaiz1/cmp_luasnip", commit = "a9de941bcbda508d0a45d28ae366bb3f08db2e36" } -- snippet completions
  --use { "hrsh7th/cmp-nvim-lsp", commit = "affe808a5c56b71630f17aa7c38e15c59fd648a8" }
  --use { "hrsh7th/cmp-nvim-lua", commit = "d276254e7198ab7d00f117e88e223b4bd8c02d21" }

  ---- LSP
  --use { "neovim/nvim-lspconfig", commit = "148c99bd09b44cf3605151a06869f6b4d4c24455" } -- enable LSP
  --use { "williamboman/nvim-lsp-installer", commit = "e9f13d7acaa60aff91c58b923002228668c8c9e6" } -- simple to use language server installer
  --use { "jose-elias-alvarez/null-ls.nvim", commit = "ff40739e5be6581899b43385997e39eecdbf9465" } -- for formatters and linters
  --use { "RRethy/vim-illuminate", commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5" }
  --use { "simrat39/rust-tools.nvim", commit = "11dcd674781ba68a951ab4c7b740553cae8fe671"}

  ---- Telescope
  --use { "nvim-telescope/telescope.nvim", commit = "d96eaa914aab6cfc4adccb34af421bdd496468b0" }

  ---- Treesitter
  use { "nvim-treesitter/nvim-treesitter", commit = "4f07518" } -- Advanced syntax highlighting

  use { "Darazaki/indent-o-matic", commit = "749b7cb" } -- Detect indent style (tabs/spaces/3/4/8) automatically

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
