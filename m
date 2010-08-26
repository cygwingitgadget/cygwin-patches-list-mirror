Return-Path: <cygwin-patches-return-7071-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 31217 invoked by alias); 26 Aug 2010 17:55:20 -0000
Received: (qmail 31200 invoked by uid 22791); 26 Aug 2010 17:55:19 -0000
X-Spam-Check-By: sourceware.org
Received: from aquarius.hirmke.de (HELO calimero.vinschen.de) (217.91.18.234)    by sourceware.org (qpsmtpd/0.83/v0.83-20-g38e4449) with ESMTP; Thu, 26 Aug 2010 17:55:13 +0000
Received: by calimero.vinschen.de (Postfix, from userid 500)	id C8E6A6D4364; Thu, 26 Aug 2010 19:55:10 +0200 (CEST)
Date: Thu, 26 Aug 2010 17:55:00 -0000
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: res_send() doesn't work with osquery enabled
Message-ID: <20100826175510.GN6726@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4e84197e3f02b0bbf6e190e78826148b.squirrel@pseudo.egg6.net> <20100826163812.GM6726@calimero.vinschen.de> <00d601cb4542$7de440e0$2a0010ac@wirelessworld.airvananet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <00d601cb4542$7de440e0$2a0010ac@wirelessworld.airvananet.com>
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
X-SW-Source: 2010-q3/txt/msg00031.txt.bz2

On Aug 26 13:16, Pierre A. Humblet wrote:
> ----- Original Message ----- 
> From: "Corinna Vinschen" 
> To: <cygwin-patches>
> Sent: Thursday, August 26, 2010 12:38
> 
> 
> | Pierre, would you mind to take a look?
> | 
> | On Aug 26 19:07, pseudo@egg6.net wrote:
> | > Currently res_init() checks for availability of the native windows
> | > function DnsQuery_A. If the function is found, it's preferred over the
> | > cygwin implementation and res_query is set up to use it.
> | > As DnsQuery_A finds the configured name servers itself, the current code
> | > assumes we can avoid loading the dns server list with GetNetworkParams().
> | > 
> | > However, the assumption that everybody would use res_query is wrong. Some
> | > programs may use res_mkquery() and res_send() or may only read the list of
> | > servers from _res.nsaddr_list and send/receive the queries/replies
> | > themselves. res_send() also relies on nsaddr_list.
> 
> It's true that the behavior described above is legitimate, even if nobody had ever 
> requested it. If people want to access nsaddr_list after calling res_ninit, loading 
> iphlpapi.dll every time (as the patch does) is unavoidable.
> 
> The other change has res_nsend return an error if no server can be found.
> Alternatively the error could be reported by res_ninit, by removing the second
> condition in 
> if (statp->nscount == 0 && !statp->os_query) {
>     errno = ENONET;
>     statp->res_h_errno = NETDB_INTERNAL;
> 
> Hypothetically this could affect some installations where iphlpapi doesn't report any
> servers although the Windows resolver can find a server (but I don't see how this
> could happen), so it's safer to proceed as in the patch.
> However the patch should send errno to ENONET and set res_h_errno to
> NETDB_INTERNAL
> 
> Except for the previous comment, I am fine with the patch.

IIRC you have checkin rights, Pierre.  Please apply whatever you
think is right.


Thanks,
Corinna

-- 
Corinna Vinschen                  Please, send mails regarding Cygwin to
Cygwin Project Co-Leader          cygwin AT cygwin DOT com
Red Hat
