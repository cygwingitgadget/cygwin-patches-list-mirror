Return-Path: <cygwin-patches-return-6403-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 24568 invoked by alias); 5 Jan 2009 15:52:53 -0000
Received: (qmail 24558 invoked by uid 22791); 5 Jan 2009 15:52:52 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-199.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.199)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Mon, 05 Jan 2009 15:52:48 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 7E1DC13C028 	for <cygwin-patches@cygwin.com>; Mon,  5 Jan 2009 10:52:37 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 2E5E02B35E; Mon,  5 Jan 2009 10:52:36 -0500 (EST)
Date: Mon, 05 Jan 2009 15:52:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make cygcheck handle Windows paths with spaces
Message-ID: <20090105155236.GA3138@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ad01c96abb$3ccee370$640410ac@wirelessworld.airvananet.com> <00eb01c96f49$163ecd00$640410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00eb01c96f49$163ecd00$640410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2009-q1/txt/msg00001.txt.bz2

On Mon, Jan 05, 2009 at 10:19:59AM -0500, Pierre A. Humblet wrote:
>Oops, I didn't notice that one line required a double fix.
>
>Pierre
>
>2009-01-05  Pierre Humblet  <Pierre.Humblet@ieee.org>
> 
>        * cygcheck.cc (dump_sysinfo_services): Quote the path for popen.

Looks good.  Please check in.

Thanks.

cgf
