Return-Path: <cygwin-patches-return-5594-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24789 invoked by alias); 29 Jul 2005 14:32:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 24774 invoked by uid 22791); 29 Jul 2005 14:32:39 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 29 Jul 2005 14:32:39 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id 5045313C0EC; Fri, 29 Jul 2005 10:32:38 -0400 (EDT)
Date: Fri, 29 Jul 2005 14:32:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Try to remove possible race pinfo::init
Message-ID: <20050729143238.GF9031@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1122633554.7369.170.camel@tkuwhuuskartlnx.novogroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122633554.7369.170.camel@tkuwhuuskartlnx.novogroup.com>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00049.txt.bz2

On Fri, Jul 29, 2005 at 01:39:14PM +0300, Arto Huusko wrote:
>On some systems, I was frequent segmentation faults on fork(), and
>I was able to track it down to the patch I just sent. However, my
>scripts don't run much better, because they now fail only a bit
>more cleanly with "fork: Resource temporarily unavailable".
>
>Since my previous patch transformed seg faults to EAGAIN errors,
>I tried to find potential races or other errors in pinfo::init.
>I didn't really take the time to try to understand the code, but
>if I'm guessing right, the MapViewOfFileEx() call is doing something
>that depends on the child. If that's right, then it seems to me
>that the retry loop in open_shared() failure case is a bit too
>tight.
>
>
>2005-07-29  Arto Huusko  <arto.huusko@wmdata.fi>
>
>	* pinfo.cc (pinfo::init): Sleep before retrying open_shared().

I've applied this, although it's difficult for me to see how it could
have actually been a real problem since the loop in question iterates
for 20 times and this condition is only supposed to happen when the
address space set aside for the pinfo structure is already in use.

Thanks.

cgf
