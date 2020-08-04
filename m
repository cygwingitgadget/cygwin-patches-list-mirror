Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id 655C1384242F
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 08:12:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 655C1384242F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeTkC-1kdJHI3wiC-00aUzW for <cygwin-patches@cygwin.com>; Tue, 04 Aug 2020
 10:12:48 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 32F25A807C3; Tue,  4 Aug 2020 10:12:46 +0200 (CEST)
Date: Tue, 4 Aug 2020 10:12:46 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler_proc.cc(format_proc_cpuinfo): add SERIALIZE
 instruction flag
Message-ID: <20200804081246.GT460314@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200803162246.2872-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803162246.2872-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:aB2cK4emJdoHkjbmIbyMfmIth7x7sHcszCNHRiJN2gNPsz4MnLn
 1+B6P99X20qSGKLWUU8YUKwICjm9cUX9s8qtsHyqPBAY6IlczIrSj6w+6bQaLFATy+3Q7tQ
 hilXWmSxlyZ4MBxRcKtHRD0c8/Htx4IG3R4HChX8YMw9/8a1XqF6M3iSsXkjrIbkYCAzqGR
 J+75S4AN70SAXeqOKKxig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Mzd02HmmR8=:XJ82lk8DpMVozGX106edi6
 PpTgqQn2MM0ir/bntK7vKxadQZfipZTWAv+XzVQ+gRkQCb0Sh1nudL9crDUkTiGHr9OFaWD+Y
 Yc4SpAylH2QlY0F5TdrT/bETkJ07DGUL4aEulI8KrtiUiC3QyNcdRqrvK6OKz50wkUdwhgXnW
 6s3JO59Pue/h54bwuSF2a/yT+clL0MLBqGakZyNk0Z/yAxGL1brBPhihPf5/0gMP0n5cr6PFx
 otAXqUQrVVXBEpaiN8ckN1HAsHheDKip9Tovx4F1MQ4ArTwa77t/NLCLQ4VaZVQHUnXtOvq4T
 ebQqISUubN9pXDXLDYcKnV87fcW1aIpMsd/vnLWo1R3Etd+TQIkXpzyeqETBQrMAZmZ8av7Vf
 rnBYISV/WfShRtlfD3sAHbgI4OjeLM8X53USiYljNm4D3P3xcoDM9nO0r78gHJ5c1ojmQkb3/
 A9HGUQkgd3h7G8+h5Qey4a09aT7F50GhE8z/zK+d9wejwVGYO3orxh5OGC884FPEgxgoazD0Q
 t09uWwhdWqsBs9Al4dMwzqkyPRC0/4tb3S9wXpzuPr3Z+593x+xcDojbd801o2LKL/1oUZfmu
 rCowrxV354RSsPrRHqsxWrCGf96zKgkWcfMcj6zwdkU2h722MdmOmA0SB+48UZlxVdoDAGDLy
 veqJXPtZNmRX0AtB8zqFx3kK0N2GlpbpR4echfZrhBPyoaHfVUvA0rX3vmvG3gcq8QQ7Kllza
 uwbXQlrUeOewy3ormfiEWbfK8uaWHeVOkG6gkxm8Bk3SqIecJO0FyDtZPVVKDJAc+UIolqQEE
 cjjuBg+0NRYainZttlKu05n9wQmIxIu6CZ+OrQG96UiNmg2txvTiT/vAqXxdqxf1ZQQLKIdBY
 CH7+ES3uPTjyL67foB9g==
X-Spam-Status: No, score=-105.0 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Tue, 04 Aug 2020 08:12:52 -0000

On Aug  3 10:22, Brian Inglis wrote:
> CPUID 7:0 EDX[14] serialize added in linux-next 5.8 by Ricardo Neri-Calderon:
> The Intel architecture defines a set of Serializing Instructions (a
> detailed definition can be found in Vol.3 Section 8.3 of the Intel "main"
> manual, SDM). However, these instructions do more than what is required,
> have side effects and/or may be rather invasive. Furthermore, some of
> these instructions are only available in kernel mode or may cause VMExits.
> Thus, software using these instructions only to serialize execution (as
> defined in the manual) must handle the undesired side effects.
> 
> As indicated in the name, SERIALIZE is a new Intel architecture
> Serializing Instruction. Crucially, it does not have any of the mentioned
> side effects. Also, it does not cause VMExit and can be used in user mode.
> 
> This new instruction is currently documented in the latest "extensions"
> manual (ISE). It will appear in the "main" manual in the future.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/x86/include/asm/cpufeatures.h?id=85b23fbc7d88f8c6e3951721802d7845bc39663d
> ---
>  winsup/cygwin/fhandler_proc.cc | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/winsup/cygwin/fhandler_proc.cc b/winsup/cygwin/fhandler_proc.cc
> index 4bb8bea1766c..72ffa89cdc79 100644
> --- a/winsup/cygwin/fhandler_proc.cc
> +++ b/winsup/cygwin/fhandler_proc.cc
> @@ -1578,6 +1578,7 @@ format_proc_cpuinfo (void *, char *&destbuf)
>            ftcprint (features1,  4, "fsrm");		   /* fast short REP MOVSB */
>            ftcprint (features1,  8, "avx512_vp2intersect"); /* vec intcpt d/q */
>            ftcprint (features1, 10, "md_clear");            /* verw clear buf */
> +          ftcprint (features1, 14, "serialize");           /* SERIALIZE instruction */
>            ftcprint (features1, 18, "pconfig");		   /* platform config */
>            ftcprint (features1, 19, "arch_lbr");		   /* last branch records */
>            ftcprint (features1, 28, "flush_l1d");	   /* flush l1d cache */
> -- 
> 2.27.0

Pushed.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
