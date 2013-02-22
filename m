Return-Path: <cygwin-patches-return-7830-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27312 invoked by alias); 22 Feb 2013 08:00:57 -0000
Received: (qmail 27224 invoked by uid 22791); 22 Feb 2013 08:00:39 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 22 Feb 2013 08:00:29 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id B1D6B52030D; Fri, 22 Feb 2013 09:00:25 +0100 (CET)
Date: Fri, 22 Feb 2013 08:00:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 64bit] Export <io.h> symbols with underscore
Message-ID: <20130222080025.GI28458@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20130220151600.5983c15a@YAAKOV04> <20130221011432.GA2786@ednor.casa.cgf.cx> <20130221111545.GA24054@calimero.vinschen.de> <20130221194236.GA1163@ednor.casa.cgf.cx> <20130222001848.7049805a@YAAKOV04> <20130222065110.GA7834@ednor.casa.cgf.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20130222065110.GA7834@ednor.casa.cgf.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2013-q1/txt/msg00041.txt.bz2

On Feb 22 01:51, Christopher Faylor wrote:
> On Fri, Feb 22, 2013 at 12:18:48AM -0600, Yaakov wrote:
> >On Thu, 21 Feb 2013 14:42:36 -0500, Christopher Faylor wrote:
> >> I wasn't fulling grokking the fact that Cygwin explicitly defined the
> >> get_osfhandle without an underscore in io.h.  Sigh.  That's probably my
> >> fault too.
> >> 
> >> But we definitely shouldn't be going back to adding "_" decorations.  I
> >> have deleted a few of these and no one has complained.  I know that
> >> isn't a scientific sampling but it's hard to believe that someone has
> >> written code which actually goes out of its way to prepend an underscore
> >> in front of a standard UNIX function name, especially since we do not,
> >> AFAIK, define these functions in any header file.
> >> 
> >> So, I guess I don't understand why we need to add an underscore now
> >> when we have gotten by with the incorrect declaration for get_osfhandle
> >> all of these years.
> >
> >Because even if it caused a warning in C, the link still succeeded with
> >the underscored symbol.
> 
> Ok.  I think we should also change io.h to only define _get_osfhandle on
> both 64-bit and the trunk version of cygwin.  Ditto for _setmode.  And,
> IMO, the access() declaration should be removed from io.h entirely.

access should go, no doubt about it.

For get_osfhandle and setmode I would prefer maintaining backward
compatibility with existing applications.  Both variations, with and
without underscore are definitely in use.

What about exporting the underscored variants only, but define the
non-underscored ones:

  extern long _get_osfhandle(int);
  #define get_osfhandle(i) _get_osfhandle(i)

  extern int _setmode (int __fd, int __mode);
  #define setmode(f,m) _setmode((f),(m))


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Maintainer                 cygwin AT cygwin DOT com
Red Hat
