--[[
	Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]

gDuel.vgui = gDuel.vgui or {}

surface.CreateFont( 'gDuelFont100', {
	font = 'Roboto',
	size = 100,
	weight = 500
} )

surface.CreateFont( 'gDuelFont20', {
	font = 'Roboto',
	size = 20,
	weight = 500
} )

surface.CreateFont( 'gDuelFont18', {
	font = 'Roboto',
	size = 18,
	weight = 500
} )

surface.CreateFont( 'gDuelFont15', {
	font = 'Roboto',
	size = 15,
	weight = 500
} )

surface.CreateFont( 'gDuelFont14', {
	font = 'Roboto',
	size = 14,
	weight = 500
} )

// Our functions
local blur = Material 'pp/blurscreen'
local Linecolor = Color(255, 255, 255, 100)
// Blur
function gDuel.vgui.DrawBlur( pan, amt )

	local x, y = pan:LocalToScreen( 0, 0 )

	surface.SetDrawColor( 255, 255, 255 )
	surface.SetMaterial( blur )

	for i = 1, 3 do

		blur:SetFloat( '$blur', ( i / 3 ) * ( amt or 6 ) )
		blur:Recompute()

		render.UpdateScreenEffectTexture()
		surface.DrawTexturedRect( x * -1, y * -1, ScrW(), ScrH() )

	end

end
// Line
function gDuel.vgui.DrawLine( x1, y1, x2, y2, clr )

	if not clr then clr = Color( 255, 255, 255 ) end

	surface.SetDrawColor( clr )
	surface.DrawLine( x1, y1, x2, y2 )

end
// Box
function gDuel.vgui.DrawBox( x, y, w, h, clr, out )

	if not clr then clr = Color( 15, 15, 15, 200 ) end

	surface.SetDrawColor( clr )
	surface.DrawRect( x, y, w, h )

	if out then
		gDuel.vgui.DrawOutlinedBox(x, y, w, h, Color(0, 0, 0, 0))
	end

end
// DrawOutlinedBox
function gDuel.vgui.DrawOutlinedBox( x, y, w, h, clr )

	if not clr then clr = Color( 15, 15, 15, 200 ) end

	//gDuel.vgui.DrawBox( x, y, w, h, clr )

	surface.SetDrawColor(Linecolor)
	surface.DrawOutlinedRect(x, y, w, h)
end

function gDuel.vgui.txt( str, size, x, y, clr, a1, a2 )

	if not a1 then a1 = 0 end
	if not a2 then a2 = 0 end
	if not clr or clr == nil then clr = Color( 255, 255, 255 ) end

	draw.SimpleText( str, 'gDuelFont' .. size, x, y, clr, a1, a2 )

end


function gDuel.vgui.scroll(parent, x, y, w, h, down, ph, items)
	local scroll = parent:Add 'DScrollPanel'
	scroll:SetSize(w, h)
	scroll:SetPos(x, y)
	scroll:GetVBar():SetWide(0)

	if items then items(scroll) end

	return scroll
end

// txt entery
PANEL = {}

function PANEL:Init()
	self:SetFont( 'DermaDefault' )
end

function PANEL:Paint( w, h )
	gDuel.vgui.DrawOutlinedBox(0, 0, w, h)
	self:DrawTextEntryText(Color(255,255,255,255), Color( 150, 150, 150, 150 ), Color(255,255,255,255) )
end

vgui.Register('gTxtEntry', PANEL, 'DTextEntry')


function gDuel.vgui.txtentry(name, parent, x, y, w, h, onchange, secval)
	local idText = parent:Add 'gTxtEntry'
	idText:SetSize(w, h)
	idText:SetPos(x, y)
	idText:SetText(name)
	idText:SetFont 'gDuelFont18'

	function idText:OnChange()
		onchange(self, self:GetValue())
	end

	function idText:OnGetFocus()
		if self:GetValue() == name then
			self:SetValue ''
		end
	end

	return idText
end




