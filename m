Return-Path: <cygwin-patches-return-5145-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7438 invoked by alias); 20 Nov 2004 06:23:09 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7416 invoked from network); 20 Nov 2004 06:23:04 -0000
Received: from unknown (HELO cgf.cx) (66.30.17.189)
  by sourceware.org with SMTP; 20 Nov 2004 06:23:04 -0000
Received: by cgf.cx (Postfix, from userid 201)
	id 1CA161B3E5; Sat, 20 Nov 2004 01:23:39 -0500 (EST)
Date: Sat, 20 Nov 2004 06:23:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
Message-ID: <20041120062339.GA31757@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111224857.00819b20@incoming.verizon.net> <3.0.5.32.20041111235225.00818340@incoming.verizon.net> <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx> <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116155640.GA22397@trixie.casa.cgf.cx>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q4/txt/msg00146.txt.bz2

Here's the good news/bad news.

On Tue, Nov 16, 2004 at 10:56:40AM -0500, Christopher Faylor wrote:
>The simplification of the code from removing all of the reparenting
>considerations is not something that I'm going to give up on easily.

Well, the code seems to be slightly faster now than the old method,
so that's something.  I think it's also a lot simpler.

There are some ancillary benefits of this new approach.  I've fixed the
old problem where if you run a process from a windows command prompt and
that process execs another process and it execs another process, each
process will wait around into the final process in the chain dies.

I've also added an 'exitcode' field to _pinfo so that a Cygwin process
will set the error code in a UNIX fashion based on whether it is exiting
due to a signal or with a normal exit().  Unfortunately, this means that
I don't know quite what to do with exit codes from Windows processes.
This is the last remaining problem before I check things in.  This
problem just occurred to me as I was typing in the ChangeLog and it may
be the one reason why you actually need to do the reparenting tango.

What do you want to bet that someone is relying on exit codes from a
non-cygwin java program?  Blech.

cgf
