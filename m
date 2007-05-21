Return-Path: <cygwin-patches-return-6097-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19624 invoked by alias); 21 May 2007 09:22:22 -0000
Received: (qmail 19584 invoked by uid 22791); 21 May 2007 09:22:14 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 21 May 2007 09:22:07 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 3C9956D4803; Mon, 21 May 2007 11:22:01 +0200 (CEST)
Date: Mon, 21 May 2007 09:22:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  ddrescue 1.3)
Message-ID: <20070521092201.GA6003@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt> <464EE7C1.3000709@t-online.de> <465062E9.4030003@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <465062E9.4030003@t-online.de>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00043.txt.bz2

Hi Christian,

On May 20 17:02, Christian Franke wrote:
> fhandler_dev_floppy::lseek() always clears the 60KB pre-read buffer, 
> even on lseek(fd, 0, SEEK_CUR);
> If a programm (like ddrescue) always calls lseek() before each read(), 
> performance is poor, because the same block is read several times.
> 
> With this new version of the patch, the buffer is only cleared if necessary.

Thanks for the patch.  I've checked in a simplified version of the
buffer allocation which doesn't require calling alloca.  While at it,
I also added error handling in case raw_read fails.

As for the devbuf part of the patch, it's missing a ChangeLog entry.
Can you please send one, possibly in present tense?  (Your first
ChangeLog was incorrectly written in past tense)


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
