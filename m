Return-Path: <cygwin-patches-return-2869-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 2710 invoked by alias); 26 Aug 2002 17:56:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2685 invoked from network); 26 Aug 2002 17:56:54 -0000
Date: Mon, 26 Aug 2002 10:56:00 -0000
From: Bart Oldeman <bart.oldeman@btinternet.com>
X-X-Sender:  <enbeo@enm-bo-lt.enm.bris.ac.uk>
To: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
cc:  <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] winsock related changes for w32api
In-Reply-To: <20020826084803.41470.qmail@web14504.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0208261813120.17877-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00317.txt.bz2

On Mon, 26 Aug 2002, Danny Smith wrote:

> No it is not fine. We need explict A and W SERVICE_INFO structure definitions.

OK - I see what you mean and corrected that now.

> This is not fine either. Did you read the FIXME in winsock2.h next to include
> #<nspapi.h.>  My reading of the Windows Sockest 2.2 spec is that is not meant
> to depend on other api's.
>
> The FIXME refers to getting rid of dependence of winsock on service provider
> api, not reinforcing that dependence

I tried addressing what the FIXME said, by defining a __CSADDR_T_DEFINED
guard.

third try...

Bart

2002-08-26  Bart Oldeman  <bart.oldeman@btinternet.com>

        * include/winsock2.h (SOCKET_ADDRESS): define if
	__CSADDR_T_DEFINED is not defined (copied from nspapi.h). Removed
	FIXME comment.
        (CSADDR_INFO): Ditto.
        * include/nspapi.h (SOCKET_ADDRESS) Only define if
	__CSADDR_T_DEFINED is not defined.
	(CSADDR_INFO): Ditto.
        (BLOB): Added structure and typedef if not already defined.
        (NS_*): Add defines.
        (SERVICE_*): Ditto.
        (SERVICE_ADDRESS): Add structure and typedefs.
        (SERVICE_ADDRESSES): Ditto.
        (SERVICE_INFO[AW]): Ditto, and add UNICODE mappings.
        (LPSERVICE_ASYNC_INFO): Add typedef.
        (SetService[AW], GetAddressByName[AW]): Add prototypes and UNICODE
	mappings.
        * include/wsipx.h: New file.
        * include/svcguid.h: New file.

Index: include/nspapi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/nspapi.h,v
retrieving revision 1.2
diff -u -r1.2 nspapi.h
--- include/nspapi.h	9 Mar 2002 09:04:09 -0000	1.2
+++ include/nspapi.h	26 Aug 2002 17:46:23 -0000
@@ -7,6 +7,39 @@
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
+#if defined (_WINSOCK_H) || defined (_WINSOCK2_H) /* needed for LPSOCKADDR */
+#ifndef __CSADDR_T_DEFINED /* also in winsock2.h, but not in winsock.h */
+#define __CSADDR_T_DEFINED
 typedef struct _SOCKET_ADDRESS {
 	LPSOCKADDR lpSockaddr;
 	INT iSockaddrLength;
@@ -17,6 +50,71 @@
 	INT iSocketType;
 	INT iProtocol;
 } CSADDR_INFO,*PCSADDR_INFO,*LPCSADDR_INFO;
+#endif
+#endif
+
+#ifndef __BLOB_T_DEFINED /* also in wtypes.h and winsock2.h */
+#define __BLOB_T_DEFINED
+typedef struct _BLOB {
+	ULONG	cbSize;
+	BYTE	*pBlobData;
+} BLOB,*PBLOB,*LPBLOB;
+#endif
+
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
+typedef struct _SERVICE_INFOA {
+	LPGUID lpServiceType;
+	LPSTR lpServiceName;
+	LPSTR lpComment;
+	LPSTR lpLocale;
+	DWORD dwDisplayHint;
+	DWORD dwVersion;
+	DWORD dwTime;
+	LPSTR lpMachineName;
+	LPSERVICE_ADDRESSES lpServiceAddress;
+	BLOB ServiceSpecificInfo;
+} SERVICE_INFOA, *LPSERVICE_INFOA;
+typedef struct _SERVICE_INFOW {
+	LPGUID lpServiceType;
+	LPWSTR lpServiceName;
+	LPWSTR lpComment;
+	LPWSTR lpLocale;
+	DWORD dwDisplayHint;
+	DWORD dwVersion;
+	DWORD dwTime;
+	LPWSTR lpMachineName;
+	LPSERVICE_ADDRESSES lpServiceAddress;
+	BLOB ServiceSpecificInfo;
+} SERVICE_INFOW, *LPSERVICE_INFOW;
+
+typedef void *LPSERVICE_ASYNC_INFO;
+INT WINAPI SetServiceA(DWORD,DWORD,DWORD,LPSERVICE_INFOA,LPSERVICE_ASYNC_INFO,LPDWORD);
+INT WINAPI SetServiceW(DWORD,DWORD,DWORD,LPSERVICE_INFOA,LPSERVICE_ASYNC_INFO,LPDWORD);
+INT WINAPI GetAddressByNameA(DWORD,LPGUID,LPSTR,LPINT,DWORD,LPSERVICE_ASYNC_INFO,LPVOID,LPDWORD,LPTSTR,LPDWORD);
+INT WINAPI GetAddressByNameW(DWORD,LPGUID,LPWSTR,LPINT,DWORD,LPSERVICE_ASYNC_INFO,LPVOID,LPDWORD,LPTSTR,LPDWORD);
+#ifdef UNICODE
+typedef SERVICE_INFOW SERVICE_INFO, *LPSERVICE_INFO;
+#define _SERVICE_INFO SERVICE_INFOW
+#define SetService SetServiceW
+#define GetAddressByName GetAddressByNameW
+#else
+typedef SERVICE_INFOA SERVICE_INFO, *LPSERVICE_INFO;
+#define _SERVICE_INFO SERVICE_INFOA
+#define SetService SetServiceA
+#define GetAddressByName GetAddressByNameA
+#endif
+
 #ifdef __cplusplus
 }
 #endif
Index: include/winsock2.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winsock2.h,v
retrieving revision 1.17
diff -u -r1.17 winsock2.h
--- include/winsock2.h	20 Aug 2002 00:36:09 -0000	1.17
+++ include/winsock2.h	26 Aug 2002 17:46:32 -0000
@@ -734,23 +734,26 @@
 	WSAECOMPARATOR	ecHow;
 } WSAVERSION, *PWSAVERSION, *LPWSAVERSION;

-/*
- * FIXME: nspapi.h has definition of SOCKET_ADDRESS needed by
- * SOCKET_ADDRESS_LIST and  LPCSADDR_INFO, needed in WSAQuery
- * but itself needs LPSOCKADDR which is defined earlier in this file
- * Incuding nspapi.h here works for now, but may need to change
- * as nspapi.h actually starts to define the Name Space Provider API.
- * MSDN docs say that SOCKET_ADDRESS is defined in winsock2.h.
- */
-
-#include <nspapi.h>
+#ifndef __CSADDR_T_DEFINED /* also in nspapi.h */
+#define __CSADDR_T_DEFINED
+typedef struct _SOCKET_ADDRESS {
+	LPSOCKADDR lpSockaddr;
+	INT iSockaddrLength;
+} SOCKET_ADDRESS,*PSOCKET_ADDRESS,*LPSOCKET_ADDRESS;
+typedef struct _CSADDR_INFO {
+	SOCKET_ADDRESS LocalAddr;
+	SOCKET_ADDRESS RemoteAddr;
+	INT iSocketType;
+	INT iProtocol;
+} CSADDR_INFO,*PCSADDR_INFO,*LPCSADDR_INFO;
+#endif

 typedef struct _SOCKET_ADDRESS_LIST {
     INT             iAddressCount;
     SOCKET_ADDRESS  Address[1];
 } SOCKET_ADDRESS_LIST, * LPSOCKET_ADDRESS_LIST;

-#ifndef __BLOB_T_DEFINED /* also in wtypes.h */
+#ifndef __BLOB_T_DEFINED /* also in wtypes.h and nspapi.h */
 #define __BLOB_T_DEFINED
 typedef struct _BLOB {
 	ULONG	cbSize;
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
