Return-Path: <cygwin-patches-return-6102-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 12459 invoked by alias); 22 May 2007 07:16:47 -0000
Received: (qmail 12367 invoked by uid 22791); 22 May 2007 07:16:40 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Tue, 22 May 2007 07:16:35 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 14C1B6D4802; Tue, 22 May 2007 09:16:31 +0200 (CEST)
Date: Tue, 22 May 2007 07:16:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Segfault on unaligned lseek() on /dev/sdX (was: [ITP]  ddrescue 1.3)
Message-ID: <20070522071631.GG6003@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <464DF837.6020304@t-online.de> <20070518194526.GA3586@ednor.casa.cgf.cx> <464ECCBA.3000700@portugalmail.pt> <464EE7C1.3000709@t-online.de> <465062E9.4030003@t-online.de> <20070521092201.GA6003@calimero.vinschen.de> <4651D3B1.3030908@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4651D3B1.3030908@t-online.de>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2007-q2/txt/msg00048.txt.bz2

On May 21 19:15, Christian Franke wrote:
> 	* fhandler_floppy.cc (fhandler_dev_floppy::lseek): Don't invalidate
> 	devbuf if new position is within buffered range.

Thanks, applied.


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
