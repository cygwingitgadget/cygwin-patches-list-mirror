Return-Path: <cygwin-patches-return-5159-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20810 invoked by alias); 22 Nov 2004 17:47:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20204 invoked from network); 22 Nov 2004 17:46:48 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 22 Nov 2004 17:46:48 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id iAMHkkrc009198
	for <cygwin-patches@cygwin.com>; Mon, 22 Nov 2004 12:46:46 -0500 (EST)
Date: Mon, 22 Nov 2004 17:47:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041120062339.GA31757@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0411221240590.20353@slinky.cs.nyu.edu>
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q4/txt/msg00160.txt.bz2

On Sat, 20 Nov 2004, Christopher Faylor wrote:

> Here's the good news/bad news.
>
> On Tue, Nov 16, 2004 at 10:56:40AM -0500, Christopher Faylor wrote:
> >The simplification of the code from removing all of the reparenting
> >considerations is not something that I'm going to give up on easily.
>
> Well, the code seems to be slightly faster now than the old method,
> so that's something.  I think it's also a lot simpler.
>
> There are some ancillary benefits of this new approach.  I've fixed the
> old problem where if you run a process from a windows command prompt and
> that process execs another process and it execs another process, each
> process will wait around into the final process in the chain dies.
>
> I've also added an 'exitcode' field to _pinfo so that a Cygwin process
> will set the error code in a UNIX fashion based on whether it is exiting
> due to a signal or with a normal exit().  Unfortunately, this means that
> I don't know quite what to do with exit codes from Windows processes.
> This is the last remaining problem before I check things in.  This
> problem just occurred to me as I was typing in the ChangeLog and it may
> be the one reason why you actually need to do the reparenting tango.

Can the code simply propagate the actual exit code into the exitcode field
(since Windows programs don't know about signals)?  Besides, I recall that
there could be a problem if the Windows program had a negative exit code,
since it treads upon special bit flags.  Can we just mask the higher bits
of the signal?  If that means that -2 becomes 126 -- so be it.

> What do you want to bet that someone is relying on exit codes from a
> non-cygwin java program?  Blech.

Oh, bet on it.  Ant relies on exactly that.  Blech, indeed.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
