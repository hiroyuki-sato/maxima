[Setup]
AppName=Maxima
AppVerName=Maxima 5.9.3
AppId=Maxima-5.9.3
UsePreviousAppDir=yes
AppPublisher=The Maxima Development Team
AppPublisherURL=http://maxima.sourceforge.net
AppSupportURL=http://maxima.sourceforge.net
AppUpdatesURL=http://maxima.sourceforge.net
AppVersion=5.9.3
OutputBaseFilename=maxima-5.9.3-lang-pt
DefaultDirName={pf}\Maxima-5.9.3
DefaultGroupName=Maxima-5.9.3
AllowNoIcons=yes
Compression=lzma/ultra
SolidCompression=yes
Uninstallable=yes
UninstallFilesDir={app}\uninst
; uncomment the following line if you want your installation to run on NT 3.51 too.
; MinVersion=4,3.51

[Files]
Source: "/usr\info\pt\*.*"; DestDir: "{app}\info\pt\";  Flags: recursesubdirs
Source: "/usr\share\maxima\5.9.3\doc\html\pt\*.*"; DestDir: "{app}\share\maxima\5.9.3\doc\html\pt\";  Flags: recursesubdirs


