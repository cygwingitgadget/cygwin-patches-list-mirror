Return-Path: <cygwin-patches-return-2632-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 28841 invoked by alias); 11 Jul 2002 15:16:43 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28827 invoked from network); 11 Jul 2002 15:16:43 -0000
Date: Thu, 11 Jul 2002 08:16:00 -0000
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [Setup] [Patch] New Views for Skipped Packages and Installed Packages (keeps)
Message-Id: <VA.00000bee.0057f647@thesoftwaresource.com>
From: Brian Keener <bkeener@thesoftwaresource.com>
Reply-To: bkeener@thesoftwaresource.com
X-SW-Source: 2002-q3/txt/msg00080.txt.bz2

Here is a change for Setup for Two new views for skipped packages only and 
Installed packages not being updated (keeps). I hope it is something you can 
use - I find it helpful.

2002-07-11  Brian Keener  <bkeener@thesoftwaresource.com>

        * PickView.cc (PickView::views): Two new views added for Skipped
        packages and Installed Packages not requiring update.
        (PickView::set_headers () ): Ditto.
        (PickView::clear_view (void) ): Ditto.
        (PickView::views::caption () ): Two new caption added for the new
        views added for Skipped and Installed Packages.
        * PickView.h: Two new views for Skipped packages and Installed
        packages added to public class view.
        * choose.cc (set_view_mode): Two new views added for Skipped
        packages and Installed Packages not requiring update.


? autom4te.cache
? bz2lib/autom4te.cache
? libgetopt++/cfgaux
? libgetopt++/aclocal.m4
? libgetopt++/autom4te.cache
? libgetopt++/configure
? libgetopt++/Makefile.in
? libgetopt++/include/autoconf.h.in
? zlib/autom4te.cache
Index: PickView.cc
===================================================================
RCS file: /cvs/cygwin-apps/setup/PickView.cc,v
retrieving revision 2.9
diff -u -p -r2.9 PickView.cc
--- PickView.cc        8 Jul 2002 12:52:08 -0000       2.9
+++ PickView.cc        11 Jul 2002 14:23:38 -0000
@@ -47,8 +47,10 @@ static PickView::Header cat_headers[] = 
 // PickView:: views
 const PickView::views PickView::views::Unknown (0);
 const PickView::views PickView::views::PackageFull (1);
-const PickView::views PickView::views::Package = PickView::views (2);
-const PickView::views PickView::views::Category (3);
+const PickView::views PickView::views::Package (2);
+const PickView::views PickView::views::PackageKeeps (3);
+const PickView::views PickView::views::PackageSkips = PickView::views (4);
+const PickView::views PickView::views::Category (5);
 
 // DoInsertItem - inserts an item into a header control.
 // Returns the index of the new item.
@@ -82,7 +84,9 @@ PickView::set_headers ()
   if (view_mode == views::Unknown)
     return;
   if (view_mode == views::PackageFull ||
-      view_mode == views::Package)
+      view_mode == views::Package ||
+      view_mode == views::PackageKeeps ||
+      view_mode == views::PackageSkips)
     {
       headers = pkg_headers;
       current_col = 0;
@@ -154,6 +158,10 @@ PickView::views::caption ()
     case 2:
       return "Partial";
     case 3:
+      return "Installed";
+    case 4:
+      return "Skipped";
+    case 5:
       return "Category";
     default:
       return "";
@@ -210,7 +218,9 @@ PickView::clear_view (void)
   if (view_mode == views::Unknown)
     return;
   if (view_mode == views::PackageFull ||
-      view_mode == views::Package)
+      view_mode == views::Package ||
+      view_mode == views::PackageKeeps ||
+      view_mode == views::PackageSkips)
     contents.ShowLabel (false);
   else if (view_mode == views::Category)
     contents.ShowLabel ();
Index: PickView.h
===================================================================
RCS file: /cvs/cygwin-apps/setup/PickView.h,v
retrieving revision 2.4
diff -u -p -r2.4 PickView.h
--- PickView.h 27 Mar 2002 12:21:19 -0000      2.4
+++ PickView.h 11 Jul 2002 14:23:39 -0000
@@ -79,6 +79,8 @@ public:
     static const views Unknown;
     static const views PackageFull;
     static const views Package;
+    static const views PackageKeeps;
+    static const views PackageSkips;
     static const views Category;
     static const views NView;
       views ():_value (0)
@@ -87,7 +89,7 @@ public:
     views (int aInt)
     {
       _value = aInt;
-      if (_value < 0 || _value > 3)
+      if (_value < 0 || _value > 5)
       _value = 0;
     }
     views & operator++ ();
Index: choose.cc
===================================================================
RCS file: /cvs/cygwin-apps/setup/choose.cc,v
retrieving revision 2.105
diff -u -p -r2.105 choose.cc
--- choose.cc  7 Jul 2002 15:14:49 -0000       2.105
+++ choose.cc  11 Jul 2002 14:23:43 -0000
@@ -360,9 +360,28 @@ set_view_mode (HWND h, PickView::views m
       for (size_t n = 1; n <= db.packages.number (); n++)
       {
         packagemeta & pkg = *db.packages[n];
-        if ((!pkg.desired && pkg.installed)
+        if ((!pkg.desired && pkg.installed) 
             || (pkg.desired && (pkg.desired.picked () 
                                 || pkg.desired.sourcePackage().picked())))
+          chooser->insert_pkg (pkg);
+      }
+    }
+  else if (chooser->get_view_mode () == PickView::views::PackageKeeps)
+    {
+      for (size_t n = 1; n <= db.packages.number (); n++)
+      {
+        packagemeta & pkg = *db.packages[n];
+        if (pkg.installed && pkg.desired && !pkg.desired.picked() 
+            && !pkg.desired.sourcePackage().picked())
+          chooser->insert_pkg (pkg);
+      }
+    }
+  else if (chooser->get_view_mode () == PickView::views::PackageSkips)
+    {
+      for (size_t n = 1; n <= db.packages.number (); n++)
+      {
+        packagemeta & pkg = *db.packages[n];
+        if (!pkg.desired && !pkg.installed)
           chooser->insert_pkg (pkg);
       }
     }


