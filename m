Return-Path: <SRS0=uTC2=ID=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.244])
	by sourceware.org (Postfix) with ESMTP id 3FC7B4BA23D3
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 13:06:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3FC7B4BA23D3
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3FC7B4BA23D3
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.244
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791896799; cv=none;
	b=AJ3vJgtwp9XcqIqDxuv+s6CvpBDez/5WcAZbCBTXUkIUQvol3ArS8SIF8PirtcmC1eaZiTSKI0GfIfra2FAb5Q+17wkcnl7pufshOYbcs+pS1lmqWkqflDg6opikXoDOvp19NBuX9yIAUxNxj3Sw/GRRZ4eFLr8z19KYSG6xypU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791896799; c=relaxed/simple;
	bh=lYqx/tU5199ZYwoiQKqN4YgoGx8CCHDWylBsCoSOcMQ=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=kFoP03p5MBdKoecOLQEJE8ueqyLHEmwlZXe3uAzhh5VTRMZSde2oUDwZIpLuVLQ2VYkiyIdQejxlC6ydoBMhHAQitwqT/8+wY26/2jzXFgqV+c5lHN6iaIRSg7L417Hc0f//4O0gYzH/tW99ZBSHAbx8uFLCnP2GW06CEb+J89g=
ARC-Authentication-Results: i=1; sourceware.org
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A989FAD085B308D
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=79/300, class=clean
X-RazorGate-Vade: dmFkZTF1XlttF1Qm4XQ6e/dOyQsps33QX1HYJsPAv7b9kNtDtGMTtsv0pAb/GYPhy9CUFLyliyjfqBNnVe9y77XFVmFZjaRxnF8NuUVNJGIRys9MzC4FQIQmZwI3b+X2h6ZMAuGcCArfdi0afPNvUbHFUncB4KPKaQZWabTZOGxU+ZtASmA7M1uaSbCWalAyhppWgGy3ORMKSv8vXuvJC1Vznh8dsVlC9l3elkDNiTthnav6ir0urOOwiUa6XyNbtmfltiNGZbByAf6B8B1B9uw2IpEaRCVlHhgFyK1VF2gfxmQuGbNlPCSL6UkaLaUTJKVV1cTDioqENtLyIWGpXVzE7jA0LbRviLKRrpn6hOSuYg5Jr5hy2eACX+lZkB9f9sT3KS6D5MmlTnK8UuR08Q5FSs5yxhQ3eHKqFb9tLli/UIIlh9OElWCL4VTW86q4cG6xQ0Sal72vKJqUBbJTxD5sE707OnM/3XBidaYHN6V+LykCTYLPxcfRaJkB2jLgBoXaRsB2z/dW/8HUqjh0lhEdMiqspubgLlvKJfUcif5bROjn0IPnHuc5R7XPqT54bhIXq50mt9YeDQsATpC7kFrFZutpGMdmcoNPf+rRlYPGKtjITogoHdl0L41MH5bh0fhRs3jzjgtg0g/ulNuOXdYrHeCeGHxPXVMQe2Z5PcVj0doykg
X-RazorGate-Vade-Verdict: clean 79
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A989FAD085B308D for cygwin-patches@cygwin.com; Tue, 13 Oct 2026 14:06:29 +0100
Message-ID: <e7e33944-9c71-46e3-b311-e4596afbaa82@dronecode.org.uk>
Date: Tue, 13 Oct 2026 14:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cygwin-htdocs/packaging-hint-files.html: update SPDX spec
 to 3.0.1
References: <0de3fd2021ffe58cc5657c1ebb5aaa1decd89ae0.1791229333.git.Brian.Inglis@SystematicSW.ab.ca>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <0de3fd2021ffe58cc5657c1ebb5aaa1decd89ae0.1791229333.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,KAM_SHORT,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 05/10/2026 20:42, Brian Inglis wrote:
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>   packaging-hint-files.html | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/packaging-hint-files.html b/packaging-hint-files.html
> index 291f9ddc6244..c5108fbd5906 100755
> --- a/packaging-hint-files.html
> +++ b/packaging-hint-files.html
> @@ -418,10 +418,11 @@ version: <i>version-identifier</i>
>   
>     <li>
>       <p>
> -      <code>license</code> is
> -      an <a href="https://spdx.github.io/spdx-spec/v2.3/SPDX-license-expressions/">SPDX
> -      license expression</a> for the <a href="https://spdx.org/licenses/">open
> -      source license(s)</a> of the package source code.
> +      <code>license</code> is an
> +      <a href="https://spdx.github.io/spdx-spec/v3.0.1/annexes/spdx-license-expressions/">
> +	  SPDX license expression</a> for the
> +      <a href="https://spdx.org/licenses/">open source license(s)</a>
> +      of the package source code.
>       </p>
>     </li>
>   

Applied. Thanks!
