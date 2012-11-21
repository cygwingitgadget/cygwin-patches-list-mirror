Return-Path: <cygwin-patches-return-7786-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2272 invoked by alias); 21 Nov 2012 15:22:01 -0000
Received: (qmail 2260 invoked by uid 22791); 21 Nov 2012 15:21:56 -0000
X-SWARE-Spam-Status: No, hits=-1.9 required=5.0	tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mho-03-ewr.mailhop.org (HELO mho-01-ewr.mailhop.org) (204.13.248.66)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 21 Nov 2012 15:21:49 +0000
Received: from pool-173-76-51-117.bstnma.fios.verizon.net ([173.76.51.117] helo=cgf.cx)	by mho-01-ewr.mailhop.org with esmtpa (Exim 4.72)	(envelope-from <cgf@cgf.cx>)	id 1TbC7W-000Ebz-OX	for cygwin-patches@cygwin.com; Wed, 21 Nov 2012 15:21:46 +0000
Received: from localhost (ednor.casa.cgf.cx [192.168.187.5])	by cgf.cx (Postfix) with ESMTP id CE96E13C076	for <cygwin-patches@cygwin.com>; Wed, 21 Nov 2012 10:21:45 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/l4P66XnPhg6a9TkS96Ljj
Date: Wed, 21 Nov 2012 15:22:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] add cfsetspeed
Message-ID: <20121121152145.GB14791@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <1353495243.5592.25.camel@YAAKOV04>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1353495243.5592.25.camel@YAAKOV04>
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
X-SW-Source: 2012-q4/txt/msg00063.txt.bz2

On Wed, Nov 21, 2012 at 04:54:03AM -0600, Yaakov (Cygwin/X) wrote:
>This patchset adds cfsetspeed(3), a BSD extension also available in
>glibc:
>
>http://man7.org/linux/man-pages/man3/termios.3.html
>
>Per the description, cfsetspeed() is the equivalent of cfsetospeed() and
>cfsetispeed() with the same baud rate.  Patch for winsup/cygwin
>attached.
>
>
>Yaakov
>

>2012-11-21  Yaakov Selkowitz  <yselkowitz@...>
>
>	* termios.cc (cfsetspeed): New function.
>	* cygwin.din (cfsetspeed): Export.
>	* posix.sgml (std-bsd): Add cfsetspeed.
>	* include/sys/termios.h (cfsetspeed): Declare.
>	* include/cygwin/version.h (CYGWIN_VERSION_API_MINOR): Bump.

Looks good.  Please check in.

Thanks.

cgf
