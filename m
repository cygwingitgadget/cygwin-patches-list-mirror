From: Jeffrey Juliano <juliano@cs.unc.edu>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall contribution
Date: Mon, 17 Jul 2000 12:18:00 -0000
Message-id: <39735BDE.ECBF7C9A@cs.unc.edu>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com> <396F377E.F3ADDEF6@cs.unc.edu> <200007141712.NAA14485@envy.delorie.com> <396F9057.83997899@cs.unc.edu> <200007142222.SAA16834@envy.delorie.com>
X-SW-Source: 2000-q3/msg00017.html

DJ Delorie wrote:
> 
> > Did that, but I additionally patched concat to prevent a crash when
> > root_mount remained unset.
> 
> Others have suggested that, but in all the cases where that patch
> would help, what you *really* need is a test for root_dir==NULL
> elsewhere to change the logic so that concat isn't calles.  Otherwise,
> you end up passing an null pointer as a filename, which is a bad idea.

Ok, I removed that change.  But note that the lines

  if (!s)
    return 0;

are essentially a noop, because strlen will already have segfault'd if s
is null.


> > How else do you do that in C?
> 
> With fgets.  One of the parameters is the size of the buffer.  If the

Done.  Also added code to strip newline.


Jeffrey Juliano wrote:
> 
> new todo: make the text entry for the "Other URL" window be selected by
> default.  I don't know how to do this, or I would have.

I did this by reordering something in the .rc file.  MSDN says that focus
goes by default to first control in dialog box that is visible, not
disabled, and has the WS_TABSTOP style.


Here's the patch again.

================================


2000-07-17  Jeff Juliano  <juliano@cs.unc.edu>

	* res.rc (IDD_OTHER_URL): reorder to give default focus to entry

	* other.cc (dialog_cmd): save download site URL
	* site.cc (get_root_dir): new
	(save_mirror_site): new
	(dialog_cmd): save download site URL
	(get_site_list): make list big enough to add prev site
	(get_initial_list_idx): new, read last-used URL from file and
	append it to site_list
	(do_site): call get_initial_list_idx
	* site.h: new

---- new file site.h ----
/*
 * Copyright (c) 2000, Red Hat, Inc.
 *
 *     This program is free software; you can redistribute it and/or
modify
 *     it under the terms of the GNU General Public License as published
by
 *     the Free Software Foundation; either version 2 of the License, or
 *     (at your option) any later version.
 *
 *     A copy of the GNU General Public License can be found at
 *     http://www.gnu.org/
 *
 * Written by DJ Delorie <dj@cygnus.com>
 *
 */

/* The purpose of this file is to get the list of mirror sites and ask
   the user which mirror site they want to download from. */

void save_URL ();
------------------------

Index: other.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/other.cc,v
retrieving revision 1.1
diff -p -u -2 -r1.1 other.cc
--- other.cc	2000/07/07 00:29:20	1.1
+++ other.cc	2000/07/17 19:02:21
@@ -25,4 +25,5 @@
 #include "state.h"
 #include "msg.h"
+#include "site.h"
 
 
@@ -59,4 +60,5 @@ dialog_cmd (HWND h, int id, HWND hwndctl
     case IDOK:
       save_dialog(h);
+      save_URL();
       NEXT(IDD_S_LOAD_INI);
       break;
Index: res.rc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/res.rc,v
retrieving revision 1.4
diff -p -u -2 -r1.4 res.rc
--- res.rc	2000/07/11 21:27:08	1.4
+++ res.rc	2000/07/17 19:02:21
@@ -104,8 +104,8 @@ CAPTION "Cygwin Setup"
 FONT 8, "MS Sans Serif"
 BEGIN
-    DEFPUSHBUTTON   "Next -->",IDOK,100,75,45,15
-    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15
     EDITTEXT        IDC_OTHER_URL,55,25,127,12,ES_AUTOHSCROLL
     LTEXT           "Select URL to download
from",IDC_STATIC,55,15,135,11
+    DEFPUSHBUTTON   "Next -->",IDOK,100,75,45,15
+    PUSHBUTTON      "Cancel",IDCANCEL,165,75,45,15
     PUSHBUTTON      "<-- Back",IDC_BACK,55,75,45,15
     ICON            IDI_CYGWIN,IDC_STATIC,5,5,20,20
Index: site.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/site.cc,v
retrieving revision 1.1
diff -p -u -2 -r1.1 site.cc
--- site.cc	2000/07/07 00:29:20	1.1
+++ site.cc	2000/07/17 19:02:21
@@ -22,4 +22,5 @@
 #include <string.h>
 
+#include "site.h"
 #include "dialog.h"
 #include "resource.h"
@@ -27,4 +28,6 @@
 #include "geturl.h"
 #include "msg.h"
+#include "concat.h"
+#include "mount.h"
 
 #include "port.h"
@@ -71,4 +74,31 @@ save_dialog (HWND h)
 }
 
+static void
+get_root_dir()
+{
+  int istext;
+  int issystem;
+  if (root_dir)
+    return;
+  root_dir = find_root_mount (&istext, &issystem);
+}
+
+void
+save_URL ()
+{
+  if (! MIRROR_SITE)
+    return;
+
+  get_root_dir();
+  if (! root_dir)
+    return;
+  
+  FILE *f = fopen (concat (root_dir, "/etc/setup/last-mirror", 0),
"wb");
+  if (!f)
+    return;
+  fprintf (f, "%s\n", MIRROR_SITE);
+  fclose (f);
+}
+
 static BOOL
 dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)
@@ -87,5 +117,9 @@ dialog_cmd (HWND h, int id, HWND hwndctl
 	NEXT(IDD_OTHER_URL);
       else
-	NEXT(IDD_S_LOAD_INI);
+	{
+	  other_url = 0;
+	  save_URL();
+	  NEXT(IDD_S_LOAD_INI);
+	}
       break;
 
@@ -138,5 +172,9 @@ get_site_list (HINSTANCE h)
   char *bol, *eol, *nl;
 
-  int nmirrors = 2; /* null plus account for possibly missing NL */
+  
+  /* null plus account for possibly missing NL
+   * plus account for "Other URL" from previous run. */
+  int nmirrors = 3;
+
   for (bol=mirrors; *bol; bol++)
     if (*bol == '\n')
@@ -172,4 +210,40 @@ get_site_list (HINSTANCE h)
 }
 
+static void
+get_initial_list_idx ()
+{
+  get_root_dir();
+  if (! root_dir)
+    return;
+
+  FILE *f = fopen (concat (root_dir, "/etc/setup/last-mirror", 0),
"rt");
+  if (!f)
+    return;
+
+  char site[1000];
+  site[0]='\0';
+  char * fg_ret = fgets (site, 1000, f);
+  fclose (f);
+  if ((! fg_ret) || (! site[0]))
+    return;
+
+  char *eos = site + strlen(site) - 1;
+  if ('\n' == *eos)
+    *eos = '\0';
+
+  int i=0;
+  for (; site_list[i]; i++)
+    if (strcmp (site_list[i], site) == 0)
+      break;
+
+  if (! site_list[i])
+    {
+      site_list[i] = _strdup (site);
+      site_list[i+1] = 0;
+    }
+
+  mirror_idx = list_idx = i;
+}
+
 void
 do_site (HINSTANCE h)
@@ -183,4 +257,6 @@ do_site (HINSTANCE h)
 	return;
       }
+
+  get_initial_list_idx();
 
   rv = DialogBox (h, MAKEINTRESOURCE (IDD_SITE), 0, dialog_proc);
