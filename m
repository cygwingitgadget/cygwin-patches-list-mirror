Return-Path: <cygwin-patches-return-6340-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20292 invoked by alias); 12 Jul 2008 17:32:11 -0000
Received: (qmail 20279 invoked by uid 22791); 12 Jul 2008 17:32:11 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-72-93-245-95.bstnma.fios.verizon.net (HELO ednor.cgf.cx) (72.93.245.95)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Sat, 12 Jul 2008 17:31:53 +0000
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id E2B1F6A83D4; Sat, 12 Jul 2008 13:31:51 -0400 (EDT)
Date: Sat, 12 Jul 2008 17:32:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: use volatile when replacing Interlocked*
Message-ID: <20080712173151.GB14153@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4878A2C3.6060908@byu.net> <20080712153519.GA13069@calimero.vinschen.de> <4878D6DF.9060008@byu.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4878D6DF.9060008@byu.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q3/txt/msg00003.txt.bz2

On Sat, Jul 12, 2008 at 10:07:59AM -0600, Eric Blake wrote:
> |> 2008-07-12  Eric Blake  <ebb9@byu.net>
> |>
> |> 	Fix usage of recently fixed Interlocked* functions.
> |> 	* winbase.h (ilockincr, ilockdecr, ilockexch, ilockcmpexch): Add
> |> 	volatile qualifier, to match Interlocked* functions.

Looks pretty uncontroversial.  Please check in.

Thanks.

cgf
