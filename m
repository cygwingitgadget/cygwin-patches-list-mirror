Return-Path: <cygwin-patches-return-5941-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 370 invoked by alias); 26 Jul 2006 23:20:34 -0000
Received: (qmail 358 invoked by uid 22791); 26 Jul 2006 23:20:33 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-29.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.29)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Wed, 26 Jul 2006 23:20:31 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 7D65213C0F1; Wed, 26 Jul 2006 19:20:29 -0400 (EDT)
Date: Wed, 26 Jul 2006 23:20:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: check_iovec cleanup
Message-ID: <20060726232029.GB5680@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607261730550.2352@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607261730550.2352@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00036.txt.bz2

On Wed, Jul 26, 2006 at 05:53:35PM -0500, Brian Ford wrote:
>I think this removes some redundancy and a questionable check while being
>more straight forward and covering more possible fault cases.  Please let
>me know if I missed a reason it had to be that way.
>
>2006-07-26  Brian Ford  <Brian.Ford@FlightSafety.com>
>
>	* miscfuncs.cc (dummytest): Delete.

Thanks for the patch, but I'm not convinced that this patch duplicates
the functionality that you eliminated from check_iovec.

It is not "more straighforward" to move a check out of a function and
duplicate it in callers of the function.  And, the dummytest is actually
there for a reason.  Unless you can give more of a rationale for your
changes they will not be applied.

cgf
