#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
;#Warn, Unreachable ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.
SetBatchLines -1
DetectHiddenWindows, On
#SingleInstance Force
#include Data\ShinsImageScanClass.ahk

IF NOT A_IsAdmin
{
	Run *RunAs "%A_ScriptFullPath%"
	ExitApp
}

IniRead, UserDiscordHook, config.ini, Discord, Hook
Global UserDiscordHook
Global waters
a_window := "ahk_exe rf4_x64.exe"
guiwindow := "RF4 Spot Logger"
global Schritt := 0
global Max := 100

If WinExist(a_window)
	window=True
else
{
	MsgBox, 4112, Please start RF4., Please start RF4.
	ExitApp
}

scan := new ShinsImageScanClass()
scan.autoUpdate := 0

SetTimer,timenow,500

ListFish:="Aal|Aalmutter|Adlerfisch|Aland|Albino-Gerahmter-Spiegelkarpfen|Albino-Barbe|Albino-Graskarpfen|Albino-Lederkarpfen|Albino-Schuppenkarpfen|Albino-Spiegelkarpfen|Albino-Wels|Albino-Zeilkarpfen|Alfonsino|Aligatorhecht|Amerikanischer-Maifisch|Amurwels|Aral-Barbe|Arktische-Äsche|Arktische-Maráne|Arktischer-Rochen|Atlantischer-Hering|Atlantischer-Kabeljau|Atlantischer-Lachs|Augenfleckenkammbarsch|Auster|Bachforelle|Bachsaibling|Bachschmerle|Baikal-Maráne|Baltischer-Stör|Barbe|Beluga-Stör|Blauer-Seewolf|Blauer-Sonnenbarsch|Blauer-Wittling|Blauflossen-Thunfisch|Blauleng|Brachse|Brachymystax|Braschnikow-Hering|Buckellachs|C2-SuperFreak|Chereshnev-Saibling|Conger|Dinkelsbühler-Lederkarpfen|Dinkelsbühler-Spiegelkarpfen|Dinkelsbühler-Zeilenkarpfen|Döbel|Doggerscharbe|Dolly-Varden-Forelle|Don-Kaulbarsch|Donauhering|Dornhai|Dreistachliger-Stichling|Dryagin-Saibling|Esmarks-Aalmutter|Europäische-Äsche|Europäische-Sardine|Europäischer-Seehecht|F1-Karpfen|Felsenbarsch|Fernöstliches-Neunauge|Flachkopfwels|Fluss-Wandermuschel|Flussbarsch|Flusskrebs|Flussmuschel|Forellenbarsch|Fussballfisch|Gefleckter-Knochenhecht|Gefleckter-Seewolf|Geister-Zeilkarpfen|Geister-Gerahmter-Spiegelkarpfen|Geister-Lederkarpfen|Geister-Schuppenkarpfen|Geister-Spiegelkarpfen|Gemeine-Miesmuschel|Gemeiner-Kalmar|Gepunkteter-Barsch|Gerahmter-Spiegelkarpfen|Gestreifter-Seewolf|Getüpfelter-Gabelwels|Gewöhlicher-Leng|Giebel|Glatt-Stör|Goldener-Spiegelkarpfen|Goldkarpfen|Goldschleie|Gotteslachs|Grasfrosch|Grenadierfisch|Grönlandhai|Große-Bodenrenke|Großmäuliger-Büffelfisch|Gründling|Güster|Hasel|Hecht|Heilbutt|Heringshai|Hi-Utsuri|Isländische-Kammmuschel|Japanischer-Saibling|Kaluga-Hausen|Kamtschatka-Regenbogenforelle|Karausche|Kaspi-Maifisch|Kaspineunauge|Kaspische-Forelle|Kaspischer-Schwarzrücken-Hering|Kaulbarsch|Keta-Lachs|Kleine-Bodenrenke|Kleine-Sibirische-Maráne|Kleiner-Rotbarsch|Kliesche|Klotzsaibling|Kohaku|Köhler|Königskrabbe|Königslachs|Kragenhai|Kuori-Felchen|Kürbiskernbarsch|Kutum|Kvolsdorfsky-Schleie|Ladoga-Lachs|Ladoga-Stör|Ladogasee-Felchen|Langnasen-Saugdöbel|Langohr-Aalmutter|Laube|Lederkarpfen|Lenok|Ludoga-Renke|Ludoga-Saibling|Lumb|Makrele|Makrelenhecht|Mameshibori-Goshiki|Marmorkarpfen|Masu-Lachs|Masu-Lachs-(sesshaft)|Midori-Goi|Mongolische-Rotfeder|Muksun|Narumi-Asagi|Nase|Neiva|Nelma|Neunstachliger-Stichling|Orenji-Ogon|Ostbrasse|Ostrog-Felchen|Ostsibirische-Äsche|Pazifisches-Neunauge|Peledmaráne|Persischer-Stör|Prosopium|Quappe|Rapfen|Regenbogenforelle|Regenbogenstint|Riesenhai|Ripus-Maráne|Rotauge|Rotbarsch|Rotfeder|Rotlachs|Rotohr-Sonnenbarsch|Russischer-Stör|Schellfisch|Scherg|Schläfergrundel|Schlammpeitzger|Schleie|Scholle|Schuppenkarpfen|Schwarzbarsch|Schwarze-Felchen|Schwarzer-Amur|Schwarzer-Büffelfisch|Schwarzer-Crappie|Schwarzer-Degenfisch|Schwarzer-Heilbutt|Schwarzfisch|Schwarzmeer-Beluga|Schwarzmeer-Kutum|Schwarzmeer-Seelaube|Schwertfisch|See-Elritze|Seeforelle|Seehase|Seekatze|Seelaube|Seesaibling|Seesaibling-Kuorsky|Seeskorpion|Seeteufel|Sewan-Forelle|Sibirische-Groppe|Sibirische-Plötze|Sibirischer-Gründling|Sibirischer-Hasel|Sibirischer-Sterlet|Sibirischer-Stör|Sibirisches-Bachneunauge|Sichling|Silberkarpfen|Silberlachs|Spiegelkarpfen|Steinbutt|Steinköhler|Steinschill|Sterlet|Sternrochen|Stint|Streifenbarsch|Südlicher-Neunstachliger-Stichling|Sumpfelritze|Süßwassertrommler|Svir-Felchen|Taimen|Taschenkrebs|Tiefenrotbarsch|Tugun|Tunguska-Rotauge|Tyulka-Sardine|Ugui|Ukrainisches-Bachneunauge|Valaam-Buckelmaráne|Vuoksi-Renke|Walleye|Warmouth|Weißbarsch|Weißer-Amur|Weißer-Crappie|Weißlachs|Wels|Wildkarpfen|Wittling|Wobla|Wolchow-Renke|Wrackbarsch|Yotsushiro|Zährte|Zander|Zeilkarpfen|Zobel|Zope|Zwergmaráne"
Listwaters:="Moskito-See|Elk-Lake|Windenbach|Alte-Festung|Fluss-Belaja|Kuori|Bärensee|Wolchow|Siwerskyj-Donez|FlussSura|Ladogasee|Bernsteinsee|Ladoga-Archipel|Achtuba|Kupfersee|Untere-Tunguska|Fluss-Jama"

if(!FileExist("config.ini"))
	FileAppend, [Info]`nVersion=0.2 `n[User]`nName=""`nID=""`n[Discord]`nHook="", config.ini

IniRead, UName, config.ini, User, Name
IniRead, UID, config.ini, User, ID
If (UName == "")
{
	Gui +LastFound +OwnDialogs +AlwaysOnTop
	InputBox, UserInput, Firststart, Please enter your Name., , 300, 130
	if ErrorLevel{
		ExitApp
	}
	else
	{
		IniWrite, %UserInput%, config.ini,User, Name
		sleep 100
	}
	Gui +LastFound +OwnDialogs +AlwaysOnTop
	InputBox, UserInput, RF4 Spot Logger, Please enter your RF 4 LvL., , 300, 130
	if ErrorLevel{
		ExitApp
	}
	else
	{
		IniWrite, %UserInput%, config.ini,User, ID
		sleep 100
	}
	InputBox, UserInput, RF4 Spot Logger, Please enter your Discord Webhook., , 300, 130
	if ErrorLevel{
		ExitApp
	}
	else
	{
		IniWrite, %UserInput%, config.ini,Discord, Hook
		sleep 100
	}
	Reload
}

cords:=""
fish:=""
clip:=""
hook:=""
bitetime:=""
weather:=""
speed:=""
basis:=""
extra1:=""
extra2:=""
extra3:=""
extra4:=""
flavour:=""
rig:=""
bait:=""
mix:=""

StartUI:
	Gui, Main:New
	Gui, Main:Font, s8 bold, Tahoma
	;Gui, Main:Color, 0x4c4f4d
	Gui, Main:Add, Text, x20 y20 w120 h20, Gewässer
	Gui, Main:Add, DropDownList, x150 y18 w200 h40 r25 Choose%waters% vwaters, % Listwaters
	Gui, Main:Add, Text, x20 y50 w120 h20, Uhrzeit
	Gui, Main:Add, Edit, x150 y48 w120 h20 Center vsimpletime , %ctime%

	Gui, Main:Add, Text, x20 y70 w120 h20, Koordinaten
	Gui, Main:Add, Edit, x150 y68 w200 h20 Center vcords, %cords%

	Gui, Main:Add, Text, x20 y90 w120 h20, Fischart
	Gui, Main:Add, ComboBox, x150 y88 w200 h20 R25 Choose%fish% vfish, % Listfish

	Gui, Main:Add, Text, x20 y110 w120 h20, Clip
	Gui, Main:Add, Edit, x150 y108 w200 h20 Center vclip, %clip%

	Gui, Main:Add, Text, x20 y130 w120 h20, Hakengröße
	Gui, Main:Add, Edit, x150 y128 w200 h20 Center vhook, %hook%

	Gui, Main:Add, Text, x20 y150 w120 h20, Fangzeit
	Gui, Main:Add, Edit, x150 y148 w200 h20 Center vbitetime, %bitetime%

	Gui, Main:Add, Text, x20 y170 w120 h20, Wetter/Gewässertemp.
	Gui, Main:Add, Edit, x150 y168 w200 h20 Center vweather, %weather%

	Gui, Main:Add, Text, x20 y190 w120 h20, Einholgeschwindigkeit
	Gui, Main:Add, Edit, x150 y188 w200 h20 Center vspeed, %speed%

	Gui, Main:Add, Button, x200 y225 w150 h40 gfireit, Einschicken
	Gui, Main:Add, Button, x200 y275 w150 h40 gdelete, Löschen
	Gui, Main:Add, Button, x20 y225 w150 h40 gscreenit, Screenshot Spot
	Gui, Main:Add, Button, x20 y275 w150 h40 gscreenit2, Screenshot Köder

	Gui, Main:Add, Text, x20 y340 w350 h20 Center, Sceenshot Preview Spot
	Gui, Main:Add, Text, x420 y340 w350 h20 Center, Sceenshot Preview Bait
	Gui, Main:Add, Picture, x20 y360 w350 h-1 vscreen, Screen.png
	Gui, Main:Add, Picture, x430 y360 w350 h-1 vscreen2, Screen2.png

	Gui, Main:Add, Text, x450 y20 w120 h20, Köder
	Gui, Main:Add, Edit, x520 y20 w260 h20 Center vbait, %Bait%

	Gui, Main:Add, Text, x450 y40 w120 h20, Basis
	Gui, Main:Add, Edit, x520 y40 w260 h20 Center vbasis, %basis%

	Gui, Main:Add, Text, x450 y60 w120 h20, Zusatz1
	Gui, Main:Add, Edit, x520 y60 w260 h20 Center vextra1, %extra1%

	Gui, Main:Add, Text, x450 y80 w120 h20, Zusatz2
	Gui, Main:Add, Edit, x520 y80 w260 h20 Center vextra2, %extra2%

	Gui, Main:Add, Text, x450 y100 w120 h20, Zusatz3
	Gui, Main:Add, Edit, x520 y100 w260 h20 Center vextra3, %extra3%

	Gui, Main:Add, Text, x450 y120 w120 h20, Zusatz4
	Gui, Main:Add, Edit, x520 y120 w260 h20 Center vextra4, %extra4%

	Gui, Main:Add, Text, x450 y140 w120 h20, Aroma
	Gui, Main:Add, Edit, x520 y140 w260 h20 Center vflavour, %flavour%

	Gui, Main:Add, Text, x450 y160 w120 h20, Montage
	Gui, Main:Add, Edit, x520 y160 w260 h20 Center vrig, %rig%

	Gui, Main:Add, Text, x450 y185 w300 h20 Center, Futtermischung (Beschreibung)
	Gui, Main:Add, Edit, x450 y200 w330 R10 vmix Limit1000, %mix%
	Gui, Main:Add, Picture, x10 y600 w780 , Data\footer.png

	Gui, Main:Show, , RF4 Spot Logger
return

MainGuiClose:
	FileDelete, Screen.png
	FileDelete, Screen2.png
ExitApp
return

End::
	WinActivate, %guiwindow%

return

timenow:
	FormatTime,ctime,,HH:mm:ss
	GuiControl,Main:, simpletime, %ctime%
return

delete:
	SetAllVars("", "", "", "", "", "", "", "", "", "", "", "", "", "", "", "")
	Gui, Main:Destroy
	FileDelete, Screen.png
	FileDelete, Screen2.png
	sleep 100
	Gosub, Startui
return

screenit:
	Gui, Main:Submit, NoHide
	sleep 100
	WinActivate, %a_window%
	WinGetPos, X, Y, Width, Height, %a_window%,
	scan.update()
	scan.SaveImage("Screen", X, Y, Width, Height)

	GuiControl,, screen , Screen.png
	Gui, Main:Destroy
	sleep 100
	Gosub, Startui
	GuiControl, Choose, fish, %fish%
	GuiControl, Choose, waters, %waters%
	WinActivate, %guiwindow%
Return

screenit2:
	Gui, Main:Submit, NoHide
	sleep 100
	WinActivate, %a_window%
	WinGetPos, X, Y, Width, Height, %a_window%,
	scan.update()
	scan.SaveImage("Screen2", X, Y, Width, Height)
	GuiControl,, screen , Screen2.png
	Gui, Main:Destroy
	sleep 100
	Gosub, Startui
	GuiControl, Choose, fish, %fish%
	GuiControl, Choose, waters, %waters%
	WinActivate, %guiwindow%
Return

fireit:

	GuiControlGet, waters, Main:
	If(waters="")
	{
		MsgBox, "Bitte See auswählen".
		return
	}
	GuiControlGet, cords, Main:
	if(cords="")
		cords:="n/a"
	GuiControlGet, fish,Main:
	if(fish="")
		fish:="n/a"
	GuiControlGet, clip,Main:
	if(clip="")
		clip:="n/a"
	GuiControlGet, hook,Main:
	if(hook="")
		hook:="n/a"
	GuiControlGet, bitetime,Main:
	if(bitetime="")
		bitetime:="n/a"
	GuiControlGet, weather,Main:
	if(weather="")
		weather:="n/a"
	GuiControlGet, speed,Main:
	if(speed="")
		speed:="n/a"
	GuiControlGet, basis,Main:
	if(basis="")
		basis:="n/a"
	GuiControlGet, extra1,Main:
	if(extra1="")
		extra1:="n/a"
	GuiControlGet, extra2,Main:
	if(extra2="")
		extra2:="n/a"
	GuiControlGet, extra3,Main:
	if(extra3="")
		extra3:="n/a"
	GuiControlGet, extra4,Main:
	if(extra4="")
		extra4:="n/a"
	GuiControlGet, flavour,Main:
	if(flavour="")
		flavour:="n/a"
	GuiControlGet, rig,Main:
	if(rig="")
		rig:="n/a"
	GuiControlGet, bait,Main:
	if(bait="")
		bait:="n/a"
	GuiControlGet, mix,Main:
	if(mix="")
		mix:="n/a"

	SetTimer, UpdateProgress, 50
	if (FileExist("Screen.png"))
		CompressPNG("Screen.png")
	if (FileExist("Screen2.png"))
		CompressPNG("Screen2.png")

	valueText := FormatDiscordValue(mix)
	FormatTime, TimeCurrent , YYYYMMDDHH24MISS , yyyy-M-ddTHH:mm:ss+0200
	SendDiscordMessage(UName, TimeCurrent, waters,fish , cords, clip, hook, weather, speed, bitetime, bait, valueText, basis, extra1, extra2, extra3, extra4, flavour, rig)
	IfExist, Screen2.png
	{
		objParam := {file: ["Screen.png"], file2: ["Screen2.png"] , username: "RF 4 Spot Tool"}
	}
	else
		objParam := {file: ["Screen.png"] , username: "RF 4 Spot Tool"}
	CreateFormData(PostData, hdr_ContentType, objParam)

	HTTP := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	HTTP.Open("POST", UserDiscordHook, true)
	HTTP.SetRequestHeader("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko")
	HTTP.SetRequestHeader("Content-Type", hdr_ContentType)
	HTTP.SetRequestHeader("Pragma", "no-cache")
	HTTP.SetRequestHeader("Cache-Control", "no-cache, no-store")
	HTTP.SetRequestHeader("If-Modified-Since", "Sat, 1 Jan 2000 00:00:00 GMT")
	HTTP.Send(PostData)
;HTTP.WaitForResponse()

;msgbox % HTTP.ResponseText

Return

SendDiscordMessage(Uname, time, waters="",fish:="n/a", cords:="n/a", clip:="n/a",hook:="n/a",weather:="n/a",speed:="n/a", bitetime:="n/a", bait:="n/a", valuemix:="n/a", basis:="n/a" ,extra1:="n/a", extra2:="n/a", extra3:="n/a", extra4:="n/a", flavour:="n/a", rig:="n/a")
{
	; A simple HTTP POST request sending the message contents to the defined Webhook URL

	json :="{"
		. """username"": ""RF 4 Spot Tool"","
		. """avatar_url"": ""https://i.imgur.com/oBPXx0D.png"","
		. """content"": """","
		. """embeds"": [ {"
		.   """color"": 16711680,"
		.   """description"": ""**Angler: " . Uname . " \nAm Gewässer: " . waters . "**"","
		.   """timestamp"": """ . time . ""","
		.   """thumbnail"": { ""url"": ""https://avatar.rf4game.com/rf4game.de/wp-content/uploads/avatar/256/0011/11043.jpg"" },"
		.   """footer"": { ""text"": ""Petri Heil!"" },"
		.   """fields"": ["
		.     "{"
		.       """name"": ""Fischart: " . fish . " \nKoordinaten: " . cords . " \nClip: " . clip . " \nHakengröße: " . hook . " \nWetterdaten: " . weather . " \nEinholgeschwindigkeit: " . speed . " \nFangzeit: " . bitetime . " \nKöder " . bait . ""","
		.       """value"": ""Basis: " . basis . " \nZusatz1: " . extra1 . " \nZusatz2: " . extra2 . " \nZusatz3: " . extra3 . " \nZusatz4: " . extra4 . " \nAroma: " . flavour . " \nMontage: " . rig . ""","
		.       """inline"": false"
		.     "},"
		.     "{"
		.       """name"": ""Futtermischung Beschreibung:"","
		.       """value"": """ . valueMix . ""","
		.       """inline"": true"
		.     "}"
		.   "]"
		. "} ],"
		. """components"": []"
		. "}"

	Http := ComObjCreate("WinHTTP.WinHTTPRequest.5.1")
	Http.Open("POST", UserDiscordHook, False)
	Http.SetRequestHeader("Content-Type", "application/json")
	Http.Send(json)
	;HTTP.WaitForResponse()

	;msgbox % HTTP.ResponseText
}
;////////////////////////////////////////////////////////////////////////////////////////////////////////////

CreateFormData(ByRef retData, ByRef retHeader, objParam) {
	New CreateFormData(retData, retHeader, objParam)
}

Class CreateFormData {

	__New(ByRef retData, ByRef retHeader, objParam) {

		Local CRLF := "`r`n", i, k, v, str, pvData
		; Create a random Boundary
		Local Boundary := this.RandomBoundary()
		Local BoundaryLine := "------------------------------" . Boundary

		this.Len := 0 ; GMEM_ZEROINIT|GMEM_FIXED = 0x40
		this.Ptr := DllCall( "GlobalAlloc", "UInt",0x40, "UInt",1, "Ptr"  )          ; allocate global memory

		; Loop input paramters
		For k, v in objParam
		{
			If IsObject(v) {
				For i, FileName in v
				{
					str := BoundaryLine . CRLF
						. "Content-Disposition: form-data; name=""" . k . """; filename=""" . FileName . """" . CRLF
						. "Content-Type: " . this.MimeType(FileName) . CRLF . CRLF
					this.StrPutUTF8( str )
					this.LoadFromFile( Filename )
					this.StrPutUTF8( CRLF )
				}
			} Else {
				str := BoundaryLine . CRLF
					. "Content-Disposition: form-data; name=""" . k """" . CRLF . CRLF
					. v . CRLF
				this.StrPutUTF8( str )
			}
		}

		this.StrPutUTF8( BoundaryLine . "--" . CRLF )

		; Create a bytearray and copy data in to it.
		retData := ComObjArray( 0x11, this.Len ) ; Create SAFEARRAY = VT_ARRAY|VT_UI1
		pvData  := NumGet( ComObjValue( retData ) + 8 + A_PtrSize )
		DllCall( "RtlMoveMemory", "Ptr",pvData, "Ptr",this.Ptr, "Ptr",this.Len )

		this.Ptr := DllCall( "GlobalFree", "Ptr",this.Ptr, "Ptr" )                   ; free global memory

		retHeader := "multipart/form-data; boundary=----------------------------" . Boundary
	}

	StrPutUTF8( str ) {
		Local ReqSz := StrPut( str, "utf-8" ) - 1
		this.Len += ReqSz                                  ; GMEM_ZEROINIT|GMEM_MOVEABLE = 0x42
		this.Ptr := DllCall( "GlobalReAlloc", "Ptr",this.Ptr, "UInt",this.len + 1, "UInt", 0x42 )
		StrPut( str, this.Ptr + this.len - ReqSz, ReqSz, "utf-8" )
	}

	LoadFromFile( Filename ) {
		Local objFile := FileOpen( FileName, "r" )
		this.Len += objFile.Length                     ; GMEM_ZEROINIT|GMEM_MOVEABLE = 0x42
		this.Ptr := DllCall( "GlobalReAlloc", "Ptr",this.Ptr, "UInt",this.len, "UInt", 0x42 )
		objFile.RawRead( this.Ptr + this.Len - objFile.length, objFile.length )
		objFile.Close()
	}

	RandomBoundary() {
		str := "0|1|2|3|4|5|6|7|8|9|a|b|c|d|e|f|g|h|i|j|k|l|m|n|o|p|q|r|s|t|u|v|w|x|y|z"
		Sort, str, D| Random
		str := StrReplace(str, "|")
		Return SubStr(str, 1, 12)
	}

	MimeType(FileName) {
		n := FileOpen(FileName, "r").ReadUInt()
		Return (n        = 0x474E5089) ? "image/png"
			: (n        = 0x38464947) ? "image/gif"
			: (n&0xFFFF = 0x4D42    ) ? "image/bmp"
			: (n&0xFFFF = 0xD8FF    ) ? "image/jpeg"
			: (n&0xFFFF = 0x4949    ) ? "image/tiff"
			: (n&0xFFFF = 0x4D4D    ) ? "image/tiff"
			: "application/octet-stream"
	}

}

FormatDiscordValue(editText) {
	formatted := ""
	Loop, Parse, editText, `n, `r
	{
		line := A_LoopField
		if InStr(line, ":")
			line := RegExReplace(line, "i)^(.+?):", "**$1:**")
		formatted .= line . "\n"
	}
	if (SubStr(formatted, -1) = "\n")
		formatted := SubStr(formatted, 1, -1)

	; JSON-escaping
	formatted := StrReplace(formatted, """", "\""") ; Escape "
	formatted := StrReplace(formatted, "\", "\\")   ; Escape \

	return formatted
}

SetAllVars(c, f, cl, h, bt, w, s, b, e1, e2, e3, e4, fl, r, ba, m) {
	global cords := c
	global fish := f
	global clip := cl
	global hook := h
	global bitetime := bt
	global weather := w
	global speed := s
	global basis := b
	global extra1 := e1
	global extra2 := e2
	global extra3 := e3
	global extra4 := e4
	global flavour := fl
	global rig := r
	global bait := ba
	global mix := m
}

CompressPNG(filePath) {
	; Pfad zur PNGQUANT.EXE im Unterordner "data"
	exePath := A_ScriptDir . "\data\pngquant.exe"

	; Prüfen, ob pngquant.exe existiert
	if !FileExist(exePath) {
		MsgBox, 16, Fehler, pngquant.exe nicht gefunden im Ordner `data`.
		return
	}

	; Zieldateiname (z. B. Bildname-fs8.png)
	compressedFile := StrReplace(filePath, ".png", "-fs8.png")

	; pngquant ausführen
	RunWait, %ComSpec% /c ""%exePath%" --force --output "%compressedFile%" "%filePath%"", , Hide

	; Wenn komprimierte Datei erfolgreich erstellt wurde → Original ersetzen
	if FileExist(compressedFile) {
		FileMove, %compressedFile%, %filePath%, 1
	} else {
		MsgBox, 48, Fehler, PNG-Komprimierung fehlgeschlagen bei:`n%filePath%
	}
}

ShowProgress(Titel, Max, Schritt, Farbe:="Blue") {
	global MyProgress
	static GuiErstellt := false

	; Wenn GUI noch nicht erstellt → erstellen
	if (!GuiErstellt) {
		Gui, Pro:New
		Gui, Pro:+AlwaysOnTop -SysMenu
		Gui, Pro:Add, Progress, vMyProgress w300 h25
		GuiControl, Pro:+Range0-100, MyProgress
		GuiControl, Pro:+c%Farbe%, MyProgress
		Gui, Pro:Show,, %Titel%
		GuiErstellt := true
	}

	; Prozent berechnen
	Prozent := Round(Schritt * 100 / Max)

	; Fortschritt setzen
	GuiControl, Pro:, MyProgress, %Prozent%

	; Titel aktualisieren
	Gui, Pro:Show,, % Titel " (" Prozent "%)"

	; Wenn fertig → automatisch schließen
	if (Schritt >= Max) {
		Gui, Pro:Destroy
		GuiErstellt := false
		return true   ; Signal: fertig
	}
	return false      ; noch nicht fertig
}

UpdateProgress:
	Schritt++
	if (ShowProgress("Upload", Max, Schritt, "Green")) {
		SetTimer, UpdateProgress, Off
		Schritt:="0"
	}
return