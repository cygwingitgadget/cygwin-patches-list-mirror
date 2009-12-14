Return-Path: <cygwin-patches-return-6865-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23816 invoked by alias); 14 Dec 2009 17:13:38 -0000
Received: (qmail 23799 invoked by uid 22791); 14 Dec 2009 17:13:37 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 14 Dec 2009 17:13:34 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 686B86D4190; Mon, 14 Dec 2009 18:13:23 +0100 (CET)
Date: Mon, 14 Dec 2009 17:13:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: console enhancements: mouse events etc
Message-ID: <20091214171323.GS8059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20091106101448.GA2568@calimero.vinschen.de>  <4AF73FEC.2050300@towo.net>  <20091119152632.GJ29173@calimero.vinschen.de>  <20091119160054.GB8185@ednor.casa.cgf.cx>  <20091119160948.GA1883@calimero.vinschen.de>  <4B1C04D1.8010707@towo.net>  <20091214114715.GG8059@calimero.vinschen.de>  <4B266528.7090006@towo.net>  <20091214162953.GO8059@calimero.vinschen.de>  <4B266F9B.6070204@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B266F9B.6070204@towo.net>
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
X-SW-Source: 2009-q4/txt/msg00196.txt.bz2

On Dec 14 18:02, Thomas Wolff wrote:
> Hi, please excuse some basic questions about CVS best practice:
> 
> Corinna Vinschen wrote:
> >...  Patches are supposed to be against
> >the latest from CVS.  And it's also not cumbersome, it's rather quite
> >simple.  CVS is doing that for you usually anyway.  If you have a
> >patched CVS source tree, just call `cvs up' and the current HEAD is
> >merged with your local changes.  Given that fhandler_console.cc wasn't
> >changed for a while anyway, you should not see any merge conflicts.
> In this case yes. In general, if there are merging conflicts, I
> would have to dig around in reject logs, right? (Or do a fresh
> checkout and repatch.)

No, you get a locally merged file with marked merge conflicts.

> Also, since with this workflow I'd have the patched latest version
> only, what is the most convenient way to create the patch diff?

cvs diff -up

> Do you maintain two checkouts, an unpatched one to base on?

Of course not.  What's a source code control system good for if you do
everything manually?  You should really start RTF cvs M.  `info cvs' for
a start.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
