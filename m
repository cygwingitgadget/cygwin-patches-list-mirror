Return-Path: <cygwin-patches-return-5203-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8195 invoked by alias); 14 Dec 2004 14:41:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8182 invoked from network); 14 Dec 2004 14:41:47 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 14 Dec 2004 14:41:47 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I8PVHI-0000N5-HN
	for cygwin-patches@cygwin.com; Tue, 14 Dec 2004 09:41:42 -0500
Message-ID: <41BEFBA5.97CA687B@phumblet.no-ip.org>
Date: Tue, 14 Dec 2004 14:41:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
References: <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00204.txt.bz2



Christopher Faylor wrote:
> 
> With the current CVS, I am seeing the same (suboptimal) behavior on
> Windows Me that I do in 1.5.12.
>
> If I type a bunch of "sleep 60&" at the command line, then "bash" won't
> exit until the last sleep 60 has terminated.  I can't explain why this
> is.  It doesn't work that way on XP, of course.
> 
> While "bash" is waiting, I see no sign of it in the process table so
> it's odd behavior.

1.5.12, the current official release? I have never observed it there.
Also my recollection is that the delay was not necessarily equal
to the sleep duration.

> The current CVS should work better with exim now, though.

Are you done with the changes? I will try a snapshot and look at the
code in the coming days. Not much free time currently.

Pierre
