Return-Path: <cygwin-patches-return-5443-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3987 invoked by alias); 11 May 2005 00:55:53 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3903 invoked from network); 11 May 2005 00:55:43 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.140.130)
  by sourceware.org with SMTP; 11 May 2005 00:55:43 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IGAVT1-0001TO-DA
	for cygwin-patches@cygwin.com; Tue, 10 May 2005 20:53:25 -0400
Message-Id: <3.0.5.32.20050510205301.00b4b658@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Wed, 11 May 2005 00:55:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
In-Reply-To: <20050510151138.GT15665@trixie.casa.cgf.cx>
References: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
 <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
 <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q2/txt/msg00039.txt.bz2

At 11:11 AM 5/10/2005 -0400, Christopher Faylor wrote:
>Could we see this as a unified-diff please?

Oops, but in retrospect it's a good thing. I did some more tests.

If c:\dev exists, then mkdir /dev/tty created c:\dev\tty (ditto
for the other /dev/xxx ), but rmdir /dev/tty would not delete 
c:\dev\tty
mkdir /cygdrive created c:\cygwin\cygdrive 

So I restrained mkdir to only act on FH_FS.

Ideally mkdir & rmdir should be part of the various handlers, but
there is no current payoff in doing so as directories can only be
created/deleted on FH_FS 

>On Mon, May 09, 2005 at 08:16:36PM -0400, Pierre A. Humblet wrote:
>>At 06:19 PM 5/9/2005 +0000, Eric Blake wrote:
>>
>>>Second, the sequence chdir("//"), mkdir("machine") creates machine in the 
>>>current directory.
>>
>>Old bug. 
>>chdir("/proc"), mkdir("machine") produces the same result.
>>And mkdir("/proc"), mkdir("/proc/machine") creates c:\proc\machine
>>
>>The fix sets errno to EROFS, which is what rmdir is already doing.
>>Is that OK for coreutils?

Pierre
  
2005-05-11  Pierre Humblet <pierre.humblet@ieee.org>

	* dir.cc (isrofs): New function.
	(mkdir): Check for FH_FS and use isrofs.
	(rmdir): Use isrofs.




Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.84
diff -u -p -r1.84 dir.cc
--- dir.cc      16 Mar 2005 21:20:56 -0000      1.84
+++ dir.cc      11 May 2005 00:38:11 -0000
@@ -216,6 +216,13 @@ closedir (DIR *dir)
   return res;
 }
 
+inline bool 
+isrofs(DWORD devn) 
+{
+  return devn == FH_PROC || devn == FH_REGISTRY 
+    || devn == FH_PROCESS || devn == FH_NETDRIVE;
+}
+
 /* mkdir: POSIX 5.4.1.1 */
 extern "C" int
 mkdir (const char *dir, mode_t mode)
@@ -231,6 +238,14 @@ mkdir (const char *dir, mode_t mode)
       set_errno (real_dir.case_clash ? ECASECLASH : real_dir.error);
       goto done;
     }
+  if (real_dir.get_devn () != FH_FS)
+    {
+      if (isrofs (real_dir.get_devn ()))
+       set_errno (EROFS);
+      else
+       set_errno (EEXIST);
+      goto done;
+    }
 
   nofinalslash (real_dir.get_win32 (), real_dir.get_win32 ());
 
@@ -263,14 +278,12 @@ extern "C" int
 rmdir (const char *dir)
 {
   int res = -1;
-  DWORD devn;
 
   path_conv real_dir (dir, PC_SYM_NOFOLLOW | PC_FULL);
 
   if (real_dir.error)
     set_errno (real_dir.error);
-  else if ((devn = real_dir.get_devn ()) == FH_PROC || devn == FH_REGISTRY
-          || devn == FH_PROCESS)
+  else if (isrofs (real_dir.get_devn ()))
     set_errno (EROFS);
   else if (!real_dir.exists ())
     set_errno (ENOENT);
