Return-Path: <cygwin-patches-return-4419-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5492 invoked by alias); 17 Nov 2003 22:31:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5476 invoked from network); 17 Nov 2003 22:31:41 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Mon, 17 Nov 2003 22:31:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: Corinna Vinschen <cygwin-patches@cygwin.com>
cc: newlib@sources.redhat.com
Subject: Re: (fhandler_base::lseek): Include high order bits in return.
In-Reply-To: <20031117221509.GP18706@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0311171628330.922@eos>
References: <Pine.GSO.4.56.0311171454590.922@eos> <Pine.GSO.4.56.0311171538130.922@eos>
 <20031117221509.GP18706@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-SW-Source: 2003-q4/txt/msg00138.txt.bz2

On Mon, 17 Nov 2003, Corinna Vinschen wrote:

> On Mon, Nov 17, 2003 at 03:40:46PM -0600, Brian Ford wrote:
> > On Mon, 17 Nov 2003, Brian Ford wrote:
> >
> > > This bug fix got our app past its first problem with > 2 Gig files, but
> > > then it tripped over ftello.  I'm still trying to figure that one out.
> > >
> > > It looks like it got a 32 bit sign extended value somewhere.  Any help would
> > > be appreciated.  Thanks.
> > >
> > Well, that somewhere is ftello64.c line 111.  fp->_offset has a 32 bit
> > sign extended value.  Anybody know how it got there?
>
> That can't be it.  fp is of type FILE which is actually mapped to
> __sFILE64 in 64 bit case.  See newlib/libc/include/sys/reent.h.
> _offset is of type _off64_t there.
>
I think you misunderstood.  fp->_offset is a 64 bit type, but at the
ftello call in question, it contains a value that must have come from a 32
bit sign extension.  That's why I asked for help, because I have to figure
out what/who put it there.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
