Return-Path: <cygwin-patches-return-5279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29304 invoked by alias); 23 Dec 2004 23:28:25 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 29282 invoked from network); 23 Dec 2004 23:28:20 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.186.67)
  by sourceware.org with SMTP; 23 Dec 2004 23:28:20 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I97817-00C5XD-FU
	for cygwin-patches@cygwin.com; Thu, 23 Dec 2004 18:31:55 -0500
Message-Id: <3.0.5.32.20041223182306.00824b60@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Thu, 23 Dec 2004 23:28:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <41C9C2DB.99D0D9F3@phumblet.no-ip.org>
References: <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org>
 <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
 <3.0.5.32.20041202211311.00820770@incoming.verizon.net>
 <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net>
 <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net>
 <20041205010020.GA20101@trixie.casa.cgf.cx>
 <20041213202505.GB27768@trixie.casa.cgf.cx>
 <41BEFBA5.97CA687B@phumblet.no-ip.org>
 <20041214154214.GE498@trixie.casa.cgf.cx>
 <41C99D2A.B5C4C418@phumblet.no-ip.org>
 <41C9C088.9E9B16E3@phumblet.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00280.txt.bz2

I have run some more tests with a built from cvs this afternoon
and peeked at some of the changes, so here is some feedback.

When a process is terminated from Windows, the reported exit code
is 0. This can easily be fixed by initializing exitcode to
the value it should take when a process is terminated.

If my spawn(P_DETACH) program of yesterday is terminated from 
Windows during the sleep interval, then the parent process does
not notice the termination and keeps waiting.

This can be fixed with my lunch time ideas of yesterday.
Looking at the code, I saw that most of them were already 
implemented. The only changes are:
1) remove child_proc_info->parent_wr_proc_pipe stuff
2) in pinfo::wait, duplicate into non-inheritable wr_proc_pipe
3) make wr_proc_pipe inheritable just before exec
4) make wr_proc_pipe non-inheritable when starting after exec
 (or better? at the first fork or spawn, leaving 2) as currently done)

Comments on pinfo.cc comments:
Delete: "but, unfortunately, reparenting is still needed ..."
        It's really gone, isn't it?
Update: "We could just let this happen automatically when the process.."
        to indicate it's needed by P_DETACH (at least with current code)

Pierre

