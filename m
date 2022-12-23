Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
	by sourceware.org (Postfix) with ESMTPS id DCA2E3858D1E
	for <cygwin-patches@cygwin.com>; Fri, 23 Dec 2022 09:15:05 +0000 (GMT)
Authentication-Results: sourceware.org; dmarc=permerror header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MTAJr-1pIjRv1uEp-00UXQl for <cygwin-patches@cygwin.com>; Fri, 23 Dec 2022
 10:15:04 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
	id C21A8A80CC3; Fri, 23 Dec 2022 10:15:03 +0100 (CET)
Date: Fri, 23 Dec 2022 10:15:03 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] fhandler/proc.cc(format_proc_cpuinfo): add Linux 6.1
 cpuinfo
Message-ID: <Y6Vxl/D9h/JytK7z@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <4d0d6a99-5f21-33dc-c9fa-7d73eef030bd@Shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4d0d6a99-5f21-33dc-c9fa-7d73eef030bd@Shaw.ca>
X-Provags-ID: V03:K1:ZI/+p47zwdZTpF50BfLfnFHvk8svgXZAEk8VC1LpyX6o+CwJYel
 q4D4L8ke4heLhZfE2y1h+f8OpnjmO91BYnfQtj3ytLZcgTawliYhJdT1ioNYwaSFwmlXCqB
 4t5BMD8C1dSJ1Kd4Ny+BHN+l2+0y7fa4dBuOQ4aGtBGZhQm9KrsV4IJMKbzzHd4cmP5uESB
 ZE4zX/KPBY4N7T+psT7RQ==
UI-OutboundReport: notjunk:1;M01:P0:u1IRmwG5k+k=;4ggB+u2BH3WdfivQLkh7h4d1lBw
 F28HdrTKDc49+Zgjz4J5d9l0/O3pGdMYKZfuF+oEKX35IOynM64xUltUNezf6xWU9xJUtbbHp
 A9tUeOj73BFG2HPGMfwtaUMBOrme9cwFRWMp9v6Pyg1AS3pTiU8H0scli20f3d0+8PvLHRlEs
 VZXVpv7wYdcoYakEVyQUtrtjiP8wz41hR5eOJ2JpHyOfWC45UqIgqo7RTeys8GzUHGu3lWHwy
 iOv8rsLLclUtUEJ8v9BC/sBjFV0zz9yofR2LqgmWE29Hw4bxuOtPBRvNGIa9ekXqMgc+UDxlT
 FZfZraL8HgJrppoaecN379IAXYYSnCiXgeY6F+N6ymFRbvRHNPq+/IaxvgKo5uE5HkfgwXXkv
 0dYuMJu6/hY3JowqRnUvn2sFZKumnxUXSRQo9oieQd/lHbJXOH4Guy+kB4uRq3d4s/5dMh4GA
 OQGxTg9CKfc+YkZGmRrklI3UuFvWpIAAdDRXV42UmZzMPH0XSWK0zy9sgZfdEU8tW5NaJNTsH
 e0v12Y5kuaCKsQrWuifrgxwf2xq3g35E89TYWd2slZ32ZJzwwnmlx60a7IqC1EaOjs679vwJK
 hGbOGLV0okjCiDPWSNVy92oM8cAeomANO3jopab9tobVCaXVTbhn7SOvN8itr6kkUoMz7AoPN
 EO3skYbZcbuudlRZ2Jw5+dqnRP4fHhT/AbxMFFpB5w==
X-Spam-Status: No, score=-102.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,GOOD_FROM_CORINNA_CYGWIN,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_FAIL,SPF_HELO_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Dec 22 13:26, Brian Inglis wrote:
> 
> Intel 0x00000007:1 EAX:26 lam	Linear Address Masking (& recent entries)
> ---
>  winsup/cygwin/fhandler/proc.cc | 4 ++++
>  1 file changed, 4 insertions(+)
> 

> diff --git a/winsup/cygwin/fhandler/proc.cc b/winsup/cygwin/fhandler/proc.cc
> index 6643d1f1aa0f..75a6a85517cd 100644
> --- a/winsup/cygwin/fhandler/proc.cc
> +++ b/winsup/cygwin/fhandler/proc.cc
> @@ -1484,6 +1484,10 @@ format_proc_cpuinfo (void *, char *&destbuf)
>  
>  	  ftcprint (features1,  4, "avx_vnni");	    /* vex enc NN vec */
>  	  ftcprint (features1,  5, "avx512_bf16");  /* vec bfloat16 short */
> +/*	  ftcprint (features1,  7, "cmpccxadd"); */ /* CMPccXADD instructions */
> +/*	  ftcprint (features1, 21, "amx_fp16");	 */ /* AMX fp16 Support */
> +/*	  ftcprint (features1, 23, "avx_ifma");	 */ /* Support for VPMADD52[H,L]UQ */
> +	  ftcprint (features1, 26, "lam");	    /* Linear Address Masking */
>  	}
>  
>        /* AMD cpuid 0x80000008 ebx */
> 

Pushed.


Thanks,
Corinna
