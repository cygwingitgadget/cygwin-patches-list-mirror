Return-Path: <cygwin-patches-return-2676-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 32210 invoked by alias); 19 Jul 2002 19:13:59 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 32194 invoked from network); 19 Jul 2002 19:13:58 -0000
Date: Fri, 19 Jul 2002 12:13:00 -0000
From: Bart Oldeman <bart.oldeman@btinternet.com>
X-X-Sender:  <enbeo@enm-bo-lt.enm.bris.ac.uk>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [PATCH] w32api (some general, some Watcom related)
Message-ID: <Pine.LNX.4.33.0207192007530.1882-100000@enm-bo-lt.enm.bris.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-SW-Source: 2002-q3/txt/msg00124.txt.bz2

Hi,

here are some misc. fixes:
I hope the shlobj.h fix survives high ascii in this email.

I think this now makes w32api fully Watcom compatible; further changes
will be real improvements ;)

Bart

2002-07-17   Bart Oldeman  <bart.oldeman@btinternet.com>

	* include/shlobj.h (FCIDM_MENU_FAVORITES): remove bogus character.
	* include/windef.h: (PACKED) Watcom compatible #define for
	structure packing
	* include/wincon.h (KEY_EVENT_RECORD): use the above
	* include/winsock2.h (struct sockaddr): use __int64 instead of
	long long
	* include/kernel32.c (GetCurrentFiber): Watcom does not need
	external *Fiber library functions.
	* include/kernel32.c (GetFiberData): likewise

diff -urp w32api/include/shlobj.h w32api2/include/shlobj.h
--- w32api/include/shlobj.h	Fri Jul 19 19:41:07 2002
+++ w32api2/include/shlobj.h	Fri Jul 19 19:39:57 2002
@@ -216,7 +216,7 @@ extern "C" {
 #define FCIDM_MENU_HELP	(FCIDM_GLOBALFIRST+0x0100)
 #define FCIDM_MENU_FIND	(FCIDM_GLOBALFIRST+0x0140)
 #define FCIDM_MENU_EXPLORE	(FCIDM_GLOBALFIRST+0x0150)
-#define FCIDM_MENU_FAVORITES	(FCIDM_GLOBALFIRST+0x0170)=A0
+#define FCIDM_MENU_FAVORITES	(FCIDM_GLOBALFIRST+0x0170)
 #define FCIDM_TOOLBAR	FCIDM_BROWSERFIRST
 #define FCIDM_STATUS	(FCIDM_BROWSERFIRST+1)
 #define SBSP_DEFBROWSER	0
diff -urp w32api/include/wincon.h w32api2/include/wincon.h
--- w32api/include/wincon.h	Wed Jun 19 02:15:45 2002
+++ w32api2/include/wincon.h	Fri Jul 19 19:28:40 2002
@@ -80,7 +80,8 @@ typedef struct _CONSOLE_SCREEN_BUFFER_IN
 	COORD	dwMaximumWindowSize;
 } CONSOLE_SCREEN_BUFFER_INFO,*PCONSOLE_SCREEN_BUFFER_INFO;
 typedef BOOL(CALLBACK *PHANDLER_ROUTINE)(DWORD);
-typedef struct _KEY_EVENT_RECORD {
+/* gcc's alignment is not what win32 expects */
+typedef PACKED(struct _KEY_EVENT_RECORD {
 	BOOL bKeyDown;
 	WORD wRepeatCount;
 	WORD wVirtualKeyCode;
@@ -90,12 +91,7 @@ typedef struct _KEY_EVENT_RECORD {
 		CHAR AsciiChar;
 	} uChar;
 	DWORD dwControlKeyState;
-}
-#ifdef __GNUC__
-/* gcc's alignment is not what win32 expects */
- PACKED
-#endif
-KEY_EVENT_RECORD;
+}) KEY_EVENT_RECORD;

 typedef struct _MOUSE_EVENT_RECORD {
 	COORD dwMousePosition;
diff -urp w32api/include/windef.h w32api2/include/windef.h
--- w32api/include/windef.h	Wed Jul 17 04:37:45 2002
+++ w32api2/include/windef.h	Fri Jul 19 19:51:15 2002
@@ -50,7 +50,7 @@ extern "C" {
 #endif

 #ifdef __GNUC__
-#define PACKED __attribute__((packed))
+#define PACKED(e) e __attribute__((packed))
 #ifndef _fastcall
 #define _fastcall __attribute__((fastcall))
 #endif
@@ -76,7 +76,7 @@ extern "C" {
 #define _declspec(e) __attribute__((e))
 #endif
 #elif defined(__WATCOMC__)
-#define PACKED
+#define PACKED(e) _Packed e
 #else
 #define PACKED
 #define _cdecl
diff -urp w32api/include/winsock2.h w32api2/include/winsock2.h
--- w32api/include/winsock2.h	Fri May  3 04:01:51 2002
+++ w32api2/include/winsock2.h	Fri Jul 19 19:31:30 2002
@@ -333,7 +333,7 @@ struct sockaddr {
 struct sockaddr_storage {
     short ss_family;
     char __ss_pad1[6];    /* pad to 8 */
-    long long __ss_align; /* force alignment */
+    __int64 __ss_align; /* force alignment */
     char __ss_pad2[112];  /* pad to 128 */
 };

diff -urp w32api/lib/kernel32.c w32api2/lib/kernel32.c
--- w32api/lib/kernel32.c	Mon Dec  3 19:59:34 2001
+++ w32api2/lib/kernel32.c	Fri Jul 19 19:30:12 2002
@@ -25,7 +25,7 @@ void* GetFiberData(void)
     return ret;
 }

-#else
+#elif !defined (__WATCOMC__)

 void* GetCurrentFiber(void)
 {
