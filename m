From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Sat, 04 Aug 2001 14:21:00 -0000
Message-id: <20010804172101.B4457@redhat.com>
References: <20010731203820.U490@cygbert.vinschen.de> <20010803144012.X23782@cygbert.vinschen.de> <996843821.24208.3.camel@lifelesswks> <20010803151518.Y23782@cygbert.vinschen.de> <996845317.24251.9.camel@lifelesswks> <20010804215935.N23782@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00053.html

On Sat, Aug 04, 2001 at 09:59:35PM +0200, Corinna Vinschen wrote:
>On Fri, Aug 03, 2001 at 11:39:03PM +1000, Robert Collins wrote:
>> Have you tried touch /etc/passwd? 
>> What I mean is that the following code cycle seems inevitable to me :
>> 
>> read_etc_password
>> \->check_state
>>    \->stat()
>>       \->check acls
>>          \->(couple of steps here from memory)
>>             \->read_etc_password
>>                \->check_state
>> 
>> and so on. There was a similar loop with fopen() whcih we discussed when
>> we introduced getpwuid_r.
>
>I haven't found such a problem. I had no endless loop. However, I have
>a redefined solution which doesn't use stat(). Instead it converts
>the /etc/passwd and /etc/group paths to win32 paths and accesses them
>directly using FileFirstFind() which should be way faster.

This is probably ok but there is a potential gotcha if the user changes
a mount or makes a symbolic link to /etc/passwd or something.

>If we additionally change the read_etc_passwd() and read_etc_group()
>code so that direct win32 calls are used for reading the files, we could
>perhaps speed up Cygwin again a few percent.

I think we'd get much more savings by moving /etc/passwd info into either
the cygwin heap or shared memory so that /etc/passwd wasn't read by
each exec'ed process.  Then the file would only be read when it was
needed.

Actually, it's possible that /etc/passwd isn't read by an exec'ed process
now unless it needs to look up a uid other than it's own.  I don't know
for sure.

cgf
>The ChangeLog is the same as in my first mail.
>
>Corinna
>
>Index: grp.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/grp.cc,v
>retrieving revision 1.26
>diff -u -p -r1.26 grp.cc
>--- grp.cc	2001/07/26 19:22:24	1.26
>+++ grp.cc	2001/08/04 19:57:07
>@@ -23,6 +23,7 @@ details. */
> #include "security.h"
> #include "fhandler.h"
> #include "dtable.h"
>+#include "path.h"
> #include "cygheap.h"
> #include "cygerrno.h"
> 
>@@ -51,8 +52,48 @@ enum grp_state {
>   emulated,
>   loaded
> };
>-static grp_state group_state = uninitialized;
>+class grp_check {
>+  grp_state state;
>+  FILETIME  last_modified;
>+  char	    grp_w32[MAX_PATH];
> 
>+public:
>+  grp_check () : state (uninitialized)
>+    {
>+      last_modified.dwLowDateTime = last_modified.dwHighDateTime = 0;
>+      grp_w32[0] = '\0';
>+    }
>+  operator grp_state ()
>+    {
>+      HANDLE h;
>+      WIN32_FIND_DATA data;
>+
>+      if (!grp_w32[0])	/* First call. */
>+	{
>+	  path_conv g ("/etc/group", PC_SYM_FOLLOW | PC_FULL);
>+	  if (!g.error)
>+	    strcpy (grp_w32, g.get_win32 ());
>+	}
>+
>+      if ((h = FindFirstFile (grp_w32, &data)) != INVALID_HANDLE_VALUE)
>+	{
>+	  if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
>+	    {
>+	      state = uninitialized;
>+	      last_modified = data.ftLastWriteTime;
>+	    }
>+	  FindClose (h);
>+        }
>+      return state;
>+    }
>+  void operator = (grp_state nstate)
>+    {
>+      state = nstate;
>+    }
>+};
>+
>+static grp_check group_state;
>+
> static int
> parse_grp (struct group &grp, const char *line)
> {
>@@ -153,6 +194,7 @@ read_etc_group ()
>   if (group_state != initializing)
>     {
>       group_state = initializing;
>+      curr_lines = 0;
> 
>       FILE *f = fopen (etc_group, "rt");
> 
>Index: passwd.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/passwd.cc,v
>retrieving revision 1.27
>diff -u -p -r1.27 passwd.cc
>--- passwd.cc	2001/07/26 19:22:24	1.27
>+++ passwd.cc	2001/08/04 19:57:07
>@@ -17,6 +17,7 @@ details. */
> #include "security.h"
> #include "fhandler.h"
> #include "dtable.h"
>+#include "path.h"
> #include "sync.h"
> #include "sigproc.h"
> #include "pinfo.h"
>@@ -40,8 +41,49 @@ enum pwd_state {
>   emulated,
>   loaded
> };
>-static pwd_state passwd_state = uninitialized;
>+class pwd_check {
>+  pwd_state state;
>+  FILETIME  last_modified;
>+  char	    pwd_w32[MAX_PATH];
> 
>+public:
>+  pwd_check () : state (uninitialized)
>+    {
>+      last_modified.dwLowDateTime = last_modified.dwHighDateTime = 0;
>+      pwd_w32[0] = '\0';
>+    }
>+  operator pwd_state ()
>+    {
>+      HANDLE h;
>+      WIN32_FIND_DATA data;
>+
>+      if (!pwd_w32[0])	/* First call. */
>+	{
>+	  path_conv p ("/etc/passwd", PC_SYM_FOLLOW | PC_FULL);
>+	  if (!p.error)
>+	    strcpy (pwd_w32, p.get_win32 ());
>+	}
>+
>+      if ((h = FindFirstFile (pwd_w32, &data)) != INVALID_HANDLE_VALUE)
>+	{
>+	  if (CompareFileTime (&data.ftLastWriteTime, &last_modified) > 0)
>+	    {
>+	      state = uninitialized;
>+	      last_modified = data.ftLastWriteTime;
>+	    }
>+	  FindClose (h);
>+        }
>+      return state;
>+    }
>+  void operator = (pwd_state nstate)
>+    {
>+      state = nstate;
>+    }
>+};
>+
>+static pwd_check passwd_state;
>+
>+
> /* Position in the passwd cache */
> #ifdef _MT_SAFE
> #define pw_pos  _reent_winsup ()->_pw_pos
>@@ -140,6 +182,7 @@ read_etc_passwd ()
>     if (passwd_state != initializing)
>       {
> 	passwd_state = initializing;
>+	curr_lines = 0;
> 
> 	FILE *f = fopen ("/etc/passwd", "rt");
> 
>
>-- 
>Corinna Vinschen                  Please, send mails regarding Cygwin to
>Cygwin Developer                                mailto:cygwin@cygwin.com
>Red Hat, Inc.

-- 
cgf@cygnus.com                        Red Hat, Inc.
http://sources.redhat.com/            http://www.redhat.com/
