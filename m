Return-Path: <cygwin-patches-return-5908-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5872 invoked by alias); 3 Jul 2006 11:45:33 -0000
Received: (qmail 5861 invoked by uid 22791); 3 Jul 2006 11:45:32 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Mon, 03 Jul 2006 11:45:30 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id E8D2F544001; Mon,  3 Jul 2006 13:45:22 +0200 (CEST)
Date: Mon, 03 Jul 2006 11:45:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: setmetamode
Message-ID: <20060703114522.GC14901@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <u8xncvv26.fsf@jaist.ac.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <u8xncvv26.fsf@jaist.ac.jp>
User-Agent: Mutt/1.4.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00003.txt.bz2

On Jul  3 01:19, Kazuhiro Fujieda wrote:
> Here is the patch to control the handling of the meta key with
> the setmetamode command on the Cygwin console like the Linux
> console.
> 
> I submitted the previous version of this patch three years ago,
> but it didn't work on Corinna's environment. I, however, wasn't
> able to find any reason why it didn't work, so the logic of this
> patch is the same as the previous one.
> 
> May it works fine on environment other than mine.

It works now for me, too.  I have no idea wy it didn't work way back
when, but I don't see a reason not to include it now.

Just a questions:

You didn't add an include/sys/kd.h file.  On Linux this file in turn
includes linux/kd.h.  Is there a reason that you didn't create it?  The
cygwin/kd.h file contains only a miniscule number of definitions,
compared with the Linux version.  Do you think adding sys/kd.h would
result in problems for that reason?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
