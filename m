Return-Path: <cygwin-patches-return-5272-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31047 invoked by alias); 22 Dec 2004 18:44:46 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 30956 invoked from network); 22 Dec 2004 18:44:36 -0000
Received: from unknown (HELO apmail1.astralpoint.com) (65.114.186.130)
  by sourceware.org with SMTP; 22 Dec 2004 18:44:36 -0000
Received: from [127.0.0.1] (helo=phumblet.no-ip.org)
	by usched40576.usa1ma.alcatel.com with esmtp (Exim 4.43)
	id I95021-00007W-IV
	for cygwin-patches@cygwin.com; Wed, 22 Dec 2004 13:44:25 -0500
Message-ID: <41C9C088.9E9B16E3@phumblet.no-ip.org>
Date: Wed, 22 Dec 2004 18:44:00 -0000
From: "Pierre A. Humblet" <pierre@phumblet.no-ip.org>
Reply-To: pierre.humblet@ieee.org
MIME-Version: 1.0
CC: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
References: <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx> <20041120062339.GA31757@trixie.casa.cgf.cx> <3.0.5.32.20041202211311.00820770@incoming.verizon.net> <3.0.5.32.20041204114528.0081fc00@incoming.verizon.net> <3.0.5.32.20041204130111.0081fd50@incoming.verizon.net> <20041205010020.GA20101@trixie.casa.cgf.cx> <20041213202505.GB27768@trixie.casa.cgf.cx> <41BEFBA5.97CA687B@phumblet.no-ip.org> <20041214154214.GE498@trixie.casa.cgf.cx> <41C99D2A.B5C4C418@phumblet.no-ip.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-SW-Source: 2004-q4/txt/msg00273.txt.bz2



"Pierre A. Humblet" wrote:
>
> When running try_spawn with the snapshot, during the sleep period
> ps reports
> 
>       690     443     690        232    0 11054 10:32:21 <defunct>
>       464     690     690        464    0 11054 10:32:21 /c/WINNT/system32/notepad

FWIW, I was thinking about this during lunch.
The basic issue is that the pipe to the parent is not closed in the spawned
Windows process. One way out is to make the pipe non-inheritable and
duplicate it either in the parent (fork and spawn, except detach)
or in the child (exec). Now that subproc_ready is back, it doesn't matter
that an exec'ed Windows process does not duplicate the pipe.

Pierre
