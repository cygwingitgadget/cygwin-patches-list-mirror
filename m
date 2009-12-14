Return-Path: <cygwin-patches-return-6863-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22198 invoked by alias); 14 Dec 2009 16:30:11 -0000
Received: (qmail 22185 invoked by uid 22791); 14 Dec 2009 16:30:09 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Dec 2009 16:30:04 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 19BC56D417D; Mon, 14 Dec 2009 17:29:54 +0100 (CET)
Date: Mon, 14 Dec 2009 16:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20091214162953.GO8059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0M7Ual-1MBB3j1CFD-00whzl@mrelayeu.kundenserver.de>  <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B266528.7090006@towo.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2009-q4/txt/msg00194.txt.bz2

On Dec 14 17:17, Thomas Wolff wrote:
> Corinna Vinschen wrote:
> >Hi Tom,
> Hi Cori,
> 
> >On Dec  6 20:24, Thomas Wolff wrote:
> >>This is my updated and extended patch for a number of console enhancements.
> >>...
> >>If you want a subset of the features sooner than others, I may split
> >>the patch.
> >Thanks for the offer.  It would be nice if you could split up the patch
> >in the chunks which you're referring to in your ChangeLog entries.  It
> >makes it less hard to follow the individual bits.
> Sure, although I had hoped I could at least combine a few
> modifications to reduce fiddling around...
> Also, since it's always cumbersome to update a patch to a new target
> version, would you be willing to apply some of the features still to
> the current release, 1.7.0-68?

No, that's really not how it works.  Patches are supposed to be against
the latest from CVS.  And it's also not cumbersome, it's rather quite
simple.  CVS is doing that for you usually anyway.  If you have a
patched CVS source tree, just call `cvs up' and the current HEAD is
merged with your local changes.  Given that fhandler_console.cc wasn't
changed for a while anyway, you should not see any merge conflicts.

> My proposal:

That's ok.  It's just much easier to examine the changes if
they are provided in logically combined snippets.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
