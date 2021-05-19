Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id 9769A393C87C
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 17:47:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9769A393C87C
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N5FtF-1lHkSN0ekX-011AFV for <cygwin-patches@cygwin.com>; Wed, 19 May 2021
 19:47:38 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 797DCA82BF8; Wed, 19 May 2021 19:47:37 +0200 (CEST)
Date: Wed, 19 May 2021 19:47:37 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: utils: chattr: Improve option parsing.
Message-ID: <YKVPOaBrb0a9lV54@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d515bfba-ce77-40c0-0c3e-67895675f753@t-online.de>
X-Provags-ID: V03:K1:LawGBkUvffvsI4QxmvUDNa5S0hJi8TKLrzPioex2QKIombz9rOV
 M/0GbmV9t7boHEijOrO7xM8srgnyjQTklP76+CDxljEoz9kw8w4q/zocruZ1Za8AC3GuMqQ
 x5ath3qUR4EE8V2n1J3WC7v8SKZtSdiMKByWyn/UyHST/1gpLkW3gAi5nQsq/Fm8XB96lVc
 rki7/UD56O5DGjU0YPPrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Bow9VtjdmSo=:5wVz616mkuKmXvmSGNmaEX
 k5hZCPELufi21/LKFsHlpLNcb2FaTqm4Y9YJvzH/t5xIOWDUKGp3c5gr57j32Rci4Fgu+5iBi
 STi8Fe8lVaEtha3TQVuBsfasWZkmCW5ZeXBXJNYqMOJM2AkEwgpyYEl2+LY+GE+ZMQPTVoBtb
 yc02LIw3FhM8mMqhD9wVJMshgrMuPafpWPlegCGrS1UFyrhEp9ch1Ln9Wb+OawyRNhy41vWv7
 bnCgLJ9YeKl/c/FzeCFno5IL9ekBhDQg4xjwzwniNctbW2fUKUQiQ2IROpJeRGlIVxvDNF0Tt
 9EQd5DuDCFWWsVVE/NW5qpu2FB8hHE3G0BhAYa4TASsxj35vorH+5ePCPZ9t0u1/OCdXDuMiJ
 R9EUwrBfKk2qNaf+kQsreMKT69QBsaJqZ7IvvXxJJoD3ra2ZmGwOzohccYZ8uW4YUdcvE3JG5
 4Wh2ryUYVns9sJSSfnKEHt1MlFOE2ww75EfmqSR90QBtJzGSrwWb2fO206q+RyXjLx675cONK
 a2YszHwkrDKtTMB+Dpsgf0=
X-Spam-Status: No, score=-98.6 required=5.0 tests=BAYES_00, BODY_8BITS,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 19 May 2021 17:47:41 -0000

Hi Christian,

On May 19 17:46, Christian Franke wrote:
> This possibly improves the usability of chattr for some typical use cases:
> 
> Command         : Old  : New behavior
> ================================================
> chattr -h       : help : help
> chattr -h FILE  : help : chattr -- -h -- FILE
> chattr -hs FILE : help : chattr -- -h -s -- FILE
> chattr -sh FILE : fail : chattr -- -s -h -- FILE
> chattr -ar FILE : fail : chattr -- -a -r -- FILE
> 
> Unrelated: there a two trivial block-copied-but-not-changed issues:
> 
> $ egrep 'ACL|--r' chattr.c
>           "Get POSIX ACL information\n"
>       "  -R, --recursive     recursively list attributes of directories and
> their \n"

Oops.  Please patch while you're at it...

> 
> Regards,
> Christian
> 

> From 865a5a50501f3fd0cf5ed28500d3e6e45a6456de Mon Sep 17 00:00:00 2001
> From: Christian Franke <christian.franke@t-online.de>
> Date: Wed, 19 May 2021 16:24:47 +0200
> Subject: [PATCH] Cygwin: utils: chattr: Improve option parsing.
> 
> Interpret '-h' as '--help' only if last argument.

Who was the idiot using -h for help *and* the hidden flag? *blush*

I'd vote for --help to be changed to -H for the single character
option.  The help output is very unlikely to be used in scripts,
so that shouldn't be a backward compat problem.

Would you mind to change the patch accordingly?


Thanks,
Corinna
