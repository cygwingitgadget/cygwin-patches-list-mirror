From: "Norman Vine" <nhv@cape.com>
To: <cygwin-patches@sources.redhat.com>
Cc: "'DJ Delorie'" <dj@delorie.com>
Subject: RE: Installation problems
Date: Wed, 02 Aug 2000 09:26:00 -0000
Message-id: <000001bffc9e$73977000$2037ba8c@nhv>
References: <200008021500.LAA05521@envy.delorie.com>
X-SW-Source: 2000-q3/msg00035.html

DJ Delorie writes:
>
>I don't suppose you could post that, as a diff, with a ChangeLog, to
>cygwin-patches@sources.redhat.com?  Cc me as well.
>
>Yes, I know it's trivial, but if you do it that way I can just apply
>it as-is.

Sure


========== CUT HERE ==========
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/ChangeLog,v
retrieving revision 1.67
diff -d -w -u -r1.67 ChangeLog
--- ChangeLog	2000/08/02 01:45:50	1.67
+++ ChangeLog	2000/08/02 16:23:06
@@ -1,3 +1,7 @@
+2000-08-02  Norman Vine <nhv@yahoo,com>
+
+	* msg.cc (mbox): added MB_TOPMOST to MessageBox type flags
+
 2000-08-01  DJ Delorie  <dj@redhat.com>
 
 	* postinstall.cc (each): don't rename files we ignore
Index: msg.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/msg.cc,v
retrieving revision 1.2
diff -d -w -u -r1.2 msg.cc
--- msg.cc	2000/07/17 20:48:00	1.2
+++ msg.cc	2000/08/02 16:23:07
@@ -40,7 +40,7 @@
     ExitProcess (0);
 
   vsprintf (buf, fmt, args);
-  return MessageBox (0, buf, "Cygwin Setup", type);
+  return MessageBox (0, buf, "Cygwin Setup", type | MB_TOPMOST);
 }
 
 void
