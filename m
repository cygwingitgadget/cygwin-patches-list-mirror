Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 47A18395186A
 for <cygwin-patches@cygwin.com>; Fri, 30 Jul 2021 09:35:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 47A18395186A
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M7am5-1mGqVS04Cb-0083lj for <cygwin-patches@cygwin.com>; Fri, 30 Jul 2021
 11:35:15 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AE8B2A80DEF; Fri, 30 Jul 2021 11:35:14 +0200 (CEST)
Date: Fri, 30 Jul 2021 11:35:14 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Add more winsymlinks values (v2)
Message-ID: <YQPH0itM5+G+RnSa@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210729172012.10624-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210729172012.10624-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:c7ZRFLhZJo0VHo3R8pKT9+U/VvjuT81ZToiAtoUFWEGL/V/qWoN
 v6eJUzh4jMTLePwUcK5eN5ACnqsBXX/9CxeTqpUBIMKREsHAKoGmjiXURGwbSfTvVHseA/V
 L+ow8vY1hyMuAzDwbB8tK2LVErjyswzbwK8EIpNWGa1XQJwvO5V4bo50XlOhv4FSde0jvyF
 pXQHuQ/brc3uU6H+dHs+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Qj+Uh8H/1c0=:OE6MVuBwfc32XMyclg3pQl
 +dCmgpX1nAd1mdEZwB4BhgHxX41DwcG7Qpp1QJAnKyNk2i4/YNi7TNBYsMU8fj0DnS6JJ/SeN
 /VPthIN4dy0fij2PnrsgyroU0lDRhZP/Qprg02NYkkp2do71jZyjPkH+kdzuJz+srQwN3+G/E
 JI017Tjnq2wkFIdiCYehDb6C9kw7l/kVMkEmVUj6E2d6Zy38+h34FcyQDHWzhnP64Mb69oP0L
 Sgx82A25D4NC7UEU4TQzEpuvBrLhbN8ZHeJxUxbQKpL/Db05MErpLBMbcrKSoA6h38ppZ6KGU
 6e43y+IHy6nw1rriXKZlK/fpAxyq8wZSF59ZzIk3rZJchSYd/1IpCAP7B8r/HI+gVZqf+cSZv
 kses5b4Y7M57U8U78Tjl8LetStRW1t59vy1DKTo30cq8hMj90FBde71EO7vaxGz00qxYoJaHs
 uhrvn/GTl3E2CFQYrM4uSaoy7Q7ZWqI/0428fqznpQ9onwSdbDms/x34hIvB4T8Y5dPbUYLsF
 vpIoL9LwzCWdMKhcbckDJ273yyUXY2hh95cDdoa17huXjCSmIQxG1A7dSQKQhPYRHf/RmyLj4
 cYvrQAi6en0gOHmtfkmFTurvxjd4wxFF/hxdN2uBf8cIhcxzOSms4FbSEIeZmVNu+Y1xjU25y
 sjOxBosB1Jyn9cz61SufxMI+E3gOcaL35I3BIa9uO9K4aydtHefd2t22Egh37OCm206Ek/O0P
 4cl8On0FKgstZGtu+qtXxNOxBqY66iPNYW+/ypQoHqChDhdvFPMukFejip2CFBqKlkWDbKXl4
 WE/W3JLAsNNp16JvK7Iu16nJ5J5PcRmlr04gIzGdaW5bTNQxHXyOdHqGZSF3oL1A2xthcvUUh
 vDvs9aodxhSHTarf+FFA==
X-Spam-Status: No, score=-100.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 30 Jul 2021 09:35:17 -0000

On Jul 29 18:20, Jon Turney wrote:
> * Rename magic -> sys
> * Drop wslstrict, since I'm not sure it's useful or a good idea.
> * Refine documentation changes a bit more
> 
> Jon Turney (2):
>   Rename WSYM_sysfile to WSM_default
>   Add winsymlinks:sys
> 
>  winsup/cygwin/environ.cc |  2 ++
>  winsup/cygwin/globals.cc |  7 ++++---
>  winsup/cygwin/path.cc    |  9 +++++----
>  winsup/doc/cygwinenv.xml | 20 +++++++++++++++++++-
>  winsup/doc/pathnames.xml | 29 +++++++++++++++++++----------
>  5 files changed, 49 insertions(+), 18 deletions(-)
> 
> -- 
> 2.32.0

LGTM


Thanks,
Corinna
