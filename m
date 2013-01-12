Return-Path: <cygwin-patches-return-7795-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2614 invoked by alias); 12 Jan 2013 19:26:58 -0000
Received: (qmail 2162 invoked by uid 22791); 12 Jan 2013 19:26:38 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Sat, 12 Jan 2013 19:26:32 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 510ED520666; Sat, 12 Jan 2013 20:26:29 +0100 (CET)
Date: Sat, 12 Jan 2013 19:26:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Console modes: cursor style
Message-ID: <20130112192629.GB4877@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <50EFCE3C.8030607@towo.net> <20130111110534.GD17162@calimero.vinschen.de> <50F00AFA.2000307@towo.net> <20130111133451.GH17162@calimero.vinschen.de> <50F195D9.7030904@towo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50F195D9.7030904@towo.net>
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
X-SW-Source: 2013-q1/txt/msg00006.txt.bz2

On Jan 12 17:56, Thomas Wolff wrote:
> Am 11.01.2013 14:34, schrieb Corinna Vinschen:
> >On Jan 11 13:52, Thomas Wolff wrote:
> >>On 11.01.2013 12:05, Corinna Vinschen wrote:
> >>>On Jan 11 09:33, Thomas Wolff wrote:
> >>>>The attached patch adds two escape control sequences to the Cygwin Console:
> >>>>
> >>>>  * Show/Hide Cursor (DECTCEM)
> >>>>  * Set cursor style (DECSCUSR): block vs. underline cursor, or
> >>>>    arbitrary size (as an extension, using values > 4)
> >>>>
> >>>>Thomas
> >>>>
> >>>>2013-01-13  Thomas Wolff  <...>
> >>>>
> >>>>	* fhandler.h (class dev_console): Flag for expanded control sequence.
> >>>>	* fhandler_console.cc (char_command): Supporting cursor style modes.
> >>>Patch applied.  Can you provide a patch for the docs, too, please?
> >>Sure, but: where are the docs to be patched? Any package to be installed?
> >Cygwin CVS, file winsup/doc/new-features.sgml
> Patch attached.

Applied.


Thanks,
Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
