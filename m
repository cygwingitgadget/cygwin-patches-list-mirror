Return-Path: <cygwin-patches-return-5161-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22729 invoked by alias); 22 Nov 2004 18:20:55 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22688 invoked from network); 22 Nov 2004 18:20:47 -0000
Received: from unknown (HELO slinky.cs.nyu.edu) (128.122.20.14)
  by sourceware.org with SMTP; 22 Nov 2004 18:20:47 -0000
Received: from localhost (localhost [127.0.0.1])
	by slinky.cs.nyu.edu (8.12.10+Sun/8.12.10) with ESMTP id iAMIKjrc012895
	for <cygwin-patches@cygwin.com>; Mon, 22 Nov 2004 13:20:45 -0500 (EST)
Date: Mon, 22 Nov 2004 18:20:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fixing the PROCESS_DUP_HANDLE security hole.
In-Reply-To: <20041122181301.GD32063@trixie.casa.cgf.cx>
Message-ID: <Pine.GSO.4.61.0411221317140.20353@slinky.cs.nyu.edu>
References: <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111224857.00819b20@incoming.verizon.net>
 <3.0.5.32.20041111235225.00818340@incoming.verizon.net>
 <20041114051158.GG7554@trixie.casa.cgf.cx> <20041116054156.GA17214@trixie.casa.cgf.cx>
 <419A1F7B.8D59A9C9@phumblet.no-ip.org> <20041116155640.GA22397@trixie.casa.cgf.cx>
 <20041120062339.GA31757@trixie.casa.cgf.cx> <Pine.GSO.4.61.0411221240590.20353@slinky.cs.nyu.edu>
 <20041122181301.GD32063@trixie.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q4/txt/msg00162.txt.bz2

On Mon, 22 Nov 2004, Christopher Faylor wrote:

> On Mon, Nov 22, 2004 at 12:46:46PM -0500, Igor Pechtchanski wrote:
> >Can the code simply propagate the actual exit code into the exitcode
> >field (since Windows programs don't know about signals)?
>
> And who would use it?  How would a UNIX program know that the "negative"
> exit code represented a windows error code?  A UNIX program would
> interpret the low order bytes as indicating a signal number and would
> think that there was a core dump if the appropriate bit was set.  The
> exitcode field is just for use by the cygwin DLL.  There is no way for a
> UNIX program to get more than eight bits (seven bits for signals) of
> exit code from a process.

Isn't that exactly what I said in the part that was snipped?  As long as
ant (as a Cygwin shell script), for example, can rely on handling Java
programs that exit with code 1 or 2 (as opposed to 0), it should be fine.
I don't think any portable program uses negative exit codes for anything
other than indicating some sort of failure (for which a positive exit code
would do just fine).  And I don't think we should care about non-portable
scripts/programs.
	Igor
-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"The Sun will pass between the Earth and the Moon tonight for a total
Lunar eclipse..." -- WCBS Radio Newsbrief, Oct 27 2004, 12:01 pm EDT
