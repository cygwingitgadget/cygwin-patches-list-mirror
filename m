From: Jeffrey Juliano <juliano@cs.unc.edu>
To: DJ Delorie <dj@delorie.com>
Cc: cygwin-patches@sources.redhat.com
Subject: Re: cinstall contribution
Date: Fri, 14 Jul 2000 15:12:00 -0000
Message-id: <396F9057.83997899@cs.unc.edu>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com> <396F377E.F3ADDEF6@cs.unc.edu> <200007141712.NAA14485@envy.delorie.com>
X-SW-Source: 2000-q3/msg00014.html

new todo: make the text entry for the "Other URL" window be selected by
default.  I don't know how to do this, or I would have.


DJ Delorie wrote:
> 
> Thanks for getting involved!

hey, it's fun!

 
> > Unfortunately, there is a big problem with this patch.  `root_dir' isn't
> > known yet when do_site is called.
> 
> It should be.  The root dialog comes before the site dialog.  The only
> time it doesn't is when you're downloading without installing.

That's how I was testing.

> >   o Read from the registry the value of `/'.  Scary and perhaps too
> >     limiting.
> 
> See mount.h.  It has a function to find the existing root mount point

Oh, I'd missed that.  Cool.

> (this is what root.cc does anyway).  So, if root_dir is NULL, try
> find_root_mount().  If that fails also (i.e. no previous
> installation), just don't pre-select a site.

Did that, but I additionally patched concat to prevent a crash when
root_mount remained unset.

> YYYY-MM-DD<sp><sp>Full Name<sp><sp><email@address>

fixed

> A note on coding style:  I prefer that when you test for an error
> (like the results of fopen), you test for the error case,
> not the success case.  That way you don't end up indenting a lot.
> For example, your code is like this:

Changed it.  I was trying to emulate your conventions elsewhere in that
file.

> also that I didn't bother with the intermediate "line" variable;
> there's no need.
> 
> +  if (site)

"line" is for catching the case where the URL in the file is longer than
1000 characters.  Something that's automatically handled by:

  void f (ifstream &fin)
    {
      std::string s;
      fin >> s;
    }

How else do you do that in C?


> Since "site" is an array, this test will always be true.  I think what
> you wanted was "if (site[0])" but you don't need that anyway.

Oops, thinking std::string and writing C.

> If site is an empty string, it just won't match anything from the list.

Oh, right.  Made use of that.

> Also, you don't need to pass "HINSTANCE h" to get_initial_list_idx
> because it doesn't need it.

Changed that.

> You also don't handle the case where the user selects "other" and
> fills in the URL in other.cc.  Perhaps save_mirror_site should be
> called by both dialogs?

Now I do ;)

But, I exposed a function in site.cc to other.cc, through a new file
site.h.  It's kind of ugly, but I didn't know where else to put it. 
Adding it to state.{h,cc} seems uglier, and making a new file.{h,cc} pair
seems silly; but that's probably the right answer?  If it moves to a
different file, get_root_dir() needs to go with it.

Oh, I didn't know how to diff a new file, so I attached it separately.

-jeff


------- site.h --------

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


-----------------------------------------

2000-07-14  Jeff Juliano  <juliano@cs.unc.edu>

	* concat.cc (concat): reorder to prevent crash

	* other.cc (dialog_cmd): save download site URL, return FALSE
	* site.cc (get_root_dir): new
	(save_mirror_site): new
	(dialog_cmd): save download site URL, return FALSE
	(get_site_list): make list big enough for prev site, too
	(get_initial_list_idx): new, read from file, add to list if not
	already there
	(do_site): call get_initial_list_idx


? site.h
Index: ChangeLog
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/ChangeLog,v
retrieving revision 1.59
diff -u -p -2 -r1.59 ChangeLog
--- ChangeLog	2000/07/14 01:08:07	1.59
+++ ChangeLog	2000/07/14 21:54:54
@@ -1,2 +1,15 @@
+2000-07-14    <juliano@JULIANO-LAPTOP>
+
+	* other.cc (dialog_cmd): call save_URL
+
+2000-07-14  Jeff Juliano  <juliano@cs.unc.edu>
+
+	* concat.cc (concat): reorder to prevent crash
+	* site.cc (get_root_dir): new
+	(save_mirror_site): new
+	(dialog_cmd): call save_mirror_site, return FALSE
+	(get_initial_list_idx): new
+	(do_site): call get_initial_list_idx
+
 2000-07-13  DJ Delorie  <dj@cygnus.com>
 
Index: concat.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/concat.cc,v
retrieving revision 1.2
diff -u -p -2 -r1.2 concat.cc
--- concat.cc	2000/07/13 20:57:46	1.2
+++ concat.cc	2000/07/14 21:54:54
@@ -24,10 +24,10 @@ char *
 concat (char *s, ...)
 {
+  if (!s)
+    return 0;
+
   int len = strlen(s);
   char *rv, *arg;
   va_list v;
-
-  if (!s)
-    return 0;
 
   va_start (v, s);
Index: other.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/other.cc,v
retrieving revision 1.1
diff -u -p -2 -r1.1 other.cc
--- other.cc	2000/07/07 00:29:20	1.1
+++ other.cc	2000/07/14 21:54:55
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
@@ -71,4 +73,5 @@ dialog_cmd (HWND h, int id, HWND hwndctl
       break;
     }
+  return FALSE;
 }
 
Index: site.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/site.cc,v
retrieving revision 1.1
diff -u -p -2 -r1.1 site.cc
--- site.cc	2000/07/07 00:29:20	1.1
+++ site.cc	2000/07/14 21:54:55
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
@@ -71,4 +74,27 @@ save_dialog (HWND h)
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
+  get_root_dir();
+  FILE *f = fopen (concat (root_dir, "/etc/setup/last-mirror", 0),
"wt");
+  if (!f)
+    return;
+  fprintf (f, "%s\n", MIRROR_SITE);
+  fclose (f);
+}
+
 static BOOL
 dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)
@@ -87,5 +113,9 @@ dialog_cmd (HWND h, int id, HWND hwndctl
 	NEXT(IDD_OTHER_URL);
       else
-	NEXT(IDD_S_LOAD_INI);
+	{
+	  other_url = 0;
+	  save_URL();
+	  NEXT(IDD_S_LOAD_INI);
+	}
       break;
 
@@ -99,4 +129,5 @@ dialog_cmd (HWND h, int id, HWND hwndctl
       break;
     }
+  return FALSE;
 }
 
@@ -138,5 +169,9 @@ get_site_list (HINSTANCE h)
   char *bol, *eol, *nl;
 
-  int nmirrors = 2; /* null plus account for possibly missing NL */
+  
+  /* null plus account for possibly missing NL
+   * plus account for "Other URL" from previous run. */
+  int nmirrors = 3;
+
   for (bol=mirrors; *bol; bol++)
     if (*bol == '\n')
@@ -172,4 +207,36 @@ get_site_list (HINSTANCE h)
 }
 
+static void
+get_initial_list_idx ()
+{
+  get_root_dir();
+  FILE *f = fopen (concat (root_dir, "/etc/setup/last-mirror", 0),
"rt");
+  if (!f)
+    return;
+
+  // First, read a line into array, of arbitrary length :(.  This avoids
+  // walking off the end of the array, if the URL is longer than 1000
chars.
+  char line[1000];
+  char site[1000];
+  site[0]='\0';
+  if (fgets (line, 1000, f))
+    sscanf (line, "%s", site);
+  fclose (f);
+
+  int i=0;
+  for (; site_list[i]; i++)
+    if (strcmp (site_list[i], site) == 0)
+      {
+	mirror_idx = list_idx = i;
+	break;
+      }
+  if (site[0] && (! site_list[i]))
+    {
+      site_list[i] = _strdup (site);
+      site_list[i+1] = 0;
+      mirror_idx = list_idx = i;
+    }
+}
+
 void
 do_site (HINSTANCE h)
@@ -183,4 +250,6 @@ do_site (HINSTANCE h)
 	return;
       }
+
+  get_initial_list_idx();
 
   rv = DialogBox (h, MAKEINTRESOURCE (IDD_SITE), 0, dialog_proc);
