Return-Path: <cygwin-patches-return-5146-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9026 invoked by alias); 20 Nov 2004 17:59:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8992 invoked from network); 20 Nov 2004 17:59:54 -0000
Received: from unknown (HELO phumblet.no-ip.org) (68.163.190.188)
  by sourceware.org with SMTP; 20 Nov 2004 17:59:54 -0000
Received: from [192.168.1.156] (helo=hpn5170)
	by phumblet.no-ip.org with smtp (Exim 4.43)
	id I7HOT6-002VZD-GY
	for cygwin-patches@cygwin.com; Sat, 20 Nov 2004 13:03:06 -0500
Message-Id: <3.0.5.32.20041120125458.00821b80@incoming.verizon.net>
X-Sender: vze1u1tg@incoming.verizon.net (Unverified)
Date: Sat, 20 Nov 2004 17:59:00 -0000
To: cygwin-patches@cygwin.com
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041120062339.GA31757@trixie.casa.cgf.cx>
References: <20041116155640.GA22397@trixie.casa.cgf.cx>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx>
 <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org>
 <20041116155640.GA22397@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-SW-Source: 2004-q4/txt/msg00147.txt.bz2

At 01:23 AM 11/20/2004 -0500, Christopher Faylor wrote:
>Here's the good news/bad news.
>
>On Tue, Nov 16, 2004 at 10:56:40AM -0500, Christopher Faylor wrote:
>>The simplification of the code from removing all of the reparenting
>>considerations is not something that I'm going to give up on easily.
>
>Well, the code seems to be slightly faster now than the old method,
>so that's something.  I think it's also a lot simpler.
>
>There are some ancillary benefits of this new approach.  I've fixed the
>old problem where if you run a process from a windows command prompt and
>that process execs another process and it execs another process, each
>process will wait around into the final process in the chain dies.
>
>I've also added an 'exitcode' field to _pinfo so that a Cygwin process
>will set the error code in a UNIX fashion based on whether it is exiting
>due to a signal or with a normal exit().  Unfortunately, this means that
>I don't know quite what to do with exit codes from Windows processes.
>This is the last remaining problem before I check things in.  This
>problem just occurred to me as I was typing in the ChangeLog and it may
>be the one reason why you actually need to do the reparenting tango.

For Windows process, why can't you keep doing what was done before
            case WAIT_OBJECT_0:
              sigproc_printf ("subprocess exited");
              DWORD exitcode;
              if (!GetExitCodeProcess (pi.hProcess, &exitcode))
                exitcode = 1;

and copy the Windows exit code to the exitcode field? Or did you remove the
subproc_ready as well?

Pierre
