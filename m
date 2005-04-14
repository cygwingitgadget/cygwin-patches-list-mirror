Return-Path: <cygwin-patches-return-5410-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32071 invoked by alias); 14 Apr 2005 20:26:31 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 31680 invoked from network); 14 Apr 2005 20:26:22 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.134.223)
  by sourceware.org with SMTP; 14 Apr 2005 20:26:22 -0000
Received: from [192.168.1.10] (helo=Compaq)
	by phumblet.no-ip.org with smtp (Exim 4.50)
	id IEYDZ0-0001HK-7F; Thu, 14 Apr 2005 16:24:25 -0400
Message-Id: <3.0.5.32.20050414162424.00b6d018@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 14 Apr 2005 20:26:00 -0000
To: Kazuhiro Fujieda <fujieda@jaist.ac.jp>,cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: Correct debugging output in seteuid32
In-Reply-To: <uoeci3qdv.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2005-q2/txt/msg00006.txt.bz2

I can see why would one think this is a bug, but it was meant
to be that way. Having a "wrong" gid can make seteuid fail.
Perhaps we could print the new and current uids and the current
gid to cover all cases.

Pierre


At 01:59 PM 4/14/2005 +0900, Kazuhiro Fujieda wrote:
>I'd submit a trivial patch after a long time.
>
>2005-04-14  Kazuhiro Fujieda  <fujieda@jaist.ac.jp>
>
>	* syscalls.cc (setuid32): Correct debugging output.
>
>Index: syscalls.cc
>===================================================================
>RCS file: /cvs/src/src/winsup/cygwin/syscalls.cc,v
>retrieving revision 1.372
>diff -u -u -r1.372 syscalls.cc
>--- syscalls.cc	11 Apr 2005 21:54:54 -0000	1.372
>+++ syscalls.cc	14 Apr 2005 04:45:38 -0000
>@@ -1959,7 +1959,7 @@
> extern "C" int
> seteuid32 (__uid32_t uid)
> {
>-  debug_printf ("uid: %u myself->gid: %u", uid, myself->gid);
>+  debug_printf ("uid: %u myself->uid: %u", uid, myself->uid);
> 
>   if (uid == myself->uid && !cygheap->user.groups.ischanged)
>     {
>
>____
>  | AIST      Kazuhiro Fujieda <fujieda@jaist.ac.jp>
>  | HOKURIKU  School of Information Science
>o_/ 1990      Japan Advanced Institute of Science and Technology
>
>
