--[[
	Script: gDuel-System
	Version: 0.2
	Created by DidVaitel
]]
gDuel.vgui = gDuel.vgui or {}
local function gDuelMenu()
	local w, h = ScrW() * .7, ScrH() * .7

	local selectedPlayer = nil
	local selectedDuel = 1
	local curWager = 0
	local Leaders = net.ReadTable()

	// Our main frame
	local bg = vgui.Create('DFrame')
	bg:MakePopup()
	bg:SetSize(w, h)
	bg:Center()
	bg:SetDraggable( false )
	bg:ShowCloseButton(false)
	bg:SetTitle("")
	bg.Paint = function(self, W, H)
	    gDuel.vgui.DrawBlur( self, 8 )
	    gDuel.vgui.DrawBox(0.5, 0, W , 50, Color(0, 0, 0, 170))
	    gDuel.vgui.DrawBox(0, 0, W , H, Color(0, 0, 0, 180))
	    gDuel.vgui.DrawBox(20, 70, W-40 , H-89, Color(0, 0, 0, 150))
	    gDuel.vgui.DrawOutlinedBox( 0, 0, W, H )
	    gDuel.vgui.DrawOutlinedBox( 20, 70, W-40, H-89 )
	    gDuel.vgui.DrawOutlinedBox( 0, 0, W, 50 )

	end
	local MainDop = vgui.Create( "DPanel",  bg)
	MainDop:SetPos( 20, 70 )
	MainDop:SetSize(bg:GetWide()/2-40,bg:GetTall()-89)
	MainDop.Paint = function(self,w,h)
	end

	local MainAdditional = vgui.Create( "DPanel",  bg)
	MainAdditional:SetPos( MainDop:GetWide() + 20, 75 )
	MainAdditional:SetSize(MainDop:GetWide() + 35,bg:GetTall()-105)
	MainAdditional.Paint = function(self,w,h)
	    gDuel.vgui.DrawOutlinedBox( 0, 0, w, h-60 )

	end


	local function GuiButton(name, parent, x, y, w, h, doclick, btnclr, removeonclick)
	    local btn = parent:Add 'DButton'
	    btn:SetSize(w, h)
	    btn:SetPos(x, y)

	    btn:SetText(name)
	    btn:SetTextColor(Color(255,255,255,200))

	    btn.DoClick = function()
	          doclick(btn)

	          if removeonclick then
	                parent:Remove()
	          end
	    end
	    btn.Paint = function(self,w,h)
	          gDuel.vgui.DrawBox(0, 0, w , h, Color(167, 48, 48, 100))
	          gDuel.vgui.DrawOutlinedBox( 0, 0,w, h )          
	    end

	    return btn
	end

  	if !table.IsEmpty(DarkRP) then
      local wager = gDuel.vgui.txtentry(gDuel.Translate("EnterBetVgui")..""..gDuel.minBet .. "".. gDuel.Translate("EnterBetVgui2") .."".. gDuel.maxBet .. ')', MainAdditional, 0, MainAdditional:GetTall()-45, MainAdditional:GetWide(), 35, function(self)
            curWager = tonumber(self:GetValue())
      end)
   	end


      local plList = gDuel.vgui.scroll(MainDop, 5, 30, MainDop:GetWide() - 10, MainDop:GetTall() - 35) // Players slider

      local displayPlayers = function(id) // let's get players
            plList:Clear()

            local plys = {}

            if id and id ~= '' then
                  for _, pl in ipairs(player.GetAll()) do
                        if string.find(pl:Name():lower(), id, 1, true) then
                              table.insert(plys, pl)
                        end
                  end
            else
                  plys = player.GetAll()
            end

            local curY = 0

            for k,v in pairs(plys) do
                  if v == LocalPlayer() then continue end
                        local pnl = plList:Add 'DPanel'
                        pnl:SetSize(plList:GetWide(), 50)
                        pnl:SetPos(0, curY)

                        avatar = pnl:Add 'AvatarImage'
                        avatar:SetPos(7,5)
                        avatar:SetSize(40, 40)
                        avatar:SetPlayer(v)

                        function pnl:Paint(w, h)
                              if not IsValid(v) then return end

                              gDuel.vgui.DrawBox(0, 0, w, h, Color(20, 20, 20, 100))
                              gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )
                              gDuel.vgui.txt(gDuel.Translate("Name")..'' .. v:Name(), 15, 55, 0)
                              if !table.IsEmpty(DarkRP) then
                              	gDuel.vgui.txt(gDuel.Translate("Money")..'' .. DarkRP.formatMoney(v:getDarkRPVar 'money'), 15, 55, 12)
                              end
                        end

                        pnl.select = GuiButton(gDuel.Translate("SendChallenge"), pnl, 55, pnl:GetTall() - (17 + 5), pnl:GetWide() - 60, 17, function(self)
                             if self.clickable then 
                                    net.Start 'gDuel.SendRequest'
                                          net.WriteEntity(v)
                                          net.WriteInt(curWager, 32)
                                          net.WriteInt(selectedDuel, 16)
                                    net.SendToServer()
                                    surface.PlaySound( 'buttons/button15.wav' )
                              end
                        end)

                        function pnl.select:Think()
                        	if curWager == nil or not isnumber(curWager) then self.clickable = false self:SetText(gDuel.Translate("UnavailableWager")) return end
                        	
		                    if !table.IsEmpty(DarkRP) then
		                        if curWager > gDuel.maxBet or curWager < gDuel.minBet then
		                            self.clickable = false
		                            self:SetText(gDuel.Translate("UnavailableWager"))
		                            return
		                        end
		                    end

                            self.clickable = true
                            self:SetText(gDuel.Translate("SendChallenge"))
                        end

                        plList:AddItem(pnl)

                        curY = curY + pnl:GetTall() + 5
            end
      end
      displayPlayers()
      local plSearch = gDuel.vgui.txtentry(gDuel.Translate("SearchaPlayer"), MainDop, 5, 5, MainDop:GetWide() - 10, 20, function(self)
            displayPlayers(self:GetValue())
      end)

      // Duel types
      local chList = gDuel.vgui.scroll(MainAdditional, 5, 5, MainAdditional:GetWide() - 10, MainAdditional:GetTall() - 70)

      local curX = 0
      local curY = 0

      for _, data in ipairs(gDuel.Types) do
            local pnl = chList:Add 'DPanel'
            pnl:SetSize(chList:GetWide() / 2, 100)
            pnl:SetPos(curX, curY)

            function pnl:Paint(w, h)
                  gDuel.vgui.DrawBox(0, 0, w, h, Color(50, 50, 50, 100))
                  gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )
                  gDuel.vgui.txt(data.name, 20, w / 2, 3, nil, 1)
            end

            pnl.desc = pnl:Add 'DLabel'
            pnl.desc:SetSize(pnl:GetWide() - 10, pnl:GetTall() - 75)
            pnl.desc:SetPos(5, 25)
            pnl.desc:SetText(gDuel.Translate("Description") .."" .. data.desc)
            pnl.desc:SetAutoStretchVertical(true)
            pnl.desc:SetWrap(true)
            pnl.desc:SetFont 'gDuelFont14'
            pnl.desc:SetTextColor(color_white)

            pnl.select = GuiButton(gDuel.Translate("Select"), pnl, 5, pnl:GetTall() - 22, pnl:GetWide() - 10, 17, function(self)
                  selectedDuel = _
                  surface.PlaySound( 'buttons/button15.wav' )
            end)

            function pnl.select:Think()
                  if selectedDuel == _ then
                        self:SetText(gDuel.Translate("Selected"))
                  else
                        self:SetText(gDuel.Translate("Select"))
                  end
            end

            curX = curX + pnl:GetWide() + 5

            if curX > plList:GetWide() then
                  curX = 0
                  curY = curY + pnl:GetTall() + 5 
            end
      end
     // MainDop:Hide()

      //MainAdditional:Hide()

      local LeadersLead = vgui.Create( "DPanel",  bg)
      LeadersLead:SetPos( 20, 70 )
      LeadersLead:SetSize(bg:GetWide()-40,bg:GetTall()-89)
      LeadersLead.Paint = function(self,w,h)
            gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )

      end
      local zr = 0
      local plList2 = gDuel.vgui.scroll(LeadersLead, 5, 5, LeadersLead:GetWide() - 10, LeadersLead:GetTall() ) // Players slider
      local curYxx = 0
      table.SortByMember( Leaders, "Duelswin" )
      for k,v in pairs(Leaders) do
                        local pnl = plList2:Add 'DPanel'
                        pnl:SetSize(plList2:GetWide(), 50)
                        pnl:SetPos(0, curYxx)

                        avatar = pnl:Add 'AvatarImage'
                        avatar:SetPos(7,5)
                        avatar:SetSize(40, 40)
                        avatar:SetSteamID(util.SteamIDTo64(v.steamID),64 )

                        function pnl:Paint(w, h)

                              gDuel.vgui.DrawBox(0, 0, w, h, Color(20, 20, 20, 100))
                              gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )
                              gDuel.vgui.txt(gDuel.Translate("Name")..'' .. v.Name, 15, 55, 0)
                              gDuel.vgui.txt('Wins: ' .. v.Duelswin, 15, 55, 15)
                              gDuel.vgui.txt('Loses: ' .. v.Duelslose, 15, 55, 28)
                        end

                        plList2:AddItem(pnl)

                        curYxx = curYxx + pnl:GetTall() + 5
            zr=zr+1
            if zr > 12 then break end
      end

 
      LeadersLead:Hide()


      local MainButton = vgui.Create("DButton", bg)
      MainButton:SetPos(30, 10)
      MainButton:SetSize(100,30)
      MainButton:SetText("")
      MainButton.DoClick = function()
            surface.PlaySound( 'buttons/button15.wav' )
            LeadersLead:Hide()
            MainDop:Show()
            MainAdditional:Show()
      end
      MainButton.Paint = function(self,w,h)
            gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )
            gDuel.vgui.DrawBox(0, 0, w , h, Color(167, 48, 48, 100))
            draw.SimpleText( "Main", 'gDuelFont18', 34, 6, Color(255,255,255,200))
      end
      MainButton.OnCursorEntered = function()
            surface.PlaySound( 'UI/buttonrollover.wav' )
      end

      local LeadersButton = vgui.Create("DButton", bg)
      LeadersButton:SetPos(160, 10)
      LeadersButton:SetSize(100,30)
      LeadersButton:SetText("")
      LeadersButton.DoClick = function()
            surface.PlaySound( 'buttons/button15.wav' )
            MainDop:Hide()
            MainAdditional:Hide()
            LeadersLead:Show()
      end
      LeadersButton.Paint = function(self,w,h)
            gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )
            gDuel.vgui.DrawBox(0, 0, w , h, Color(167, 48, 48, 100))
            draw.SimpleText( "Leaderboard", 'gDuelFont18', 8, 6, Color(255,255,255,200))
      end
      LeadersButton.OnCursorEntered = function()
            surface.PlaySound( 'UI/buttonrollover.wav' )
      end

      local CloseButton = vgui.Create("DButton", bg)
      CloseButton:SetPos(bg:GetWide()-130, 10)
      CloseButton:SetSize(100,30)
      CloseButton:SetText("")
      CloseButton.DoClick = function()
            bg:SizeTo( 0, 0, 0.3)
            surface.PlaySound( 'buttons/button15.wav' )
            timer.Simple( 0.3, function()
                  bg:Remove()
            end )
      end
      CloseButton.Paint = function(self,w,h)
            gDuel.vgui.DrawOutlinedBox( 0, 0, w, h )
            gDuel.vgui.DrawBox(0, 0, w , h, Color(167, 48, 48, 100))
            draw.SimpleText( "Close", 'gDuelFont18', 34, 6, Color(255,255,255,200))
      end
      CloseButton.OnCursorEntered = function()
            surface.PlaySound( 'UI/buttonrollover.wav' )
      end
end
net.Receive("gDuel.Menu", gDuelMenu)

net.Receive('gDuel.SendRequest', function()
      local dpl = net.ReadEntity()
      local wager = net.ReadInt(32)
      local type = net.ReadInt(16)
      local id = net.ReadInt(16)


      if not gDuel.Types[type] then return end

      local removetime = CurTime() + 15

      local bg = vgui.Create('DFrame')
      //bg:MakePopup()
      bg:SetSize(520, 100)
      bg:SetPos(0, ScrH() - 100)
      bg:SetDraggable( false )
      bg:ShowCloseButton(false)
      bg:SetTitle("Duel - Challenge!")
      bg.Paint = function(self, W, H)
            gDuel.vgui.DrawBlur( self, 6 )
            gDuel.vgui.DrawBox(0.5, 0, W , 50, Color(0, 0, 0, 170))
            gDuel.vgui.DrawBox(20, 70, W-40 , H-89, Color(0, 0, 0, 150))
            gDuel.vgui.DrawOutlinedBox( 0, 0, W, H )
            gDuel.vgui.DrawOutlinedBox( 20, 70, W-40, H-89 )
            gDuel.vgui.DrawOutlinedBox( 0, 0, W, 50 )

      end

      bg.titlex = 520 / 2

      function bg:PaintOver(w, h)
            if not IsValid(dpl) then bg:Remove() return end
            if !table.IsEmpty(DarkRP) then
            	gDuel.vgui.txt(dpl:Name() .. ''.. gDuel.Translate("AcceptVgui") ..'' .. gDuel.Types[type].name .. ''.. gDuel.Translate("AcceptVgui2") ..'' .. DarkRP.formatMoney(wager) , 15, w / 2, 28, nil, 1)
            else
            	gDuel.vgui.txt(dpl:Name() .. ''.. gDuel.Translate("AcceptVgui") ..'' .. gDuel.Types[type].name , 15, w / 2, 28, nil, 1)
            end
      end

      function bg:Think()
            if removetime <= CurTime() then
                  net.Start 'gDuel.DeclineRequest'
                  net.WriteInt(id, 16)
                  net.SendToServer()    
                  self:Remove()
            end
      end

      local btns =
      {
            [1] =
            {
                  str = gDuel.Translate("AcceptVgui3"),
                  func = function()
                        surface.PlaySound( 'buttons/button15.wav' )
                        net.Start 'gDuel.AcceptRequest'
                        net.WriteInt(id, 16)
                        net.SendToServer()

                        bg:Remove()
                  end
            },
            [2] =
            {
                  str = gDuel.Translate("AcceptVgui4"),
                  func = function()
                        surface.PlaySound( 'buttons/button15.wav' )
                        net.Start 'gDuel.DeclineRequest'
                        net.WriteInt(id, 16)
                        net.SendToServer()
                        
                        bg:Remove()
                  end
            }
      }

      local h = (100 - 48) / 2
      local cury = 100 - (h * 2)

      for i = 1, 2 do
            local data = btns[i]
            if not data then continue end

            local btn = bg:Add 'DButton'
            btn:SetSize(520, h)
            btn:SetPos(0, cury)

            btn:SetText(data.str)
            btn:SetTextColor(color_white)
            btn.DoClick = data.func
            btn.Paint = function(self,w,h)
                  gDuel.vgui.DrawBox(0, 0, w , h, Color(167, 48, 48, 100))
                  gDuel.vgui.DrawOutlinedBox( 0, 0,w, h )          
            end
            cury = cury + h
      end
end)
