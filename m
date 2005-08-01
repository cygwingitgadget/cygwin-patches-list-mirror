Return-Path: <cygwin-patches-return-5599-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 5482 invoked by alias); 1 Aug 2005 16:56:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 5467 invoked by uid 22791); 1 Aug 2005 16:56:41 -0000
Received: from p54941846.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.24.70)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 01 Aug 2005 16:56:41 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 7A1A86D4256; Mon,  1 Aug 2005 18:56:39 +0200 (CEST)
Date: Mon, 01 Aug 2005 16:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] TIOCMBI[SC]
Message-ID: <20050801165639.GK14783@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20050801111552.GA2844@efn.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050801111552.GA2844@efn.org>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q3/txt/msg00054.txt.bz2

On Aug  1 04:15, Yitzchak Scott-Thoennes wrote:
> I don't have a serial device to test this with, but it's just selected
> parts of the TIOCMSET handling slightly adapted.

I'm not serial I/O savvy, but the change looks pretty much ok.  I'm just
not exactly glad that the functionality itself is duplicated.  Would you
mind a rewrite so that the functionality is not copied, for instance by
creating a private method which does it, or by recursively calling
fhandler_serial::ioctl() with tweaked arguments (TIOCMSET)?


Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
