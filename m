Return-Path: <cygwin-patches-return-4530-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23014 invoked by alias); 23 Jan 2004 11:14:37 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22924 invoked from network); 23 Jan 2004 11:14:33 -0000
Date: Fri, 23 Jan 2004 11:14:00 -0000
From: Corinna Vinschen <cygwin-patches@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: 2. Thread safe stdio update
Message-ID: <20040123111432.GJ1572@cygbert.vinschen.de>
Mail-Followup-To: cygwin-patches@cygwin.com
References: <40103708.1020501@gmx.net> <20040123100856.GD12512@cygbert.vinschen.de> <4010FF6D.6020504@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4010FF6D.6020504@gmx.net>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2004-q1/txt/msg00020.txt.bz2

On Jan 23 12:03, Thomas Pfaff wrote:
> Corinna Vinschen wrote:
> >On Jan 22 21:48, Thomas Pfaff wrote:
> >>2004-01-22 Thomas Pfaff <tpfaff@gmx.net>
> >>
> >>	* include/sys/_types.h: New file.
> >
> >
> >I'm not quite sure if that's the way to go.  I'm wondering if we
> >shouldn't keep newlib's _types.h and change it like this:
> >
> >  #ifdef __CYGWIN__
> >  #include <cygwin/_types.h>
> >  #endif
> >
> >  #ifndef __CYGWIN__
> >  typedef int _flock_t;
> >  #endif
> >
> >Then we can create a cygwin/_types.h with the correct _flock_t definition.
> >IMHO that's cleaner than just overloading newlib's _types.h.
> >
> 
> You may be right.
> 
> I just followed the way it was done in newlibs linux support where a 
> modified _types.h is in newlib/libc/sys/linux/sys (and it was the 
> easiest way for me to test it).
> 
> Will you make this change in newlibs _types.h ?

I think you should RFA it on newlib and apply the rest of the patch
when Jeff applied.  But I'd like to hear from Chris first, if that
patch should go into 1.5.7 or if it should wait for a while.

Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Developer                                mailto:cygwin@cygwin.com
Red Hat, Inc.
