Return-Path: <SRS0=a/ZA=HC=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo002.btinternet.com (btprdrgo002.btinternet.com [65.20.50.146])
	by sourceware.org (Postfix) with ESMTP id CB9234BB5922
	for <cygwin-patches@cygwin.com>; Thu, 10 Sep 2026 10:51:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CB9234BB5922
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CB9234BB5922
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.146
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789037496; cv=none;
	b=hCQTZ2FwuiMyuQedrVydD4AohDcmObH1nho96gpGfS0cx49FdcliymjUvMfa5RrK+EtnUI0u0nS7SeFoIhupaq59a5eCAtRCk5GBJZRBRy5/d45C6sbZNxYZrM9wfz1fgDd2FxTch+xcOgKF4t/myuHYNRRjw7KGml8dRHbwTfw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789037496; c=relaxed/simple;
	bh=Ulc+xMELmkBXQrQxT9vzdemZliETSISHrXBe0ZAY4n0=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=cojFsqS31Rq+crzaizrneBZJpTi2c9CnFQDGFpIz1O97DB1tI0Ga9NvUrqB3/Jnhf5uzsBdfvykhsQ4PVnifi4Vjfyj8ByBBFFbmYC91G9qKkFB3io486Zt0goYV2rxj+QzfmTEHXS9o9CzDTzsUeT1TPNeABwqtZRqMOzzFt1Q=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CB9234BB5922
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A71593506E29A46
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTFO3RKrLahQu8X18THc9PE3zkcDzOX07+XpacSLmKP3eVN6z1BAY9L+/LdLVcahOey2kebsilgVFB9xkaE8iPoIdqI1iJ2IuYxwwleIbAkbpmRGskpw4lTDhnaW1acIGVm15UwB6IFBThClgPPn22qFSpfM65VgFAGlAwnKqyf344mZD5pSbQd2gogzo6ZTAmlxFMSy483Muz9rNSa7ZEaTC+K/AGONsKhHneMXjgHPtSoEc4ocCc1dGx7JbGze6d5l5fjjvtxcg9/6ttTLRz85LF2Va7WNY+PMfV9n2WdyDtDxo1FsE2yAarFEkBqEIuglYflORZLEKV5QUaJvDkPntFXpVSi1mvDW75tVa9StHHNVR+FxpJ4N1cCom5SN2GGSiSqCawbZKmi7QNCOhpbB6rIks7hs+ChQlEdC5vXi22oERjO3+wc2XVwmV+d518v0KckbsY6R9512PSwE5atllnwKUCmD3eF1Z4RkbBKPg3afGKw8aNvvhmfDTmRR93uN/KfbsoXuSwWWOHFIts91h8B2SgEq0HzmcNpnSk3qGUIye/XYMFwL4RAs7uv4KcOuwUu05m5Oxd2BUInYJ+o1CWVLxpuqKihKcavfcLs8iL3lLLFe/OEJJMUU3iEape3QcqBqjxOAOPkhpcBIMjTxyfSMbEtRZ3QsxrPS/KCQUQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo002.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A71593506E29A46; Thu, 10 Sep 2026 11:51:29 +0100
Message-ID: <1aa82300-aa9d-4860-8dcd-58b8b1a750c9@dronecode.org.uk>
Date: Thu, 10 Sep 2026 11:51:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin 3.6.10 release
References: <c4835768b043a802c4fde5f68323005571c32567.1789021325.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
In-Reply-To: <c4835768b043a802c4fde5f68323005571c32567.1789021325.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/09/2026 07:22, Brian Inglis wrote:
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>   index.html | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/index.html b/index.html
> index 27c6fd68c289..3b81ee0eaae3 100755
> --- a/index.html
> +++ b/index.html
> @@ -45,7 +45,7 @@
>   
>     <p>
>       The most recent version of the Cygwin DLL is
> -    <b><a href="https://sourceware.org/pipermail/cygwin-announce/2026-April/012969.html">3.6.9</a></b>.
> +    <b><a href="https://cygwin.com/pipermail/cygwin-announce/2026-July/013133.html">3.6.10</a></b>.
>     </p>
>     <p>
>       The Cygwin DLL currently works with all recent, commercially released

Oops! Seems like I forgot to update that!

Applied, thanks.

