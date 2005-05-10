Return-Path: <cygwin-patches-return-5441-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3896 invoked by alias); 10 May 2005 00:19:12 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3846 invoked from network); 10 May 2005 00:19:05 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.193.151)
  by sourceware.org with SMTP; 10 May 2005 00:19:05 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IG8ZGA-0000CG-1M; Mon, 09 May 2005 20:16:58 -0400
Message-Id: <3.0.5.32.20050509201636.00b4e7b8@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Tue, 10 May 2005 00:19:00 -0000
To: Eric Blake <ebb9@byu.net>,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch]: mkdir -p and network drives
In-Reply-To: <loom.20050509T200029-6@post.gmane.org>
References: <3.0.5.32.20050505225708.00b64250@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q2/txt/msg00037.txt.bz2

At 06:19 PM 5/9/2005 +0000, Eric Blake wrote:

>Second, the sequence chdir("//"), mkdir("machine") creates machine in the 
>current directory.

Old bug. 
chdir("/proc"), mkdir("machine") produces the same result.
And mkdir("/proc"), mkdir("/proc/machine") creates c:\proc\machine

The fix sets errno to EROFS, which is what rmdir is already doing.
Is that OK for coreutils?

Pierre
   
2005-05-10  Pierre Humblet <pierre.humblet@ieee.org>

	* dir.cc (isrofs): New function.
	(mkdir): Use isrofs.
	(rmdir): Ditto.


Index: dir.cc
===================================================================
RCS file: /cvs/src/src/winsup/cygwin/dir.cc,v
retrieving revision 1.84
diff -r1.84 dir.cc
218a219,225
> inline bool 
> isrofs(DWORD devn) 
> {
>   return devn == FH_PROC || devn == FH_REGISTRY 
>     || devn == FH_PROCESS || devn == FH_NETDRIVE;
> }
> 
233a241,245
>   else if (isrofs (real_dir.get_devn ()))
>     {
>       set_errno (EROFS);
>       goto done;
>     }
266d277
<   DWORD devn;
272,273c283
<   else if ((devn = real_dir.get_devn ()) == FH_PROC || devn == FH_REGISTRY
<          || devn == FH_PROCESS)
---
>   else if (isrofs (real_dir.get_devn ()))
