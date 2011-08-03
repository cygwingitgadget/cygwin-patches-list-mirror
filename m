Return-Path: <cygwin-patches-return-7474-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5719 invoked by alias); 3 Aug 2011 19:10:48 -0000
Received: (qmail 5659 invoked by uid 22791); 3 Aug 2011 19:10:29 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 03 Aug 2011 19:10:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 4130F2C05AA; Wed,  3 Aug 2011 21:10:10 +0200 (CEST)
Date: Wed, 03 Aug 2011 19:10:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] clock_nanosleep(2), round two
Message-ID: <20110803191010.GA19411@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1312396928.7084.6.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1312396928.7084.6.camel@YAAKOV04>
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
X-SW-Source: 2011-q3/txt/msg00050.txt.bz2

On Aug  3 13:42, Yaakov (Cygwin/X) wrote:
> 	* cygwin.din (clock_nanosleep): Export.
> 	* posix.sgml (std-notimpl): Move clock_nanosleep from here...
> 	(std-susv4): ... to here.
> 	(std-notes): Note limitations of clock_nanosleep.
> 	* signal.cc (clock_nanosleep): Renamed from nanosleep, adding clock_id
> 	and flags arguments and changing return values throughout.
> 	Improve checks for illegal rqtp values.  Add support for
> 	CLOCK_MONOTONIC and TIMER_ABSTIME.
> 	(nanosleep): Rewrite in terms of clock_nanosleep.
> 	(sleep): Ditto.
> 	(usleep): Ditto.
> 	* thread.cc: Mark clock_nanosleep in list of cancellation points.
> 	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Thumbs up.


Thank you,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
