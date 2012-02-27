Return-Path: <cygwin-patches-return-7609-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29637 invoked by alias); 27 Feb 2012 23:58:16 -0000
Received: (qmail 29624 invoked by uid 22791); 27 Feb 2012 23:58:15 -0000
X-SWARE-Spam-Status: No, hits=-1.8 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE
X-Spam-Check-By: sourceware.org
Received: from mho-01-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.71)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 27 Feb 2012 23:58:00 +0000
Received: from pool-173-76-50-248.bstnma.fios.verizon.net ([173.76.50.248] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1S2AS7-000FVZ-Sh	for cygwin-patches@cygwin.com; Mon, 27 Feb 2012 23:57:59 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id 17A0C13C002	for <cygwin-patches@cygwin.com>; Mon, 27 Feb 2012 18:57:59 -0500 (EST)
X-Mail-Handler: MailHop Outbound by DynDNS
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/mailhop/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX196caerXE6GW9ujbj0KVfqz
Date: Mon, 27 Feb 2012 23:58:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: fix tcgetsid return type
Message-ID: <20120227235759.GA26689@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4F4C10F0.3080306@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4F4C10F0.3080306@redhat.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00032.txt.bz2

On Mon, Feb 27, 2012 at 04:25:36PM -0700, Eric Blake wrote:
>Detected by gnulib's unit tests.  POSIX requires tcgetsid to return
>pid_t, not int.
>
>2012-02-27  Eric Blake  <eblake@redhat.com>
>
>	* include/sys/termios.h (tcgetsid): Fix return type.
>	* termios.cc (tcgetsid): Likewise.
>	* fhandler_termios.cc (fhandler_termios::tcgetsid): Likewise.
>	* fhandler.h (fhandler_base): Likewise.
>	* fhandler.cc (fhandler_base::tcgetsid): Likewise.

Looks good.  Please check in.

cgf
