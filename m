From: Jeffrey Juliano <juliano@cs.unc.edu>
To: cygwin-patches@sources.redhat.com
Subject: fix: setup.exe crash when "Nothing to Install/Update"
Date: Wed, 06 Sep 2000 21:38:00 -0000
Message-id: <1919463230.968287104@dsl-64-34-95-237.telocity.com>
X-SW-Source: 2000-q3/msg00072.html

setup.exe crashes if the user clicks in the chooser on the row labeled 
"Nothing to Install/Update", middle column (labeled "New").

paint() handles this situation as a special case, so I changed list_click() 
to use the same logic.

-jeff


2000-09-07  Jeffrey Juliano  <juliano@cs.unc.edu>

	* choose.cc (list_click): Check for nindexes==0; if so, return.


Index: choose.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
retrieving revision 2.5
diff -u -p -r2.5 choose.cc
--- choose.cc   2000/08/30 01:05:42     2.5
+++ choose.cc   2000/09/07 04:28:48
@@ -239,6 +239,9 @@ list_click (HWND hwnd, BOOL dblclk, int
 {
   int r;

+  if (nindexes == 0)
+    return 0;
+
   if (y < header_height)
     return 0;
   x += scroll_ulc_x;

