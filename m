Return-Path: <cygwin-patches-return-5482-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2909 invoked by alias); 23 May 2005 09:56:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 1635 invoked by uid 22791); 23 May 2005 09:55:40 -0000
Received: from p54941750.dip0.t-ipconnect.de (HELO calimero.vinschen.de) (84.148.23.80)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Mon, 23 May 2005 09:55:40 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id 50CFB544001; Mon, 23 May 2005 11:55:44 +0200 (CEST)
Date: Mon, 23 May 2005 09:56:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [patch] dump service info in cygcheck
Message-ID: <20050523095544.GA22615@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4290DC81.8311E428@dessent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4290DC81.8311E428@dessent.net>
User-Agent: Mutt/1.4.2i
X-SW-Source: 2005-q2/txt/msg00078.txt.bz2

On May 22 12:24, Brian Dessent wrote:
> (Okay, this time I hope this is the correct mailing list since this lives in
> winsup/utils.)

Yep.  This list is correct for everything within the winsup directory.

> 	* cygcheck.cc (dump_sysinfo_services): Add new function that uses
> 	new cygrunsrv options to dump service info.
> 	(dump_sysinfo): Call dump_sysinfo_services if running under NT.
> 	Change 'Cygnus' to 'Cygwin' in output.

Applied.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          mailto:cygwin@cygwin.com
Red Hat, Inc.
