From: Brian Keener <bkeener@thesoftwaresource.com>
To: cygwin-patches <cygwin-patches@cygwin.com>
Subject: [patch] change to choose.cc in setup.exe for Redownload/Sources crashes
Date: Thu, 17 May 2001 19:10:00 -0000
Message-id: <VA.0000078b.0055922a@thesoftwaresource.com>
X-SW-Source: 2001-q2/msg00256.html

2001-05-07  Brian Keener <bkeener@thesoftwaresource.com>

   * choose.cc (do_choose): Fix incorrect assignment of trust setting
   to use when Redownload or Sources Only selected.    
                                           

Index: choose.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/choose.cc,v
retrieving revision 2.19
diff -u -p -w -r2.19 choose.cc
--- choose.cc  2001/05/11 02:39:27 2.19
+++ choose.cc  2001/05/18 01:39:07
@@ -1059,7 +1059,10 @@ do_choose (HINSTANCE h)
 
         case TRUST_REDO:
           package[i].action = ACTION_REDO;
-          package[i].trust = extra[i].chooser[extra[i].pick].trust;
+    if (0 <= extra[i].which_is_installed <= TRUST_TEST)
+      package[i].trust = extra[i].which_is_installed;
+    else 
+      package[i].trust = TRUST_CURR;
           break;
 
         case TRUST_UNINSTALL:
@@ -1070,7 +1073,10 @@ do_choose (HINSTANCE h)
 
         case TRUST_SRC_ONLY:
           package[i].action = ACTION_SRC_ONLY;
-          package[i].trust = extra[i].chooser[extra[i].pick].trust;
+        if (0 <= extra[i].which_is_installed <= TRUST_TEST)
+      package[i].trust = extra[i].which_is_installed;
+    else 
+      package[i].trust = TRUST_CURR;
           package[i].srcaction = SRCACTION_YES;
           break;
 


