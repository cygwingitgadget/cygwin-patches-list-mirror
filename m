From: Mumit Khan <khan@NanoTech.Wisc.EDU>
To: cygwin-patches@sourceware.cygnus.com
Subject: wchar prototype tweaks
Date: Sat, 06 May 2000 08:40:00 -0000
Message-id: <200005061540.KAA06446@pluto.xraylith.wisc.edu>
X-SW-Source: 2000-q2/msg00038.html

Trivial prototype fixes. Wish I had the time to rig up a more complete
wchar implementation, sigh.

2000-05-06  Mumit Khan  <khan@xraylith.wisc.edu>

	* include/wchar.h (wcscmp, wcslen): Fix prototypes.

Index: include/wchar.h
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/include/wchar.h,v
retrieving revision 1.1.1.1
diff -u -3 -p -r1.1.1.1 wchar.h
--- wchar.h	2000/02/17 19:38:31	1.1.1.1
+++ wchar.h	2000/05/06 15:36:54
@@ -19,8 +19,8 @@ details. */
 
 __BEGIN_DECLS
 
-int wcscmp (wchar_t *__s1, wchar_t *__s2);
-int wcslen (wchar_t *__s1);
+int wcscmp (const wchar_t *__s1, const wchar_t *__s2);
+size_t wcslen (const wchar_t *__s1);
 
 __END_DECLS
 
Regards,
Mumit
