From: Jeffrey Juliano <juliano@cs.unc.edu>
To: cygwin-patches@sources.redhat.com
Subject: cinstall contribution
Date: Fri, 14 Jul 2000 08:53:00 -0000
Message-id: <396F377E.F3ADDEF6@cs.unc.edu>
References: <Pine.SGI.4.10.10007111450500.361924-100000@cystine.cs.unc.edu> <396B7FC4.188536DC@delorie.com> <200007112129.RAA03821@envy.delorie.com>
X-SW-Source: 2000-q3/msg00011.html

DJ, great job with the new install program!  The structure makes it very
easy to understand.  And this is my first exposure to win32 GUI
programming.


Below is a patch to cinstall/site.cc that will

 o Save, to a file in etc/setup/last-mirror, the URL of the site last
   downloaded from.

 o Scan the mirrors list for the last-used URL, and if found, select it
   as the default.

 o But, there's a problem...

Unfortunately, there is a big problem with this patch.  `root_dir' isn't
known yet when do_site is called.  So, I've hardcoded it's value for now.

Feel free to complete this patch.  Or, I can give it a shot over the
weekend.  RFC: what's the right way forward from here?  DJ, do you have
feelings about this?  Seems the available options include:

  o Read from the registry the value of `/'.  Scary and perhaps too
    limiting.

  o Cache the install location in the registry.  You've nicely avoided
    the registry so far, so why start now.

  o Ask the user for install dir first, then go to what's currently
    the first dialog.  Could be annoying for user.

    o Prehaps default the install location to what's in the registry
      for `/'.

    o Should we ask about system/user, text/binary mounts at this point?
    

Then again, if the ToDo list includes caching the install location for
use as default next time, that could be integrated with finishing my
patch.


Also, please point me to a reference explaining the ChangeLog conventions
that you follow.  I know about standards.info, but it's kind of skimpy. 
What do y'all do to ensure you don't miss mentioning a changed function?

-jeff


-------------------------------------

2000-07-14    <juliano@cs.unc.edu>

	* site.cc (save_mirror_site): new
	(dialog_cmd): call save_mirror_site
	(get_initial_list_idx): new
	(do_site): call get_initial_list_idx


Index: site.cc
===================================================================
RCS file: /cvs/src/src/winsup/cinstall/site.cc,v
retrieving revision 1.1
diff -u -p -r1.1 site.cc
--- site.cc	2000/07/07 00:29:20	1.1
+++ site.cc	2000/07/14 15:15:36
@@ -26,6 +26,7 @@
 #include "state.h"
 #include "geturl.h"
 #include "msg.h"
+#include "concat.h"
 
 #include "port.h"
 
@@ -70,6 +71,22 @@ save_dialog (HWND h)
     }
 }
 
+static void
+save_mirror_site ()
+{
+  /* XXX
+   * Should concat with root_dir, but it unfortunately hasn't been set
yet.
+   * Instead, will hardcode my path to root_dir so that I can test.
+   */
+  //FILE *f = fopen (concat (root_dir, "/etc/setup/last-mirror", 0),
"wt");
+  FILE *f = fopen ("D:/cygwin/etc/setup/last-mirror", "wt");
+  if (f)
+    {
+      fprintf (f, "%s\n", mirror_site);
+      fclose (f);
+    }
+}
+
 static BOOL
 dialog_cmd (HWND h, int id, HWND hwndctl, UINT code)
 {
@@ -83,6 +100,7 @@ dialog_cmd (HWND h, int id, HWND hwndctl
 
     case IDOK:
       save_dialog(h);
+      save_mirror_site();
       if (mirror_idx == OTHER_IDX)
 	NEXT(IDD_OTHER_URL);
       else
@@ -171,6 +189,36 @@ get_site_list (HINSTANCE h)
   return 0;
 }
 
+static void
+get_initial_list_idx (HINSTANCE h)
+{
+  char site[1000];
+  site[0]='\0';
+
+  /* XXX
+   * Should concat with root_dir, but it unfortunately hasn't been set
yet.
+   * Instead, will hardcode my path to root_dir so that I can test.
+   */
+  //FILE *f = fopen (concat (root_dir, "/etc/setup/last-mirror", 0),
"rt");
+  FILE *f = fopen ("D:/cygwin/etc/setup/last-mirror", "rt");
+  if (f)
+    {
+      char line[1000];
+      if (fgets (line, 1000, f))
+	sscanf (line, "%s", site);
+      fclose (f);
+    }
+
+  if (site)
+    {
+      for (int i=0; site_list[i]; i++)
+	{
+	  if (strcmp (site_list[i], site) == 0)
+	    list_idx = i;
+	}
+    }
+}
+
 void
 do_site (HINSTANCE h)
 {
@@ -182,6 +230,8 @@ do_site (HINSTANCE h)
 	NEXT(0);
 	return;
       }
+
+  get_initial_list_idx (h);
 
   rv = DialogBox (h, MAKEINTRESOURCE (IDD_SITE), 0, dialog_proc);
   if (rv == -1)
