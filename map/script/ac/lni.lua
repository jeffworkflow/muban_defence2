local lni = require 'ac.lni-loader'
local storm = require 'jass.storm'

ac.lni = {}

lni:set_marco('TableSearcher', '$MapPath$table\\')
-- print('package.path:',package.path)
for _, path in ipairs(ac.split(package.path, ';')) do
	if _>1 then 
		-- print('测试本地脚本,',path:gsub('%?%.lua', 'table\\.iniconfig'))
		local buf = storm.load(path:gsub('%?%.lua', 'table\\.iniconfig'))
		if buf then
			-- print('storm.load,',path:gsub('%?%.lua', ''))
			lni:set_marco('MapPath', path:gsub('%?%.lua', ''))
			break
		end
	end
end

function ac.lni_loader(name)
	ac.lni[name] = lni:packager(name, storm.load)
end