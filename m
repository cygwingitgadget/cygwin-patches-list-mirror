Return-Path: <cygwin-patches-return-4387-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8929 invoked by alias); 14 Nov 2003 20:41:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8907 invoked from network); 14 Nov 2003 20:41:07 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Fri, 14 Nov 2003 20:41:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: cygwin-patches@cygwin.com
Subject: Re: dtable.cc (build_fh_pc): serial port handling
In-Reply-To: <20031114013739.GC2631@redhat.com>
Message-ID: <Pine.GSO.4.56.0311141425120.9584@eos>
References: <Pine.GSO.4.56.0311111612280.9584@eos> <Pine.GSO.4.56.0311111819230.9584@eos>
 <20031112092733.GB7542@cygbert.vinschen.de> <Pine.GSO.4.56.0311121307230.9584@eos>
 <20031114013739.GC2631@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00106.txt.bz2

On Thu, 13 Nov 2003, Christopher Faylor wrote:

> On Wed, Nov 12, 2003 at 01:24:21PM -0600, Brian Ford wrote:
> >2003-11-12  Brian Ford  <ford@vss.fsi.com>
> >
> >	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
> >	serial ports.  Remove redundant FH_CYGDRIVE case since it is
> >	handled by DEV_CYGDRIVE_MAJOR.
> >
> >FYI, this is the reason I am here:
> >
> >http://www.cygwin.com/ml/cygwin/2003-10/msg01750.html
> >
> >He offered to test my tcflush patch, but reported being unable to
> >open /dev/ttyS0 with the cvs compiled Cygwin.
>
> Reporting that this solved an actual bug would have been useful
> information in the patch.  I was holding off approving this until
> I had a chance to investigate and I'm extremely busy with real
> work this week.
>
Well, I'm busy too, so I understand.  The updated patch and comments were
not meant to push anything.  They should have been taken at face value;
just an update and some background info.

At the moment, I don't have any serial hardware myself to test this patch
with.  And, I haven't had Martin Farnik try it yet either.

However, it certainly looked like an obvious and logical bug fix.  So, I
submitted it for further review after minimal testing.  I did check the
situation out before and after in the debugger.  It looked like a problem
before, and it looked ok after, but that was as far as I went.

Since I'm new here, and even things that look obviously wrong to me are
not always incorrect, I appreciate and am content to wait for a "full"
review.  Even in my regular job, I can often be faulted for checking in an
"obvious" fix/change.  Sometimes, without even compiling it.  I know, I
know, I've got to stop that.

> So, approved and applied.
>
Anyway, thanks.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
