Return-Path: <cygwin-patches-return-4238-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13401 invoked by alias); 26 Sep 2003 02:17:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13390 invoked from network); 26 Sep 2003 02:17:27 -0000
Date: Fri, 26 Sep 2003 02:17:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: {Patch]: Giving access to pinfo after seteuid and exec
Message-ID: <20030926021722.GA30575@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.5.32.20030925214748.0081f330@incoming.verizon.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00254.txt.bz2

On Thu, Sep 25, 2003 at 09:47:48PM -0400, Pierre A. Humblet wrote:
>This patch sets the _pinfo acl in order to allow access after 
>seteuid and exec.
>
>While looking at spawn.cc I also noticed oddities in pinfo related
>error handling, and reworked them. I also restored impersonation in
>case of CreateProcessAsUser failure.
>
>Pierre
>
>2003-09-25  Pierre Humblet <pierre.humblet@ieee.org>
>
>	* pinfo.h (pinfo::set_acl): Declare.
>	* pinfo.cc (pinfo_fixup_after_fork): Duplicate with no rights.
>	(pinfo::set_acl): New.
>	* spawn.cc (spawn_guts): Call myself.set_acl. Always reimpersonate
>	after errors. Fix pinfo related error cases. 
>Index: pinfo.h
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/pinfo.h,v
>retrieving revision 1.52
>diff -u -p -r1.52 pinfo.h
>--- pinfo.h	25 Sep 2003 00:37:17 -0000	1.52
>+++ pinfo.h	26 Sep 2003 00:57:08 -0000
>@@ -176,6 +176,7 @@ public:
>   }
> #endif
>   HANDLE shared_handle () {return h;}
>+  void set_acl();
> };
>
> #define ISSTATE(p, f)	(!!((p)->process_state & f))
>Index: pinfo.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/pinfo.cc,v
>retrieving revision 1.88
>diff -u -p -r1.88 pinfo.cc
>--- pinfo.cc	25 Sep 2003 00:37:17 -0000	1.88
>+++ pinfo.cc	26 Sep 2003 00:57:09 -0000
>@@ -30,6 +30,7 @@ details. */
> #include "shared_info.h"
> #include "cygheap.h"
> #include "fhandler.h"
>+#include <aclapi.h>
>
> static char NO_COPY pinfo_dummy[sizeof (_pinfo)] = {0};
>
>@@ -42,9 +43,9 @@ pinfo_fixup_after_fork ()
> {
>   if (hexec_proc)
>     CloseHandle (hexec_proc);
>-
>+  /* Keeps the cygpid from being reused. No rights required */
>   if (!DuplicateHandle (hMainProc, hMainProc, hMainProc, &hexec_proc, 0,
>-			TRUE, DUPLICATE_SAME_ACCESS))
>+			TRUE, 0))
>     {
>       system_printf ("couldn't save current process handle %p, %E", hMainProc);
>       hexec_proc = NULL;
>@@ -236,6 +237,22 @@ pinfo::init (pid_t n, DWORD flag, HANDLE
>       break;
>     }
>   destroy = 1;
>+}
>+
>+void
>+pinfo::set_acl()
>+{
>+  char sa_buf[1024];
>+  SECURITY_DESCRIPTOR sd;
>+
>+  sec_acl ((PACL) sa_buf, true, true, cygheap->user.sid (),
>+	   well_known_world_sid, FILE_MAP_READ | FILE_MAP_READ); /* FIXME */
>+  if (!InitializeSecurityDescriptor( &sd, SECURITY_DESCRIPTOR_REVISION))
>+    debug_printf("InitializeSecurityDescriptor %E");
>+  else if (!SetSecurityDescriptorDacl(&sd, TRUE, (PACL) sa_buf, FALSE))
>+    debug_printf("SetSecurityDescriptorDacl %E");
>+  else if (!SetKernelObjectSecurity(h, DACL_SECURITY_INFORMATION, &sd))
>+    debug_printf ("SetKernelObjectSecurity %E");
> }
>
> bool
>Index: spawn.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/spawn.cc,v
>retrieving revision 1.132
>diff -u -p -r1.132 spawn.cc
>--- spawn.cc	25 Sep 2003 13:49:21 -0000	1.132
>+++ spawn.cc	26 Sep 2003 00:57:11 -0000
>@@ -672,7 +672,9 @@ spawn_guts (const char * prog_arg, const
>   else
>     {
>       PSID sid = cygheap->user.sid ();
>-
>+      /* Give access to myself */
>+      if (mode == _P_OVERLAY)
>+	myself.set_acl();
>       /* Set security attributes with sid */
>       PSECURITY_ATTRIBUTES sec_attribs = sec_user_nih (sa_buf, sid);
>
>@@ -711,7 +713,7 @@ spawn_guts (const char * prog_arg, const
>
>   /* Restore impersonation. In case of _P_OVERLAY this isn't
>      allowed since it would overwrite child data. */
>-  if (mode != _P_OVERLAY)
>+  if (mode != _P_OVERLAY || !rc)
>       cygheap->user.reimpersonate ();

I was looking at the above today.  Don't you have to reimpersonate regardless
of whether the CreateProcess succeeded?

I'll check in the rest of the spawn.cc stuff with some modifications.  I see
I missed some cases with the addition of _P_SYSTEM.

cgf
