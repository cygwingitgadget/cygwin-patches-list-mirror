Return-Path: <cygwin-patches-return-5624-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 9356 invoked by alias); 17 Aug 2005 00:30:22 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 9311 invoked by uid 22791); 17 Aug 2005 00:30:15 -0000
Received: from c-24-61-23-223.hsd1.ma.comcast.net (HELO cgf.cx) (24.61.23.223)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Wed, 17 Aug 2005 00:30:15 +0000
Received: by cgf.cx (Postfix, from userid 201)
	id C84FC13C882; Tue, 16 Aug 2005 20:30:13 -0400 (EDT)
Date: Wed, 17 Aug 2005 00:30:00 -0000
From: Christopher Faylor <cgf-no-personal-reply-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix cygrunsrv invocation in cygcheck
Message-ID: <20050817003013.GA22307@trixie.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.61.0508161203480.9560@slinky.cs.nyu.edu> <4302715C.528696C3@dessent.net> <430274CC.FA870D37@dessent.net> <4302850A.A3AC4F4E@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4302850A.A3AC4F4E@dessent.net>
User-Agent: Mutt/1.5.8i
X-SW-Source: 2005-q3/txt/msg00079.txt.bz2

On Tue, Aug 16, 2005 at 05:30:02PM -0700, Brian Dessent wrote:
>Brian Dessent wrote:
>>Now that I re-read what you said I think I misunderstood.  You're
>>right, it could have simply done
>
>Here is a patch that fixes both issues.
>
>2005-08-16 Brian Dessent <brian@dessent.net>
>
>* cygcheck.cc (dump_sysinfo_services): Properly null-terminate 'buf'.
>Avoid extraneous cygrunsrv invocation if 'verbose' is true.

Go ahead and check this in.  Thanks.

Thanks, Igor, for bringing this up (again).

cgf
