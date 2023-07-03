Return-Path: <SRS0=WU4+=CV=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id E9EB83858D28
	for <cygwin-patches@cygwin.com>; Mon,  3 Jul 2023 06:59:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E9EB83858D28
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
Received: from shw-obgw-4003a.ext.cloudfilter.net ([10.228.9.183])
	by cmsmtp with ESMTP
	id G08JqPIgxLAoIGDXGqsNkF; Mon, 03 Jul 2023 06:59:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1688367586; bh=g5AXz7zdvfYIjhq4CVWDxdOVZnw+RygIBltX3IieG5c=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=QiEwOdt0f5QCM8mPoxvBO8s6UzLiKNFqTtwO8ra+zwj9c6iBdr23VKCXu+TsUSJwE
	 NaX2+5/DRzXHn5tqIq9qxB9Ka8erX4tR8S3VrMofhkEJ0XyH4Uh8F+vJUcxkjz3wyt
	 OO1OKpzBL62vzccwOcNRvKneib0jmVGPrzTy9wBjVpdBtfo7rqpigr7hBPUtUefivW
	 7qpenGWXh9uP4foStO135+nMoShxZru96DAg9UDVp/d2xU5ie81wbNYfDySvEV/c1i
	 /v1TALOs0ZHzvfYYIg0TQ/yL/QlIm+IxZkqfVahT3hIMm1bRIqELpkKdC0duF9MuCu
	 cG4xu16C+ZrLQ==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id GDXFqEHt4cyvuGDXGqyaka; Mon, 03 Jul 2023 06:59:46 +0000
X-Authority-Analysis: v=2.4 cv=VbHkgXl9 c=1 sm=1 tr=0 ts=64a271e2
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=w_pzkKWiAAAA:8 a=OJdjf9PGVqm-ZWuIBscA:9 a=QEXdDO2ut3YA:10
 a=JWzpkttAmvkA:10 a=4kk6h8rRjzwA:10 a=sRI3_1zDfAgwuvI8zelB:22
Message-ID: <b5d4a958-cab1-ab8f-d268-0be51e4ebf34@Shaw.ca>
Date: Mon, 3 Jul 2023 00:59:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Make <sys/cpuset.h> safe for c89 compilations
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20230703061730.5147-1-mark@maxrnd.com>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <20230703061730.5147-1-mark@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfPmV0kgxUZv4S1JqAG1jS4xHtVjf6p4eE7CTd6fVu1g769Vcr+emV8GyLphLWpWpYeD+z+g9lFyeEhG0VovCsQWEDMw4JfsU2Ik89Y3ZhxJAYqPyuhLN
 kVc6qfLeOFglJHTkbqDNRgaYHh7x9ss20O8OhUr3U70enBzUJu1Of/zSaWtCunXBtFaz9KoVdqgbKwcyf9Dt1/8azZQMuMkop/c=
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-07-03 00:17, Mark Geisert wrote:
> Three modifications to include/sys/cpuset.h:
> * Change C++-style comments to C-style also supported by C++
> * Change "inline" to "__inline" on code lines
> * Don't declare loop variables on for-loop init clauses
> 
> Tested by first reproducing the reported issue with home-grown test
> programs by compiling with gcc option "-std=c89", then compiling again
> using the modified <sys/cpuset.h>. Other "-std=" options tested too.
> 
> Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html
> Fixes: 315e5fbd99ec ("Cygwin: Fix type mismatch on sys/cpuset.h")
> 
> ---
>   winsup/cygwin/include/sys/cpuset.h | 47 ++++++++++++++++--------------
>   winsup/cygwin/release/3.4.7        |  3 ++
>   2 files changed, 28 insertions(+), 22 deletions(-)
> 
> diff --git a/winsup/cygwin/include/sys/cpuset.h b/winsup/cygwin/include/sys/cpuset.h
> index d83359fdf..01576b041 100644
> --- a/winsup/cygwin/include/sys/cpuset.h
> +++ b/winsup/cygwin/include/sys/cpuset.h
> @@ -14,9 +14,9 @@ extern "C" {
>   #endif
>   
>   typedef __SIZE_TYPE__ __cpu_mask;
> -#define __CPU_SETSIZE 1024  // maximum number of logical processors tracked
> -#define __NCPUBITS (8 * sizeof (__cpu_mask))  // max size of processor group
> -#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  // maximum group number
> +#define __CPU_SETSIZE 1024  /* maximum number of logical processors tracked */
> +#define __NCPUBITS (8 * sizeof (__cpu_mask))  /* max size of processor group */
> +#define __CPU_GROUPMAX (__CPU_SETSIZE / __NCPUBITS)  /* maximum group number */
>   
>   #define __CPUELT(cpu)  ((cpu) / __NCPUBITS)
>   #define __CPUMASK(cpu) ((__cpu_mask) 1 << ((cpu) % __NCPUBITS))
> @@ -32,21 +32,21 @@ int __sched_getaffinity_sys (pid_t, size_t, cpu_set_t *);
>   /* These macros alloc or free dynamically-sized cpu sets of size 'num' cpus.
>      Allocations are padded such that full-word operations can be done easily. */
>   #define CPU_ALLOC_SIZE(num) __cpuset_alloc_size (num)

Does this patch need __inline defined e.g.

   +#include <sys/cdefs.h>

did you perhaps include this directly in your test cases?

> -static inline size_t
> +static __inline size_t
...
> diff --git a/winsup/cygwin/release/3.4.7 b/winsup/cygwin/release/3.4.7
> index 0e6922163..923408ec2 100644
> --- a/winsup/cygwin/release/3.4.7
> +++ b/winsup/cygwin/release/3.4.7
> @@ -25,3 +25,6 @@ Bug Fixes
>   - Fix return code and errno set by renameat2, if oldfile and newfile
>     refer to the same file, and the RENAME_NOREPLACE flag is set.
>     Addresses: https://cygwin.com/pipermail/cygwin/2023-April/253514.html
> +
> +- Make <sys/cpuset.h> safe for c89 compilations.
> +  Addresses: https://cygwin.com/pipermail/cygwin-patches/2023q3/012308.html

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
