Return-Path: <SRS0=Lpkk=IF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 25D354BA2E15
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:28:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 25D354BA2E15
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 25D354BA2E15
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792049290; cv=none;
	b=eZvDAZ4Oie1D9rHryztYA/+B8dSF0J7j//n+NLXSgSQE6gNl82T6ACmCrbtZcjH4mCLCpeMYbyg6xY/QJNTLHBQ3bvwIAzofOwKOgPbkxns9RI2Gce9XmRQ7wPGeMh8uXDsXhxs0BSp2RgyPMSNPaGK1Q8hJULe+aIZ7q5iB/eQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792049290; c=relaxed/simple;
	bh=id2A8HSfmG0Vu9MQ7L1+XfOBVR2r2RzQzLCp85RUizs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Pf9Dn5d2pYxf/kSE4pA9Sl6DJS6SuztEVYwG9lf/G/vY4LfomEKMf0dm2+6otb/8TdlXMaMGYyte9s60mI/is1zaLRKKhxkk3YBNM4r3ll3vgfUt1KRijwemzW1Z4vaHyaGInYE43rMn6ioI4JmpC3Xjkj2DbU3Fag221CuIAnQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 25D354BA2E15
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69F7fcjo026217
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:41:38 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdVrdbHJ; Thu Oct 15 00:41:38 2026
Message-ID: <de0e2b76-f893-4b96-bc16-112131074cc8@maxrnd.com>
Date: Thu, 15 Oct 2026 00:28:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: API winsup/doc/posix.xml: update ISO to final
 9945:2026 Edition 2 2026-03-18
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <00d6c451303b15168f7ec6801c5435f8708cdd34.1791913465.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <00d6c451303b15168f7ec6801c5435f8708cdd34.1791913465.git.Brian.Inglis@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Brian,

On 10/13/2026 10:49 AM, Brian Inglis wrote:
> Signed-off-by: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
> ---
>   winsup/doc/posix.xml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/winsup/doc/posix.xml b/winsup/doc/posix.xml
> index cec7ee38a533..f789e6baffaf 100644
> --- a/winsup/doc/posix.xml
> +++ b/winsup/doc/posix.xml
> @@ -11,9 +11,9 @@
>   POSIX®.1-2024 also simultaneously IEEE Std 1003.1™-2024 Edition,
>   The ®Open Group Base Specifications Issue 8
>   (see https://pubs.opengroup.org/onlinepubs/9799919799/), and
> -ISO®/IEC DIS 9945 Information technology
> -- Portable Operating System Interface (POSIX®) base specifications
> -- Issue 8.</para>
> +ISO/IEC/IEEE 9945:2026 Information technology
> +- Portable Operating System Interface (POSIX™) Base Specifications,
> +Issue 8 (Edition 2, 2026) published 2026-03-18.</para>
>   
>   <screen>
>       CMPLX

The patch LGTM.  Please apply, or I can do that if you wish.
Thanks,

..mark
