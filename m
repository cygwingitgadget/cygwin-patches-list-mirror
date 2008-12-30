Return-Path: <cygwin-patches-return-6401-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31036 invoked by alias); 30 Dec 2008 20:56:42 -0000
Received: (qmail 31024 invoked by uid 22791); 30 Dec 2008 20:56:41 -0000
X-Spam-Check-By: sourceware.org
Received: from pool-96-233-71-199.bstnma.fios.verizon.net (HELO cgf.cx) (96.233.71.199)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 30 Dec 2008 20:55:49 +0000
Received: from ednor.cgf.cx (ednor.casa.cgf.cx [192.168.187.5]) 	by cgf.cx (Postfix) with ESMTP id 5DAD313C028 	for <cygwin-patches@cygwin.com>; Tue, 30 Dec 2008 15:55:39 -0500 (EST)
Received: by ednor.cgf.cx (Postfix, from userid 201) 	id 546F12B35E; Tue, 30 Dec 2008 15:55:39 -0500 (EST)
Date: Tue, 30 Dec 2008 20:56:00 -0000
From: Christopher Faylor <cgf-use-the-mailinglist-please@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Make cygcheck handle Window paths with spaces
Message-ID: <20081230205539.GB13488@ednor.casa.cgf.cx>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <00ad01c96abb$3ccee370$640410ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00ad01c96abb$3ccee370$640410ac@wirelessworld.airvananet.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00045.txt.bz2

On Tue, Dec 30, 2008 at 03:14:30PM -0500, Pierre A. Humblet wrote:
>Formatting is more likely to be preserved in the attached files.
>
>Pierre 
>
>2008-12-30  Pierre Humblet  <Pierre.Humblet@ieee.org>
>
>        * cygcheck.cc (pretty_id): Quote the path for popen.
>        (dump_sysinfo_services): Ditto.

Looks good.  Please check in.

Thanks.

cgf
