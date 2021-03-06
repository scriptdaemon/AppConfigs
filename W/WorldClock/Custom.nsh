${SegmentFile}

Var strCustomFullPathToFlashCookie
Var strCustomFullPathToFlash

!addincludedir "${PACKAGE}\App\AppInfo\Launcher"
!include FlashPathConversion.nsh

${SegmentInit}
	StrCpy $2 ""
	${If} ${FileExists} "$APPDATA\Macromedia\Flash Player\#SharedObjects"
		FindFirst $0 $1 "$APPDATA\Macromedia\Flash Player\#SharedObjects\*"
		SegmentPrePrimaryLoop:
			StrCmp $1 "" SegmentPrePrimaryDone
			DetailPrint $1
			${If} $1 != "."
			${AndIf} $1 != ".."
				StrCpy $2 $1
			${EndIf}
			FindNext $0 $1
			Goto SegmentPrePrimaryLoop
		SegmentPrePrimaryDone:
		FindClose $0
	${EndIf}
	
	${If} $2 == ""
		md5dll::GetMD5Random
		Pop $R0
		StrCpy $2 $R0 8
	${EndIf}
	
	${GetRoot} $EXEDIR $0
	${WordReplace} "$EXEDIR" "$0" "" "+" $0
	
	${ConvertPathToFlash} $0 $0
	
	StrCpy $strCustomFullPathToFlashCookie "%APPDATA%\Macromedia\Flash Player\#SharedObjects\$2\localhost$0\App\WorldClock\worldclock-flash-clocks.exe"
	StrCpy $strCustomFullPathToFlash "%APPDATA%\Macromedia\Flash Player\#SharedObjects\$2"
	
	WriteINIStr "$EXEDIR\App\AppInfo\Launcher\WorldClockPortable.ini" "DirectoriesMove" "WorldClockSettings" $strCustomFullPathToFlashCookie
!macroend

${SegmentPrePrimary}
	${If} ${FileExists} "$EXEDIR\Data\WorldClockSettings\localhost"
		;Upgraded from old version
		ExpandEnvStrings $0 "%PAL:LastPackagePartialDir%"
		
		Rename "$EXEDIR\Data\WorldClockSettings\localhost$0\App\WorldClock\worldclock-flash-clocks.exe\WorldMapColorDataEx.sol" "$EXEDIR\Data\WorldMapColorDataEx.sol"
		
		RMDir /r "$EXEDIR\Data\localhost"
		
		CreateDirectory "$EXEDIR\Data\WorldClockSettings"
		
		Rename "$EXEDIR\Data\WorldMapColorDataEx.sol" "$EXEDIR\Data\WorldClockSettings\WorldMapColorDataEx.sol"
	${EndIf}
!macroend

${SegmentPostPrimary}
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20300')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20310')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20320')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20330')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20340')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20350')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20360')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20370')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20380')i .r2"
	System::Call "wininet::DeleteUrlCacheEntryW(t'http://flash-clocks.com/wc2/wc-config.xml?nocache%20=%20390')i .r2"
	
	${GetRoot} $EXEDIR $0
	
	ExpandEnvStrings $1 $strCustomFullPathToFlashCookie
	ExpandEnvStrings $2 $strCustomFullPathToFlash
	
	SegmentPostPrimaryLoop:
		RMDir $1
		${GetParent} $1 $1
		${If} $1 == $2
			Goto SegmentPostPrimaryDone
		${EndIf}
		Goto SegmentPostPrimaryLoop
	SegmentPostPrimaryDone:
!macroend
