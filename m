From: Danny Smith <danny_r_smith_2001@yahoo.co.nz>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: _ANONYMOUS_STRUCT (again)
Date: Sun, 09 Sep 2001 21:48:00 -0000
Message-id: <20010910044816.4205.qmail@web14509.mail.yahoo.com>
X-SW-Source: 2001-q3/msg00113.html

The last change to the anonymous struct in LARGE_INTEGER in winnt.h,
doesn't make sense to me.

Sat Sep  1 10:40:37 2001  Christopher Faylor <cgf@cygnus.com>

	* include/winnt.h: Use defined(_ANONYMOUS_STRUCT) to determine if
	anonymous structs are available rather than just testing preprocessor
	variable directly.



 _ANONYMOUS_STRUCT is always defined in windows.h, so the
#if defined(_ANONYMOUS_STRUCT) conditional doesn't do anything.  
If you compile this

#define NONMAMELESSUNION
#include <windows.h>

with current CVS winnt.h, the _[U]LARGE_INTEGER structs throw pedantic
warnings.

If you don't like the #if _ANONYMOUS_STRUCT syntax (which doesn't
cause any problems for me with 3.0.1 or with 2.95.3, as long as I
include windows.h first), here is a macro guard that actually does
something.

I've also picked up another nameless union that wasn't protected.

Now, if we are really serious about pedantic warnings,we need to
protect against all the non-ANSI bit-fields in w32api structs.

Danny

ChangeLog

2001-09-10  Danny Smith  <dannysmith@users.sourceforge.net>
 	* include/winnt.h (_[U]LARGE_INTEGER): Protect nameless struct with
	!defined(NONAMELESSUNION), rather than defined(_ANONYMOUS_STRUCT).
	(_REPARSE_DATA_BUFFER): Name union field DUMMYUNIONNAME.

--- winnt.h.orig	Mon Sep 10 15:55:31 2001
+++ winnt.h	Mon Sep 10 16:06:55 2001
@@ -1705,7 +1705,7 @@ typedef union _LARGE_INTEGER {
     DWORD LowPart;
     LONG  HighPart;
   } u;
-#if defined(_ANONYMOUS_STRUCT) || defined(__cplusplus)
+#if ! defined(NONAMELESSUNION) || defined(__cplusplus)
   struct {
     DWORD LowPart;
     LONG  HighPart;
@@ -1718,7 +1718,7 @@ typedef union _ULARGE_INTEGER {
     DWORD LowPart;
     DWORD HighPart;
   } u;
-#if defined(_ANONYMOUS_STRUCT) || defined(__cplusplus)
+#if ! defined(NONAMELESSUNION) || defined(__cplusplus)
   struct {
     DWORD LowPart;
     DWORD HighPart;
@@ -2502,7 +2502,7 @@ typedef struct _REPARSE_DATA_BUFFER {
 		struct {
 			BYTE   DataBuffer[1];
 		} GenericReparseBuffer;
-	};
+	} DUMMYUNIONNAME;
 } REPARSE_DATA_BUFFER, *PREPARSE_DATA_BUFFER;
 typedef struct _REPARSE_GUID_DATA_BUFFER {
 	DWORD  ReparseTag;

_____________________________________________________________________________
http://messenger.yahoo.com.au - Yahoo! Messenger
- Voice chat, mail alerts, stock quotes and favourite news and lots more!
