Return-Path: <cygwin-patches-return-6981-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 29472 invoked by alias); 26 Feb 2010 05:27:01 -0000
Received: (qmail 29455 invoked by uid 22791); 26 Feb 2010 05:27:00 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-173-48-46-17.bstnma.fios.verizon.net (HELO cgf.cx) (173.48.46.17)     by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Fri, 26 Feb 2010 05:26:57 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id B43DE13C0D0 	for <cygwin-patches@cygwin.com>; Fri, 26 Feb 2010 00:26:55 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id A5B0B2B352; Fri, 26 Feb 2010 00:26:55 -0500 (EST)
Date: Fri, 26 Feb 2010 05:27:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] define SIGPWR
Message-ID: <20100226052655.GA22741@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4B875901.6010906@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4B875901.6010906@users.sourceforge.net>
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
X-SW-Source: 2010-q1/txt/msg00097.txt.bz2

On Thu, Feb 25, 2010 at 11:15:45PM -0600, Yaakov (Cygwin/X) wrote:
>2010-02-25  Yaakov Selkowitz  <yselkowitz@users.sourceforge.net>
>
>	* include/cygwin/signal.h: Define SIGPWR as synonym for SIGLOST.
>	* strsig.cc: Ditto.
>	* include/cygwin/version.h: Bump CYGWIN_VERSION_API_MINOR.

Looks good.  Please check in.

cgf
