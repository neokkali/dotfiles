-- 1. إعداد Mason لإدارة وتثبيت الخوادم تلقائياً في الخلفية
require("mason").setup({
  ui = {
    icons = {
      package_installed = "✓",
      package_pending = "➜",
      package_uninstalled = "✗"
    }
  }
})

-- تحديد خوادم اللغات المطلوبة
local servers = {
  pyright = {},       -- Python
  ts_ls = {},         -- TypeScript / JavaScript
  prismals = {},      -- Prisma ORM
}

require("mason-lspconfig").setup({
  ensure_installed = vim.tbl_keys(servers),
  automatic_installation = true,
})

-- 2. إعداد مفاتيح التحكم واختصارات الـ LSP عند تفعيله داخل الملف
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf }
    
    -- اختصارات الـ IDE الذكية
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)          -- Go to definition
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)                -- Show documentation
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)  -- Code Actions (Fixes)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)       -- Rename variable
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)          -- Show references
    vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- Show error details
  end,
})

-- 3. الطريقة الحديثة (Neovim 0.11+) لإعداد الخوادم باستخدام vim.lsp.config
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- تفعيل الخوادم من خلال النظام المدمج بدلاً من require("lspconfig")
for server, config in pairs(servers) do
  config.capabilities = capabilities
  -- الأسلوب الجديد للتشغيل المدمج
  vim.lsp.config(server, config)
end

-- 4. إعداد محرك الإكمال التلقائي nvim-cmp (يبقى كما هو)
local cmp = require("cmp")
local luasnip = require("luasnip")

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = "nvim-lsp" },
    { name = "luasnip" },
  }, {
    { name = "buffer" },
    { name = "path" },
  }),
})
