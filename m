Return-Path: <cygwin-patches-return-1917-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 4527 invoked by alias); 27 Feb 2002 17:01:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4483 invoked from network); 27 Feb 2002 17:01:42 -0000
Date: Wed, 27 Feb 2002 09:37:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: /proc and /proc/registry
Message-ID: <20020227170138.GA2380@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <008901c1b1be$80b36e70$0100a8c0@advent02> <20020210043745.GA5128@redhat.com> <006401c1b998$c106f230$0100a8c0@advent02> <20020219230649.GC4626@redhat.com> <024601c1b9a3$2f8fb700$0100a8c0@advent02> <20020220003104.GD22591@redhat.com> <20020225164230.GA17325@redhat.com> <001301c1be40$647220b0$0100a8c0@advent02> <20020225214630.GD22795@redhat.com> <00b501c1bec2$ae997530$0100a8c0@advent02>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b501c1bec2$ae997530$0100a8c0@advent02>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00274.txt.bz2

On Tue, Feb 26, 2002 at 12:39:47PM -0000, Chris January wrote:
>> 1) The copyrights still need to be changed.
>Done.
>> 2) The code formatting still is not correct.
>Now piped through indent with a few touch-ups.
>> 3) You have a lot of calls to normalize_posix_path.  Is that really
>>    necessary?  It seems to be called a lot.  If it is really necessary,
>>    I'd prefer that it just be called in dtable::build_fhandler and made
>>    the standard "unix_path_name".
>Done.
>> 4) Could you generate the diff using 'cvs diff -up"
>Done. The new files are diff'ed against /dev/null and are appended to the
>output of cvs diff.
>
>NB: The ChangeLog has two additions because I found chdir had broken.
>
>@@ -370,9 +379,9 @@ dtable::build_fhandler (int fd, DWORD de
> 
>   if (unix_name)
>     {
>-      char new_win32_name[strlen (unix_name) + 1];
>       if (!win32_name)
> 	{
>+          char new_win32_name[strlen (unix_name) + 1];
> 	  char *p;
> 	  /* FIXME: ? Should we call win32_device_name here?
> 	     It seems like overkill, but... */

The above is a gratuitous and dangerous change.

>@@ -100,7 +103,10 @@ enum
> extern const char *windows_device_names[];
> extern struct __cygwin_perfile *perfile_table;
> #define __fmode (*(user_data->fmode_ptr))
>+extern const char *proc;
>+extern const int proc_len;
> 
>+
> class select_record;
> class path_conv;
> class fhandler_disk_file;

Please eliminate the extra white space.

>@@ -1028,6 +1034,74 @@ class fhandler_dev_dsp : public fhandler
>   void fixup_after_exec (HANDLE);
> };
> 
>+class fhandler_virtual : public fhandler_base
>+{
>+ protected:
>+  char normalized_path[MAX_PATH];

There should be no need for normalized_path, should there?

>@@ -490,6 +496,24 @@ path_conv::check (const char *src, unsig
> 		}
> 	      goto out;
> 	    }
>+          else if (isvirtual_dev(devn))
>+            {
>+              fhandler_virtual *fh =
>+                (fhandler_virtual *)cygheap->fdtab.build_fhandler(-1, devn, path_copy, NULL, unit);
>+              int file_type = fh->exists(path_copy);
>+              switch (file_type)
>+                {
>+                  case 0:
>+                    error = ENOENT;
>+                  case 1:
>+                  case 2:
>+                    fileattr = FILE_ATTRIBUTE_DIRECTORY;
>+                  case -1:
>+                    fileattr = 0;
>+                }
>+              delete fh;
>+              return;
>+            }
> 	  /* devn should not be a device.  If it is, then stop parsing now. */
> 	  else if (devn != FH_BAD)
> 	    {

Non GNU-formatting above.  Need spaces before parentheses in function calls.
Need spaces after closing parentheses in coercions.

Please just fix this.  Don't run the code through indent.

>@@ -1405,10 +1429,16 @@ mount_info::conv_to_win32_path (const ch
>       else if (mount_table->cygdrive_len > 1)
> 	return ENOENT;
>     }
>+  if (isproc (pathbuf))
>+  {
>+    devn = fhandler_proc::get_proc_fhandler(pathbuf);
>+    dst[0] = '\0';
>+    goto out;
>+  }
> 
>   int chrooted_path_len;
>   chrooted_path_len = 0;
>   /* Check the mount table for prefix matches. */
>   for (i = 0; i < nmounts; i++)
>     {
>       const char *path;

Ditto.

>@@ -1472,7 +1502,7 @@ mount_info::conv_to_win32_path (const ch
>       *flags = mi->flags;
>     }
> 
>-  if (devn != FH_CYGDRIVE)
>+  if (!isvirtual_dev(devn))
>     win32_device_name (src_path, dst, devn, unit);
> 
>  out:

Ditto.

>@@ -3233,7 +3263,8 @@ chdir (const char *in_dir)
>       path.get_win32 ()[3] = '\0';
>     }
>   int res;
>-  if (path.get_devn () != FH_CYGDRIVE)
>+  int devn = path.get_devn();
>+  if (!isvirtual_dev(devn))
>     res = SetCurrentDirectory (native_dir) ? 0 : -1;
>   else
>     {

Ditto.

>@@ -3253,8 +3284,9 @@ chdir (const char *in_dir)
>      we'll see if Cygwin mailing list users whine about the current behavior. */
>   if (res == -1)
>     __seterrno ();
>-  else if (!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
>-	   && pcheck_case == PCHECK_RELAXED)
>+  else if ((!path.has_symlinks () && strpbrk (dir, ":\\") == NULL
>+            && pcheck_case == PCHECK_RELAXED) ||
>+            isvirtual_dev(devn))
>     cygheap->cwd.set (native_dir, dir);
>   else
>     cygheap->cwd.set (native_dir, NULL);

Ditto.

>--- /dev/null	Tue Feb 26 12:30:52 2002
>+++ fhandler_proc.cc	Tue Feb 26 10:15:16 2002
>@@ -0,0 +1,294 @@
>+/* offsets in proc_listing */
>+static const int PROC_REGISTRY = 0;     // /proc/registry
>+static const int PROC_VERSION = 1;      // /proc/version
>+static const int PROC_UPTIME = 2;       // /proc/uptime
>+static const int PROC_LINK_COUNT = 3;
>+
>+/* names of objects in /proc */
>+static const char *proc_listing[PROC_LINK_COUNT] = {
>+  "registry",
>+  "version",
>+  "uptime"
>+};

Either derive PROC_LINK_COUNT from the size of the array or just use
a NULL terminated array (preferred).

>+
>+/* name of the /proc filesystem */
>+const char *proc = "/proc";
>+const int proc_len = strlen (proc);

How about:
const char proc[] = "/proc";
const int proc_len = sizeof (proc) - 1;

Then we don't have any runtime hits.

>+/* auxillary function that returns the fhandler associated with the given path
>+ * this is where it would be nice to have pattern matching in C - polymorphism
>+ * just doesn't cut it
>+ */
>+DWORD
>+fhandler_proc::get_proc_fhandler (const char *path)
>+{
>+  debug_printf("get_proc_fhandler(%s)", path);
>+  path += proc_len;
>+  while (SLASH_P (*path))
>+    path++;

Why are you eating slashes here?  Unnecessary slashes should have been eliminated
by normalize_path.

>+  if (*path == 0)
>+    return FH_PROC;

How could this happen?

>+  for (int i = 0; i < PROC_LINK_COUNT; i++)
>+    {
>+      if (path_prefix_p (proc_listing[i], path, strlen (proc_listing[i])))
>+        return proc_fhandlers[i];
>+    }

Here is where you could just do:
  for (int i = 0; proc_listing[i]; i++)

>+  int pid = atoi (path);
>+  winpids pids;
>+  for (unsigned i = 0; i < pids.npids; i++)
>+    {
>+      _pinfo *p = pids[i];
>+
>+      if (!proc_exists (p))
>+        continue;
>+
>+      if (p->pid == pid)
>+        return FH_PROCESS;
>+    }
>+  return FH_PROC;
>+}

Is this right?  If I type /proc/qwerty this returns FH_PROC?

>--- /dev/null	Tue Feb 26 12:30:59 2002
>+++ fhandler_process.cc	Tue Feb 26 10:01:16 2002
>@@ -0,0 +1,289 @@
>+/* fhandler_process.cc: fhandler for /proc/<pid> virtual filesystem
>+
>+   Copyright 2002 Red Hat, Inc.
>+
>+This file is part of Cygwin.
>+
>+This software is a copyrighted work licensed under the terms of the
>+Cygwin license.  Please consult the file "CYGWIN_LICENSE" for
>+details. */
>+
>+#include "winsup.h"
>+#include <sys/fcntl.h>
>+#include <errno.h>
>+#include <unistd.h>
>+#include <stdlib.h>
>+#include <sys/cygwin.h>
>+#include "cygerrno.h"
>+#include "security.h"
>+#include "fhandler.h"
>+#include "sigproc.h"
>+#include "pinfo.h"
>+#include "path.h"
>+#include "shared_info.h"
>+#include <assert.h>
>+
>+#define _COMPILING_NEWLIB
>+#include <dirent.h>
>+
>+static const int PROCESS_PPID = 0;
>+static const int PROCESS_EXENAME = 1;
>+static const int PROCESS_WINPID = 2;
>+static const int PROCESS_WINEXENAME = 3;
>+static const int PROCESS_STATUS = 4;
>+static const int PROCESS_UID = 5;
>+static const int PROCESS_GID = 6;
>+static const int PROCESS_PGID = 7;
>+static const int PROCESS_SID = 8;
>+static const int PROCESS_CTTY = 9;
>+static const int PROCESS_LINK_COUNT = 10;
>+
>+static const char *process_listing[PROCESS_LINK_COUNT] = {
>+  "ppid",
>+  "exename",
>+  "winpid",
>+  "winexename",
>+  "status",
>+  "uid",
>+  "gid",
>+  "pgid",
>+  "sid",
>+  "ctty"
>+};

Same comments as before wrt PROCESS_LINK_COUNT.

>--- /dev/null	Tue Feb 26 12:31:02 2002
>+++ fhandler_registry.cc	Tue Feb 26 11:11:53 2002
>@@ -0,0 +1,505 @@
>+const int registry_len = strlen ("registry");
>+/* If this bit is set in __d_position then we are enumerating values,
>+ * else sub-keys. keeping track of where we are is horribly messy
>+ * the bottom 16 bits are the absolute position and the top 15 bits
>+ * make up the value index if we are enuerating values.
>+ */
>+const __off32_t REG_ENUM_VALUES_MASK = 0x8000000;
>+
>+const int ROOT_KEY_COUNT = 7;

Derive from array.
Should these be static?

>+/* List of root keys in /proc/registry.
>+ * Possibly we should filter out those not relevant to the flavour of Windows
>+ * Cygwin is running on.
>+ */
>+static const char *registry_listing[ROOT_KEY_COUNT] = {
>+  "HKEY_CLASSES_ROOT",
>+  "HKEY_CURRENT_CONFIG",
>+  "HKEY_CURRENT_USER",
>+  "HKEY_LOCAL_MACHINE",
>+  "HKEY_USERS",
>+  "HKEY_DYN_DATA",              // 95/98/Me
>+  "HKEY_PERFOMANCE_DATA"        // NT/2000/XP
>+};
>+static HKEY registry_keys[ROOT_KEY_COUNT] = { HKEY_CLASSES_ROOT,
>+  HKEY_CURRENT_CONFIG,
>+  HKEY_CURRENT_USER,
>+  HKEY_LOCAL_MACHINE,
>+  HKEY_USERS,
>+  HKEY_DYN_DATA,
>+  HKEY_PERFORMANCE_DATA
>+};

>--- /dev/null	Tue Feb 26 12:31:06 2002
>+++ fhandler_virtual.cc	Tue Feb 26 11:14:04 2002
>@@ -0,0 +1,228 @@
>+DIR *
>+fhandler_virtual::opendir (path_conv & real_name)
>+{
>+  return opendir (get_name());
>+}

I don't see how this can be right.  Won't this induce infinite recursion?

Phew.

cgf
