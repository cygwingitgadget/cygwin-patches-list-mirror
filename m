Return-Path: <cygwin-patches-return-5912-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11815 invoked by alias); 3 Jul 2006 15:30:45 -0000
Received: (qmail 11805 invoked by uid 22791); 3 Jul 2006 15:30:45 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 03 Jul 2006 15:30:43 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id CECAD544001; Mon,  3 Jul 2006 17:30:35 +0200 (CEST)
Date: Mon, 03 Jul 2006 15:30:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setmetamode
Message-ID: <20060703153035.GA18873@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <u8xncvv26.fsf@jaist.ac.jp> <20060703114522.GC14901@calimero.vinschen.de> <ur712vmyb.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ur712vmyb.fsf@jaist.ac.jp>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00007.txt.bz2

On Jul  3 22:26, Kazuhiro Fujieda wrote:
> >>> On Mon, 03 Jul 2006 13:45:22 +0200
> >>> Corinna Vinschen <corinna-cygwin@cygwin.com> said:
> 
> > You didn't add an include/sys/kd.h file.  On Linux this file in turn
> > includes linux/kd.h.  Is there a reason that you didn't create it?
> 
> No. I just forgot it.

No worries.  I've applied the patch with minor changes (copyright dates,
comments).


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
