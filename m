Return-Path: <cygwin-patches-return-5287-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11858 invoked by alias); 24 Dec 2004 05:59:21 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 11813 invoked from network); 24 Dec 2004 05:59:14 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 24 Dec 2004 05:59:14 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I97Q4H-008KH9-KA
	for cygwin-patches@cygwin.com; Fri, 24 Dec 2004 01:02:41 -0500
Message-Id: <3.0.5.32.20041224005402.007c88f0@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Fri, 24 Dec 2004 05:59:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041224052526.GB22543@trixie.casa.cgf.cx>
References: <3.0.5.32.20041223235959.0081ba80@incoming.verizon.net>
 <20041205010020.GA20101@trixie.casa.cgf.cx>
 <20041213202505.GB27768@trixie.casa.cgf.cx>
 <41BEFBA5.97CA687B@phumblet.no-ip.org>
 <20041214154214.GE498@trixie.casa.cgf.cx>
 <41C99D2A.B5C4C418@phumblet.no-ip.org>
 <41C9C088.9E9B16E3@phumblet.no-ip.org>
 <3.0.5.32.20041223182306.00824b60@incoming.verizon.net>
 <3.0.5.32.20041223215420.0082b790@incoming.verizon.net>
 <3.0.5.32.20041223230550.0081e100@incoming.verizon.net>
 <3.0.5.32.20041223235959.0081ba80@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00288.txt.bz2

At 12:25 AM 12/24/2004 -0500, Christopher Faylor wrote:
>On Thu, Dec 23, 2004 at 11:59:59PM -0500, Pierre A. Humblet wrote:
>>At 11:35 PM 12/23/2004 -0500, Christopher Faylor wrote:
>>>I don't think you need it.  You just need to tell a process which is
>>>about to exec after having been execed to make sure that its
>>>wr_proc_pipe is valid.
>>
>>Yes, that's the key. So the question is only about method. Either the parent
>>guarantees that the child has a valid handle, or the child must check
>>that it already has a valid handle or wait until it does. 
>
>I have just implemented code which causes an execed child to wait for the
>parent to fill in its wr_proc_pipe if it is going to exec again.  It uses
>a busy loop but I think it's unlikely that the loop will be exercised too
>often.

It's late, but I am trying to go through all permutations.
Here is a strange one. 
Cygwin process A started from Windows execs a Windows process B.
We are in the case where A
      if (!myself->wr_proc_pipe)
       {
         myself.remember (true);
         wait_for_myself = true;

The problem is that later there is
if (wait_for_myself)
  waitpid (myself->pid, &res, 0);
else
  ciresrv.sync (myself, INFINITE);

Process A takes the first branch (waitpid), although it's the
second branch that will call GetExitCodeProcess.
So A will see its logical self terminate, but it won't get the
exit status of B. 
Right? Going to sleep on this.

Pierre
