From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sources.redhat.com
Subject: [PATCH] fix winuser.h typo
Date: Tue, 08 Aug 2000 07:29:00 -0000
Message-id: <20000808102824.A20406@cygnus.com>
X-SW-Source: 2000-q3/msg00037.html

Tue Aug  8 10:25:14 2000  Christopher Faylor <cgf@cygnus.com>

	* include/winuser.h: Correct PCWPSTRUCT typo.
	(discovered by Axel Riese)

Index: include/winuser.h
===================================================================
RCS file: /cvs/src/src/winsup/w32api/include/winuser.h,v
retrieving revision 1.2
diff -u -p -r1.2 winuser.h
--- winuser.h	2000/04/25 19:13:51	1.2
+++ winuser.h	2000/08/08 14:26:39
@@ -1948,7 +1948,7 @@ typedef struct tagCWPSTRUCT {
 	WPARAM wParam;
 	UINT message;
 	HWND hwnd;
-} CWPSTRUCT,*PWCWPSTRUCT;
+} CWPSTRUCT,*PCWPSTRUCT;
 typedef struct tagDEBUGHOOKINFO {
 	DWORD idThread;
 	DWORD idThreadInstaller;
