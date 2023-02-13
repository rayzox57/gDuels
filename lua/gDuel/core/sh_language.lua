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

	["DuelNPC"] = "Duel NPC",

	["MainMenu"] = "Main",
	["LeaderBoard"] = "LeaderBoard",
	["Close"] = "Close",
	
	["Win"]  = "Wins",
	["Wins"] = "Wins",
	["Lose"] = "Loses",
	["Loses"] = "Loses",

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
	["EnemyInDuel"] = "Your enemy is already in the duel!",
	["CantDuelYourself"] = "You can't duel Yourself",
	["CantDuelInBuildMode"] = "You can't launch duel in BuildMode",
	["CantDuelEnemyInBuildMode"] = "You can't launch duel with enemy in BuildMode",
	["NoDescription"] = "No Description",


	// Add here all duel modes descriptions 
	["Kinky Crowbar"] = "You have kinky crowbar sex with the opponent",
	["Fisting"] = "You both spawn with 50 hp and have to fist eachother to death xd",
	["Explosionz"] = "Spawn with 999 nades, and fuck up the opponent with em!"


}

gDuel.Language["fra"] = {

	["DuelNPC"] = "PNJ Duel",

	["MainMenu"] = "Accueil",
	["LeaderBoard"] = "Classement",
	["Close"] = "Fermer",
	
	["Win"]  = "Partie Gagnée",
	["Wins"] = "Parties Gagnées",
	["Lose"] = "Partie Perdue",
	["Loses"] = "Parties Perdues",

	["Small amount"] = "Votre montant de pari est inférieur au pari minimum !",
	["Big amount"] = "Votre montant de pari est plus élevé que le pari maximum !",
	["GameWithYourself"] = "Vous ne pouvez pas jouer avec vous-même !",
	["CantAfford"] = "Vous ne pouvez pas vous permettre ça !",
	["CantAffordEnemy"] = "Votre ennemi ne peut pas se permettre cela!",
	["Declined"] = "Vous avez refusé la demande avec succès !",
	["DeclinedEnemy"] = "Votre ennemi a refusé la demande !",
	["Accepted"] = "Vous avez accepté une demande pour un duel !",
	["AcceptedEnemy"] = "Votre ennemi a accepté une demande pour un duel !",
	["FirstPoint"] = "Premier point défini, définissez maintenant un autre avec le bouton droit de la souris !",
	["SecondPoint"] = "Deuxième point défini ! Vous pouvez maintenant le refaire pour en définir d'autres!",
	["DuelToolName"] = "Configuration de points de duel",
	["DuelToolNameGlobal"] = "Outil de configuration de points de duel",
	["DuelToolDesc"] = "Clique gauche : définir le point du premier joueur. Clique droit : définir le point du deuxième joueur. R : effacer toutes les positions",
	["DuelTool0"] = " Appuyez sur R pour effacer tous les points.",
	["DuelToolSetFirstPoint"] = "Vous ne pouvez pas définir deuxième point sans définir le premier point!",
	["Youwin!"] = "Vous avez gagné!",
	["YouLose!"] = "Vous avez perdu!",
	["YouDontHaveRights!"] = "Vous n'avez pas le droit de le faire!",
	["GO"] = "GO!",
	["EnterBetVgui"] = "Entrez une mise (plus grand que ",
	["EnterBetVgui2"] = " et moins que ",
	["SendChallenge"] = "Envoyer le défi!",
	["SearchaPlayer"] = "Rechercher un joueur...",
	["Selected"] = "Sélectionné",
	["Select"] = "Sélectionner",
	["Description"] = "Description: ",
	["AcceptVgui"] = " vous a défié pour",
	["AcceptVgui2"] = " avec une mise de ",
	["AcceptVgui3"] = "Oui. Duel ce nerd",
	["AcceptVgui4"] = "Non",
	["PointsCleared"] = "Vous avez effacé avec succès tous les points!",
	["DuelToolSetFirstPointalready"] = "Le premier point est déjà défini",
	["Name"] = "Nom: ",
	["Money"] = "Argent: ",
	["AlreadySended"] = "Vous avez déjà envoyé une demande ou le joueur est déjà en duel",
	["OnTheDuel"] = "Vous ne pouvez pas changer de travail pendant un duel!",
	["RemoveAllPoints"] = "Vous avez déjà des points de duel, pour ajouter de nouveaux points, supprimez toutes les anciennes données",
	["UnavailableWager"] = "Entrez une mise!",
	["PointNotFound"] = "Veuillez configurer les points de duel!",
	["EnemyInDuel"] = "Votre ennemi est déjà en duel!",
	["CantDuelYourself"] = "Vous ne pouvez pas vous affronter",
	["CantDuelInBuildMode"] = "Vous ne pouvez pas lancer un duel en BuildMode",
	["CantDuelEnemyInBuildMode"] = "Vous ne pouvez pas lancer un duel avec un ennemi en BuildMode",
	["NoDescription"] = "Aucune description",

	// Ajouter ici toutes les descriptions pour vos modes de duel
	["Kinky Crowbar"] = "Vous avez des relations sexuelles coquines avec l'adversaire",
	["Fisting"] = "Vous apparaissez tous les deux avec 50 points de vie et vous devez vous fister à mort xd",
	["Explosionz"] = "Spawn avec 999 nades, et nique l'adversaire avec !"

}

gDuel.Language["rus"] = {

	["DuelNPC"] = "Дуэль NPC",

	["ГлавноеМеню"] = "Дом",
	["LeaderBoard"] = "Таблица лидеров",
	["Закрыть"] = "Закрыть",
	
	["Победа"] = "Игра выиграна",
	["Победы"] = "Выигранные игры",
	["Проигрыш"] = "Проигранная игра",
	["Проигрыши"] = "Проигранные игры",
	
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
	["EnemyInDuel"] = "Ваш оппонент уже находится в дуэли!",
	["CantDuelYourself"] = "Вы не можете сражаться с самим собой!",
	["CantDuelInBuildMode"] = "Вы не можете вызвать на дуэль в режиме постройки!",
	["CantDuelEnemyInBuildMode"] = "Вы не можете вызвать на дуэль игрока находящегося в режиме постройки!",
	["NoDescription"] = "Нет описания",

	// Добавляем сюда описания всех режимов дуэли
	["Kinky Crowbar"] = "У вас странный ломовый секс с противником",
	["Fisting"] = "Вы оба появляетесь с 50 хп и должны драть друг друга до смерти xd",
	["Explosionz"] = "Появитесь с 999 гранатами и испортите ими противника!"



}



function gDuel.Translate(str)
	return gDuel.Language[gDuel.Lang][str]
end 
