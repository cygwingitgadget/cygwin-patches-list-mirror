Return-Path: <cygwin-patches-return-7380-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21728 invoked by alias); 19 May 2011 06:07:54 -0000
Received: (qmail 21636 invoked by uid 22791); 19 May 2011 06:07:30 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 19 May 2011 06:07:14 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id 10A202CA0E7; Thu, 19 May 2011 08:07:12 +0200 (CEST)
Date: Thu, 19 May 2011 06:07:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Export __fpurge(3) (pending newlib patch)
Message-ID: <20110519060712.GW5248@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <BANLkTimHnhSjBjBUVRgy3+xmrs7mG6srSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <BANLkTimHnhSjBjBUVRgy3+xmrs7mG6srSw@mail.gmail.com>
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
X-SW-Source: 2011-q2/txt/msg00146.txt.bz2

On May 18 01:46, Yaakov (Cygwin/X) wrote:
> These are the patches for exporting __fpurge(3) on our side, once my
> patch on newlib@ is approved.

After we got note from Ralf on the newlib list on the #ifndef __rtems__
issue, this will be obviously good to go as well.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
