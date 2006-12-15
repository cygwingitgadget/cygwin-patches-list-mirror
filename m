Return-Path: <cygwin-patches-return-6016-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 27868 invoked by alias); 15 Dec 2006 09:50:58 -0000
Received: (qmail 27857 invoked by uid 22791); 15 Dec 2006 09:50:57 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)     by sourceware.org (qpsmtpd/0.31.1) with ESMTP; Fri, 15 Dec 2006 09:50:50 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500) 	id 0482F544001; Fri, 15 Dec 2006 10:50:48 +0100 (CET)
Date: Fri, 15 Dec 2006 09:50:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] minires
Message-ID: <20061215095047.GA32286@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <3.0.1.32.20061214224518.00bbb670@incoming.verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3.0.1.32.20061214224518.00bbb670@incoming.verizon.net>
User-Agent: Mutt/1.4.2.2i
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2006-q4/txt/msg00034.txt.bz2

On Dec 14 22:45, Pierre A. Humblet wrote:
> 	* libc/minires-os-if.c (cygwin_query): Remove ERROR_PROC_NOT_FOUND case.
> 	(get_dns_info): Verify DnsQuery exists. Use autoloaded GetNetworkParams.

Thanks, applied.


Corinna
