Return-Path: <cygwin-patches-return-1637-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 19458 invoked by alias); 30 Dec 2001 09:09:20 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19442 invoked from network); 30 Dec 2001 09:09:17 -0000
Message-ID: <05b201c19111$a9c6bc90$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Cc: "Guido Serassio" <serassio@libero.it>
Subject: Fw: Service Control Updates - Round 2
Date: Fri, 09 Nov 2001 05:03:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_05AF_01C1916D.DC8B8B40"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 30 Dec 2001 09:09:15.0873 (UTC) FILETIME=[A7CC2510:01C19111]
X-SW-Source: 2001-q4/txt/msg00169.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_05AF_01C1916D.DC8B8B40
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 836


===
----- Original Message -----
From: "Guido Serassio" <serassio@libero.it>
To: <cygwin-patches@cygwin.com>
Cc: "Robert Collins" <robert.collins@itdomain.com.au>
Sent: Sunday, December 30, 2001 7:58 PM
Subject: Service Control Updates - Round 2


> Hi,
>
> This patch implements all the remaining new Windows 2000 service
functions
> and Structures.
> The first round was merged at 2001-12-02.
>
> 2001-12-30  Guido Serassio <serassio@libero.it>
>
>          * include/winsvc.h: Add EnumServiceStatusEx(),
QueryServiceStatusEx()
> & RegisterServiceCtrlHandlerEx()
>
> Guido
>
>
>
> -
> =======================================================
> Serassio Guido
> Via Albenga, 11/4                                       10134 -
Torino - ITALY
> E-mail: serassio@interfree.it
>          serassio@libero.it
> WWW: http://www.serassio.it
>

------=_NextPart_000_05AF_01C1916D.DC8B8B40
Content-Type: application/octet-stream;
	name="w2kServiceEXupdate.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="w2kServiceEXupdate.patch"
Content-length: 8717

Index: include/winsvc.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winsvc.h,v=0A=
retrieving revision 1.2=0A=
diff -u -p -r1.2 winsvc.h=0A=
--- winsvc.h	2001/12/16 21:57:36	1.2=0A=
+++ winsvc.h	2001/12/30 08:33:05=0A=
@@ -27,11 +27,25 @@ extern "C" {=0A=
 #define SERVICE_ACCEPT_STOP	1=0A=
 #define SERVICE_ACCEPT_PAUSE_CONTINUE	2=0A=
 #define SERVICE_ACCEPT_SHUTDOWN 4=0A=
+#define SERVICE_ACCEPT_PARAMCHANGE    8=0A=
+#define SERVICE_ACCEPT_NETBINDCHANGE  16=0A=
+#define SERVICE_ACCEPT_HARDWAREPROFILECHANGE   32=0A=
+#define SERVICE_ACCEPT_POWEREVENT              64=0A=
+#define SERVICE_ACCEPT_SESSIONCHANGE           128=0A=
 #define SERVICE_CONTROL_STOP	1=0A=
 #define SERVICE_CONTROL_PAUSE	2=0A=
 #define SERVICE_CONTROL_CONTINUE	3=0A=
 #define SERVICE_CONTROL_INTERROGATE	4=0A=
 #define SERVICE_CONTROL_SHUTDOWN	5=0A=
+#define SERVICE_CONTROL_PARAMCHANGE     6=0A=
+#define SERVICE_CONTROL_NETBINDADD      7=0A=
+#define SERVICE_CONTROL_NETBINDREMOVE   8=0A=
+#define SERVICE_CONTROL_NETBINDENABLE   9=0A=
+#define SERVICE_CONTROL_NETBINDDISABLE  10=0A=
+#define SERVICE_CONTROL_DEVICEEVENT     11=0A=
+#define SERVICE_CONTROL_HARDWAREPROFILECHANGE 12=0A=
+#define SERVICE_CONTROL_POWEREVENT            13=0A=
+#define SERVICE_CONTROL_SESSIONCHANGE         14=0A=
 #define SERVICE_ACTIVE 1=0A=
 #define SERVICE_INACTIVE 2=0A=
 #define SERVICE_STATE_ALL 3=0A=
@@ -45,6 +59,7 @@ extern "C" {=0A=
 #define SERVICE_INTERROGATE 128=0A=
 #define SERVICE_USER_DEFINED_CONTROL 256=0A=
 #define SERVICE_ALL_ACCESS (STANDARD_RIGHTS_REQUIRED|SERVICE_QUERY_CONFIG|=
SERVICE_CHANGE_CONFIG|SERVICE_QUERY_STATUS|SERVICE_ENUMERATE_DEPENDENTS|SER=
VICE_START|SERVICE_STOP|SERVICE_PAUSE_CONTINUE|SERVICE_INTERROGATE|SERVICE_=
USER_DEFINED_CONTROL)=0A=
+#define SERVICE_RUNS_IN_SYSTEM_PROCESS 1=0A=
 #define SERVICE_CONFIG_DESCRIPTION     1=0A=
 #define SERVICE_CONFIG_FAILURE_ACTIONS 2=0A=
=20=0A=
@@ -57,6 +72,23 @@ typedef struct _SERVICE_STATUS {=0A=
 	DWORD dwCheckPoint;=0A=
 	DWORD dwWaitHint;=0A=
 } SERVICE_STATUS,*LPSERVICE_STATUS;=0A=
+typedef struct _SERVICE_STATUS_PROCESS {=0A=
+	DWORD dwServiceType;=0A=
+	DWORD dwCurrentState;=0A=
+	DWORD dwControlsAccepted;=0A=
+	DWORD dwWin32ExitCode;=0A=
+	DWORD dwServiceSpecificExitCode;=0A=
+	DWORD dwCheckPoint;=0A=
+	DWORD dwWaitHint;=0A=
+	DWORD dwProcessId;=0A=
+	DWORD dwServiceFlags;=0A=
+} SERVICE_STATUS_PROCESS, *LPSERVICE_STATUS_PROCESS;=0A=
+typedef enum _SC_STATUS_TYPE {=0A=
+	SC_STATUS_PROCESS_INFO =3D 0=0A=
+} SC_STATUS_TYPE;=0A=
+typedef enum _SC_ENUM_TYPE {=0A=
+        SC_ENUM_PROCESS_INFO =3D 0=0A=
+} SC_ENUM_TYPE;=0A=
 typedef struct _ENUM_SERVICE_STATUSA {=0A=
 	LPSTR lpServiceName;=0A=
 	LPSTR lpDisplayName;=0A=
@@ -67,6 +99,16 @@ typedef struct _ENUM_SERVICE_STATUSW {=0A=
 	LPWSTR lpDisplayName;=0A=
 	SERVICE_STATUS ServiceStatus;=0A=
 } ENUM_SERVICE_STATUSW,*LPENUM_SERVICE_STATUSW;=0A=
+typedef struct _ENUM_SERVICE_STATUS_PROCESSA {=0A=
+	LPSTR lpServiceName;=0A=
+	LPSTR lpDisplayName;=0A=
+	SERVICE_STATUS_PROCESS ServiceStatusProcess;=0A=
+} ENUM_SERVICE_STATUS_PROCESSA,*LPENUM_SERVICE_STATUS_PROCESSA;=0A=
+typedef struct _ENUM_SERVICE_STATUS_PROCESSW {=0A=
+	LPWSTR lpServiceName;=0A=
+	LPWSTR lpDisplayName;=0A=
+	SERVICE_STATUS_PROCESS ServiceStatusProcess;=0A=
+} ENUM_SERVICE_STATUS_PROCESSW,*LPENUM_SERVICE_STATUS_PROCESSW;=0A=
 typedef struct _QUERY_SERVICE_CONFIGA {=0A=
 	DWORD dwServiceType;=0A=
 	DWORD dwStartType;=0A=
@@ -114,6 +156,7 @@ typedef SC_HANDLE *LPSC_HANDLE;=0A=
 typedef PVOID SC_LOCK;=0A=
 typedef DWORD SERVICE_STATUS_HANDLE;=0A=
 typedef VOID(WINAPI *LPHANDLER_FUNCTION)(DWORD);=0A=
+typedef DWORD (WINAPI *LPHANDLER_FUNCTION_EX)(DWORD,DWORD,LPVOID,LPVOID);=
=0A=
 typedef struct _SERVICE_DESCRIPTIONA {=0A=
 	LPSTR lpDescription;=0A=
 } SERVICE_DESCRIPTIONA,*LPSERVICE_DESCRIPTIONA;=0A=
@@ -158,6 +201,8 @@ BOOL WINAPI EnumDependentServicesA(SC_HA=0A=
 BOOL WINAPI EnumDependentServicesW(SC_HANDLE,DWORD,LPENUM_SERVICE_STATUSW,=
DWORD,PDWORD,PDWORD);=0A=
 BOOL WINAPI EnumServicesStatusA(SC_HANDLE,DWORD,DWORD,LPENUM_SERVICE_STATU=
SA,DWORD,PDWORD,PDWORD,PDWORD);=0A=
 BOOL WINAPI EnumServicesStatusW(SC_HANDLE,DWORD,DWORD,LPENUM_SERVICE_STATU=
SW,DWORD,PDWORD,PDWORD,PDWORD);=0A=
+BOOL WINAPI EnumServicesStatusExA(SC_HANDLE,SC_ENUM_TYPE,DWORD,DWORD,LPBYT=
E,DWORD,LPDWORD,LPDWORD,LPDWORD,LPCSTR);=0A=
+BOOL WINAPI EnumServicesStatusExW(SC_HANDLE,SC_ENUM_TYPE,DWORD,DWORD,LPBYT=
E,DWORD,LPDWORD,LPDWORD,LPDWORD,LPCWSTR);=0A=
 BOOL WINAPI GetServiceDisplayNameA(SC_HANDLE,LPCSTR,LPSTR,PDWORD);=0A=
 BOOL WINAPI GetServiceDisplayNameW(SC_HANDLE,LPCWSTR,LPWSTR,PDWORD);=0A=
 BOOL WINAPI GetServiceKeyNameA(SC_HANDLE,LPCSTR,LPSTR,PDWORD);=0A=
@@ -176,8 +221,11 @@ BOOL WINAPI QueryServiceLockStatusA(SC_H=0A=
 BOOL WINAPI QueryServiceLockStatusW(SC_HANDLE,LPQUERY_SERVICE_LOCK_STATUSW=
,DWORD,PDWORD);=0A=
 BOOL WINAPI QueryServiceObjectSecurity(SC_HANDLE,SECURITY_INFORMATION,PSEC=
URITY_DESCRIPTOR,DWORD,LPDWORD);=0A=
 BOOL WINAPI QueryServiceStatus(SC_HANDLE,LPSERVICE_STATUS);=0A=
+BOOL WINAPI QueryServiceStatusEx(SC_HANDLE,SC_STATUS_TYPE,LPBYTE,DWORD,LPD=
WORD);=0A=
 SERVICE_STATUS_HANDLE WINAPI RegisterServiceCtrlHandlerA(LPCSTR,LPHANDLER_=
FUNCTION);=0A=
 SERVICE_STATUS_HANDLE WINAPI RegisterServiceCtrlHandlerW(LPCWSTR,LPHANDLER=
_FUNCTION);=0A=
+SERVICE_STATUS_HANDLE WINAPI RegisterServiceCtrlHandlerExA(LPCSTR,LPHANDLE=
R_FUNCTION_EX,LPVOID);=0A=
+SERVICE_STATUS_HANDLE WINAPI RegisterServiceCtrlHandlerExW(LPCWSTR,LPHANDL=
ER_FUNCTION_EX,LPVOID);=0A=
 BOOL WINAPI SetServiceObjectSecurity(SC_HANDLE,SECURITY_INFORMATION,PSECUR=
ITY_DESCRIPTOR);=0A=
 BOOL WINAPI SetServiceStatus(SERVICE_STATUS_HANDLE,LPSERVICE_STATUS);=0A=
 BOOL WINAPI StartServiceA(SC_HANDLE,DWORD,LPCSTR*);=0A=
@@ -188,6 +236,8 @@ BOOL WINAPI UnlockServiceDatabase(SC_LOC=0A=
=20=0A=
 #ifdef UNICODE=0A=
 typedef ENUM_SERVICE_STATUSW ENUM_SERVICE_STATUS,*LPENUM_SERVICE_STATUS;=
=0A=
+typedef ENUM_SERVICE_STATUS_PROCESSW ENUM_SERVICE_STATUS_PROCESS;=0A=
+typedef LPENUM_SERVICE_STATUS_PROCESSW LPENUM_SERVICE_STATUS_PROCESS;=0A=
 typedef QUERY_SERVICE_CONFIGW QUERY_SERVICE_CONFIG,*LPQUERY_SERVICE_CONFIG=
;=0A=
 typedef QUERY_SERVICE_LOCK_STATUSW QUERY_SERVICE_LOCK_STATUS,*LPQUERY_SERV=
ICE_LOCK_STATUS;=0A=
 typedef SERVICE_TABLE_ENTRYW SERVICE_TABLE_ENTRY,*LPSERVICE_TABLE_ENTRY;=
=0A=
@@ -204,6 +254,7 @@ typedef LPSERVICE_FAILURE_ACTIONSW LPSER=0A=
 #define CreateService CreateServiceW=0A=
 #define EnumDependentServices EnumDependentServicesW=0A=
 #define EnumServicesStatus EnumServicesStatusW=0A=
+#define EnumServicesStatusEx  EnumServicesStatusExW=0A=
 #define GetServiceDisplayName GetServiceDisplayNameW=0A=
 #define GetServiceKeyName GetServiceKeyNameW=0A=
 #define OpenSCManager OpenSCManagerW=0A=
@@ -212,10 +263,13 @@ typedef LPSERVICE_FAILURE_ACTIONSW LPSER=0A=
 #define QueryServiceConfig2 QueryServiceConfig2W=0A=
 #define QueryServiceLockStatus QueryServiceLockStatusW=0A=
 #define RegisterServiceCtrlHandler RegisterServiceCtrlHandlerW=0A=
+#define RegisterServiceCtrlHandlerEx RegisterServiceCtrlHandlerExW=0A=
 #define StartService StartServiceW=0A=
 #define StartServiceCtrlDispatcher StartServiceCtrlDispatcherW=0A=
 #else=0A=
 typedef ENUM_SERVICE_STATUSA ENUM_SERVICE_STATUS,*LPENUM_SERVICE_STATUS;=
=0A=
+typedef ENUM_SERVICE_STATUS_PROCESSA ENUM_SERVICE_STATUS_PROCESS;=0A=
+typedef LPENUM_SERVICE_STATUS_PROCESSA LPENUM_SERVICE_STATUS_PROCESS;=0A=
 typedef QUERY_SERVICE_CONFIGA QUERY_SERVICE_CONFIG,*LPQUERY_SERVICE_CONFIG=
;=0A=
 typedef QUERY_SERVICE_LOCK_STATUSA QUERY_SERVICE_LOCK_STATUS,*LPQUERY_SERV=
ICE_LOCK_STATUS;=0A=
 typedef SERVICE_TABLE_ENTRYA SERVICE_TABLE_ENTRY,*LPSERVICE_TABLE_ENTRY;=
=0A=
@@ -232,6 +286,7 @@ typedef LPSERVICE_FAILURE_ACTIONSA LPSER=0A=
 #define CreateService CreateServiceA=0A=
 #define EnumDependentServices EnumDependentServicesA=0A=
 #define EnumServicesStatus EnumServicesStatusA=0A=
+#define EnumServicesStatusEx  EnumServicesStatusExA=0A=
 #define GetServiceDisplayName GetServiceDisplayNameA=0A=
 #define GetServiceKeyName GetServiceKeyNameA=0A=
 #define OpenSCManager OpenSCManagerA=0A=
@@ -240,6 +295,7 @@ typedef LPSERVICE_FAILURE_ACTIONSA LPSER=0A=
 #define QueryServiceConfig2 QueryServiceConfig2A=0A=
 #define QueryServiceLockStatus QueryServiceLockStatusA=0A=
 #define RegisterServiceCtrlHandler RegisterServiceCtrlHandlerA=0A=
+#define RegisterServiceCtrlHandlerEx RegisterServiceCtrlHandlerExA=0A=
 #define StartService StartServiceA=0A=
 #define StartServiceCtrlDispatcher StartServiceCtrlDispatcherA=0A=
 #endif=0A=

------=_NextPart_000_05AF_01C1916D.DC8B8B40--
