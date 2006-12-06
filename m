Return-Path: <cygwin-patches-return-6011-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19298 invoked by alias); 6 Dec 2006 14:08:40 -0000
Received: (qmail 19202 invoked by uid 22791); 6 Dec 2006 14:08:39 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Wed, 06 Dec 2006 14:08:28 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 4F15C544001; Wed,  6 Dec 2006 15:08:26 +0100 (CET)
Date: Wed, 06 Dec 2006 14:08:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: get TIOCGWINSZ from <sys/ioctl.h>
Message-ID: <20061206140826.GO9829@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4576C4FB.6010703@byu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4576C4FB.6010703@byu.net>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00029.txt.bz2

On Dec  6 06:26, Eric Blake wrote:
> 	* include/sys/ioctl.h: Pick up termios.h, for TIOCGWINSZ.

Thanks, applied.


Corinna


-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
