
--  TEST  lua-filter for Xwriter
--	Go to Menu,Preferences: add ' set PandocOptions "--lua-filter=test.lua" '


--  Test1 : Transform strong emphasis in strikeout  ( Uncomment to enable )
--function Strong(elem)
--  return pandoc.Strikeout(elem.c)
--end


--  Test2 : Subsitute {{helloworld}} with Hellow, world ( Uncomment to enable )
--function expand_hello_world(inline)
--	if inline.c == '{{helloworld}}' then
--   	return pandoc.Strong{ pandoc.Str "Hello, World" }
--	else
--		return inline
--	end
--end
--return {{Str = expand_hello_world}}
