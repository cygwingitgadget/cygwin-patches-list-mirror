Return-Path: <SRS0=dqak=H5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo009.btinternet.com (btprdrgo009.btinternet.com [65.20.50.104])
	by sourceware.org (Postfix) with ESMTP id 20DA04BA2E2B
	for <cygwin-patches@cygwin.com>; Wed,  7 Oct 2026 11:41:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 20DA04BA2E2B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 20DA04BA2E2B
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.104
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791373305; cv=none;
	b=bG/dZRkApfrhXlknoY1WQeymtE+ok9j9tzwIr9H+cLbn0X/M0k0k8Unfk39vB/nPvJZcanRLzRMbJtnSUHpafAZ23kEOtT7O31NT0PvZEA+IiwF2wgq6kRZfzCZDscp+FvgYNfqJYZSxGxfSsjDz/Bz5k1KVqf2aGC35Pb6e+10=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791373305; c=relaxed/simple;
	bh=sGExdl2BOIuLiy55Hu0qqxZEJZDGsGq+O9RagmgJFsU=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=vvX64G2OMd/JgmV2khtK8QWsNInnuiHGPRUVY505EodOhc2nyroG/My8/GeFeP4sEM9pO0M4L2ae+Iwghn6qX2ly4LIQBPk2tYQUYprCjy0asNRY0IguSUyLdrg8wkSzcMhs6HnB49I6RCnTZf6/N5I14o/+U1TKK3ygK0qM+ZQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 20DA04BA2E2B
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715FF30C657D24
X-Originating-IP: [62.56.7.113]
X-OWM-Source-IP: 62.56.7.113
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTGPuu0KQFoNu/B1QMEzubWJJPM2xj+B8E2ulX4Y3JNDrrstFkSPvwYH+npqniXepEnh5O1MaeafxrALW6mB9yRdktSr6h4O9OXqv/HmNElqvgKaSsQ7bu3+8u9tPjTjRUKBAdkbUuR5DL5EkY4YbOGhXxsgaCbFhON9R/cHQxCQQZWYkaWGxDc8PnQ6vKY2G3LmDdKXymnWuvoSlV94gKuPPbD3CnCDAf5tMl+NqRtuP1pwhq2hdPcoTddd2vb6+FGV/oVhiPWodKeoKo1mshqdpzCDxIBh+3FQEdBeIY1cIXLVxWyXLyq34rcLZBtz4uyiAP098xCqHq7VdnyxwF3HX1wMN023x2hlvsSDxruwGOl+ZWBlS+j584u5XP1rvuhX6UXkfMs3MVqhJNZA6YlSdx0XUBdQcexXOWMzIliFZ66ap/bUtk/QOzq9OyxyVB/oi1gtEnxdB3VO/zfaYgz9c8gjn0BIUPEiq34FCY039IMBqiPKd9reA007OLkKa3HuLWRixFsikIuJcnKTC0EKPCg+Ei8gajXftTBmIlc0SlLb51I90xwXsXLPO4S+8GQZfF7llZdJRpHm9z1E3cgWn0d513yaq4+CuQC1Cix4bxCh+mdgQu/eRSiWwMjhm32WfBKoc926rDIOjVmW6ZP0ym21vUJeI1/mpeINYqVPOw
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.7.113) by btprdrgo009.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715FF30C657D24 for cygwin-patches@cygwin.com; Wed, 7 Oct 2026 12:41:39 +0100
Message-ID: <4b5c229a-b527-4ffc-82a7-69cb3f5008e4@dronecode.org.uk>
Date: Wed, 7 Oct 2026 12:41:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: devices: Fix the code for device number handling
References: <20261007000050.100799-1-takashi.yano@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20261007000050.100799-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/10/2026 01:00, Takashi Yano wrote:
> Currently, the code handling the device number is not match with
> the expected code intent. The shift width for the major device
> number should be the size of _minor_t, rather than that of
> _major_t.
> 
> Fixes: 7ac6173643b1 ("* devices.h: Renumber devices based on more Linux-like major/minor numbers.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> ---
>   winsup/cygwin/local_includes/devices.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/winsup/cygwin/local_includes/devices.h b/winsup/cygwin/local_includes/devices.h
> index 10a46150e..8e02f60bc 100644
> --- a/winsup/cygwin/local_includes/devices.h
> +++ b/winsup/cygwin/local_includes/devices.h
> @@ -11,9 +11,9 @@ details. */
>   typedef unsigned short _major_t;
>   typedef unsigned short _minor_t;
>   
> -#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_major_t) * 8)) | (unsigned) (min))
> +#define FHDEV(maj, min) ((((unsigned) (maj)) << (sizeof (_minor_t) * 8)) | (unsigned) (min))
>   #define _minor(dev) ((dev) & ((1 << (sizeof (_minor_t) * 8)) - 1))
> -#define _major(dev) ((dev) >> (sizeof (_major_t) * 8))
> +#define _major(dev) ((dev) >> (sizeof (_minor_t) * 8))
>   
>   #include <dirent.h>
>   #include "cygheap_malloc.h"

Ha!

Just so I'm understanding this correctly, this isn't a functional change 
because sizeof(_minor_t) == sizeof(_major_t), it's just clarifying the 
intent, right?

