Return-Path: <cygwin-patches-return-2000-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28606 invoked by alias); 26 Mar 2002 10:36:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28583 invoked from network); 26 Mar 2002 10:36:54 -0000
Message-ID: <3CA04F45.1A33644@cistron.nl>
Date: Tue, 26 Mar 2002 02:43:00 -0000
From: Ton van Overbeek <tvoverbe@cistron.nl>
X-Accept-Language: en, en-US, en-GB, nl, sv
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: SETUP(PickPackageLine.cc): Patch for 'chopped of characters' problem 
 (RESEND)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2002-q1/txt/msg00357.txt.bz2

This time without linewrapping (I hope)

Here is a patch for the 'chopped off characters in the chooser' problem when
using Large Fonts. I mentioned this problem in my message
http://cygwin.com/ml/cygwin/2002-03/msg01200.html and also saw it appearing
on cygwin-apps yesterday (with a picture illustrating the problem under
windows XP) in http://cygwin.com/ml/cygwin-apps/2002-03/msg00247.html.

The original code uses a fixed clip rectangle height of 11, which is the
height of the used bitmaps for the boxes in the line. This is OK when using
small fonts, but when using large fonts textheight is larger than 11, hence
the chopping off at the top.

Here is a changelogentry and the patch:

Changelog-entry

2002-03-26 Ton van Overbeek (tvoverbe@cistron.nl)

* PickPackageLine.cc (PickPackageline::paint) Adjust clipping rectangle
  to textheight, so large fonts work.

and here is the diff:
------------------------------------------------------------------------
--- PickPackageLine.cc-orig     Wed Mar 20 08:16:38 2002
+++ PickPackageLine.cc  Tue Mar 26 11:09:14 2002
@@ -43,7 +43,8 @@ void
 PickPackageLine::paint (HDC hdc, int x, int y, int row, int show_cat)
 {
   int r = y + row * theView.row_height;
-  int by = r + theView.tm.tmHeight - 11;
+  int rb = r + theView.tm.tmHeight;
+  int by = rb - 11; // top of box images
   int oldDC = SaveDC (hdc);
   if (!oldDC)
     return;
@@ -78,9 +79,9 @@ PickPackageLine::paint (HDC hdc, int x, 
   if (pkg.installed)
     {
       IntersectClipRect (hdc, x + theView.headers[theView.current_col].x,
-                        by,
+                        r,
                         x + theView.headers[theView.current_col].x +
-                        theView.headers[theView.current_col].width, by + 11);
+                        theView.headers[theView.current_col].width, rb);
       TextOut (hdc,
               x + theView.headers[theView.current_col].x + HMARGIN / 2, r,
               pkg.installed->Canonical_version ().cstr_oneuse(),
@@ -93,9 +94,9 @@ PickPackageLine::paint (HDC hdc, int x, 
 
   String s = pkg.action_caption ();
   IntersectClipRect (hdc, x + theView.headers[theView.new_col].x,
-                    by,
+                    r,
                     x + theView.headers[theView.new_col].x +
-                    theView.headers[theView.new_col].width, by + 11);
+                    theView.headers[theView.new_col].width, rb);
   TextOut (hdc,
           x + theView.headers[theView.new_col].x + HMARGIN / 2 +
           NEW_COL_SIZE_SLOP, r, s.cstr_oneuse(), s.size());
@@ -138,9 +139,9 @@ PickPackageLine::paint (HDC hdc, int x, 
       int index = 1;
       if (!pkg.Categories[1]->key.name.casecompare( "All"))
        index = 2;
-      IntersectClipRect (hdc, x + theView.headers[theView.cat_col].x, by,
+      IntersectClipRect (hdc, x + theView.headers[theView.cat_col].x, r,
                         x + theView.headers[theView.cat_col].x +
-                        theView.headers[theView.cat_col].x, by + 11);
+                        theView.headers[theView.cat_col].x, rb);
       TextOut (hdc, x + theView.headers[theView.cat_col].x + HMARGIN / 2, r,
               pkg.Categories[index]->key.name.cstr_oneuse(),
               pkg.Categories[index]->key.name.size());
@@ -150,9 +151,9 @@ PickPackageLine::paint (HDC hdc, int x, 
   s = pkg.name;
   if (pkg.SDesc ().size())
     s += String(": ") + pkg.SDesc ();
-  IntersectClipRect (hdc, x + theView.headers[theView.pkg_col].x, by,
+  IntersectClipRect (hdc, x + theView.headers[theView.pkg_col].x, r,
                     x + theView.headers[theView.pkg_col].x +
-                    theView.headers[theView.pkg_col].width, by + 11);
+                    theView.headers[theView.pkg_col].width, rb);
   TextOut (hdc, x + theView.headers[theView.pkg_col].x + HMARGIN / 2, r, s.cstr_oneuse(),
           s.size());
   DeleteObject (oldClip);
------------------------------------------------------------------------


Ton van Overbeek
