Return-Path: <cygwin-patches-return-3778-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23330 invoked by alias); 2 Apr 2003 15:42:56 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23319 invoked from network); 2 Apr 2003 15:42:55 -0000
Date: Wed, 02 Apr 2003 15:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygwin_internal(CW_CHECK_NTSEC, filename) patch
Message-ID: <20030402154258.GA2614@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030402131626.GA1888@tishler.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030402131626.GA1888@tishler.net>
User-Agent: Mutt/1.4i
X-SW-Source: 2003-q2/txt/msg00005.txt.bz2

On Wed, Apr 02, 2003 at 08:16:26AM -0500, Jason Tishler wrote:
>The attached patch adds Corinna's OpenSSH check_ntsec() functionality to
>Cygwin as cygwin_internal(CW_CHECK_NTSEC, filename).  The third
>attachment, check_ntsec.cc, can be used to test this functionality:
>
>    $ cygcheck -s | egrep 'FAT|NTFS'
>    a:  fd  FAT        1Mb  62% CP    UN           
>    c:  hd  NTFS   38146Mb  35% CP CS UN PA FC
>    ...
>
>    $ check_ntsec a:/readdir.exe 
>    0 = check_ntsec(a:/readdir.exe)
>
>    $ check_ntsec c:/boot.ini 
>    1 = check_ntsec(c:/boot.ini)
>
>Thanks,
>Jason

I don't get it.  Why are you essentially duplicating all of the checking that already
happens with the wincap stuff?

cgf

>Index: external.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/external.cc,v
>retrieving revision 1.50
>diff -u -p -r1.50 external.cc
>--- external.cc	28 Mar 2003 14:21:40 -0000	1.50
>+++ external.cc	2 Apr 2003 11:43:29 -0000
>@@ -28,6 +28,17 @@ details. */
> #include "wincap.h"
> #include "heap.h"
> #include "cygthread.h"
>+#include <stdio.h>
>+#include <stdlib.h>
>+#include <sys/utsname.h>
>+#include <sys/vfs.h>
>+
>+#define is_winnt	(GetVersion() < 0x80000000)
>+#define ntsec_on(c)	((c) && strstr((c),"ntsec") && !strstr((c),"nontsec"))
>+#define ntsec_off(c)	((c) && strstr((c),"nontsec"))
>+#define ntea_on(c)	((c) && strstr((c),"ntea") && !strstr((c),"nontea"))
>+#define HAS_CREATE_TOKEN 1
>+#define HAS_NTSEC_BY_DEFAULT 2
> 
> static external_pinfo *
> fillout_pinfo (pid_t pid, int winpid)
>@@ -121,6 +132,99 @@ get_cygdrive_prefixes (char *user, char 
>   return res;
> }
> 
>+static int
>+has_capability (int what)
>+{
>+  /* has_capability() basically calls uname() and checks if
>+     specific capabilities of Cygwin can be evaluated from that.
>+     This simplifies the calling functions which only have to ask
>+     for a capability using has_capability() instead of having
>+     to figure that out by themselves. */
>+  static int inited;
>+  static int has_create_token;
>+  static int has_ntsec_by_default;
>+
>+  if (!inited)
>+    {
>+      struct utsname uts;
>+
>+      if (!uname (&uts))
>+	{
>+	  int major_high = 0;
>+	  int major_low = 0;
>+	  int minor = 0;
>+	  int api_major_version = 0;
>+	  int api_minor_version = 0;
>+	  char *c;
>+
>+	  sscanf (uts.release, "%d.%d.%d", &major_high, &major_low, &minor);
>+	  c = strchr (uts.release, '(');
>+	  if (c)
>+	    sscanf (c + 1, "%d.%d", &api_major_version, &api_minor_version);
>+	  if (major_high > 1 ||
>+	      (major_high == 1 && (major_low > 3 ||
>+				   (major_low == 3 && minor >= 2))))
>+	    has_create_token = 1;
>+	  if (api_major_version > 0 || api_minor_version >= 56)
>+	    has_ntsec_by_default = 1;
>+	  inited = 1;
>+	}
>+    }
>+  switch (what)
>+    {
>+    case HAS_CREATE_TOKEN:
>+      return has_create_token;
>+    case HAS_NTSEC_BY_DEFAULT:
>+      return has_ntsec_by_default;
>+    }
>+  return 0;
>+}
>+
>+static int
>+check_ntsec (const char *filename)
>+{
>+  char *cygwin;
>+  int allow_ntea = 0;
>+  int allow_ntsec = 0;
>+  struct statfs fsstat;
>+
>+  /* Windows 95/98/ME don't support file system security at all. */
>+  if (!is_winnt)
>+    return 0;
>+
>+  /* Evaluate current CYGWIN settings. */
>+  cygwin = getenv ("CYGWIN");
>+  allow_ntea = ntea_on (cygwin);
>+  allow_ntsec = ntsec_on (cygwin) ||
>+    (has_capability (HAS_NTSEC_BY_DEFAULT) && !ntsec_off (cygwin));
>+
>+  /*
>+   * `ntea' is an emulation of POSIX attributes. It doesn't support
>+   * real file level security as ntsec on NTFS file systems does
>+   * but it supports FAT filesystems. `ntea' is minimum requirement
>+   * for security checks.
>+   */
>+  if (allow_ntea)
>+    return 1;
>+
>+  /*
>+   * Retrieve file system flags. In Cygwin, file system flags are
>+   * copied to f_type which has no meaning in Win32 itself.
>+   */
>+  if (statfs (filename, &fsstat))
>+    return 1;
>+
>+  /*
>+   * Only file systems supporting ACLs are able to set permissions.
>+   * `ntsec' is the setting in Cygwin which switches using of NTFS
>+   * ACLs to support POSIX permissions on files.
>+   */
>+  if (fsstat.f_type & FS_PERSISTENT_ACLS)
>+    return allow_ntsec;
>+
>+  return 0;
>+}
>+
> extern "C" unsigned long
> cygwin_internal (cygwin_getinfo_types t, ...)
> {
>@@ -246,6 +350,11 @@ cygwin_internal (cygwin_getinfo_types t,
> 	  pid_t pid = va_arg (arg, pid_t);
> 	  pinfo p (pid);
> 	  return (DWORD) p->cmdline (n);
>+	}
>+      case CW_CHECK_NTSEC:
>+	{
>+	  char *filename = va_arg (arg, char *);
>+	  return check_ntsec (filename);
> 	}
>       default:
> 	return (DWORD) -1;
>Index: include/cygwin/version.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/include/cygwin/version.h,v
>retrieving revision 1.112
>diff -u -p -r1.112 version.h
>--- include/cygwin/version.h	19 Mar 2003 20:13:57 -0000	1.112
>+++ include/cygwin/version.h	2 Apr 2003 11:43:29 -0000
>@@ -197,12 +197,13 @@ details. */
> 		  fgetpos64 fopen64 freopen64 fseeko64 fsetpos64 ftello64
> 		  _open64 _lseek64 _fstat64 _stat64 mknod32
>        80: Export pthread_rwlock stuff
>+       81: CW_CHECK_NTSEC addition to external.cc
>      */
> 
>      /* Note that we forgot to bump the api for ualarm, strtoll, strtoull */
> 
> #define CYGWIN_VERSION_API_MAJOR 0
>-#define CYGWIN_VERSION_API_MINOR 80
>+#define CYGWIN_VERSION_API_MINOR 81
> 
>      /* There is also a compatibity version number associated with the
> 	shared memory regions.  It is incremented when incompatible
>Index: include/sys/cygwin.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/include/sys/cygwin.h,v
>retrieving revision 1.42
>diff -u -p -r1.42 cygwin.h
>--- include/sys/cygwin.h	28 Mar 2003 14:21:40 -0000	1.42
>+++ include/sys/cygwin.h	2 Apr 2003 11:43:29 -0000
>@@ -71,7 +71,8 @@ typedef enum
>     CW_STRACE_ACTIVE,
>     CW_CYGWIN_PID_TO_WINPID,
>     CW_EXTRACT_DOMAIN_AND_USER,
>-    CW_CMDLINE
>+    CW_CMDLINE,
>+    CW_CHECK_NTSEC
>   } cygwin_getinfo_types;
> 
> #define CW_NEXTPID	0x80000000	/* or with pid to get next one */

>2003-04-02  Jason Tishler <jason@tishler.net>
>	    Corinna Vinschen  <corinna@vinschen.de>
>
>	* external.cc (is_winnt): New define.
>	(ntsec_on): New macro.
>	(ntsec_off): Ditto.
>	(ntea_on): Ditto.
>	(HAS_CREATE_TOKEN): New define.
>	(HAS_NTSEC_BY_DEFAULT): Ditto.
>	(has_capability): New function.
>	(check_ntsec): Ditto.
>	(cygwin_internal): Add CW_CHECK_NTSEC handling to call check_ntsec()
>	from applications.
>	* include/cygwin/version.h: Bump API minor number.
>	* include/sys/cygwin.h (cygwin_getinfo_types): Add CW_CHECK_NTSEC.

>#include <stdio.h>
>#include <sys/cygwin.h>
>
>int
>main(int argc, char* argv[])
>{
>  const char* filename = argv[1];
>  unsigned long status = cygwin_internal(CW_CHECK_NTSEC, filename);
>  printf("%lu = check_ntsec(%s)\n", status, filename);
>  return 0;
>}
