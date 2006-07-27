Return-Path: <cygwin-patches-return-5946-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24695 invoked by alias); 27 Jul 2006 03:33:10 -0000
Received: (qmail 24675 invoked by uid 22791); 27 Jul 2006 03:33:08 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-71-248-179-29.bstnma.fios.verizon.net (HELO cgf.cx) (71.248.179.29)     by sourceware.org (qpsmtpd/0.31) with ESMTP; Thu, 27 Jul 2006 03:33:07 +0000
Received: by cgf.cx (Postfix, from userid 201) 	id 67F1213C0F1; Wed, 26 Jul 2006 23:33:05 -0400 (EDT)
Date: Thu, 27 Jul 2006 03:33:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: get_readahead; remove duplicate
Message-ID: <20060727033305.GA17952@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.CYG.4.58.0607262215190.2228@PC1163-8460-XP.flightsafety.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.CYG.4.58.0607262215190.2228@PC1163-8460-XP.flightsafety.com>
User-Agent: Mutt/1.5.11
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q3/txt/msg00041.txt.bz2

On Wed, Jul 26, 2006 at 10:18:45PM -0500, Brian Ford wrote:
>One more tiny one.
>
>2006-07-26  Brian ford  <Brian.Ford@FlightSafety.com>
>
>	* fhandler.cc (fhandler_base::read): Call
>	get_readahead_into_buffer instead of duplicating it.

Applied.  Thanks.

cgf
