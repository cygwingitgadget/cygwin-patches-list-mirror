Return-Path: <SRS0=04p2=DZ=m.gmane-mx.org=gocp-cygwin-patches@sourceware.org>
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
	by sourceware.org (Postfix) with ESMTPS id DC6AE4BA2E24
	for <cygwin-patches@cygwin.com>; Thu, 28 May 2026 12:33:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DC6AE4BA2E24
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=m.gmane-mx.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DC6AE4BA2E24
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=116.202.254.214
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1779971624; cv=none;
	b=WLwAonGkG9Vqtb1mzScEf8rVKCVuIsiNIlP5pUIou48FweyzlEaMwYVizyx1qvl8HxAysfmcJfXQLgOZRew116kvgs14uwlHw34Xf+P+I6u4D/oI8cjheZ5gjWSLUfoc8FN6sGzXWQZO6IaJYsI/ZRL301SrU1i4DJunskoJFWU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1779971624; c=relaxed/simple;
	bh=8/4GYjI/KhJLSbciU22gSoay7Cu5gc/LpQO5CCaPIrw=;
	h=To:From:Subject:Date:Message-ID:Mime-Version; b=IjWODNONmLJhuv8v10xAbpILRzxjpbtYxFlYkU2X8BexvmubOCgzzBXm+EN/XLPer1wI45xk7TRY8Zj4IhTpR59U8fXhZCbTeVg1s7NTl+Rswx0pn2ZFitkvhvM6hpi7D1L6RtBop+Ub9MflXP/WVno56SAH0iHhBsmgzwxSOS0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DC6AE4BA2E24
Received: from list by ciao.gmane.io with local (Exim 4.92)
	(envelope-from <gocp-cygwin-patches@m.gmane-mx.org>)
	id 1wSZvi-0006Ij-Ns
	for cygwin-patches@cygwin.com; Thu, 28 May 2026 14:33:42 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: cygwin-patches@cygwin.com
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH] Cygwin: cpuid: add AArch64 build stubs
Date: Thu, 28 May 2026 13:33:34 +0100
Message-ID: <54c93ea8-3e7a-4045-b1d0-2671c8ebef2f@dronecode.org.uk>
References: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla Thunderbird
Cc: cygwin-patches@cygwin.com
Content-Language: en-GB
In-Reply-To: <PN0P287MB0295E7BAEC9FFE804D2A7CDD923C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,HEADER_FROM_DIFFERENT_DOMAINS,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP,URIBL_BLOCKED shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 07/05/2026 11:45, Chandru Kumaresan wrote:
> Hi Corinna,
> 
> This patch adds ARM64 support for CPU information and cache detection used by /proc/cpuinfo and sysconf cache queries.
> Thanks & regards,
> K Chandru
> In-lined patch:
> 
> ---
>   winsup/cygwin/fhandler/proc.cc       | 242 +++++++++++++++++++++++++++
>   winsup/cygwin/local_includes/cpuid.h |  21 ++-
>   winsup/cygwin/sysconf.cc             | 148 ++++++++++++++++
>   3 files changed, 408 insertions(+), 3 deletions(-)

Thanks.

I don't have any substantive comments (apart from "oh, you're supposed 
to grovel over a registry key to get the cpu information, nice :(").

Brian,

I think you're much more familiar with this area of the code than me. 
Please chime in if you have any comments!



