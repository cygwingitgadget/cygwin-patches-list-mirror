Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 7B8603857C5A
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 07:04:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 7B8603857C5A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MlNgx-1ka1dM3e0b-00lihI for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020
 09:04:33 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 10E20A80D0B; Mon, 13 Jul 2020 09:04:33 +0200 (CEST)
Date: Mon, 13 Jul 2020 09:04:33 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
Message-ID: <20200713070433.GH514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200710173450.46857-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710173450.46857-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:HI15IKnaNiftCG/iOXhZcVU3mUIb0pULeaEk5oDsFDXnSL7TBkO
 AW8itmG/Oh7eFrR+FwyXCHsUaz6JIe3XYYxq6ZMXNtwHovQYJcQcyhYoxOa3f7CWOOrj2JO
 JVyIR7QB9WHqU3e1ukaqQKHMEdIzehM2X3OC75LHnqSPyJnVB+AMWiiWmytGohKcOHLLWQ2
 c4a7X8zNwvjM/53QhF5JQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZDAjDbcQ1ao=:fvKsFMXVrjr+xpLrEVDr7f
 vTzklT/PVlP+pymWe/UqBr4jZQWbdW+qfY3G7mciHGry3tKPNbnssHQwyAwwV89BRShQSfyS1
 a2Czb65j2/wECVpVJr5Tw24sCdDKap61+zMJzsqkdcivRk9ld34xsrMjrJf9aIINXH4EAqTyY
 ZH8Y1wUycImWhncwm3+ZaiqC+qhdURZIGguyZgx0ikiu5QlB+MhFlx3GH8fOa+lEGFEsno1zD
 O4BJUkmYQL2PA227rUP0MgE41L56iGYUtYBY68H21t6YZ8MZ7IxZQ5g15ebcB4PTtTydWlI+1
 rv9BzJSNG7mM77/YrwVyulV2T7o4XnImzogcLik2iHmx37dr0DO+PmMwUZYpWu5mX24reATN0
 V46vXmZE7yDVN0dTQ8FSMAVlNi0VXl9NAsM2J3mhwZB3aOIoRxeZlIq05vkzB6J8BVsReRdfr
 2cqDY92SYSguWW2X6MYDwfgyXDamhaRwdKPtkTOAaKtiDX6fNDvMyASEk2G8kjN6eIeypB+iN
 hszpTICs6N50F0yXZFHacLYR+JTAum+K68C7RjdEF3IEJkXnl3YDEcysCcaKYC7llPjHLPCR8
 WkzpFhCyYEyu4mCpmDQ18rGrJzIIgOMkqY/ItxKDTuM/iuyG/zskX4M8c4K0Cavk+LS4XxVVm
 3CJhihwbdG62ACt4zL/ah6W/pvGnRhiGHMwaQbEVvtDkE0i7ZPDViVI2eeJS9+WSnL0wdKl2i
 ZEQV5kqbBhIGMtJ4c41zAU+qXXpq3uu/OKh7ZMcoEPqQaBel7eI4oP69em8z1Ro0ecx+AuDU5
 cclCox9hKWe0q2uv/K1zWAM5ig0B2oHJ2ZxfPA+g2sWbKCA23w5NWcx2xjc/jyYu8A5K4dQUZ
 qmMOgHBeahIB6ACfPG2A==
X-Spam-Status: No, score=-103.5 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 13 Jul 2020 07:04:37 -0000

Hi Brian,

On Jul 10 11:34, Brian Inglis wrote:
> Patch to:
> 	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html;hb=HEAD
> as a result of thread:
> 	https://cygwin.com/pipermail/cygwin/2020-July/245442.html
> and comments:
> 	https://cygwin.com/pipermail/cygwin-patches/2020q3/010331.html
> 
> Relate Cygwin DLL to Unix kernel,
> add required options to command examples,
> differentiate Unix and Cygwin commands;
> mention that the cygwin package contains the DLL.
> ---
>  faq/faq.html | 49 +++++++++++++++++++++++++++++++++----------------
>  1 file changed, 33 insertions(+), 16 deletions(-)
> 
> diff --git a/faq/faq.html b/faq/faq.html
> index 1f2686c6..8659db5d 100644
> --- a/faq/faq.html
> +++ b/faq/faq.html

Huh?  This file doesn't exist in the repo.  The path is not relative to
the repo root, and the file is called faq-what.xml.  Can you please
check this again?


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
