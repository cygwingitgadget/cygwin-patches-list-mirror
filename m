From: Kazuhiro Fujieda <fujieda@jaist.ac.jp>
To: cygwin-patches@sourceware.cygnus.com
Subject: preliminary patch for incorporating internationalizing facilities
Date: Wed, 28 Jun 2000 13:32:00 -0000
Message-id: <s1sr99ho8cf.fsf@jaist.ac.jp>
X-SW-Source: 2000-q2/msg00115.html

I implemented the major part of internationalizing facilities
standardized by ISO C.  Before I try to incorporate them into
the latest snapshot, I want to reduce unintentional dependency
on them in the inside of Cygwin.

The behavior of them can be affected by a locale selected by an
application with setlocale(). As a result, the internal behavior
of Cygwin is probably corrupted.

The main intention of the following patch is to eliminate
str{n,}casecmp. Other changes are rather cosmetic. I made these
changes in order to check dependency on the facilities in Cygwin.
There is no need to eliminate the usage of macros defined in
ctype.h. I managed to make these macros locale-independent in
the inside of Cygwin.

ChangeLog:
2000-06-28  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>

	* assert.cc (__assert): Reduce dependency on newlib.
	* exec.cc: Eliminate unnecessary inclusion of ctype.h.
	* glob.c: Ditto.
	* hinfo.cc: Ditto.
	* init.cc: Ditto.
	* strace.cc: Ditto.
	* tty.cc: Ditto.
	* grp.cc (parse_grp): Eliminate atoi.
	* passwd.cc (grab_int): Ditto.
	* grp.cc (getgroups): Eliminate str{n,}casecmp.
	* path.cc (get_raw_device_number): Ditto.
	* path.cc (sort_by_native_name): Ditto.
	* spawn.cc (iscmd): Ditto.
	* uinfo.cc (internal_getlogin): Ditto.

Index: assert.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/assert.cc,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 assert.cc
--- assert.cc	2000/02/17 19:38:31	1.1.1.1
+++ assert.cc	2000/06/28 17:13:08
@@ -32,16 +32,15 @@ __assert (const char *file, int line, co
       char *buf;
 
       buf = (char *) alloca (100 + strlen (failedexpr));
-      siprintf (buf, "Failed assertion\n\t%s\nat line %d of file %s",
+      __small_sprintf (buf, "Failed assertion\n\t%s\nat line %d of file %s",
 		failedexpr, line, file);
       MessageBox (NULL, buf, NULL, MB_OK | MB_ICONERROR | MB_TASKMODAL);
     }
   else
     {
       CloseHandle (h);
-      (void) fiprintf (stderr,
-		       "assertion \"%s\" failed: file \"%s\", line %d\n",
-		       failedexpr, file, line);
+      small_printf ("assertion \"%s\" failed: file \"%s\", line %d\n",
+		    failedexpr, file, line);
     }
 
   abort ();
Index: exec.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/exec.cc,v
retrieving revision 1.2
diff -u -p -r1.2 exec.cc
--- exec.cc	2000/04/26 05:13:32	1.2
+++ exec.cc	2000/06/28 17:13:10
@@ -11,7 +11,6 @@ details. */
 #include <unistd.h>
 #include <stdlib.h>
 #include <errno.h>
-#include <ctype.h>
 #include <process.h>
 #include "winsup.h"
 
Index: glob.c
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/glob.c,v
retrieving revision 1.1.1.1
diff -u -p -r1.1.1.1 glob.c
--- glob.c	2000/02/17 19:38:31	1.1.1.1
+++ glob.c	2000/06/28 17:13:12
@@ -70,7 +70,6 @@
 #include <sys/param.h>
 #include <sys/stat.h>
 
-#include <ctype.h>
 #include <dirent.h>
 #include <errno.h>
 #include <glob.h>
Index: grp.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
retrieving revision 1.4
diff -u -p -r1.4 grp.cc
--- grp.cc	2000/06/25 03:48:10	1.4
+++ grp.cc	2000/06/28 17:13:13
@@ -66,7 +66,7 @@ parse_grp (struct group &grp, const char
       if (!strlen (grp.gr_passwd))
         grp.gr_passwd = NULL;
 
-      grp.gr_gid = atoi (dp);
+      grp.gr_gid = strtol (dp, NULL, 10);
       dp = strchr (dp, ':');
       if (dp)
         {
@@ -249,7 +249,7 @@ getgroups (int gidsetsize, gid_t *groupl
       }
     else if (group_buf[i].gr_mem)
       for (int gi = 0; group_buf[i].gr_mem[gi]; ++gi)
-        if (! strcasecmp (username, group_buf[i].gr_mem[gi]))
+        if (strcasematch (username, group_buf[i].gr_mem[gi]))
           {
             if (cnt < gidsetsize)
               grouplist[cnt] = group_buf[i].gr_gid;
Index: hinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/hinfo.cc,v
retrieving revision 1.7
diff -u -p -r1.7 hinfo.cc
--- hinfo.cc	2000/06/26 21:36:52	1.7
+++ hinfo.cc	2000/06/28 17:13:13
@@ -14,7 +14,6 @@ details. */
 #include <sys/socket.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <ctype.h>
 #include <unistd.h>
 #include <fcntl.h>
 
Index: init.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/init.cc,v
retrieving revision 1.5
diff -u -p -r1.5 init.cc
--- init.cc	2000/04/16 22:57:05	1.5
+++ init.cc	2000/06/28 17:13:13
@@ -9,7 +9,6 @@ Cygwin license.  Please consult the file
 details. */
 
 #include <stdlib.h>
-#include <ctype.h>
 #include "winsup.h"
 
 extern HMODULE cygwin_hmodule;
Index: passwd.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
retrieving revision 1.4
diff -u -p -r1.4 passwd.cc
--- passwd.cc	2000/06/25 03:48:10	1.4
+++ passwd.cc	2000/06/28 17:13:13
@@ -57,7 +57,7 @@ static int
 grab_int (char **p)
 {
   char *src = *p;
-  int val = atoi (src);
+  int val = strtol (src, NULL, 10);
   while (*src && *src != ':' && *src != '\n')
     src++;
   if (*src == ':')
Index: path.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/path.cc,v
retrieving revision 1.34
diff -u -p -r1.34 path.cc
--- path.cc	2000/06/16 23:39:02	1.34
+++ path.cc	2000/06/28 17:13:14
@@ -438,12 +438,12 @@ get_raw_device_number (const char *uxnam
 {
   DWORD devn = FH_BAD;
 
-  if (strncasecmp (w32path, "\\\\.\\tape", 8) == 0)
+  if (strncasematch (w32path, "\\\\.\\tape", 8))
     {
       devn = FH_TAPE;
       unit = digits (w32path + 8);
       // norewind tape devices have leading n in name
-      if (! strncasecmp (uxname, "/dev/n", 6))
+      if (strncasematch (uxname, "/dev/n", 6))
 	unit += 128;
     }
   else if (isdrive (w32path + 4))
@@ -451,7 +451,7 @@ get_raw_device_number (const char *uxnam
       devn = FH_FLOPPY;
       unit = tolower (w32path[4]) - 'a';
     }
-  else if (strncasecmp (w32path, "\\\\.\\physicaldrive", 17) == 0)
+  else if (strncasematch (w32path, "\\\\.\\physicaldrive", 17))
     {
       devn = FH_FLOPPY;
       unit = digits (w32path + 17) + 128;
@@ -1566,7 +1566,7 @@ sort_by_native_name (const void *a, cons
 
   /* The two paths were the same length, so just determine normal
      lexical sorted order. */
-  res = strcasecmp (ap->posix_path, bp->posix_path);
+  res = strcmp (ap->native_path, bp->native_path);
 
   if (res == 0)
    {
Index: spawn.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
retrieving revision 1.9
diff -u -p -r1.9 spawn.cc
--- spawn.cc	2000/06/24 17:37:52	1.9
+++ spawn.cc	2000/06/28 17:13:15
@@ -169,7 +169,7 @@ iscmd (const char *argv0, const char *wh
   n = strlen (argv0) - strlen (what);
   if (n >= 2 && argv0[1] != ':')
     return 0;
-  return n >= 0 && strcasecmp (argv0 + n, what) == 0 &&
+  return n >= 0 && strcasematch (argv0 + n, what) &&
 	 (n == 0 || isdirsep (argv0[n - 1]));
 }
 
Index: strace.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/strace.cc,v
retrieving revision 1.5
diff -u -p -r1.5 strace.cc
--- strace.cc	2000/03/15 04:49:36	1.5
+++ strace.cc	2000/06/28 17:13:15
@@ -8,7 +8,6 @@ This software is a copyrighted work lice
 Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
 details. */
 
-#include <ctype.h>
 #include <stdlib.h>
 #include <time.h>
 #include "winsup.h"
Index: tty.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/tty.cc,v
retrieving revision 1.2
diff -u -p -r1.2 tty.cc
--- tty.cc	2000/03/12 06:29:54	1.2
+++ tty.cc	2000/06/28 17:13:16
@@ -11,7 +11,6 @@ details. */
 #include <errno.h>
 #include <unistd.h>
 #include <utmp.h>
-#include <ctype.h>
 #include "winsup.h"
 
 extern fhandler_tty_master *tty_master;
Index: uinfo.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/uinfo.cc,v
retrieving revision 1.9
diff -u -p -r1.9 uinfo.cc
--- uinfo.cc	2000/06/24 17:37:52	1.9
+++ uinfo.cc	2000/06/28 17:13:16
@@ -41,7 +41,7 @@ internal_getlogin (struct pinfo *pi)
       if ((env = getenv ("USERDOMAIN")) != NULL)
         strcpy (pi->domain, env);
       /* Trust only if usernames are identical */
-      if (!strcasecmp (pi->username, buf) && pi->domain[0] && pi->logsrv[0])
+      if (strcasematch (pi->username, buf) && pi->domain[0] && pi->logsrv[0])
         debug_printf ("Domain: %s, Logon Server: %s", pi->domain, pi->logsrv);
       /* If that failed, try to get that info from NetBIOS */
       else if (!NetWkstaUserGetInfo (NULL, 1, (LPBYTE *)&wui))
@@ -53,7 +53,7 @@ internal_getlogin (struct pinfo *pi)
           wcstombs (pi->domain, wui->wkui1_logon_domain,
                     (wcslen (wui->wkui1_logon_domain) + 1) * sizeof (WCHAR));
           /* Save values in environment */
-          if (strcasecmp (pi->username, "SYSTEM")
+          if (!strcasematch (pi->username, "SYSTEM")
               && pi->domain[0] && pi->logsrv[0])
             {
               LPUSER_INFO_3 ui = NULL;
@@ -133,7 +133,7 @@ internal_getlogin (struct pinfo *pi)
               PSID psid = (PSID) psidbuf;
 
               pi->psid = (PSID) pi->sidbuf;
-              if (strcasecmp (pi->username, "SYSTEM")
+              if (!strcasematch (pi->username, "SYSTEM")
                   && pi->domain[0] && pi->logsrv[0])
                 {
                   if (get_registry_hive_path (pi->psid, buf))

____
  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
  | HOKURIKU  School of Information Science
o_/ 1990      Japan Advanced Institute of Science and Technology
