Return-Path: <cygwin-patches-return-2858-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 30177 invoked by alias); 25 Aug 2002 16:28:14 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30163 invoked from network); 25 Aug 2002 16:28:14 -0000
Date: Sun, 25 Aug 2002 09:28:00 -0000
From: Bart Oldeman <bart.oldeman@btinternet.com>
X-X-Sender:  <enbeo@enm-bo-lt.enm.bris.ac.uk>
To:  <cygwin-patches@cygwin.com>
Subject: [PATCH] winsock related changes for w32api
Message-ID: <Pine.LNX.4.33.0208251712170.8293-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00306.txt.bz2

Hi,

here's a patch adding some winsock, IPX and Netware related definitions.
It was necessary to compile the Watcom Novell debug helper, but can be
useful for others too.

2002-08-25  Bart Oldeman  <bart.oldeman@btinternet.com>

	* include/nspapi.h (NS_*): Add defines.
	(SERVICE_*): Add defines.
	(SERVICE_ADDRESS): Add structure and typedefs.
	(SERVICE_ADDRESSES): Ditto.
	(SERVICE_INFO): Ditto.
	(LPSERVICE_ASYNC_INFO): Add typedef.
	(SetService, GetAddressByName): Add prototypes.
	(wtypes.h): Add include.
	* include/wsipx.h: New file.
	* include/svcguid.h: New file.
	* lib/wsock32.def (GetAddressByName@40): Export.
	(SetService@24): Likewise.

Index: include/nspapi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/nspapi.h,v
retrieving revision 1.2
diff -u -r1.2 nspapi.h
--- include/nspapi.h	9 Mar 2002 09:04:09 -0000	1.2
+++ include/nspapi.h	25 Aug 2002 16:06:52 -0000
@@ -3,10 +3,41 @@
 #if __GNUC__ >=3
 #pragma GCC system_header
 #endif
+#include <wtypes.h>

 #ifdef __cplusplus
 extern "C" {
 #endif
+
+#define NS_ALL		0
+
+#define NS_SAP		1
+#define NS_NDS		2
+#define NS_PEER_BROWSE	3
+
+#define NS_TCPIP_LOCAL	10
+#define NS_TCPIP_HOSTS	11
+#define NS_DNS		12
+#define NS_NETBT	13
+#define NS_WINS		14
+
+#define NS_NBP		20
+
+#define NS_MS		30
+#define NS_STDA		31
+#define NS_NTDS		32
+
+#define NS_X500		40
+#define NS_NIS		41
+#define NS_NISPLUS	42
+
+#define NS_WRQ		50
+
+#define SERVICE_REGISTER	1
+#define SERVICE_DEREGISTER	2
+#define SERVICE_FLUSH		3
+#define SERVICE_FLAG_HARD	0x00000002
+
 typedef struct _SOCKET_ADDRESS {
 	LPSOCKADDR lpSockaddr;
 	INT iSockaddrLength;
@@ -17,6 +48,35 @@
 	INT iSocketType;
 	INT iProtocol;
 } CSADDR_INFO,*PCSADDR_INFO,*LPCSADDR_INFO;
+typedef struct _SERVICE_ADDRESS {
+	DWORD dwAddressType;
+	DWORD dwAddressFlags;
+	DWORD dwAddressLength;
+	DWORD dwPrincipalLength;
+	BYTE *lpAddress;
+	BYTE *lpPrincipal;
+} SERVICE_ADDRESS;
+typedef struct _SERVICE_ADDRESSES {
+	DWORD dwAddressCount;
+	SERVICE_ADDRESS Addresses[1];
+} SERVICE_ADDRESSES, *PSERVICE_ADDRESSES, *LPSERVICE_ADDRESSES;
+typedef struct _SERVICE_INFO {
+	LPGUID lpServiceType;
+	LPTSTR lpServiceName;
+	LPTSTR lpComment;
+	LPTSTR lpLocale;
+	DWORD dwDisplayHint;
+	DWORD dwVersion;
+	DWORD dwTime;
+	LPTSTR lpMachineName;
+	LPSERVICE_ADDRESSES lpServiceAddress;
+	BLOB ServiceSpecificInfo;
+} SERVICE_INFO, *LPSERVICE_INFO;
+
+typedef void *LPSERVICE_ASYNC_INFO;
+INT WINAPI SetService(DWORD,DWORD,DWORD,LPSERVICE_INFO,LPSERVICE_ASYNC_INFO,LPDWORD);
+INT WINAPI GetAddressByName(DWORD,LPGUID,LPTSTR,LPINT,DWORD,LPSERVICE_ASYNC_INFO,LPVOID,LPDWORD,LPTSTR,LPDWORD);
+
 #ifdef __cplusplus
 }
 #endif
Index: lib/wsock32.def
===================================================================
RCS file: /cvs/src/src/winsup/w32api/lib/wsock32.def,v
retrieving revision 1.1.1.1
diff -u -r1.1.1.1 wsock32.def
--- lib/wsock32.def	17 Feb 2000 19:38:32 -0000	1.1.1.1
+++ lib/wsock32.def	25 Aug 2002 16:06:53 -0000
@@ -4,6 +4,7 @@
 EnumProtocolsA@12
 EnumProtocolsW@12
 GetAcceptExSockaddrs@32
+GetAddressByName@40
 GetAddressByNameA@40
 GetAddressByNameW@40
 GetNameByTypeA@12
@@ -13,6 +14,7 @@
 GetTypeByNameA@8
 GetTypeByNameW@8
 NPLoadNameSpaces@12
+SetService@24
 SetServiceA@24
 SetServiceW@24
 TransmitFile@28
--- /dev/null	Wed Apr 24 18:21:26 2002
+++ include/wsipx.h	Sun Aug 25 16:34:00 2002
@@ -0,0 +1,28 @@
+/* WSIPX.H - initially taken from the Wine project
+ */
+
+#ifndef _WSIPX_H
+#define _WSIPX_H
+#if __GNUC__ >=3
+#pragma GCC system_header
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif /* defined(__cplusplus) */
+
+#define NSPROTO_IPX	1000
+#define NSPROTO_SPX	1256
+#define NSPROTO_SPXII	1257
+
+typedef struct sockaddr_ipx {
+	short sa_family;
+	char sa_netnum[4];
+	char sa_nodenum[6];
+	unsigned short sa_socket;
+} SOCKADDR_IPX, *PSOCKADDR_IPX, *LPSOCKADDR_IPX;
+
+#ifdef __cplusplus
+}
+#endif
+#endif
--- /dev/null	Wed Apr 24 18:21:26 2002
+++ include/svcguid.h	Sun Aug 25 16:54:58 2002
@@ -0,0 +1,33 @@
+#ifndef _SVCGUID_H
+#define _SVCGUID_H
+#if __GNUC__ >=3
+#pragma GCC system_header
+#endif
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+#define SVCID_NETWARE(_SapId) \
+	{ (0x000B << 16) | (_SapId), 0, 0, { 0xC0,0,0,0,0,0,0,0x46 } }
+
+#define SAPID_FROM_SVCID_NETWARE(_g) \
+	((WORD)(_g->Data1 & 0xFFFF))
+
+#define SET_NETWARE_SVCID(_g,_SapId) { \
+	(_g)->Data1 = (0x000B << 16 ) | (_SapId); \
+	(_g)->Data2 = 0; \
+	(_g)->Data3 = 0; \
+	(_g)->Data4[0] = 0xC0; \
+	(_g)->Data4[1] = 0x0; \
+	(_g)->Data4[2] = 0x0; \
+	(_g)->Data4[3] = 0x0; \
+	(_g)->Data4[4] = 0x0; \
+	(_g)->Data4[5] = 0x0; \
+	(_g)->Data4[6] = 0x0; \
+	(_g)->Data4[7] = 0x46; }
+
+#ifdef __cplusplus
+}
+#endif
+#endif
