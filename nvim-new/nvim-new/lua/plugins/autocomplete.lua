-- local cmp = require("cmp")
-- local luasnip = require("luasnip")
--
-- -- تحميل السنيبتات من الـ vscode
-- require("luasnip.loaders.from_vscode").lazy_load()
--
-- cmp.setup({
-- 	completion = {
-- 		completeopt = "menu,menuone,preview,noselect",
-- 	},
-- 	snippet = {
-- 		expand = function(args)
-- 			luasnip.lsp_expand(args.body)
-- 		end,
-- 	},
-- 	mapping = cmp.mapping.preset.insert({
-- 		["<C-k>"] = cmp.mapping.select_prev_item(), -- السهم للأعلى
-- 		["<C-j>"] = cmp.mapping.select_next_item(), -- السهم للأسفل
-- 		["<C-b>"] = cmp.mapping.scroll_docs(-4),
-- 		["<C-f>"] = cmp.mapping.scroll_docs(4),
-- 		["<C-Space>"] = cmp.mapping.complete(), -- فتح القائمة يدوياً
-- 		["<C-e>"] = cmp.mapping.abort(), -- إغلاق القائمة
-- 		["<CR>"] = cmp.mapping.confirm({ select = false }), -- تأكيد الاختيار
-- 	}),
-- 	-- مصادر الاقتراحات
-- 	sources = cmp.config.sources({
-- 		{ name = "nvim_lsp" }, -- هذا هو الأهم لعمل LSP
-- 		{ name = "luasnip" }, -- السنيبتات
-- 		{ name = "buffer" }, -- النصوص الموجودة في الملف الحالي
-- 		{ name = "path" }, -- مسارات الملفات
-- 	}),
-- })
--
local cmp = require("cmp")
local luasnip = require("luasnip")

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
	completion = {
		-- 1. التعديل هنا: قمنا بإزالة noselect وإضافة noinsert لتظليل الخيار الأول تلقائياً
		completeopt = "menu,menuone,preview,noinsert",
		keyword_length = 1,
	},
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body)
		end,
	},
	mapping = cmp.mapping.preset.insert({
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),

		-- 2. التعديل الأهم هنا: تحويل select إلى true واختيار الـ Replace لضمان استبدال الكلمة بسلاسة
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
	}),

	["<Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_next_item()
		elseif luasnip.expand_or_jumpable() then
			luasnip.expand_or_jump()
		else
			fallback()
		end
	end, { "i", "s" }),

	-- 🔥 تفعيل زر Shift + Tab للرجوع للخيار السابق أو القفز العكسي داخل السنيبت
	["<S-Tab>"] = cmp.mapping(function(fallback)
		if cmp.visible() then
			cmp.select_prev_item()
		elseif luasnip.jumpable(-1) then
			luasnip.jump(-1)
		else
			fallback()
		end
	end, { "i", "s" }),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
	}),
})
