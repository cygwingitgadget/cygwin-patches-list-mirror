Return-Path: <cygwin-patches-return-4503-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21574 invoked by alias); 12 Dec 2003 19:33:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21564 invoked from network); 12 Dec 2003 19:33:09 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Fri, 12 Dec 2003 19:33:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Re: termios.cc: Restore setting of EBADF appropriately throughout
In-Reply-To: <20031212192036.GA6287@redhat.com>
Message-ID: <Pine.GSO.4.58.0312121329510.23399@eos>
References: <Pine.GSO.4.58.0312121305400.23399@eos> <20031212192036.GA6287@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00222.txt.bz2

On Fri, 12 Dec 2003, Christopher Faylor wrote:
> On Fri, Dec 12, 2003 at 01:14:32PM -0600, Brian Ford wrote:
> >I noticed this while digging through other serial port problems.  It
> >appears to have been lost in version 1.16, although there did not appear
> >to be a reason for the loss in that change.  Please let me know if it was
> >intentional for some reason that I do not understand.  Thanks.
> >
> >2003-12-12  Brian Ford  <ford@vss.fsi.com>
> >
> >	* termios.cc: Restore setting of EBADF appropriately throughout.
> >	Lost in version 1.16.
> >
> I think you've missed the fact that cygheap_fdget sets errno.  That is part of
> the reason for its existence.  If it is not doing that, then that's the bug
> which needs to be fixed.
>
Yep, missed it.  Sorry, I guess I keep expecting things to be more
orthogonal than they are.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
