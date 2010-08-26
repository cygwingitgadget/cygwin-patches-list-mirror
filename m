Return-Path: <cygwin-patches-return-7069-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28070 invoked by alias); 26 Aug 2010 16:38:53 -0000
Received: (qmail 28053 invoked by uid 22791); 26 Aug 2010 16:38:52 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 26 Aug 2010 16:38:15 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id A64236D4364; Thu, 26 Aug 2010 18:38:12 +0200 (CEST)
Date: Thu, 26 Aug 2010 16:38:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: res_send() doesn't work with osquery enabled
Message-ID: <20100826163812.GM6726@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4e84197e3f02b0bbf6e190e78826148b.squirrel@pseudo.egg6.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4e84197e3f02b0bbf6e190e78826148b.squirrel@pseudo.egg6.net>
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
X-SW-Source: 2010-q3/txt/msg00029.txt.bz2

Pierre, would you mind to take a look?

On Aug 26 19:07, pseudo@egg6.net wrote:
> Currently res_init() checks for availability of the native windows
> function DnsQuery_A. If the function is found, it's preferred over the
> cygwin implementation and res_query is set up to use it.
> As DnsQuery_A finds the configured name servers itself, the current code
> assumes we can avoid loading the dns server list with GetNetworkParams().
> 
> However, the assumption that everybody would use res_query is wrong. Some
> programs may use res_mkquery() and res_send() or may only read the list of
> servers from _res.nsaddr_list and send/receive the queries/replies
> themselves. res_send() also relies on nsaddr_list.
> 
> The following patch makes get_dns_info() always try to populate
> nsaddr_list if empty. If resolv.conf exists and provides nameservers, they
> will be used as usual. Otherwise, GetNetworkParams() will be called to get
> the servers from the operating system.
> 
> 2010-08-26  Rumen Stoyanov <pseudo@egg6.net>
> 
>      * libc/minires-os-if.c (get_dns_info): Always populate nsaddr_list
>      if empty, regardless of the availability of os_query.
>      * libc/minires.c (res_nsend): Make sure there is atleast one
>      nameserver in nsaddr_list or return.

Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
