Return-Path: <cygwin-patches-return-2860-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 5336 invoked by alias); 25 Aug 2002 21:59:00 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5317 invoked from network); 25 Aug 2002 21:58:59 -0000
Date: Sun, 25 Aug 2002 14:59:00 -0000
From: Bart Oldeman <bart.oldeman@btinternet.com>
X-X-Sender:  <enbeo@enm-bo-lt.enm.bris.ac.uk>
To: =?iso-8859-1?q?Danny=20Smith?= <danny_r_smith_2001@yahoo.co.nz>
cc:  <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] winsock related changes for w32api
In-Reply-To: <20020825204937.24049.qmail@web14502.mail.yahoo.com>
Message-ID: <Pine.LNX.4.33.0208252247200.9978-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2002-q3/txt/msg00308.txt.bz2

On Mon, 26 Aug 2002, Danny Smith wrote:

>  --- Bart Oldeman <bart.oldeman@btinternet.com> wrote: > Hi,
> >
> > here's a patch adding some winsock, IPX and Netware related definitions.
> > It was necessary to compile the Watcom Novell debug helper, but can be
> > useful for others too.
> >
> > 2002-08-25  Bart Oldeman  <bart.oldeman@btinternet.com>
> >
> > 	* include/nspapi.h (NS_*): Add defines.
> > 	(SERVICE_*): Add defines.
> > 	(SERVICE_ADDRESS): Add structure and typedefs.
> > 	(SERVICE_ADDRESSES): Ditto.
> > 	(SERVICE_INFO): Ditto.
> > 	(LPSERVICE_ASYNC_INFO): Add typedef.
> > 	(SetService, GetAddressByName): Add prototypes.
>
> Shouldn't structs and protos  be Unicoded properly, rather than using LPTSTR

LPTSTR should be fine, since:
<winnt.h>:
typedef TCHAR *LPTCH,*PTSTR,*LPTSTR,*LP,*PTCHAR;
and
#ifdef UNICODE
typedef WCHAR TCHAR;
#else
typedef CHAR TCHAR;
#endif

> Are you sure?  Including wtypes.h can bring in a lot of unnessary COM/OLE
> through rpc api.

Well I needed it for BLOB - I saw the same thing happened in winsock2.h,
which already includes nspapi.h, so I moved the winsock2.h BLOB typedef
to nspapi.h. and now wtypes.h is not necessary anymore.

> > 	* lib/wsock32.def (GetAddressByName@40): Export.
> > 	(SetService@24): Likewise.
>
> The Unicode stubs are already there.  Just need the mapping in nspapi.h.

Yes. I changed it now. The second try is below.

2002-08-25  Bart Oldeman  <bart.oldeman@btinternet.com>

	* include/winsock2.h (BLOB): Moved structure and typedef to nspapi.h.
 	* include/nspapi.h (BLOB): Moved structure and typedef from winsock2.h.
	(NS_*): Add defines.
 	(SERVICE_*): Ditto.
 	(SERVICE_ADDRESS): Add structure and typedefs.
 	(SERVICE_ADDRESSES): Ditto.
 	(SERVICE_INFO): Ditto.
 	(LPSERVICE_ASYNC_INFO): Add typedef.
 	(SetService[AW], GetAddressByName[AW]): Add prototypes.
 	* include/wsipx.h: New file.
 	* include/svcguid.h: New file.

Index: include/nspapi.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/nspapi.h,v
retrieving revision 1.2
diff -u -r1.2 nspapi.h
--- include/nspapi.h	9 Mar 2002 09:04:09 -0000	1.2
+++ include/nspapi.h	25 Aug 2002 21:43:12 -0000
@@ -7,6 +7,43 @@
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
+#ifndef __BLOB_T_DEFINED /* also in wtypes.h */
+#define __BLOB_T_DEFINED
+typedef struct _BLOB {
+	ULONG   cbSize;
+	BYTE    *pBlobData;
+} BLOB,*PBLOB,*LPBLOB;
+#endif
 typedef struct _SOCKET_ADDRESS {
 	LPSOCKADDR lpSockaddr;
 	INT iSockaddrLength;
@@ -17,6 +54,44 @@
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
+INT WINAPI SetServiceA(DWORD,DWORD,DWORD,LPSERVICE_INFO,LPSERVICE_ASYNC_INFO,LPDWORD);
+INT WINAPI SetServiceW(DWORD,DWORD,DWORD,LPSERVICE_INFO,LPSERVICE_ASYNC_INFO,LPDWORD);
+INT WINAPI GetAddressByNameA(DWORD,LPGUID,LPTSTR,LPINT,DWORD,LPSERVICE_ASYNC_INFO,LPVOID,LPDWORD,LPTSTR,LPDWORD);
+INT WINAPI GetAddressByNameW(DWORD,LPGUID,LPTSTR,LPINT,DWORD,LPSERVICE_ASYNC_INFO,LPVOID,LPDWORD,LPTSTR,LPDWORD);
+#ifdef UNICODE
+#define SetService SetServiceW
+#define GetAddressByName GetAddressByNameW
+#else
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
+++ include/winsock2.h	25 Aug 2002 21:43:20 -0000
@@ -750,14 +750,6 @@
     SOCKET_ADDRESS  Address[1];
 } SOCKET_ADDRESS_LIST, * LPSOCKET_ADDRESS_LIST;

-#ifndef __BLOB_T_DEFINED /* also in wtypes.h */
-#define __BLOB_T_DEFINED
-typedef struct _BLOB {
-	ULONG	cbSize;
-	BYTE	*pBlobData;
-} BLOB,*PBLOB,*LPBLOB;
-#endif
-
 typedef struct _WSAQuerySetA
 {
 	DWORD	dwSize;
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
