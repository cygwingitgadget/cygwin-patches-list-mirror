Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id E58DD385702D
 for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021 09:39:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E58DD385702D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MRT6b-1lXQgE2zYr-00NQvD for <cygwin-patches@cygwin.com>; Wed, 17 Feb 2021
 10:39:11 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 55520A8066E; Wed, 17 Feb 2021 10:39:11 +0100 (CET)
Date: Wed, 17 Feb 2021 10:39:11 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] cpuinfo: fix check; add AVX features; move SME, SEV/_ES
 features
Message-ID: <YCzkP/tySyRgeO5v@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210216160059.62164-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210216160059.62164-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:CC6rBKrSoxcF5EwadOvIV/6wZMfIj9Z39zy0DCQ8ywKBPmguepw
 7yh39CBmE70WFlgNxi41KvralfDysHrD07hauc0sQcaXuOHPyJWFqez6hbsxP1C1kApx75p
 r6k9cFWoQrKgGnBH/LCvd5j5FN3spb8LJOBQMbRXfUgqyFqgPCcilysFqzFIQtrGbHLYEcs
 xYL9o2D9GZC1YJYiK22RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qir4dTCJ1HU=:ke8EBmsxk3dE5HeUm675Eh
 gJxQN1qVfLTKp2xGiREhOf5yAu6d2ULXMWqHOyszrPTRSu4NpznR1N+Zh4ZX1rPM6EkoC9f5Z
 cDszt/Al63QwuH4SplLLNiDQt6cLHHH1zvsfbV64WwluHIiybyhRJtxAcVU4K0WQP6DPV8u3L
 AmAGWBs6ico8Z/HF2yVHaj39sWO6awf5bTJ1nkVUc/UAyGD9JDHOUp15L1LmhiMrMMq+X4+bg
 YqVctP2F69qM7z9wE3NL+HKmmjj70IEdgn9wVHrFNeW6fL1YtcCLgGAOwWnCzskgoUw85RkNc
 G/eukCEQ2741u/f2ubchXVjTSoCypEhXp96xgLYf5FN4dCJkAOGbUFMWjLmwuziG1VKiZ5+dB
 pyn31IyJCOPczRNdpKT5lGteWr7mlD3Qjs0CWegVbQVtK2MDQmReBSVrfzX/ICufnRhkgGH+0
 Ad7oBRkIYg==
X-Spam-Status: No, score=-104.1 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPAM_BODY, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Wed, 17 Feb 2021 09:39:15 -0000

Hi Brian,

On Feb 16 09:00, Brian Inglis wrote:
> 
> fix cpuid 0x80000007 supported check;
> Linux 5.11 💕 Valentine's Day Edition 💕 added features and changes:
> add Intel 0x00000007 EDX:23 avx512_fp16 and 0x00000007:1 EAX:4 avx_vnni;
> group scattered AMD 0x8000001f EAX Secure Mem/Encrypted Virt features at end:
> 0 sme, 1 sev, 3 sev_es (more to come not yet displayed)
> ---
>  winsup/cygwin/fhandler_proc.cc | 46 ++++++++++++++++++----------------
>  1 file changed, 24 insertions(+), 22 deletions(-)
> 

> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 8e23c0609485..501c157daae5 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1293,7 +1293,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  
>  /* features scattered in various CPUID levels. */
>        /* cpuid 0x80000007 edx */
> -      if (maxf >= 0x00000007)
> +      if (maxe >= 0x80000007)

Maybe I'm a stickler here, but I think it would be nice to put this
bugfix into its own patch, prior to the patch adding the 5.11 features.


Thanks,
Corinna
