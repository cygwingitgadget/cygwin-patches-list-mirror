Return-Path: <cygwin-patches-return-7657-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 32037 invoked by alias); 25 Apr 2012 08:23:51 -0000
Received: (qmail 31591 invoked by uid 22791); 25 Apr 2012 08:23:14 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Wed, 25 Apr 2012 08:23:00 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 019922C4985; Wed, 25 Apr 2012 10:22:57 +0200 (CEST)
Date: Wed, 25 Apr 2012 08:23:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Extended mouse coordinates
Message-ID: <20120425082257.GY25385@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F945706.3050808@towo.net> <20120424144403.GA24364@calimero.vinschen.de> <4F970064.8020009@towo.net> <20120424194513.GV25385@calimero.vinschen.de> <20120424194753.GW25385@calimero.vinschen.de> <4F970657.4010203@towo.net> <20120424202255.GA6807@calimero.vinschen.de> <4F9721F9.90109@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F9721F9.90109@towo.net>
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
X-SW-Source: 2012-q2/txt/msg00026.txt.bz2

On Apr 24 23:58, Thomas Wolff wrote:
> Am 24.04.2012 22:22, schrieb Corinna Vinschen:
> >On Apr 24 22:00, Thomas Wolff wrote:
> >>Am 24.04.2012 21:47, schrieb Corinna Vinschen:
> >>>On Apr 24 21:45, Corinna Vinschen wrote:
> >>>>That was exactly the patch I applied.  I only chnaged the formatting
> >>>>and changed sprintf to  __small_sprintf.
> >>>...and as far as quoting goes, the above is the ChangeLog you provided
> >>>with your updated patch.
> >>Sh.. I see. My deep apologies, I must have been confused. Here is
> >>the actual updated patch which should be used instead.
> >>Sorry for the trouble.
> >>Thomas
> >>2012-04-20  Thomas Wolff<towo@towo.net>
> >>
> >>	* fhandler.h (class dev_console): Flags for extended mouse modes.
> >>	* fhandler_console.cc: Supporting mouse coordinates greater than 222.
> >>	(fhandler_console::read) Implemented extended mouse modes
> >>	1015 (urxvt, mintty, xterm), 1006 (xterm), and 1005 (xterm, mintty).
> >>	Also: two { wrap formatting consistency fixes.
> >>	(fhandler_console::mouse_aware) Removed limitation of not sending
> >>	anything at exceeded coordinates; sending 0 byte instead (xterm).
> >>	(fhandler_console::char_command) Initialization of enhanced
> >>	mouse reporting modes.
> >>
> >Please recreate the patch against current CVS.  And please use
> >__small_sprintf instead of sprintf.
> >
> Here's the missing patch and changelog. Sorry again for previous mix-up.
> Thomas

Patch applied and rigged into 1.7.14.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
