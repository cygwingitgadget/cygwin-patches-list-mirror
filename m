Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 5E0873947403
 for <cygwin-patches@cygwin.com>; Fri,  1 Apr 2022 12:55:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 5E0873947403
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mj8eD-1oCswe28dJ-00fD68 for <cygwin-patches@cygwin.com>; Fri, 01 Apr 2022
 14:55:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 21DB6A80D52; Fri,  1 Apr 2022 14:55:21 +0200 (CEST)
Date: Fri, 1 Apr 2022 14:55:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add Linux Superb
 Owl cpuinfo flags
Message-ID: <Ykb2OSLYLxAKkcv7@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220324045759.57242-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220324045759.57242-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:SKh9Zb/pFu4nJmwopXOxON6CLkK34kEYXpsyCF6JN0quO+kGtJe
 2PylnlcoSkxtY0xhH03esR+NUNIVrulKJD7Rddc2d03d3N70AB2sPon+y3ifQ3qxKlshry5
 CSEa2agPM/r+UtTTtUQSyKnbM8PkpMAzllyYW1bHiXlDUURNj24pVTH/bakHDRBAjsRWtwQ
 kJAhdPTU8iVadK0gF8hjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HXgG9KXhT9I=:GR3jong1Alfw8UIfKDw1HQ
 AE/+h07NzlDdD/RvwNGAvVj4YiumGte/vSQ+S1i+PvgW+1/4Za2Y3JeuO+BHFpgxAzveNsTmt
 /hZT6sjr7GGIRChi/hHkzqSX2hN8639WsC22MzMXDev3r87dvLG0wm/soembUCC0P6w9M4J3G
 f5IYT1zMwRQgEj2LpflYguXgBWUA/ko0Bx7+6ZrFO/YuDcFOcQCVDjuUvB0/xFt8GQg6uKecF
 dEsmG3pu5TuBCVrfeH4LZ5apRRvv0QI3IFa/5X9VpjHI2LrgREh9kER0QhPsXgWEoeZcTMShH
 kn4kEvSuoJ6eyj61T5jX0MVckMLPGJfdhWNOhDY7c4BI9vdZkLXFhHBecYlp0PqJqwJqwURg/
 8sZIGXMwvfJpqXIdAn+q0nO1oBFgw5HvScbpLC9tq75+htivKBgnbQP6M00ezWfV6tqaeIuSF
 h++zJ/wGGW+x1btu5NblA4xJyEYpRnswwVuTFvK5D5t2wVS2KHp6ntbT7N0prAQg4PLrdUAms
 S8iAXAa6y+npNcGjZU/2n0DOKI7ITkXJVeO8LcOw7I8qMW6YEp1yvjfZj0rdbO5rR1G9+/+Pv
 m+V1liOujk0dZlY6wEU1zXAlpuxr4Yy6e3UC5PtaH/msWDvGxaOK2ls123gwgJHNEHSwAve+S
 YzFKkzM8ES4m73bhjIUlCoLPcDhiZP5e+gqXrRFeKBb6Tj/XqUNV80Om2VaOmlbdGVryEC1FM
 Mp41/fxzHp0XVkz9
X-Spam-Status: No, score=-95.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Fri, 01 Apr 2022 12:55:25 -0000

On Mar 23 22:57, Brian Inglis wrote:
> 
> 0x00000007:1 EBX:0  intel_ppin	Intel Protected Processor Inventory Number
> 0x00000006:0 EAX:19 hfi		Hardware Feedback Interface
> 0x00000007:0 EDX:20 ibt		Intel Indirect Branch Tracking
> ---
>  winsup/cygwin/fhandler_proc.cc | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 

Pushed.

Thanks,
Corinna
