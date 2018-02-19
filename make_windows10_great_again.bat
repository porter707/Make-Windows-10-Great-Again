@echo off
setlocal EnableDelayedExpansion

ver | find "10." > nul
if errorlevel 1 (
	echo Your Windows version is not Windows 10... yet. Brace yourself, Windows 10 is coming^^!
	pause
	exit
)

echo Make Windows 10 Great Again^^! Ultimate batch spyware and trash remover, v. 2.2.4.
echo Optimized for Anniversary Update.
pause

echo.
echo | set /p=Checking permissions... 
net session >nul 2>&1
if errorlevel 1 (
	echo Permission denied. Run this script as administrator.
	pause
	exit
) else (
	echo OK.
	timeout /t 1 > nul
)

reg query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v "ProductName" | find "LTSB" > nul
if not errorlevel 1 (
	set LTSB=1
)


set trashApps=Microsoft.3DBuilder,^
Microsoft.Appconnector,^
Microsoft.BingFinance,^
Microsoft.BingNews,^
Microsoft.BingSports,^
Microsoft.BingWeather,^
Microsoft.FreshPaint,^
Microsoft.Getstarted,^
Microsoft.MicrosoftOfficeHub,^
Microsoft.MicrosoftSolitaireCollection,^
Microsoft.MicrosoftStickyNotes,^
Microsoft.Office.OneNote,^
Microsoft.OneConnect,^
Microsoft.People,^
Microsoft.SkypeApp,^
Microsoft.Windows.Photos,^
Microsoft.WindowsAlarms,^
Microsoft.WindowsCalculator,^
Microsoft.WindowsCamera,^
Microsoft.WindowsMapsMicrosoft.WindowsPhone,^
Microsoft.WindowsSoundRecorder,^
Microsoft.ZuneMusic,^
Microsoft.ZuneVideo,^
microsoft.windowscommunicationsapps,^
Microsoft.MinecraftUWP,^
Microsoft.MicrosoftPowerBIForWindows,^
Microsoft.NetworkSpeedTest,^
Microsoft.CommsPhone,^
Microsoft.ConnectivityStore,^
Microsoft.Messaging,^
Microsoft.Office.Sway,^
Microsoft.OneConnect,^
Microsoft.WindowsFeedbackHub,^
Microsoft.BingFoodAndDrink,^
Microsoft.BingTravel,^
Microsoft.BingHealthAndFitness,^
Microsoft.WindowsReadingList,^
9E2F88E3.Twitter,^
PandoraMediaInc.29680B314EFC2,^
Flipboard.Flipboard,^
ShazamEntertainmentLtd.Shazam,^
king.com.CandyCrushSaga,^
king.com.CandyCrushSodaSaga,^
king.com.*,^
ClearChannelRadioDigital.iHeartRadio,^
4DF9E0F8.Netflix,^
6Wunderkinder.Wunderlist,^
Drawboard.DrawboardPDF,^
2FE3CB00.PicsArt-PhotoStudio,^
D52A8D61.FarmVille2CountryEscape,^
TuneIn.TuneInRadio,^
GAMELOFTSA.Asphalt8Airborne,^
TheNewYorkTimes.NYTCrossword,^
DB6EA5DB.CyberLinkMediaSuiteEssentials,^
Facebook.Facebook,^
flaregamesGmbH.RoyalRevolt2,^
Playtika.CaesarsSlotsFreeCasino,^
A278AB0D.MarchofEmpires,^
KeeperSecurityInc.Keeper,^
ThumbmunkeysLtd.PhototasticCollage,^
XINGAG.XING,^
89006A2E.AutodeskSketchBook,^
D5EA27B7.Duolingo-LearnLanguagesforFree,^
46928bounde.EclipseManager,^
ActiproSoftwareLLC.562882FEEB491,^
B9ECED6F.MyASUS,^
Microsoft.CommsPhone,^
Microsoft.Wallet,^
TripAdvisorLLC.TripAdvisorHotelsFlightsRestaurants,^
MAGIX.MusicMakerJam,^
Microsoft.Office.Sway,^
Microsoft.Windows.HolographicFirstRun,^
Microsoft.Microsoft3DViewer,^
Microsoft.FlightDashboard,^
Microsoft.Wasserburg,^
4DF9E0F8.Netflix,^
Microsoft.Advertising.Xaml,^
Microsoft.WindowsMaps,^
Microsoft.Print3D

echo list = "%trashApps%"
for %%a in ("%trashApps:,=" "%") do (
   echo Removing App: "%%a"
   powershell -Command "& {Get-AppxPackage  %%a | Remove-AppxPackage;}"
)


cls
echo Deleting spyware firewall rules... 
powershell -Command "& {Get-NetFirewallRule | Where { $_.Group -like '*@{*' } | Remove-NetFirewallRule;}"
powershell -Command "& {Get-NetFirewallRule | Where { $_.Group -eq 'DiagTrack' } | Remove-NetFirewallRule;}"
powershell -Command "& {Get-NetFirewallRule | Where { $_.DisplayGroup -eq 'Delivery Optimization' } | Remove-NetFirewallRule;}"
powershell -Command "& {Get-NetFirewallRule | Where { $_.DisplayGroup -like 'Windows Media Player Network Sharing Service*' } | Remove-NetFirewallRule;}"

cls
echo | set /p=Deleting OneDrive... 
taskkill /f /im OneDrive.exe > nul 2>&1
if exist %SystemRoot%\System32\OneDriveSetup.exe (
	start /wait %SystemRoot%\System32\OneDriveSetup.exe /uninstall
) else (
	start /wait %SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
)
rd "%UserProfile%\OneDrive" /q /s > nul 2>&1
rd "%SystemDrive%\OneDriveTemp" /q /s > nul 2>&1
rd "%LocalAppData%\Microsoft\OneDrive" /q /s > nul 2>&1
rd "%ProgramData%\Microsoft OneDrive" /q /s > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSync" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableMeteredNetworkFileSync" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableLibrariesDefaultSaveToOneDrive" /t REG_DWORD /d 1 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\OneDrive" /v "DisablePersonalSync" /t REG_DWORD /d 1 /f > nul
echo OK.

rem echo.
rem echo Deleting spyware/bloatware services...
rem set spy_services=^
rem 	DiagTrack,dmwappushservice,diagnosticshub.standardcollector.service,DcpSvc,^
rem 	WerSvc,PcaSvc,DoSvc,WMPNetworkSvc,^
rem 	wlidsvc,lfsvc,NcbService,WbioSrvc,LicenseManager,OneSyncSvc,CDPSvc,^
rem 	CDPUserSvc,MapsBroker,PhoneSvc,RetailDemo,WalletService
rem for %%i in (%spy_services%) do (
rem 	sc query %%i > nul
rem 	if not errorlevel 1060 (
rem 		echo Current service: %%i
rem 		sc stop %%i > nul
rem 		sc delete %%i
rem 		set spy_svc_found=1
rem 	)
rem )
rem if not defined spy_svc_found (
rem 	echo No spyware services found.
rem )

rem echo.
rem echo Disabling unsafe services...
rem set unsafe_services=^
rem 	RemoteRegistry,TermService,TrkWks,DPS,^
rem 	SensorDataService,SensorService,SensrSvc
rem for %%i in (%unsafe_services%) do (
rem 	echo Current service: %%i
rem 	sc stop %%i > nul
rem 	sc config %%i start= disabled
rem )

rem echo.
rem echo Adding antispy firewall rules...
rem set spy_ips=^
rem 	104.96.147.3,111.221.29.177,111.221.29.253,111.221.64.0-111.221.127.255,^
rem 	131.253.40.37,134.170.115.60,134.170.165.248,134.170.185.70,131.253.40.109,^
rem 	134.170.30.202,137.116.81.24,137.117.235.16,157.55.129.21,198.78.208.254,^
rem 	157.55.130.0-157.55.130.255,157.55.235.0-157.55.235.255,66.119.144.189,^
rem 	157.55.236.0-157.55.236.255,157.55.52.0-157.55.52.255,134.170.51.248,^
rem 	157.55.56.0-157.55.56.255,157.56.106.189,157.56.121.89,157.56.124.87,^
rem 	157.56.91.77,168.63.108.233,191.232.139.2-191.232.139.255,131.253.40.53,^
rem 	191.232.80.62,191.237.208.126,195.138.255.0-195.138.255.255,94.245.121.251,^
rem 	2.22.61.43,2.22.61.66,204.79.197.200,207.46.101.29,207.46.114.58,207.46.223.94,^
rem 	207.68.166.254,212.30.134.204,212.30.134.205,213.199.179.0-213.199.179.255,^
rem 	23.102.21.4,23.218.212.69,23.223.20.82,23.57.101.163,23.57.107.163,^
rem 	23.57.107.27,23.99.10.11,64.4.23.0-64.4.23.255,64.4.54.22,64.4.54.32,^
rem 	64.4.6.100,65.39.117.230,65.52.100.11,65.52.100.7,65.52.100.9,65.52.100.91,^
rem 	65.52.100.92,65.52.100.93,65.52.100.94,65.52.108.29,65.52.108.33,65.55.108.23,^
rem 	65.55.138.186,65.55.223.0-65.55.223.255,157.56.106.184,131.253.40.59,^
rem 	65.55.252.63,65.55.252.71,65.55.252.92,65.55.252.93,65.55.29.238,65.55.39.10,^
rem 	77.67.29.176,204.79.197.203,111.221.29.254,128.63.2.53,131.253.14.153,^
rem 	134.170.188.248,134.170.52.151,157.56.149.250,207.46.114.61,64.4.54.153,^
rem 	157.56.57.5,157.56.74.250,168.61.24.141,168.62.187.13,191.232.140.76,^
rem 	64.4.54.253,64.4.54.254,65.52.108.153,65.52.108.154,65.55.44.108,65.52.161.64,^
rem 	65.55.130.50,65.55.138.110,65.55.176.90,65.55.252.43,65.55.44.109,^
rem 	65.55.83.120,66.119.147.131,194.44.4.200,194.44.4.208,8.254.209.254,^
rem 	157.56.77.139,134.170.58.121,207.46.194.14,207.46.194.33,13.107.3.128,^
rem 	134.170.53.30,134.170.51.190,131.107.113.238,157.56.96.58,23.67.60.73,^
rem 	104.82.22.249,207.46.194.25,173.194.113.220,173.194.113.219,216.58.209.166,^
rem 	157.56.91.82,157.56.23.91,104.82.14.146,207.123.56.252,185.13.160.61,^
rem 	94.245.121.253,65.52.108.92,207.46.7.252,23.74.8.99,23.74.8.80,65.52.108.103,^
rem 	23.9.123.27,23.74.9.198,23.74.9.217,23.96.212.225,23.101.115.193,^
rem 	23.101.156.198,23.101.187.68,23.102.17.214,23.193.225.197,23.193.230.88,^
rem 	23.193.236.70,23.193.238.90,23.193.251.132,23.210.5.16,23.210.48.42,^
rem 	23.210.63.75,23.217.138.11,23.217.138.18,23.217.138.25,23.217.138.43,^
rem 	23.217.138.90,23.217.138.97,23.217.138.122,40.117.145.132,65.52.108.94,^
rem 	65.52.108.252,65.52.236.160,65.55.113.13,65.55.252.190,65.52.108.27,^
rem 	94.245.121.254,104.73.92.149,104.73.138.217,104.73.143.160,104.73.153.9,^
rem 	104.73.160.16,104.73.160.51,104.73.160.58,104.91.166.82,104.91.188.21,^
rem 	104.208.28.54,134.170.51.246,134.170.179.87,137.116.74.190,157.56.77.138,^
rem 	157.56.96.123,157.56.144.215,157.56.144.216,198.41.214.183,198.41.214.184,^
rem 	198.41.214.186,198.41.214.187,198.41.215.182,198.41.215.185,198.41.215.186
rem for %%i in (%spy_ips%) do (
rem 	netsh advfirewall firewall show rule %%i_BLOCK > nul
rem 		if errorlevel 1 (
rem 			echo | set /p=%%i_BLOCK 
rem 			route -p ADD %%i MASK 255.255.255.255 0.0.0.0 > nul 2>&1
rem 			netsh advfirewall firewall add rule name="%%i_BLOCK" dir=out interface=any action=block remoteip=%%i > nul
rem 			set frw_rule_added=1
rem 			echo [OK]
rem 		)
rem )
rem set svchost=%SystemRoot%\System32\svchost.exe
rem set svchost_rules=^
rem 	"VeriSign Global Registry Services;199.7.48.0-199.7.63.255,199.16.80.0-199.16.95.255"^
rem 	"Microsoft Limited;94.245.64.0-94.245.127.255"^
rem 	"Microsoft Internet Data Center;213.199.160.0-213.199.191.255"^
rem 	"Akamai Technologies;92.122.212.0-92.122.219.255,92.123.96.0-92.123.111.255,95.100.0.0-95.100.15.255,23.32.0.0-23.67.255.255"
rem for %%i in (%svchost_rules%) do (
rem 	for /f "tokens=1,2 delims=;" %%a in (%%i) do (
rem 		netsh advfirewall firewall show rule "%%a SVCHOST_BLOCK" > nul
rem 		if errorlevel 1 (
rem 			echo | set /p=%%a SVCHOST_BLOCK 
rem 			netsh advfirewall firewall add rule name="%%a SVCHOST_BLOCK" dir=out interface=any action=block program=%svchost% remoteip=%%b > nul
rem 			set frw_rule_added=1
rem 			echo [OK]
rem 		)
rem 	)
rem )
rem set spy_apps=^
rem 	"Program Files\Common Files\microsoft shared\OFFICE16\OLicenseHeartbeat.exe"^
rem 	"Program Files\Microsoft Office\Office16\EXCEL.EXE"^
rem 	"Program Files\Microsoft Office\Office16\MSACCESS.EXE"^
rem 	"Program Files\Microsoft Office\Office16\msoia.exe"^
rem 	"Program Files\Microsoft Office\Office16\MSOSYNC.EXE"^
rem 	"Program Files\Microsoft Office\Office16\MSOUC.EXE"^
rem 	"Program Files\Microsoft Office\Office16\MSPUB.EXE"^
rem 	"Program Files\Microsoft Office\Office16\POWERPNT.EXE"^
rem 	"Program Files\Microsoft Office\Office16\SETLANG.EXE"^
rem 	"Program Files\Microsoft Office\Office16\WINWORD.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\EXCEL.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\MSACCESS.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\msoia.exe"^
rem 	"Program Files\Microsoft Office\root\Office16\MSOSYNC.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\MSOUC.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\MSPUB.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\POWERPNT.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\SETLANG.EXE"^
rem 	"Program Files\Microsoft Office\root\Office16\WINWORD.EXE"^
rem 	"Program Files (x86)\Common Files\Microsoft Shared\OFFICE16\OLicenseHeartbeat.exe"^
rem 	"Program Files (x86)\Microsoft Office\Office16\EXCEL.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\MSACCESS.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\msoia.exe"^
rem 	"Program Files (x86)\Microsoft Office\Office16\MSOSYNC.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\MSOUC.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\MSPUB.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\POWERPNT.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\SETLANG.EXE"^
rem 	"Program Files (x86)\Microsoft Office\Office16\WINWORD.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\EXCEL.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\MSACCESS.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\msoia.exe"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\MSOSYNC.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\MSOUC.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\MSPUB.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\POWERPNT.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\SETLANG.EXE"^
rem 	"Program Files (x86)\Microsoft Office\root\Office16\WINWORD.EXE"^
rem 	"Windows\explorer.exe"^
rem 	"Windows\ImmersiveControlPanel\SystemSettings.exe"^
rem 	"Windows\System32\backgroundTaskHost.exe"^
rem 	"Windows\System32\BackgroundTransferHost.exe"^
rem 	"Windows\System32\browser_broker.exe"^
rem 	"Windows\System32\CompatTelRunner.exe"^
rem 	"Windows\System32\dmclient.exe"^
rem 	"Windows\System32\InstallAgentUserBroker.exe"^
rem 	"Windows\System32\lsass.exe"^
rem 	"Windows\System32\msfeedssync.exe"^
rem 	"Windows\System32\rundll32.exe"^
rem 	"Windows\System32\SettingSyncHost.exe"^
rem 	"Windows\System32\SIHClient.exe"^
rem 	"Windows\System32\smartscreen.exe"^
rem 	"Windows\System32\taskhostw.exe"^
rem 	"Windows\System32\wbem\WmiPrvSE.exe"^
rem 	"Windows\System32\WerFault.exe"^
rem 	"Windows\System32\wermgr.exe"^
rem 	"Windows\System32\wsqmcons.exe"^
rem 	"Windows\System32\WWAHost.exe"^
rem 	"Windows\SystemApps\ContactSupport_cw5n1h2txyewy\ContactSupport.exe"^
rem 	"Windows\SystemApps\Microsoft.MicrosoftEdge_8wekyb3d8bbwe\MicrosoftEdge.exe"^
rem 	"Windows\SystemApps\Microsoft.Windows.Cortana_cw5n1h2txyewy\SearchUI.exe"^
rem 	"Windows\SysWOW64\backgroundTaskHost.exe"^
rem 	"Windows\SysWOW64\BackgroundTransferHost.exe"^
rem 	"Windows\SysWOW64\InstallAgentUserBroker.exe"^
rem 	"Windows\SysWOW64\msfeedssync.exe"^
rem 	"Windows\SysWOW64\rundll32.exe"^
rem 	"Windows\SysWOW64\SettingSyncHost.exe"^
rem 	"Windows\SysWOW64\wbem\WmiPrvSE.exe"^
rem 	"Windows\SysWOW64\WerFault.exe"^
rem 	"Windows\SysWOW64\wermgr.exe"^
rem 	"Windows\SysWOW64\WWAHost.exe"
rem for %%i in (%spy_apps%) do (
rem 	set item=%%i
rem 	set file_path="%SystemDrive%\!item:~1!
rem 	if exist !file_path! (
rem 		echo !file_path! | find "SysWOW64" > nul
rem 		if errorlevel 1 (
rem 			set rule_name=%%~nxi_BLOCK
rem 		) else (
rem 			set rule_name=%%~nxi-SysWOW64_BLOCK
rem 		)
rem 		netsh advfirewall firewall show rule !rule_name! > nul
rem 		if errorlevel 1 (
rem 			echo | set /p=!rule_name! 
rem 			netsh advfirewall firewall add rule name=!rule_name! dir=out interface=any action=block program=!file_path! > nul
rem 			set frw_rule_added=1
rem 			echo [OK]
rem 		)
rem 	)
rem )
rem set spy_svc=WSearch
rem netsh advfirewall firewall show rule %spy_svc%_BLOCK > nul
rem if errorlevel 1 (
rem 	echo | set /p=%spy_svc%_BLOCK 
rem 	netsh advfirewall firewall add rule name="%spy_svc%_BLOCK" dir=out interface=any action=block service=%spy_svc% > nul
rem 	set frw_rule_added=1
rem 	echo [OK]
rem )
rem if not defined frw_rule_added (
rem 	echo Antispy rules already present.
rem )

rem echo.
rem echo Blocking spyware domains...
rem set spy_domains=^
rem 	nullroute,^
rem 	statsfe2.update.microsoft.com.akadns.net,fe2.update.microsoft.com.akadns.net,^
rem 	survey.watson.microsoft.com,watson.microsoft.com,^
rem 	watson.ppe.telemetry.microsoft.com,vortex.data.microsoft.com,^
rem 	vortex-win.data.microsoft.com,telecommand.telemetry.microsoft.com,^
rem 	telecommand.telemetry.microsoft.com.nsatc.net,oca.telemetry.microsoft.com,^
rem 	sqm.telemetry.microsoft.com,sqm.telemetry.microsoft.com.nsatc.net,^
rem 	watson.telemetry.microsoft.com,watson.telemetry.microsoft.com.nsatc.net,^
rem 	redir.metaservices.microsoft.com,choice.microsoft.com,^
rem 	choice.microsoft.com.nsatc.net,wes.df.telemetry.microsoft.com,^
rem 	services.wes.df.telemetry.microsoft.com,sqm.df.telemetry.microsoft.com,^
rem 	telemetry.microsoft.com,telemetry.urs.microsoft.com,^
rem 	settings-sandbox.data.microsoft.com,watson.live.com,statsfe2.ws.microsoft.com,^
rem 	corpext.msitadfs.glbdns2.microsoft.com,www.windowssearch.com,ssw.live.com,^
rem 	sls.update.microsoft.com.akadns.net,i1.services.social.microsoft.com,^
rem 	diagnostics.support.microsoft.com,corp.sts.microsoft.com,^
rem 	statsfe1.ws.microsoft.com,feedback.windows.com,feedback.microsoft-hohm.com,^
rem 	feedback.search.microsoft.com,rad.msn.com,preview.msn.com,^
rem 	df.telemetry.microsoft.com,reports.wes.df.telemetry.microsoft.com,^
rem 	vortex-sandbox.data.microsoft.com,settings.data.microsoft.com,^
rem 	oca.telemetry.microsoft.com.nsatc.net,pre.footprintpredict.com,^
rem 	spynet2.microsoft.com,spynetalt.microsoft.com,win10.ipv6.microsoft.com,^
rem 	fe3.delivery.dsp.mp.microsoft.com.nsatc.net,cache.datamart.windows.com,^
rem 	db3wns2011111.wns.windows.com,settings-win.data.microsoft.com,^
rem 	v10.vortex-win.data.microsoft.com,apps.skype.com,^
rem 	g.msn.com,bat.r.msn.com,client-s.gateway.messenger.live.com,^
rem 	arc.msn.com,rpt.msn.com,bn1303.settings.live.net,client.wns.windows.com,^
rem 	ieonlinews.microsoft.com,inprod.support.services.microsoft.com,^
rem 	geover-prod.do.dsp.mp.microsoft.com,geo-prod.do.dsp.mp.microsoft.com,^
rem 	kv201-prod.do.dsp.mp.microsoft.com,cp201-prod.do.dsp.mp.microsoft.com,^
rem 	disc201-prod.do.dsp.mp.microsoft.com,array201-prod.do.dsp.mp.microsoft.com,^
rem 	array202-prod.do.dsp.mp.microsoft.com,array203-prod.do.dsp.mp.microsoft.com,^
rem 	array204-prod.do.dsp.mp.microsoft.com,tsfe.trafficshaping.dsp.mp.microsoft.com,^
rem 	dl.delivery.mp.microsoft.com,tlu.dl.delivery.mp.microsoft.com,^
rem 	statsfe1-df.ws.microsoft.com,statsfe2-df.ws.microsoft.com,^
rem 	public-family.api.account.microsoft.com,dub407-m.hotmail.com,^
rem 	urs.microsoft.com,c.urs.microsoft.com,t.urs.microsoft.com,activity.windows.com,^
rem 	uif.microsoft.com,iecvlist.microsoft.com,ieonline.microsoft.com,c.microsoft.com,^
rem 	nexus.officeapps.live.com,nexusrules.officeapps.live.com,c1.microsoft.com,^
rem 	c.s-microsoft.com,apprep.smartscreen.microsoft.com,otf.msn.com,c.msn.com,^
rem 	rr.office.microsoft.com,web.vortex.data.microsoft.com,ocsa.office.microsoft.com,^
rem 	ocos-office365-s2s.msedge.net,odc.officeapps.live.com,uci.officeapps.live.com,^
rem 	roaming.officeapps.live.com,urs.smartscreen.microsoft.com
rem set hosts=%SystemRoot%\System32\drivers\etc\hosts
rem for %%i in (%spy_domains%) do (
rem 	find /c " %%i" %hosts% > nul
rem 	if errorlevel 1 (
rem 		echo %%i
rem 		echo 0.0.0.0 %%i>>%hosts%
rem 		set hosts_added=1
rem 	)
rem )
rem if not defined hosts_added (
rem 	echo Spyware domains already blocked.
rem ) else (
rem 	echo.
rem 	echo | set /p=Flushing DNS cache 
rem 	ipconfig /flushdns > nul
rem 	echo [OK]
rem )

echo.
echo Adding registry tweaks...

echo | set /p=Disable telemetry 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\ControlSet001\Services\DiagTrack" /v "Start" /t REG_DWORD /d 4 /f > nul
reg add "HKLM\SYSTEM\ControlSet001\Services\dmwappushsvc" /v "Start" /t REG_DWORD /d 4 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\dmwappushservice" /v "Start" /t REG_DWORD /d 4 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\diagnosticshub.standardcollector.service" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable Windows Customer Experience Improvement Program 
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient\Windows" /v "CEIPEnable" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\SQMClient" /v "CorporateSQMURL" /t REG_SZ /d "0.0.0.0" /f > nul
echo [OK]

echo | set /p=Disable Application Telemetry 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "AITEnable" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable Inventory Collector 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableInventory" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Steps Recorder 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisableUAR" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Advertising ID 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AdvertisingInfo" /v "DisabledByGroupPolicy" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable keylogger 
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitInkCollection" /t REG_DWORD /d 1 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization" /v "RestrictImplicitTextCollection" /t REG_DWORD /d 1 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\InputPersonalization\TrainedDataStore" /v "HarvestContacts" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\TabletPC" /v "PreventHandwritingDataSharing" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\HandwritingErrorReports" /v "PreventHandwritingErrorReports" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable browser access to local language 
reg add "HKCU\Control Panel\International\User Profile" /v "HttpAcceptLanguageOptOut" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable SmartScreen 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f > nul
reg add "HKLM\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Explorer" /v "SmartScreenEnabled" /t REG_SZ /d "Off" /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\AppHost" /v "EnableWebContentEvaluation" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableSmartScreen" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable Cortana and web search 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowSearchToUseLocation" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchPrivacy" /t REG_DWORD /d 3 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWeb" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "ConnectedSearchUseWebOverMeteredConnections" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "DisableWebSearch" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\Experience\AllowCortana" /v "value" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CortanaEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "CanCortanaBeEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Personalization\Settings" /v "AcceptedPrivacyPolicy" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "DeviceHistoryEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" /v "HistoryViewEnabled" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable Wi-Fi Sense 
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowWiFiHotSpotReporting" /v "value" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\PolicyManager\default\WiFi\AllowAutoConnectToWiFiSenseHotspots" /v "value" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable biometrics 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Biometrics" /v "Enabled" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\WbioSrvc" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable location access and sensors 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocation" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableLocationScripting" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableSensors" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\LocationAndSensors" /v "DisableWindowsLocationProvider" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc" /v "Start" /t REG_DWORD /d 4 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\lfsvc\Service\Configuration" /v "Status" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Permissions\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Sensor\Overrides\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "SensorPermissionState" /t REG_DWORD /d 0 /f > nul
echo [OK]

rem echo | set /p=Disable sync 
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncPolicy" /t REG_DWORD /d 5 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Accessibility" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\AppSync" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\BrowserSettings" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Credentials" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\DesktopTheme" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Language" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\PackageState" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Personalization" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\StartLayout" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\SettingSync\Groups\Windows" /v "Enabled" /t REG_DWORD /d 0 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableAppSyncSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableApplicationSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableCredentialsSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableDesktopThemeSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisablePersonalizationSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableStartLayoutSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableSyncOnPaidNetwork" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWebBrowserSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSync" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\SettingSync" /v "DisableWindowsSettingSyncUserOverride" /t REG_DWORD /d 1 /f > nul
rem echo [OK]

rem echo | set /p=Disable device access for Universal Apps 
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{21157C1F-2651-4CC1-90CA-1F28B02263F6}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{2EEF81BE-33FA-4800-9670-1CD474972C3F}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{7D7E8402-7C54-4821-A34E-AEEFD62DED93}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{8BC668CF-7728-45BD-93F8-CF2B3B41D7AB}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9231CB4C-BF57-4AF3-8C55-FDA7BFCC04C5}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{992AFA70-6F47-4148-B3E9-3003349C1548}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{9D9E0118-1807-4F2E-96E4-2CE57142E196}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{A8804298-2D5F-42E3-9531-9C8C39EB29CE}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{B19F89AF-E3EB-444B-8DEA-202575A71599}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{BFA794E4-F964-4FDB-90F6-51056BFE4B44}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{C1D23ACC-752B-43E5-8448-8D0E519CD6D6}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{D89823BA-7180-4B81-B50C-7E471E6121A3}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E5323777-F976-4f5b-9B55-B94699C46E44}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E6AD100E-5F4E-44CD-BE0F-2265D88D14F5}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\{E83AF229-8640-4D18-A213-E22675EBB2C3}" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\Global\LooselyCoupled" /v "Value" /t REG_SZ /d "Deny" /f > nul
rem if not defined LTSB (
rem 	set edge_path=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-3624051433-2125758914-1423191267-1740899205-1073925389-3782572162-737981194
rem 	reg add !edge_path!\{2EEF81BE-33FA-4800-9670-1CD474972C3F} /v "Value" /t REG_SZ /d "Deny" /f > nul
rem 	reg add !edge_path!\{E5323777-F976-4f5b-9B55-B94699C46E44} /v "Value" /t REG_SZ /d "Deny" /f > nul
rem )
rem set shell_exp_path=HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeviceAccess\S-1-15-2-155514346-2573954481-755741238-1654018636-1233331829-3075935687-2861478708
rem reg add %shell_exp_path%\{7D7E8402-7C54-4821-A34E-AEEFD62DED93} /v "Value" /t REG_SZ /d "Deny" /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessAccountInfo" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCalendar" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCallHistory" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessCamera" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessContacts" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessEmail" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessLocation" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMessaging" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMicrophone" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessMotion" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessNotifications" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessPhone" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessRadios" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsAccessTrustedDevices" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppPrivacy" /v "LetAppsSyncWithDevices" /t REG_DWORD /d 2 /f > nul
rem reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\SmartGlass" /v "UserAuthPolicy" /t REG_DWORD /d 0 /f > nul
rem echo [OK]

rem if not defined LTSB (
rem 	echo | set /p=Disable background access for Universal Apps 
rem 	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.PPIProjection_cw5n1h2txyewy" /v "Disabled" /t REG_DWORD /d 1 /f > nul
rem 	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.PPIProjection_cw5n1h2txyewy" /v "DisabledByUser" /t REG_DWORD /d 1 /f > nul
rem 	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Windows.ContactSupport_cw5n1h2txyewy" /v "Disabled" /t REG_DWORD /d 1 /f > nul
rem 	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Windows.ContactSupport_cw5n1h2txyewy" /v "DisabledByUser" /t REG_DWORD /d 1 /f > nul
rem 	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /v "Disabled" /t REG_DWORD /d 1 /f > nul
rem 	reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications\Microsoft.MicrosoftEdge_8wekyb3d8bbwe" /v "DisabledByUser" /t REG_DWORD /d 1 /f > nul
rem 	echo [OK]
rem )

echo | set /p=Disable protected trash services 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PimIndexMaintenanceSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UnistoreSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\UserDataSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable Delivery Optimization 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization\Config" /v "DODownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization" /v "SystemSettingsDownloadMode" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\DoSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable Program Compatibility Assistant 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\AppCompat" /v "DisablePCA" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Services\PcaSvc" /v "Start" /t REG_DWORD /d 4 /f > nul
echo [OK]

echo | set /p=Disable Windows Error Reporting 
reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Windows Tips 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableSoftLanding" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Windows Consumer Features (App Suggestions on Start) 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "SystemPaneSuggestionsEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CloudContent" /v "DisableWindowsConsumerFeatures" /t REG_DWORD /d 1 /f > nul
echo [OK]


echo | set /p=Disable ads on lock screen 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v "RotatingLockScreenOverlayEnabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "LockImageFlags" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "CreativeId" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "PortraitAssetPath" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "LandscapeAssetPath" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "DescriptionText" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ActionText" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ActionUri" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "PlacementId" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ClickthroughToken" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "ImpressionToken" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "HotspotImageFolderPath" /t REG_SZ /d "" /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Lock Screen\Creative" /v "CreativeJson" /t REG_SZ /d "" /f > nul
echo [OK]


echo | set /p=Disable File History 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\FileHistory" /v "Disabled" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Active Help 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoActiveHelp" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable loggers 
reg add "HKLM\SYSTEM\ControlSet001\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\AutoLogger-Diagtrack-Listener" /v "Start" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\WMI\AutoLogger\SQMLogger" /v "Start" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable Windows Feedback 
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "NumberOfSIUFInPeriod" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Siuf\Rules" /v "PeriodInNanoSeconds" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Microsoft Help feedback 
reg add "HKCU\SOFTWARE\Policies\Microsoft\Assistance\Client\1.0" /v "NoExplicitFeedback" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable feedback on write 
reg add "HKLM\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Microsoft\Input\TIPC" /v "Enabled" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable lock screen camera 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v "NoLockScreenCamera" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable password reveal button 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\CredUI" /v "DisablePasswordReveal" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Windows Insider Program 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "AllowBuildPreview" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\PreviewBuilds" /v "EnableConfigFlighting" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable DRM features 
reg add "HKLM\SOFTWARE\Policies\Microsoft\WMDRM" /v "DisableOnline" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Office 2016 telemetry 
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "Enablelogging" /t REG_DWORD /d 0 /f > nul
reg add "HKCU\SOFTWARE\Policies\Microsoft\Office\16.0\osm" /v "EnableUpload" /t REG_DWORD /d 0 /f > nul
echo [OK]


echo | set /p=Disable Adobe Flash Player in Microsoft Edge 
reg add "HKCU\SOFTWARE\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\Addons" /v "FlashPlayerEnabled" /t REG_DWORD /d 0 /f > nul
echo [OK]


echo | set /p=Disable Game DVR 
reg add "HKCU\System\GameConfigStore" /v "GameDVR_Enabled" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\GameDVR" /v "AllowGameDVR" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable Live Tiles 
reg add "HKCU\SOFTWARE\Policies\Microsoft\Windows\CurrentVersion\PushNotifications" /v "NoTileApplicationNotification" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable AutoPlay and AutoRun 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoDriveTypeAutoRun" /t REG_DWORD /d 255 /f > nul
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoAutorun" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Disable Remote Assistance 
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowToGetHelp" /t REG_DWORD /d 0 /f > nul
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Remote Assistance" /v "fAllowFullControl" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Disable administrative shares 
reg add "HKLM\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" /v "AutoShareWks" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Do not send Windows Media Player statistics 
reg add "HKCU\SOFTWARE\Microsoft\MediaPlayer\Preferences" /v "UsageTracking" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Remove 3D Builder from context menu 
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.bmp\Shell\T3D Print" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.jpg\Shell\T3D Print" /f > nul 2>&1
reg delete "HKEY_CLASSES_ROOT\SystemFileAssociations\.png\Shell\T3D Print" /f > nul 2>&1
echo [OK]

echo | set /p=Set default PhotoViewer 
reg add "HKCU\SOFTWARE\Classes\.ico" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.tiff" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.bmp" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.png" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.gif" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.jpeg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
reg add "HKCU\SOFTWARE\Classes\.jpg" /ve /t REG_SZ /d "PhotoViewer.FileAssoc.Tiff" /f > nul
echo [OK]

echo | set /p=Turn off "You have new apps that can open this type of file" alert 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoNewAppAlert" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Turn off "Look For An App In The Store" option 
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Explorer" /v "NoUseStoreOpenWith" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Open File Explorer to This PC instead of Quick Access 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "LaunchTo" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Do not show recently used files in Quick Access 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowRecent" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Do not show frequently used folders in Quick Access 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "ShowFrequent" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Show hidden files, folders and drives in File Explorer 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Hidden" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Show file extensions in File Explorer 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "HideFileExt" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Launch folder windows in a separate process 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "SeparateProcess" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Auto-end non responsive tasks 
reg add "HKCU\Control Panel\Desktop" /v "AutoEndTasks" /t REG_SZ /d "1" /f > nul
echo [OK]

echo | set /p=Maximize wallpaper quality 
reg add "HKCU\Control Panel\Desktop" /v "JPEGImportQuality" /t REG_DWORD /d 100 /f > nul
echo [OK]

echo | set /p=Set icon cache size to 4096 KB 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer" /v "Max Cached Icons" /t REG_SZ /d "4096" /f > nul
echo [OK]

echo | set /p=Add Recycle Bin to Navigation Pane 
reg add "HKCU\SOFTWARE\Classes\CLSID\{645FF040-5081-101B-9F08-00AA002F954E}" /v "System.IsPinnedToNameSpaceTree" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Restore Classic Context Menu in Explorer 
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\FlightedFeatures" /v "ImmersiveContextMenu" /t REG_DWORD /d 0 /f > nul
echo [OK]

echo | set /p=Set "Do this for all current items" checkbox by default in the file operation conflict dialog 
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\OperationStatusManager" /v "ConfirmationCheckBoxDoForAll" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo | set /p=Enable NTFS long paths 
reg add "HKLM\SYSTEM\CurrentControlSet\Policies" /v "LongPathsEnabled" /t REG_DWORD /d 1 /f > nul
echo [OK]

echo.
echo | set /p=Restarting Explorer... 
taskkill /f /im explorer.exe >nul & explorer.exe
schtasks /delete /tn "CreateExplorerShellUnelevatedTask" /f > nul
echo OK.

rem echo.
rem echo Deleting spyware tasks...
rem set spy_tasks=^
rem 	"Microsoft\Office\Office 15 Subscription Heartbeat"^
rem 	"Microsoft\Office\OfficeTelemetryAgentFallBack2016"^
rem 	"Microsoft\Office\OfficeTelemetryAgentLogOn2016"^
rem 	"Microsoft\Windows\AppID\SmartScreenSpecific"^
rem 	"Microsoft\Windows\Application Experience\AitAgent"^
rem 	"Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"^
rem 	"Microsoft\Windows\Application Experience\ProgramDataUpdater"^
rem 	"Microsoft\Windows\Application Experience\StartupAppTask"^
rem 	"Microsoft\Windows\Autochk\Proxy"^
rem 	"Microsoft\Windows\Clip\License Validation"^
rem 	"Microsoft\Windows\CloudExperienceHost\CreateObjectTask"^
rem 	"Microsoft\Windows\Customer Experience Improvement Program\BthSQM"^
rem 	"Microsoft\Windows\Customer Experience Improvement Program\Consolidator"^
rem 	"Microsoft\Windows\Customer Experience Improvement Program\KernelCeipTask"^
rem 	"Microsoft\Windows\Customer Experience Improvement Program\UsbCeip"^
rem 	"Microsoft\Windows\Device Information\Device"^
rem 	"Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"^
rem 	"Microsoft\Windows\Feedback\Siuf\DmClient"^
rem 	"Microsoft\Windows\Feedback\Siuf\DmClientOnScenarioDownload"^
rem 	"Microsoft\Windows\License Manager\TempSignedLicenseExchange"^
rem 	"Microsoft\Windows\Location\Notifications"^
rem 	"Microsoft\Windows\Location\WindowsActionDialog"^
rem 	"Microsoft\Windows\Maps\MapsToastTask"^
rem 	"Microsoft\Windows\Maps\MapsUpdateTask"^
rem 	"Microsoft\Windows\Media Center\ActivateWindowsSearch"^
rem 	"Microsoft\Windows\Media Center\ConfigureInternetTimeService"^
rem 	"Microsoft\Windows\Media Center\DispatchRecoveryTasks"^
rem 	"Microsoft\Windows\Media Center\ehDRMInit"^
rem 	"Microsoft\Windows\Media Center\InstallPlayReady"^
rem 	"Microsoft\Windows\Media Center\mcupdate"^
rem 	"Microsoft\Windows\Media Center\MediaCenterRecoveryTask"^
rem 	"Microsoft\Windows\Media Center\ObjectStoreRecoveryTask"^
rem 	"Microsoft\Windows\Media Center\OCURActivate"^
rem 	"Microsoft\Windows\Media Center\OCURDiscovery"^
rem 	"Microsoft\Windows\Media Center\PBDADiscovery"^
rem 	"Microsoft\Windows\Media Center\PBDADiscoveryW1"^
rem 	"Microsoft\Windows\Media Center\PBDADiscoveryW2"^
rem 	"Microsoft\Windows\Media Center\PvrRecoveryTask"^
rem 	"Microsoft\Windows\Media Center\PvrScheduleTask"^
rem 	"Microsoft\Windows\Media Center\RegisterSearch"^
rem 	"Microsoft\Windows\Media Center\ReindexSearchRoot"^
rem 	"Microsoft\Windows\Media Center\SqlLiteRecoveryTask"^
rem 	"Microsoft\Windows\Media Center\UpdateRecordPath"^
rem 	"Microsoft\Windows\Maintenance\WinSAT"^
rem 	"Microsoft\Windows\Power Efficiency Diagnostics\AnalyzeSystem"^
rem 	"Microsoft\Windows\RetailDemo\CleanupOfflineContent"^
rem 	"Microsoft\Windows\SettingSync\BackgroundUploadTask"^
rem 	"Microsoft\Windows\SettingSync\BackupTask"^
rem 	"Microsoft\Windows\SettingSync\NetworkStateChangeTask"^
rem 	"Microsoft\Windows\Shell\FamilySafetyMonitor"^
rem 	"Microsoft\Windows\Shell\FamilySafetyMonitorToastTask"^
rem 	"Microsoft\Windows\Shell\FamilySafetyRefresh"^
rem 	"Microsoft\Windows\Shell\FamilySafetyRefreshTask"^
rem 	"Microsoft\Windows\Speech\SpeechModelDownloadTask"^
rem 	"Microsoft\Windows\Windows Error Reporting\QueueReporting"^
rem 	"Microsoft\Windows\WindowsUpdate\Automatic App Update"^
rem 	"Microsoft\Windows\WindowsUpdate\sih"^
rem 	"Microsoft\Windows\WindowsUpdate\sihboot"^
rem 	"Microsoft\Windows\WS\License Validation"^
rem 	"Microsoft\Windows\WS\WSTask"^
rem set tasks_dir=%SystemRoot%\System32\Tasks
rem for %%i in (%spy_tasks%) do (
rem 	schtasks /query /tn %%i > nul 2>&1
rem 	if not errorlevel 1 (
rem 		echo | set /p=%%i
rem 		schtasks /delete /tn %%i /f > nul
rem 		set item=%%i
rem 		set dir_path="%tasks_dir%\!item:~1!
rem 		mkdir !dir_path!
rem 		icacls !dir_path! /deny "Everyone:(OI)(CI)W" > nul
rem 		set spy_task_deleted=1
rem 		echo  [OK]
rem 	)
rem )
rem if not defined spy_task_deleted (
rem 	echo Spyware tasks already deleted.
rem )

set update_orchestrator_dir=%tasks_dir%\Microsoft\Windows\UpdateOrchestrator
if not exist %update_orchestrator_dir%\Reboot\ (
	echo.
	echo | set /p=Prevent Windows 10 reboots after installing updates... 
	schtasks /delete /tn "Microsoft\Windows\UpdateOrchestrator\Reboot" /f > nul 2>&1
	mkdir %update_orchestrator_dir%\Reboot
	icacls %update_orchestrator_dir%\Reboot /deny "Everyone:(OI)(CI)W" > nul
	echo OK.
)

echo.
echo Finished.
pause
