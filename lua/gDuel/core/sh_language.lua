--[[
	Created by DidVaitel (http://steamcommunity.com/profiles/76561198108670811)
]]
--[[
	Script: gDuel-System
	Version: 0.2
	Created by DidVaitel
]]

gDuel.Language = {}

// P.S if you want to add new translation copy english table

gDuel.Language["eng"] = {
	["Small amount"] = "Your bet amount is smaller than minimum bet!",
	["Big amount"] = "Your bet amount is bigger than maximum bet!",
	["GameWithYourself"] = "You can't play with yourself!",
	["CantAfford"] = "You can't afford this!",
	["CantAffordEnemy"] = "Your enemy can't afford this!",
	["Declined"] = "You succesfull declined request!",
	["DeclinedEnemy"] = "Your enemy declined request!",
	["Accepted"] = "You accepted a request for a duel!",
	["AcceptedEnemy"] = "Your enemy has accepted a request for a duel!",
	["FirstPoint"] = "First point set, now set another with right mouse button!",
	["SecondPoint"] = "Second point set! Now you can do it again to make another points!",
	["DuelToolName"] = "Duel Points Setup",
	["DuelToolNameGlobal"] = "Duel Points Setup Tool",
	["DuelToolDesc"] = "Left click: Setup first player point. Right click: Setup second player point. R: Clear all positions",
	["DuelTool0"] = " Press R to clear all points.",
	["DuelToolSetFirstPoint"] = "You can't set second point without first point set!",
	["Youwin!"] = "You win!",
	["YouLose!"] = "You lose!",
	["YouDontHaveRights!"] = "You don't have rights to do it!",
	["GO"] = "GO!",
	["EnterBetVgui"] = "Enter a wager (Greater than ",
	["EnterBetVgui2"] = " and less than ",
	["SendChallenge"] = "Send challenge!",
	["SearchaPlayer"] = "Search for a player...",
	["Selected"] = "Selected",
	["Select"] = "Select",
	["Description"] = "Description: ",
	["AcceptVgui"] = " challenged you to",
	["AcceptVgui2"] = " with wager ",
	["AcceptVgui3"] = "Yes. Duel dis nerd",
	["AcceptVgui4"] = "No",
	["PointsCleared"] = "You Successfully cleared all points!",
	["DuelToolSetFirstPointalready"] = "First point already set",
	["Name"] = "Name: ",
	["Money"] = "Money: ",
	["AlreadySended"] = "You already sent request or player already in a duel",
	["OnTheDuel"] = "You can't change job while you in a duel!",
	["RemoveAllPoints"] = "You already have duel points, in order to add a new points remove all old data",
	["UnavailableWager"] = "Enter a wager!",
	["PointNotFound"] = "Please setup duel points!",
	["EnemyInDuel"] = "Your enemy is already in the duel!"

}

gDuel.Language["rus"] = {
	["Small amount"] = "Ваша ставка меньше чем минимальная допустимая ставка!",
	["Big amount"] = "Ваша ставка больше чем максимальная допустимая ставка!",
	["GameWithYourself"] = "Ты не можешь вызвать самого себя на дуэль!",
	["CantAfford"] = "У вас недостаточно средств!",
	["CantAffordEnemy"] = "У вашего соперника недостаточно средств!",
	["Declined"] = "Вы отказались от дуэли!",
	["DeclinedEnemy"] = "Ваш соперник отказался от дуэли!",
	["Accepted"] = "Вы приняли вызов на дуэль!",
	["AcceptedEnemy"] = "Ваш соперник принял вызов на дуэль!",
	["FirstPoint"] = "Первая тояка установлена, теперь установите",
	["YouDontHaveRights!"] = "У вас недостаточно прав!",
	["SecondPoint"] = "Вторая точка установлена!",
	["DuelToolName"] = "Установка позиций для дуэли",
	["DuelToolNameGlobal"] = "Установщик позиций",
	["DuelToolDesc"] = "Устанавливает позиции для игроков, сражающихся на дуэле.",
	["DuelTool0"] = "Левый клик: Устанавливает позицию первого игрока. Правый клик: Устанавливает позицию второго игрока. R: Очистить позиции",
	["DuelToolSetFirstPoint"] = "Вы не можете установить вторую точку без установки первой!",
	["GO"] = "БОЙ!",
	["EnterBetVgui"] = "Введите ставку (Больше чем ",
	["EnterBetVgui2"] = " и меньше чем ",
	["SendChallenge"] = "Отправить вызов на дуэль!",
	["SearchaPlayer"] = "Поиск игрока...",
	["Selected"] = "Выбрано",
	["Youwin!"] = "Вы выиграли!",
	["YouLose!"] = "Вы проиграли!",
	["Select"] = "Выбрать",
	["Description"] = "Описание: ",
	["AcceptVgui"] = " вызвал вас на дуэль ",
	["AcceptVgui2"] = " со ставкой ",
	["AcceptVgui3"] = "Да. Дуэль необходим",
	["AcceptVgui4"] = "Нет",
	["PointsCleared"] = "Все точки были успешно очищены!",
	["DuelToolSetFirstPointalready"] = "Первая точка уже установлена!",
	["Name"] = "Ник: ",
	["Money"] = "Баланс: ",
	["AlreadySended"] = "Вы уже отправили приглашение на дуэль или игрок уже на дуэли!",
	["OnTheDuel"] = "Вы не можете менять работу находясь на дуэли!",
	["RemoveAllPoints"] = "У вас уже есть установленные точки дуэлей, чтобы добавить новые очистите сохранённые позиции",
	["UnavailableWager"] = "Введите ставку!",
	["PointNotFound"] = "Пожалуйста настройте точки дуэли!",
	["EnemyInDuel"] = "Ваш оппонент уже находится в дуэли!"

}



function gDuel.Translate(str)
	return gDuel.Language[gDuel.Lang][str]
end 
