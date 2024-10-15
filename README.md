
# Steps to Set Up LazyVim with LuaSnip and LaTeX Snippets

### 1. Fresh Install of LazyVim and Clear Cache
- Follow the LazyVim installation guide: https://www.lazyvim.org/installation
- Clear the cache by running the following commands:

```bash
rm -rf ~/.local/share/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.cache/nvim
rm -rf ~/.config/nvim
```

### 2. Update and Install LazyVim Defaults
- Installation link for LazyVim - https://www.lazyvim.org/installation
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