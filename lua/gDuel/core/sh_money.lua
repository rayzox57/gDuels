gDuel.Money = gDuel.Money or {}
gDuel.MoneyCache = {}

gDuel.Money.sys = function()
    if istable(gDuel.MoneyCache) then return gDuel.MoneyCache, gDuel.MoneyCache["name"] or "Free" end
    local sys = gDuel.Money[gDuel.Config.MoneySystem]
    local installed = istable(sys) and (isfunction(sys["check"]) and sys["check"]() or true) or false
    gDuel.MoneyCache = installed and sys or gDuel.Money["Free"]
    return gDuel.MoneyCache, gDuel.MoneyCache["name"] or "Free"
end


gDuel.Money.get = function(ply)
    local sys = gDuel.Money["sys"]()
    if SERVER and isfunction(sys["get"]) then return sys["get"](ply)
    elseif CLIENT and isfunction(sys["get_cl"]) then return sys["get_cl"](ply)
    else return 0 end
end

gDuel.Money.afford = function(ply,money)
    local sys = gDuel.Money["sys"]()
    if SERVER and isfunction(sys["afford"]) then return sys["afford"](ply,money)
    elseif CLIENT and isfunction(sys["afford_cl"]) then return sys["afford_cl"](ply,money)
    else return true end
end

gDuel.Money.take = function(ply,money)
    if SERVER then
        local sys = gDuel.Money["sys"]()
        if isfunction(sys["take"]) then sys["take"](ply,money) end
    end
end

gDuel.Money.give = function(ply,money)
    if SERVER then
        local sys = gDuel.Money["sys"]()
        if isfunction(sys["give"]) then sys["give"](ply,money) end
    end
end

gDuel.Money.display = function(money)
    local sys = gDuel.Money["sys"]()
    if isfunction(sys["display"]) then return sys["display"](money) end
    return money
end

gDuel.Money["DRP"] = {
    ["check"] = function()
        return !table.IsEmpty(DarkRP)
    end,
    ["get"] = function(ply)
        return ply:getDarkRPVar("wallet")
    end,
    ["afford"] = function(ply,money)
        return ply:canAfford(money)
    end,
    ["take"] = function(ply,money)
        ply:addMoney(-money)
    end,
    ["give"] = function(ply,money)
        ply:addMoney(money)
    end,
    ["display"] = function(money)
        return DarkRP.formatMoney(money)
    end,
    ["name"] = "DarkRP"
}

gDuel.Money["PS1"] = {
    ["get"] = function(ply)
        return ply:PS_GetPoints()
    end,
    ["afford"] = function(ply,money)
        return ply:PS_HasPoints(amount)
    end,
    ["take"] = function(ply,money)
        ply:PS_GivePoints(-money)
    end,
    ["give"] = function(ply,money)
        ply:PS_GivePoints(money)
    end,
    ["display"] = function(money)
        return string.Comma(money) .. " points"
    end,
    ["name"] = "PointShop 1"
}

gDuel.Money["PS2"] = {
    ["get"] = function(ply)
        return ply.PS2_Wallet.points
    end,
    ["afford"] = function(ply,money)
        return ply.PS2_Wallet.points >= money
    end,
    ["take"] = function(ply,money)
        ply:PS2_AddStandardPoints(-money)
    end,
    ["give"] = function(ply,money)
        ply:PS2_AddStandardPoints(money)
    end,
    ["display"] = function(money)
        return string.Comma(money) .. " points"
    end,
    ["name"] = "PointShop 2"
}

gDuel.Money["PPS2"] = {
    ["get"] = function(ply)
        return ply.PS2_Wallet.premiumPoints
    end,
    ["afford"] = function(ply,money)
        return ply.PS2_Wallet.premiumPoints >= amount
    end,
    ["take"] = function(ply,money)
        ply:PS2_AddPremiumPoints(-money)
    end,
    ["give"] = function(ply,money)
        ply:PS2_AddPremiumPoints(money)
    end,
    ["display"] = function(money)
        return string.Comma(money) .. " premium points"
    end,
    ["name"] = "PointShop 2 Premium"
}

gDuel.Money["SHPS"] = {
    ["get"] = function(ply)
        return ply:SH_GetStandardPoints()
    end,
    ["afford"] = function(ply,money)
        return ply:SH_GetStandardPoints() >= amount
    end,
    ["take"] = function(ply,money)
        ply:SH_AddStandardPoints(-money)
    end,
    ["give"] = function(ply,money)
        ply:SH_AddStandardPoints(money)
    end,
    ["display"] = function(money)
        return string.Comma(money) .. " points"
    end,
    ["name"] = "SH Pointshop"
}

gDuel.Money["ZPN"] = {
    ["check"] = function()
        return IsTable(zpn)
    end,
    ["get_cl"] = function(ply)
        return ( ply:GetNWInt("zpn_CandyPoints") or 0 ) >= amount
    end,
    ["get"] = function(ply)
        return zpn.Candy.HasPoints(ply,amount)
    end,
    ["afford_cl"] = function(ply,money)
        return ( ply:GetNWInt("zpn_CandyPoints") or 0 ) >= amount
    end,
    ["afford"] = function(ply,money)
        return zpn.Candy.HasPoints(ply,amount)
    end,
    ["take"] = function(ply,money)
        zpn.Candy.TakePoints(ply,money)
    end,
    ["give"] = function(ply,money)
        zpn.Candy.AddPoints(ply,money)
    end,
    ["display"] = function(money)
        return string.Comma(money) .. " Bonbons"
    end,
    ["name"] = "Zero Pumpkin Night Candy"
}

gDuel.Money["Free"] = {
    ["get"] = function(ply)
        return 0
    end,
    ["afford"] = function(ply,money)
        return true
    end,
    ["take"] = function(ply,money)
    end,
    ["give"] = function(ply,money)
    end,
    ["display"] = function(money)
        return "--"
    end
}