;Copyright (C) 2004-2013 John T. Haller of PortableApps.com

;Website: http://portableapps.com/apps/development/xampp

;This software is OSI Certified Open Source Software.
;OSI Certified is a certification mark of the Open Source Initiative.

;This program is free software; you can redistribute it and/or
;modify it under the terms of the GNU General Public License
;as published by the Free Software Foundation; either version 2
;of the License, or (at your option) any later version.

;This program is distributed in the hope that it will be useful,
;but WITHOUT ANY WARRANTY; without even the implied warranty of
;MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;GNU General Public License for more details.

;You should have received a copy of the GNU General Public License
;along with this program; if not, write to the Free Software
;Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

!define NAME "XAMPPLauncher"
!define FRIENDLYNAME "XAMPP Control Panel"
!define APP "XAMPP"
!define VER "1.6.0.0"
!define WEBSITE "PortableApps.com/apps/development/xampp"

;=== Program Details
Name "${FRIENDLYNAME}"
OutFile "..\..\${NAME}.exe"
Caption "${FRIENDLYNAME} | PortableApps.com"
VIProductVersion "${VER}"
VIAddVersionKey ProductName "${FRIENDLYNAME}"
VIAddVersionKey Comments "Allows ${APP} to appear in the PortableApps Menu.  For additional details, visit ${WEBSITE}"
VIAddVersionKey CompanyName "PortableApps.com"
VIAddVersionKey LegalCopyright "John T. Haller"
VIAddVersionKey FileDescription "${FRIENDLYNAME}"
VIAddVersionKey FileVersion "${VER}"
VIAddVersionKey ProductVersion "${VER}"
VIAddVersionKey InternalName "${FRIENDLYNAME}"
VIAddVersionKey LegalTrademarks "PortableApps.com is a Trademark of Rare Ideas, LLC."
VIAddVersionKey OriginalFilename "${NAME}.exe"
;VIAddVersionKey PrivateBuild ""
;VIAddVersionKey SpecialBuild ""

;=== Runtime Switches
CRCCheck On
WindowIcon Off
SilentInstall Silent
AutoCloseWindow True
RequestExecutionLevel user
XPStyle on

; Best Compression
SetCompress Auto
SetCompressor /SOLID lzma
SetCompressorDictSize 32
SetDatablockOptimize On

;=== Program Icon
Icon "..\..\App\AppInfo\appicon.ico"

;=== Includes
!include "FileFunc.nsh"
!insertmacro GetRoot

Section "Main"
	${GetRoot} "$EXEDIR" $0
	IfFileExists `$0\xampp\xampp-control.exe` "" CheckXAMPPLiteRoot
		SetOutPath `$0\xampp`
		Exec `$0\xampp\xampp-control.exe`
		Goto TheEnd
	
	CheckXAMPPLiteRoot:
		IfFileExists `$0\xampplite\xampp-control.exe` "" CheckXAMPPSubdirectory
		SetOutPath `$0\xampplite`
		Exec `$0\xampplite\xampp-control.exe`
		Goto TheEnd

	CheckXAMPPSubdirectory:
		IfFileExists `$EXEDIR\App\xampp\xampp-control.exe` "" CheckXAMPPLiteSubdirectory
		SetOutPath `$EXEDIR\App\xampp`
		Exec `$EXEDIR\App\xampp\xampp-control.exe`
		Goto TheEnd
	
	CheckXAMPPLiteSubdirectory:
		IfFileExists `$EXEDIR\App\xampplite\xampp-control.exe` "" NotFound
		SetOutPath `$EXEDIR\App\xampplite`
		Exec `$EXEDIR\App\xampplite\xampp-control.exe`
		Goto TheEnd
	
	NotFound:
		MessageBox MB_OK|MB_ICONINFORMATION "Neither XAMPP nor XAMPP Lite were found on your device.  Please download the zipped version and install XAMPP to $0\xampp or $EXEDIR\App\xampp or install XAMPP Lite to $0\xampplite or $EXEDIR\App\xampplite."
	
	TheEnd:
SectionEnd