require('plugins')
require('lsp')
-- opts
-- 
local cmd = vim.cmd
local nvim = require 'nvim'

local scopes = {o = vim.o, b = vim.bo, w = vim.wo}

local function opt(scope, key, value)
    scopes[scope][key] = value
    if scope ~= 'o' then scopes['o'][key] = value end
end
-- cmd 
cmd 'syntax enable'
cmd 'filetype plugin indent on'
opt('b', 'smartindent', true)
opt('b', 'shiftwidth', 4)
opt('b', 'tabstop', 4)
opt('b', 'expandtab', true)
opt('o', 'ignorecase', true)
opt('o', 'smartcase', true)
opt('o', 'splitbelow', true)
opt('o', 'splitright', true)
opt('o', 'termguicolors', true)
opt('o', 'showmode', false)
opt('o', 'showmatch', true)
opt('o', 'mouse', 'a')
opt('o', 'ruler', true)
opt('o', 'laststatus', 2)
opt('o', 'showtabline', 2)
opt('o', 'startofline', false)
opt('o', 'hidden', true)
opt('o', 'backup', false)
opt('o', 'writebackup', false)
opt('o', 'cmdheight', 1)
opt('o', 'updatetime', 300)
--opt('o', 'completeopt', "menuone,noinsert,noselect")
opt('o', 'shortmess', "c")
opt('w', 'number', true)
opt('w', 'relativenumber', true)
opt('w', 'wrap', true)
opt('w', 'cursorline', false)
opt('w', 'signcolumn', 'number')

--format lua on save 


cmd [[autocmd FileType lua nnoremap <buffer> <c-p> :call LuaFormat()<cr>]]
cmd [[autocmd BufWrite *.lua call LuaFormat()]]

--cmd [[autocmd BufEnter * lua require'completion'.on_attach()]]

cmd [[autocmd CursorHold,CursorHoldI * lua require'nvim-lightbulb'.update_lightbulb()]]

-- treesitter -- 
--
require'nvim-treesitter.configs'.setup {
    ensure_installed = {
        "javascript", "bash", "html", "java", "c", "cpp", "ruby", "bash", "rust", "lua"
    },
    highlight = {enable = true, use_languagetree = true}
}

-- telescope --

require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        prompt_position = "bottom",
        prompt_prefix = " ",
        selection_caret = " ",
        entry_prefix = "  ",
        initial_mode = "insert",
        selection_strategy = "reset",
        sorting_strategy = "descending",
        layout_strategy = "horizontal",
        layout_defaults = {
            horizontal = {
                mirror = false,
                preview_width = 0.5
            },
            vertical = {
                mirror = false
            }
        },
        file_sorter = require "telescope.sorters".get_fuzzy_file,
        file_ignore_patterns = {},
        generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
        shorten_path = true,
        winblend = 0,
        width = 0.75,
        preview_cutoff = 120,
        results_height = 1,
        results_width = 0.8,
        border = {},
        borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
        color_devicons = true,
        use_less = true,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        file_previewer = require "telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
    },
    extensions = {
        media_files = {
            filetypes = {"png", "webp", "jpg", "jpeg"},
            find_cmd = "rg" -- find command (defaults to `fd`)
        }
    }
}

require("telescope").load_extension("media_files")

local opt = {noremap = true, silent = true}

vim.g.mapleader = " "

-- mappings
vim.api.nvim_set_keymap("n", "<Leader>ff", [[<Cmd>lua require('telescope.builtin').find_files()<CR>]], opt)
vim.api.nvim_set_keymap(
    "n",
    "<Leader>fp",
    [[<Cmd>lua require('telescope').extensions.media_files.media_files()<CR>]],
    opt
)

vim.api.nvim_set_keymap("n", "<Leader>fb", [[<Cmd>lua require('telescope.builtin').buffers()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fh", [[<Cmd>lua require('telescope.builtin').help_tags()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fo", [[<Cmd>lua require('telescope.builtin').oldfiles()<CR>]], opt)
vim.api.nvim_set_keymap("n", "<Leader>fm", [[<Cmd> Neoformat<CR>]], opt)

cmd "hi TelescopeBorder   guifg=#2a2e36"
cmd "hi TelescopePromptBorder   guifg=#2a2e36"
cmd "hi TelescopeResultsBorder  guifg=#2a2e36"
cmd "hi TelescopePreviewBorder  guifg=#525865"


    
-- nvim_lsp object
local nvim_lsp = require'lspconfig'

-- function to attach completion when setting up lsp
--local on_attach = function(client)
--    require'completion'.on_attach(client)
--end

-- Enable rust_analyzer
nvim_lsp.rust_analyzer.setup({ on_attach=on_attach })

-- Enable diagnostics
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)
-- nvimtree ---


local g = vim.g

cmd [[packadd nvim-tree.lua]]

vim.o.termguicolors = true



g.nvim_tree_side = "left"
g.nvim_tree_width = 25
g.nvim_tree_ignore = {".git", "node_modules", ".cache"}
g.nvim_tree_auto_open = 1
g.nvim_tree_auto_close = 0
g.nvim_tree_quit_on_open = 0
g.nvim_tree_follow = 1
g.nvim_tree_indent_markers = 1
g.nvim_tree_hide_dotfiles = 0
g.nvim_tree_git_hl = 1
g.nvim_tree_root_folder_modifier = ":~"
g.nvim_tree_tab_open = 1
g.nvim_tree_allow_resize = 1

g.nvim_tree_show_icons = {
    git = 1,
    folders = 1,
    files = 1
}

g.nvim_tree_icons = {
    default = " ",
    symlink = " ",
    git = {
        unstaged = "✗",
        staged = "✓",
        unmerged = "",
        renamed = "➜",
        untracked = "★"
    },
    folder = {
        default = "",
        open = "",
        symlink = ""
    }
}

local get_lua_cb = function(cb_name)
    return string.format(":lua require'nvim-tree'.on_keypress('%s')<CR>", cb_name)
end

-- Mappings for nvimtree

vim.api.nvim_set_keymap(
    "n",
    "<C-n>",
    ":NvimTreeToggle<CR>",
    {
        noremap = true,
        silent = true
    }
)

g.nvim_tree_bindings = {
    ["<CR>"] = get_lua_cb("edit"),
    ["o"] = get_lua_cb("edit"),
    ["<2-LeftMouse>"] = get_lua_cb("edit"),
    ["<2-RightMouse>"] = get_lua_cb("cd"),
    ["<C-c>"] = get_lua_cb("cd"),
    ["<C-v>"] = get_lua_cb("vsplit"),
    ["<C-x>"] = get_lua_cb("split"),
    ["<C-t>"] = get_lua_cb("tabnew"),
    ["<BS>"] = get_lua_cb("close_node"),
    ["<S-CR>"] = get_lua_cb("close_node"),
    ["<Tab>"] = get_lua_cb("preview"),
    ["I"] = get_lua_cb("toggle_ignored"),
    ["H"] = get_lua_cb("toggle_dotfiles"),
    ["R"] = get_lua_cb("refresh"),
    ["a"] = get_lua_cb("create"),
    ["d"] = get_lua_cb("remove"),
    ["r"] = get_lua_cb("rename"),
    ["<C-r>"] = get_lua_cb("full_rename"),
    ["x"] = get_lua_cb("cut"),
    ["c"] = get_lua_cb("copy"),
    ["p"] = get_lua_cb("paste"),
    ["[c"] = get_lua_cb("prev_git_item"),
    ["]c"] = get_lua_cb("next_git_item"),
    ["-"] = get_lua_cb("dir_up"),
    ["q"] = get_lua_cb("close")
}



cmd "hi NvimTreeFolderIcon guifg = #61afef"
cmd "hi NvimTreeFolderName guifg = #61afef"
cmd "hi NvimTreeIndentMarker guifg = #383c44"


-- nvim-colorize --
--
--
--
-- Attaches to every FileType mode
require 'colorizer'.setup()

-- Attach to certain Filetypes, add special configuration for `html`
-- Use `background` for everything else.
require 'colorizer'.setup {
  'css';
  'javascript';
  html = {
    mode = 'foreground';
  }
}

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup({
  'css';
  'javascript';
  html = { mode = 'background' };
}, { mode = 'foreground' })

-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode. This is the inverse of the previous
-- setup configuration.
require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  css = { rgb_fn = true; }; -- Enable parsing rgb(...) functions in css.
  html = { names = false; } -- Disable parsing "names" like Blue or Gray
}

-- Exclude some filetypes from highlighting by using `!`
require 'colorizer'.setup {
  '*'; -- Highlight all files, but customize some others.
  '!vim'; -- Exclude vim from highlighting.
  -- Exclusion Only makes sense if '*' is specified!
}

