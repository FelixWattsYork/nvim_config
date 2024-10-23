
# Steps to Set Up LazyVim with LuaSnip and LaTeX Snippets

### 0. Install Dependencies
-install neovim
````bash
sudo snap install nvim --classic
````
-install LazyVim Dependencies:
git, lazygit,fd,ripgrep @ c compiler
````bash
sudo apt install git fd-find ripgrep build-essential
sudo snapt install lazygit
````
-install tree-sitter-cli
````bash
sudo snap install npm
npm install tree-sitter-cli
````
-instal nerd font (https://www.nerdfonts.com/) \
You can repace with Jet Brains font of your choice
````bash
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv
````

### 1. Fresh Install of LazyVim and Clear Cache
- Clear the cache by running the following commands:

```bash
rm -rf ~/.local/share/nvim \
&& rm -rf ~/.local/state/nvim \
&& rm -rf ~/.cache/nvim \
&& rm -rf ~/.config/nvim
```

### 2. Update and Install LazyVim Defaults
- Install LazyVim
- clone LazyVim Repo
````bash
git clone https://github.com/LazyVim/starter ~/.config/nvim
````
- Remove the git folder
````bash
rm -rf ~/.config/nvim/.git
````
- Remove the git folder
````bash
nvim
````
- After installing LazyVim, ensure that you have updated and installed all the defaults.
- Use the LazyVim extras (use the `x` option).

### 3. Install LuaSnip from the Extras Menu
- In the LazyVim extras menu, select and install LuaSnip. This ensures all dependencies are installed correctly.

### 4. Navigaet to .config/nvim
-Navigate to .config/nvim

### 5. Configure LuaSnip and Key Mappings in init.lua
- Add the following configuration at the start of your `init.lua` file to require LuaSnip and set up key mappings:

```lua
-- Require LuaSnip
local luasnip = require("luasnip")

-- Configure key mappings
vim.keymap.set({"i", "s"}, "<Tab>", function()
    if luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
    else
        return "<Tab>"
    end
end, {silent = true, expr = true})

vim.keymap.set({"i", "s"}, "<S-Tab>", function()
    if luasnip.jumpable(-1) then
        luasnip.jump(-1)
    else
        return "<S-Tab>"
    end
end, {silent = true, expr = true})
```

### 7. Setup nvim-cmp for LuaSnip Tab Expansion
- Add the following snippet under the previous set up `nvim-cmp` to use `<Tab>` for expanding LuaSnip snippets and `<S-Tab>` for jumping backward:

```lua
-- Setup nvim-cmp.
local cmp = require'cmp'
local luasnip = require'luasnip'

cmp.setup({
    mapping = {
        -- Use <Tab> to expand snippets
        ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()  -- fall back to normal tab functionality
            end
        end, { 'i', 's' }),

        -- Use <S-Tab> to jump backward in snippets
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),
    },
})
```

### 8. Important Notes
- This configuration allows you to use `<Tab>` as the expander for LuaSnip snippets. However, it does not provide partial snippet completion.
- For example, to expand a LaTeX matrix snippet, you must type the entire trigger (e.g., `mat`) and then press `<Tab>`. It will not complete with a partial trigger like `ma` followed by `<Tab>`.



### 8. Important Notes
- In nvim create LuaSnip/ folder with all.lua and tex/ folders
- Add code to load snippets from folder structure
````bash
-- Snippets Configuration
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip" } })
require("luasnip.loaders.from_lua").load({ paths = { "~/.config/nvim/LuaSnip/tex" } })
````

-Example snippet to add to all.lua
````bash
local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.add_snippets(nil, {
  all = {
    snip({
      trig = "date",
      name = "Date", -- Fixed typo here
      dscr = "Date in the form of YYYY-MM-DD",
    }, {
      text(os.date("%Y-%m-%d")),
    }),
  },
})

````
-You should now be able to type date and then press tab to expand it as a snippet. You can also check that a snippet is loaded by running the :LuaSnipListAvaliable Command in neovim


### 9. Install Zathura, latexmk & pdflatex
- install zathura (pdf viewer) and latexmk
````bash
sudo apt install zathura latexmk pdflatex
````
- Install pdflatex and extra fonts
````bash
sudo apt install texlive-latex-base \
&& sudo apt install texlive-fonts-recommended \
&& sudo apt install texlive-fonts-extra 
````


### 10. Install VimTex
- Create vimtex.lua file and add 
```lua
-- In ~/.config/nvim/lua/plugins/vimtex.lua
return {
  "lervag/vimtex",
  lazy = false, -- we don't want to lazy load VimTeX
  -- tag = "v2.15", -- uncomment to pin to a specific release
  init = function()
    -- VimTeX configuration goes here, e.g.
    vim.g.vimtex_view_method = "zathura"
  end,
}
```
- Important note, before install VimTex, LuaSnips will see .tex files as plaintex files. After installing VimTex it will see them as .tex files