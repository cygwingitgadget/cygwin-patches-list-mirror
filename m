Return-Path: <cygwin-patches-return-2641-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 15208 invoked by alias); 12 Jul 2002 21:35:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 15194 invoked from network); 12 Jul 2002 21:35:23 -0000
Date: Fri, 12 Jul 2002 14:35:00 -0000
To: cygwin-patches@cygwin.com
Subject: Re: cygwin.din
Message-ID: <20020712213532.GB12262@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <002901c229e9$3ec34aa0$6132bc3e@BABEL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002901c229e9$3ec34aa0$6132bc3e@BABEL>
User-Agent: Mutt/1.3.23.1i
drom: Christopher Faylor <cgf@redhat.com>
From: cgf@redhat.com (Christopher Faylor)
X-SW-Source: 2002-q3/txt/msg00089.txt.bz2

On Fri, Jul 12, 2002 at 10:15:26PM +0100, Conrad Scott wrote:
>I've been looking at cygwin.din (again) for a couple of reasons.
>While I was there I noticed a couple of issues and I've attached a
>patch for one (obvious?) typo.
>
>i) The entries for read(2) are:
>
>    _read
>    read = read
>
>  I've included a patch to make this:
>
>    _read
>    read = _read
>
>  (this crept in at 1.49, June this year, by the looks of it).

Thanks.  I've fixed this.

>ii) There's a rather suspicious entry in this file:
>
>    barfly = write
>
>  Uh? or am I missing a joke here?

Maybe it was something I added.  I assume so.  If so, the joke's lost
on me, too.  I was probably just doing some global substitutions and
needed something as a place holder.

>iii) How should I go about adding the new SysV IPC entry points?
>Rob added some as `shmat' etc. (i.e. just one entry, no
>underscore) but should these instead follow the `read' pattern
>above (i.e. as two entries, one with a leading underscore)?

No underscore for these.  The underscores are to be MSVC compliant.
I think that MSVC added the underscore versions to be POSIX compliant
or something.  I wish cygwin had never exported them.

I went through a while ago and got rid of the newlib wrappers that
just have write() call _write() since I didn't understand the point
of having a wrapper doing something that the linker could do for
you automatically.  The above typos are fallout from that.

>iv) More generally, why are there these two symbols (with and
>without the leading underscore) anyhow?  Any pointers for some
>information on this gratefully received.

See above.

cgf
