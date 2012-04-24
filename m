Return-Path: <cygwin-patches-return-7650-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2600 invoked by alias); 24 Apr 2012 14:44:45 -0000
Received: (qmail 2194 invoked by uid 22791); 24 Apr 2012 14:44:20 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Tue, 24 Apr 2012 14:44:06 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 720682C4983; Tue, 24 Apr 2012 16:44:03 +0200 (CEST)
Date: Tue, 24 Apr 2012 14:44:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Extended mouse coordinates
Message-ID: <20120424144403.GA24364@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F945706.3050808@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4F945706.3050808@towo.net>
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
X-SW-Source: 2012-q2/txt/msg00019.txt.bz2

On Apr 22 21:07, Thomas Wolff wrote:
> This patch replaces my previous proposal
> (http://cygwin.com/ml/cygwin-patches/2012-q2/msg00005.html) with two
> modifications:
> 
>  * Fixed a bug that suppressed mouse reporting at large coordinates (in
>    all modes actually:-\ )
>  * Added mouse mode 1005 (total of 3 three new modes, so all reporting
>    modes run by current terminal emulators would be implemented)
> 
> I would appreciate the patch to be applied this time, planned to be
> my last mouse patch :)
> 
> Kind regards,
> Thomas

> 2012-04-03  Thomas Wolff  <towo@towo.net>
> 
> 	* fhandler.h (class dev_console): Two flags for extended mouse modes.
> 	* fhandler_console.cc (fhandler_console::read): Implemented 
> 	extended mouse modes 1015 (urxvt, mintty, xterm) and 1006 (xterm).
> 	Not implemented extended mouse mode 1005 (xterm, mintty).
> 	Supporting mouse coordinates greater than 222 (each axis).
> 	Also: two { wrap formatting consistency fixes.
> 	(fhandler_console::char_command) Initialization of enhanced 
> 	mouse reporting modes.
> 

Patch applied with changes.  Please use __small_sprintf rather than
sprintf.  I also changed the CHangeLog entry slightly.  Keep it short
and in present tense.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
