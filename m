Return-Path: <cygwin-patches-return-5163-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5264 invoked by alias); 22 Nov 2004 18:37:05 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4883 invoked from network); 22 Nov 2004 18:36:47 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 22 Nov 2004 18:36:47 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id iAMIajrc014371
	for <cygwin-patches@cygwin.com>; Mon, 22 Nov 2004 13:36:45 -0500 (EST)
Date: Mon, 22 Nov 2004 18:37:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041122183320.GE32063@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0411221333320.20353@slinky.cs.nyu.edu>
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx> <Pine.GSO.4.61.0411221240590.20353@slinky.cs.nyu.edu>
 <20041122181301.GD32063@trixie.casa.cgf.cx> <Pine.GSO.4.61.0411221317140.20353@slinky.cs.nyu.edu>
 <20041122183320.GE32063@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q4/txt/msg00164.txt.bz2

On Mon, 22 Nov 2004, Christopher Faylor wrote:

> On Mon, Nov 22, 2004 at 01:20:45PM -0500, Igor Pechtchanski wrote:
> >On Mon, 22 Nov 2004, Christopher Faylor wrote:
> >
> >> On Mon, Nov 22, 2004 at 12:46:46PM -0500, Igor Pechtchanski wrote:
> >> >Can the code simply propagate the actual exit code into the exitcode
> >> >field (since Windows programs don't know about signals)?
> >>
> >> And who would use it?  How would a UNIX program know that the "negative"
> >> exit code represented a windows error code?  A UNIX program would
> >> interpret the low order bytes as indicating a signal number and would
> >> think that there was a core dump if the appropriate bit was set.  The
> >> exitcode field is just for use by the cygwin DLL.  There is no way for a
> >> UNIX program to get more than eight bits (seven bits for signals) of
> >> exit code from a process.
> >
> >Isn't that exactly what I said in the part that was snipped?
>
> Sort of, but then it's also close what I said I was doing in the
> original message, too, except I said "error code" instead of "exit
> code", maybe that's where the confusion lies:
>
> *I've also added an 'exitcode' field to _pinfo so that a Cygwin process
> *will set the error (sic) code in a UNIX fashion based on whether it is
> *exiting *due to a signal or with a normal exit().
>
> Since a windows program can't exit "due to a signal" the only
> alternative would be to consider it an exit code.

And what I was trying to say (perhaps not as eloquently as I would have
wished) was that it's better, IMO, to mangle the negative exit code from a
Windows app than to let it tread on the reserved bits.  However, I just
realized that if the exitcode field is 8 bits (which you may have implied,
but I most likely missed), the masking I was talking about happens
automatically, so this is a non-issue.  The only question is whether to
still mask out the 8th bit for negative exit codes, or whether it's ok if
Cygwin thinks the Windows program received some sort of a signal...
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
