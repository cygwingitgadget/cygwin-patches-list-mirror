Return-Path: <cygwin-patches-return-1567-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 31508 invoked by alias); 7 Dec 2001 21:48:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31038 invoked from network); 7 Dec 2001 21:48:53 -0000
Message-ID: <099a01c17eaf$332c6a90$0200a8c0@lifelesswks>
From: "Robert Collins" <robert.collins@itdomain.com.au>
To: <cygwin-patches@cygwin.com>
Subject: service control updates
Date: Fri, 02 Nov 2001 13:49:00 -0000
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0997_01C17F0B.662A71B0"
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-OriginalArrivalTime: 06 Dec 2001 23:39:06.0058 (UTC) FILETIME=[31A862A0:01C17EAF]
X-SW-Source: 2001-q4/txt/msg00099.txt.bz2

This is a multi-part message in MIME format.

------=_NextPart_000_0997_01C17F0B.662A71B0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-length: 141

2001-12-02  Guido Serassio <serassio@libero.it>

    * include/winsvc.h: Add ChangeServiceConfig2() &
QueryServiceConfig2() definition


Rob

------=_NextPart_000_0997_01C17F0B.662A71B0
Content-Type: application/octet-stream;
	name="serviceupdate.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="serviceupdate.patch"
Content-length: 6493

Index: include/winsvc.h=0A=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
RCS file: /cvs/src/src/winsup/w32api/include/winsvc.h,v=0A=
retrieving revision 1.1.1.1=0A=
diff -u -p -r1.1.1.1 winsvc.h=0A=
--- winsvc.h	2000/02/17 19:38:32	1.1.1.1=0A=
+++ winsvc.h	2001/12/06 23:37:59=0A=
@@ -45,8 +45,9 @@ extern "C" {=0A=
 #define SERVICE_INTERROGATE 128=0A=
 #define SERVICE_USER_DEFINED_CONTROL 256=0A=
 #define SERVICE_ALL_ACCESS (STANDARD_RIGHTS_REQUIRED|SERVICE_QUERY_CONFIG|=
SERVICE_CHANGE_CONFIG|SERVICE_QUERY_STATUS|SERVICE_ENUMERATE_DEPENDENTS|SER=
VICE_START|SERVICE_STOP|SERVICE_PAUSE_CONTINUE|SERVICE_INTERROGATE|SERVICE_=
USER_DEFINED_CONTROL)=0A=
+#define SERVICE_CONFIG_DESCRIPTION     1=0A=
+#define SERVICE_CONFIG_FAILURE_ACTIONS 2=0A=
=20=0A=
-=0A=
 typedef struct _SERVICE_STATUS {=0A=
 	DWORD dwServiceType;=0A=
 	DWORD dwCurrentState;=0A=
@@ -113,9 +114,41 @@ typedef SC_HANDLE *LPSC_HANDLE;=0A=
 typedef PVOID SC_LOCK;=0A=
 typedef DWORD SERVICE_STATUS_HANDLE;=0A=
 typedef VOID(WINAPI *LPHANDLER_FUNCTION)(DWORD);=0A=
+typedef struct _SERVICE_DESCRIPTIONA {=0A=
+	LPSTR lpDescription;=0A=
+} SERVICE_DESCRIPTIONA,*LPSERVICE_DESCRIPTIONA;=0A=
+typedef struct _SERVICE_DESCRIPTIONW {=0A=
+	LPWSTR lpDescription;=0A=
+} SERVICE_DESCRIPTIONW,*LPSERVICE_DESCRIPTIONW;=0A=
+typedef enum _SC_ACTION_TYPE {=0A=
+        SC_ACTION_NONE          =3D 0,=0A=
+        SC_ACTION_RESTART       =3D 1,=0A=
+        SC_ACTION_REBOOT        =3D 2,=0A=
+        SC_ACTION_RUN_COMMAND   =3D 3=0A=
+} SC_ACTION_TYPE;=0A=
+typedef struct _SC_ACTION {=0A=
+	SC_ACTION_TYPE	Type;=0A=
+	DWORD		Delay;=0A=
+} SC_ACTION,*LPSC_ACTION;=0A=
+typedef struct _SERVICE_FAILURE_ACTIONSA {=0A=
+	DWORD	dwResetPeriod;=0A=
+	LPSTR	lpRebootMsg;=0A=
+	LPSTR	lpCommand;=0A=
+	DWORD	cActions;=0A=
+	SC_ACTION * lpsaActions;=0A=
+} SERVICE_FAILURE_ACTIONSA,*LPSERVICE_FAILURE_ACTIONSA;=0A=
+typedef struct _SERVICE_FAILURE_ACTIONSW {=0A=
+	DWORD	dwResetPeriod;=0A=
+	LPWSTR	lpRebootMsg;=0A=
+	LPWSTR	lpCommand;=0A=
+	DWORD	cActions;=0A=
+	SC_ACTION * lpsaActions;=0A=
+} SERVICE_FAILURE_ACTIONSW,*LPSERVICE_FAILURE_ACTIONSW;=0A=
=20=0A=
 BOOL WINAPI ChangeServiceConfigA(SC_HANDLE,DWORD,DWORD,DWORD,LPCSTR,LPCSTR=
,LPDWORD,LPCSTR,LPCSTR,LPCSTR,LPCSTR);=0A=
 BOOL WINAPI ChangeServiceConfigW(SC_HANDLE,DWORD,DWORD,DWORD,LPCWSTR,LPCWS=
TR,LPDWORD,LPCWSTR,LPCWSTR,LPCWSTR,LPCWSTR);=0A=
+BOOL WINAPI ChangeServiceConfig2A(SC_HANDLE,DWORD,LPVOID);=0A=
+BOOL WINAPI ChangeServiceConfig2W(SC_HANDLE,DWORD,LPVOID);=0A=
 BOOL WINAPI CloseServiceHandle(SC_HANDLE);=0A=
 BOOL WINAPI ControlService(SC_HANDLE,DWORD,LPSERVICE_STATUS);=0A=
 SC_HANDLE WINAPI CreateServiceA(SC_HANDLE,LPCSTR,LPCSTR,DWORD,DWORD,DWORD,=
DWORD,LPCSTR,LPCSTR,PDWORD,LPCSTR,LPCSTR,LPCSTR);=0A=
@@ -137,6 +170,8 @@ SC_HANDLE WINAPI OpenServiceA(SC_HANDLE,=0A=
 SC_HANDLE WINAPI OpenServiceW(SC_HANDLE,LPCWSTR,DWORD);=0A=
 BOOL WINAPI QueryServiceConfigA(SC_HANDLE,LPQUERY_SERVICE_CONFIGA,DWORD,PD=
WORD);=0A=
 BOOL WINAPI QueryServiceConfigW(SC_HANDLE,LPQUERY_SERVICE_CONFIGW,DWORD,PD=
WORD);=0A=
+BOOL WINAPI QueryServiceConfig2A(SC_HANDLE,DWORD,LPBYTE,DWORD,LPDWORD);=0A=
+BOOL WINAPI QueryServiceConfig2W(SC_HANDLE,DWORD,LPBYTE,DWORD,LPDWORD);=0A=
 BOOL WINAPI QueryServiceLockStatusA(SC_HANDLE,LPQUERY_SERVICE_LOCK_STATUSA=
,DWORD,PDWORD);=0A=
 BOOL WINAPI QueryServiceLockStatusW(SC_HANDLE,LPQUERY_SERVICE_LOCK_STATUSW=
,DWORD,PDWORD);=0A=
 BOOL WINAPI QueryServiceObjectSecurity(SC_HANDLE,SECURITY_INFORMATION,PSEC=
URITY_DESCRIPTOR,DWORD,LPDWORD);=0A=
@@ -157,10 +192,15 @@ typedef QUERY_SERVICE_CONFIGW QUERY_SERV=0A=
 typedef QUERY_SERVICE_LOCK_STATUSW QUERY_SERVICE_LOCK_STATUS,*LPQUERY_SERV=
ICE_LOCK_STATUS;=0A=
 typedef SERVICE_TABLE_ENTRYW SERVICE_TABLE_ENTRY,*LPSERVICE_TABLE_ENTRY;=
=0A=
 typedef LPSERVICE_MAIN_FUNCTIONW LPSERVICE_MAIN_FUNCTION;=0A=
+typedef SERVICE_DESCRIPTIONW SERVICE_DESCRIPTION;=0A=
+typedef LPSERVICE_DESCRIPTIONW LPSERVICE_DESCRIPTION;=0A=
+typedef SERVICE_FAILURE_ACTIONSW SERVICE_FAILURE_ACTIONS;=0A=
+typedef LPSERVICE_FAILURE_ACTIONSW LPSERVICE_FAILURE_ACTIONS;=0A=
 #define SERVICES_ACTIVE_DATABASE SERVICES_ACTIVE_DATABASEW=0A=
 #define SERVICES_FAILED_DATABASE SERVICES_FAILED_DATABASEW=0A=
 #define SC_GROUP_IDENTIFIER SC_GROUP_IDENTIFIERW=0A=
 #define ChangeServiceConfig ChangeServiceConfigW=0A=
+#define ChangeServiceConfig2 ChangeServiceConfig2W=0A=
 #define CreateService CreateServiceW=0A=
 #define EnumDependentServices EnumDependentServicesW=0A=
 #define EnumServicesStatus EnumServicesStatusW=0A=
@@ -169,6 +209,7 @@ typedef LPSERVICE_MAIN_FUNCTIONW LPSERVI=0A=
 #define OpenSCManager OpenSCManagerW=0A=
 #define OpenService OpenServiceW=0A=
 #define QueryServiceConfig QueryServiceConfigW=0A=
+#define QueryServiceConfig2 QueryServiceConfig2W=0A=
 #define QueryServiceLockStatus QueryServiceLockStatusW=0A=
 #define RegisterServiceCtrlHandler RegisterServiceCtrlHandlerW=0A=
 #define StartService StartServiceW=0A=
@@ -179,10 +220,15 @@ typedef QUERY_SERVICE_CONFIGA QUERY_SERV=0A=
 typedef QUERY_SERVICE_LOCK_STATUSA QUERY_SERVICE_LOCK_STATUS,*LPQUERY_SERV=
ICE_LOCK_STATUS;=0A=
 typedef SERVICE_TABLE_ENTRYA SERVICE_TABLE_ENTRY,*LPSERVICE_TABLE_ENTRY;=
=0A=
 typedef LPSERVICE_MAIN_FUNCTIONA LPSERVICE_MAIN_FUNCTION;=0A=
+typedef SERVICE_DESCRIPTIONA SERVICE_DESCRIPTION;=0A=
+typedef LPSERVICE_DESCRIPTIONA LPSERVICE_DESCRIPTION;=0A=
+typedef SERVICE_FAILURE_ACTIONSA SERVICE_FAILURE_ACTIONS;=0A=
+typedef LPSERVICE_FAILURE_ACTIONSA LPSERVICE_FAILURE_ACTIONS;=0A=
 #define SERVICES_ACTIVE_DATABASE SERVICES_ACTIVE_DATABASEA=0A=
 #define SERVICES_FAILED_DATABASE SERVICES_FAILED_DATABASEA=0A=
 #define SC_GROUP_IDENTIFIER SC_GROUP_IDENTIFIERA=0A=
 #define ChangeServiceConfig ChangeServiceConfigA=0A=
+#define ChangeServiceConfig2 ChangeServiceConfig2A=0A=
 #define CreateService CreateServiceA=0A=
 #define EnumDependentServices EnumDependentServicesA=0A=
 #define EnumServicesStatus EnumServicesStatusA=0A=
@@ -191,6 +237,7 @@ typedef LPSERVICE_MAIN_FUNCTIONA LPSERVI=0A=
 #define OpenSCManager OpenSCManagerA=0A=
 #define OpenService OpenServiceA=0A=
 #define QueryServiceConfig QueryServiceConfigA=0A=
+#define QueryServiceConfig2 QueryServiceConfig2A=0A=
 #define QueryServiceLockStatus QueryServiceLockStatusA=0A=
 #define RegisterServiceCtrlHandler RegisterServiceCtrlHandlerA=0A=
 #define StartService StartServiceA=0A=

------=_NextPart_000_0997_01C17F0B.662A71B0--
