
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

### 4. Add LuaSnip Example Snippets
- Paste the following LuaSnip example snippets into your `init.lua` file:
  - https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua

*(Note: You can organize your snippets into separate folders, but for quick testing, you can directly add them this way to verify they work.)*

### 5. Install LaTeX Snippets Plugin
- Install the LaTeX snippets plugin by adding the following code in the `lua/plugins/latexsnips.lua` file:

```lua
return {
    "evesdropper/luasnip-latex-snippets.nvim",
}
```

- After this, when you load a `.tex` file, you will have all the LaTeX snippets available.

### 6. Configure LuaSnip and Key Mappings in init.lua
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


### 9. Install Zathura, latexmk & pdflatex

````bash
sudo apt install 
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