local bufferline = require("bufferline")

bufferline.setup({
	options = {
		mode = "tabs",
		separator_style = "thin",
		always_show_bufferline = true,
		show_close_icon = false,
		show_buffer_close_icons = true,
		-- 🌟 إضافة مسافة صغيرة داخل التاب لتبدو ممتلئة وأنيقة (Padding)
		tab_size = 20,
	},
	-- highlights = {
	-- 	-- 1. ✨ التاب الحالي النشط - بارز، ناصع، وواضح جداً للعين
	-- 	tab_selected = {
	-- 		fg = "#ffffff", -- 🌟 أبيض ناصع ومشع 100% لتوفير أعلى وضوح للقراءة
	-- 		bg = "#1e1e2e", -- رمادي داكن مزرق مريح جداً كمساحة عمل
	-- 		bold = true,
	-- 	},
	-- 	buffer_selected = {
	-- 		fg = "#ffffff", -- 🌟 يضمن بقاء اسم الملف الحالي مشعاً وبارزاً
	-- 		bg = "#1e1e2e",
	-- 		bold = true,
	-- 	},
	-- 	close_button_selected = {
	-- 		fg = "#f38ba8", -- علامة الإكس تظهر بوضوح خفيف في التاب النشط فقط
	-- 		bg = "#1e1e2e",
	-- 	},
	--
	-- 	-- 2. 💤 التابات الأخرى الخاملة - تم تغميقها لتعطي عمقاً وتبرز التاب النشط تلقائياً
	-- 	tab = {
	-- 		fg = "#585b70", -- رمادي متوسط خامل (لا يشتت العين)
	-- 		bg = "#0b0b11", -- 🌟 تم تعتيم الخلفية هنا لصنع تباين (Contrast) هائل مع النشط
	-- 	},
	-- 	buffer_visible = {
	-- 		fg = "#585b70",
	-- 		bg = "#0b0b11",
	-- 	},
	-- 	close_button = {
	-- 		fg = "#0b0b11", -- إخفاء تام لعلامة الإكس في الخلفية لمنع الازدحام البصري
	-- 		bg = "#0b0b11",
	-- 	},
	--
	-- 	-- 3. 🥢 الفواصل الهندسية (تحدد الأطراف بنعومة بالغة)
	-- 	separator_selected = {
	-- 		fg = "#0b0b11", -- فاصل التاب النشط
	-- 		bg = "#1e1e2e",
	-- 	},
	-- 	separator = {
	-- 		fg = "#1e1e2e", -- خط فاصل ناعم يفصل التابات الخاملة عن بعضها
	-- 		bg = "#0b0b11",
	-- 	},
	--
	-- 	-- 4. 💎 الـ Indicator (العلامة الفارقة والمؤشر البصري الصريح)
	-- 	indicator_selected = {
	-- 		fg = "#74c7ec", -- 🌟 أزرق سماوي مضيء (Sapphire Blue) يصرخ بنعومة "أنت تقف هنا!"
	-- 		bg = "#1e1e2e",
	-- 	},
	-- },
})
