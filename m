Return-Path: <cygwin-patches-return-4416-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27418 invoked by alias); 17 Nov 2003 22:15:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 27396 invoked from network); 17 Nov 2003 22:15:10 -0000
Date: Mon, 17 Nov 2003 22:15:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com, newlib@sources.redhat.com
Subject: Re: (fhandler_base::lseek): Include high order bits in return.
Message-ID: <20031117221509.GP18706@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com,
	newlib@sources.redhat.com
References: <Pine.GSO.4.56.0311171454590.922@eos> <Pine.GSO.4.56.0311171538130.922@eos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0311171538130.922@eos>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q4/txt/msg00135.txt.bz2

On Mon, Nov 17, 2003 at 03:40:46PM -0600, Brian Ford wrote:
> On Mon, 17 Nov 2003, Brian Ford wrote:
> 
> > This bug fix got our app past its first problem with > 2 Gig files, but
> > then it tripped over ftello.  I'm still trying to figure that one out.
> >
> > It looks like it got a 32 bit sign extended value somewhere.  Any help would
> > be appreciated.  Thanks.
> >
> Well, that somewhere is ftello64.c line 111.  fp->_offset has a 32 bit
> sign extended value.  Anybody know how it got there?

That can't be it.  fp is of type FILE which is actually mapped to
__sFILE64 in 64 bit case.  See newlib/libc/include/sys/reent.h.
_offset is of type _off64_t there.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
