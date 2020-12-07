Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 780693857027
 for <cygwin-patches@cygwin.com>; Mon,  7 Dec 2020 09:41:34 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 780693857027
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnJdC-1kKXiT0B1w-00jFJO for <cygwin-patches@cygwin.com>; Mon, 07 Dec 2020
 10:41:33 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1B085A806B8; Mon,  7 Dec 2020 10:41:32 +0100 (CET)
Date: Mon, 7 Dec 2020 10:41:32 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Launch cygmagic with bash, not sh
Message-ID: <20201207094132.GG5295@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201207061715.1028-1-mark@maxrnd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207061715.1028-1-mark@maxrnd.com>
X-Provags-ID: V03:K1:2PLpVHVn6vxL28uD1aLYOfrrE85TCIUkSqDIEVo5Q5cfCr9uAdQ
 pxA9rX1rNC+1eioFil9qyc8sOcfKgTrh4+uESftSCRQKCw6gEHpFt8qNvNKI52IdLxgZTVA
 U5V7CzZ75KFBbgVZTu0HAZg+xkSNmO46f+Jcg+4nFyCPUmZQyQm9YqpYYN5MKnzhHl6Ow9z
 SZwVy9ZCvULvsTdrCtNlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8sGFIybTG4o=:6J/GooNXxudYVombY5djMr
 i/07GyjrOOg8mksxrp6OpMYaGeL9xmxwhHjysW/xjINcWxY9RGmydxdyM7Yp5Ib8FsVjBv7BA
 el0I/4dIXrnWAIlti9pnReLX8alrPGQIt3TixCTsrLSo6vppQuOSd/F1xmreysdN2dZAJPek6
 JyzFdSFzou7rdObjEpVZ21mJDDHzftM2ShBmDr3Ovy99jiFGDkEz/J2YZtPiWIGcf2G9f4OCz
 CGOBzjqg4Rs/9vn+t1fDwdNsX/idDbIp+9EVgko37XGGj8gEpuuDcWHV0xWTwuynNNDzz+2CC
 rU4kk5n58ORpkdKgp28pXfSDz6oXoqrVtJvAZKBp21wO9OImsJMME1aHnoPkRaJ8RCnRUMoOt
 Q0v+4wNEyL+VG4k5z+dId7L+wB7fDr0dY4JXkJPZhOVMWJX4G9rhzIsAuW6N8auTnSCoq4Dqa
 3mWqpy1fSw==
X-Spam-Status: No, score=-106.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 07 Dec 2020 09:41:36 -0000

On Dec  6 22:17, Mark Geisert wrote:
> On some systems /bin/sh is not /bin/bash and cygmagic has bash-isms in
> it.  So even though cygmagic has a /bin/bash shebang, it also needs to be
> launched with bash from within Makefile.in.
> 
> ---
>  winsup/cygwin/Makefile.in | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/Makefile.in b/winsup/cygwin/Makefile.in
> index b15c746cf..a840f2b83 100644
> --- a/winsup/cygwin/Makefile.in
> +++ b/winsup/cygwin/Makefile.in
> @@ -683,10 +683,10 @@ globals.h: mkglobals_h globals.cc
>  ${DLL_OFILES} ${LIBCOS}: globals.h $(srcdir)/$(TLSOFFSETS_H)
>  
>  shared_info_magic.h: cygmagic shared_info.h
> -	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
> +	/bin/bash $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) SHARED_MAGIC 'class shared_info' USER_MAGIC 'class user_info'
>  
>  child_info_magic.h: cygmagic child_info.h
> -	/bin/sh $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
> +	/bin/bash $(word 1,$^) $@ "${COMPILE.cc} -E -x c++" $(word 2,$^) CHILD_INFO_MAGIC 'class child_info'
>  
>  dcrt0.o sigproc.o: child_info_magic.h
>  
> -- 
> 2.29.2

Pushed

Thanks,
Corinna
