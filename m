Return-Path: <cygwin-patches-return-1939-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 26373 invoked by alias); 1 Mar 2002 09:22:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 26324 invoked from network); 1 Mar 2002 09:22:08 -0000
Date: Fri, 01 Mar 2002 19:03:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygpatch <cygwin-patches@cygwin.com>
Subject: Re: Terminal input processing fix
Message-ID: <20020301102205.C29279@cygbert.vinschen.de>
Mail-Followup-To: cygpatch <cygwin-patches@cygwin.com>
References: <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com> <4.3.2.7.2.20020118224857.00aa3720@mail.oreka.com> <4.3.2.7.2.20020228211428.00a976f0@pop.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20020228211428.00a976f0@pop.free.fr>
User-Agent: Mutt/1.3.22.1i
X-SW-Source: 2002-q1/txt/msg00296.txt.bz2

On Thu, Feb 28, 2002 at 09:24:40PM +0100, Christian LESTRADE wrote:
> At 18:14 25/02/02 +0100, you wrote:
> >So we could go ahead and apply your patch but... actually I would like
> >to ask you to change it.  The reason is that the _POSIX_VDISABLE
> >constant is typically defined in some header file in /usr/include.  As
> >is the functionality of CC_EQUAL which is called CCEQ, at least in Linux.
> >
> >So what I'd like you to ask is, could you tweak your patch so that these
> >macros are defined in some appropriate header files, e.g. sys/termios.h?
> 
> The _POSIX_VDISABLE and CCEQ defines doesn't (yet) exist in cygwin.
> 
> 1. _POSIX_VDISABLE belongs to a set of constants not included yet in 
> cygwin. Should I include it alone in sys/termios.h?
> 
> 2. CCEQ is only defined in Linux in a BSD context and has not quite the 
> same definition as my macro. Should I also include the CCEQ macro in 
> sys/termios.h and adapt my code to use it?

Yeah, that's what I'm asking for.  I think it has always at least a
minor advantage to have our implementation in Cygwin modelled on
something already existing.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
