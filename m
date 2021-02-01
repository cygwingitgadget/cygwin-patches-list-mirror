Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id B8AD63858018
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 09:55:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B8AD63858018
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M5jA2-1l3lpQ22fq-007EX5 for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021
 10:54:58 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 12BC5A80CFE; Mon,  1 Feb 2021 10:54:58 +0100 (CET)
Date: Mon, 1 Feb 2021 10:54:58 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Recognizing native Windows AF_UNIX sockets
Message-ID: <20210201095458.GG375565@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210130163436.21257-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210130163436.21257-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:2qt1/Aq+Ryj/ja05+vE4CXS4TqmbzekXe5l8qf2uiwVnAaRaZit
 M7AabP5cAnKz3XZj0xopFTDIqCCR7L+U6RbMajGktqPf0VtfwkldlYlWnAe37AnxONDvIT1
 eVMIFqyZ+wPV1EJ0jmKw8Lpps06F0IZWj/sDCX/f4vMOvyqG0amUK8yH2hb7YNSx9NUbJza
 3esWBqGvYVL2yIkql7CQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zAJNfBltods=:RUB7+XsRCeF8NYYs5entJX
 gtPaXF33TVxg7qPpBLT1+3kWqwEZBUD7XAfXpZr4EXO23EMF+iaog8bv/luFsgTiv9zfNBjFK
 p04aUgzF7b0Mldi2nZAHmTQqNH9seqoYD+IwEE0WXXg6g0inclOUfGKIAGtHoOYCLKOSjgirC
 dQbIbpJ5xVO1YwEw9xOdSwhYcl4sZByrIyKOzHza6WWFlIRRy4hkIOGXj0WYfo4IX5A06mz+T
 lLWC84h8l4hl7eQ1bIuEUWhP8bTIF5O5TSQabUU3WpUbF0BvcECl16N1lCg2SWiba+XGl5oYj
 tTsbsqybw6Sgbf8E5/40QaMY0gSDbG+P5ZU1COAfbyZhT8SOgO4WHJZ+mbICCqxp45NnNOldF
 1bqUp4soU2enLeCrWaTEYg+7FtuTI4jcG98366H5UG5/dJTtrwuedsNAJomITUp1ec6mcSjvc
 LrRNJDLJ56QnH/Lhq8rnHMQBlsNyWmDER97QtFEbKXWwRWTOGn9MUaL3Zicq/HpZ/SnfiKoLq
 w==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
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
X-List-Received-Date: Mon, 01 Feb 2021 09:55:04 -0000

On Jan 30 11:34, Ken Brown via Cygwin-patches wrote:
> This patch attempts to fix the problem reported here:
> 
>   https://cygwin.com/pipermail/cygwin/2020-September/246362.html
> 
> See also the followup here:
> 
>   https://cygwin.com/pipermail/cygwin/2021-January/247666.html
> 
> The problem, briefly, is that on certain recent versions of Windows
> 10, including 2004 but not 1909, native Windows AF_UNIX sockets are
> represented by reparse points that Cygwin doesn't recognize.  As a
> result, tools like 'ls' and 'rm' don't work.

LGTM, please push.


Thanks,
Corinna
