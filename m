Return-Path: <SRS0=J/el=FK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id 1002E4BA2E3C
	for <cygwin-patches@cygwin.com>; Thu, 16 Jul 2026 13:15:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1002E4BA2E3C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1002E4BA2E3C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1784207733; cv=none;
	b=bbQzkqw5epmhZ1pmzPYYLNdpApPbObRMG7CejvVsV/62qeDPfEpv1UyIotCxzUYdoZyTGjDSg1tfhNKsmq5dq/3p6YiF0U+cdEIgWNhadcQfYxTS69A0xyMc3Gz8oU/5CEUxjgOlPDNaVnY0GHAPnsmEBfWOpf8rs9xa0B53MWE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1784207733; c=relaxed/simple;
	bh=Kyb8BXgfvMwaTjD+y5m6TChRKvq1RRfbs5plQoVIpVg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Nsd+6HtX5qpXx5O0hPTOvLSt3VG9s09Xg1QQGhl9XySQpI6X4ckgDaJ/ZKcvz+k9xiT/dLaShHuOd0RaTgwmYCR0kNOUg9mpy+DgGUtNbhoc3lEssdz7YXlClOUhy3JXxWRV0/i7PridcC9rOgilMxbIRkcsPs6Ok7Smn0wsE+Y=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1002E4BA2E3C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FE539D0591C1D8
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEhhdkn3/lN5TRe99046kHawW87cVmNFKOPudOXKs7i0qKAd0obqo11FZoKu27A5+MpnAmTKDTKoZ35BgzDe7bhdPXcNPyXqd+UAJ6VJo0Npf6gYZrkhYq/AKxrNW54Mt/x4IR7BJ2Sr3g0zHn8aUMDcQkd6vvSBzbB/SoqbLA9bCyvqhGAV8rBzAFP66MB1OnQh849TXi8fhS3T7LzsJa24eK7C89lAajwFih8yxoIi9jgPhDFpG9t3gtyy0DL7nFphpyMHif7c3nL2GVHfsPLZMU7Ss5LVqORnnP6964wUbjOvJgozSpHJGKN414xUq1PZmhUyM11bWMF+UOHg8aBr1EqOskqT82v52SjrzuADvXqSYAuvFbWxiFvttppgdNrb5/e6eQXmmG50zkK2FkUE/uEDdUN/RaYt4VLn8ScZPQd9ZumBwENQ/CPSm98d7hNLr8QISa86jSgmQMVP9ly+t/m32H+xyPJYS/Pb1rKiiHUUbljPoUYotQXARu8cclYCceVaP6XdXYX5go2Rh9r8lzEuuYzfxb3zdCfFs74OVxvYbXh69Gn3uHut0bAjdFHFr/nwcpe6U/YvF3H+bI37hPQnMpke4ltusRNd4fQ52uDcNNGz98BksW0MKd1DhHk1W7WiRPD8mikuVGOVjBX/8CRDsF3NUvFFLb1cJLwNA
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FE539D0591C1D8; Thu, 16 Jul 2026 14:15:26 +0100
Message-ID: <2d758661-25c5-4b6b-a449-4b90ba2407fb@dronecode.org.uk>
Date: Thu, 16 Jul 2026 14:15:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: dumper: add Aarch64 support
To: Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
References: <PN3P287MB13206A5CED8DE6D538D83E40F7FE2@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN3P287MB13206A5CED8DE6D538D83E40F7FE2@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/07/2026 11:13, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Everyone,
> This patch adds Aarch64 support to the core dumper utility. Previously, dumper.cc used "elf64-aarch64" as the BFD target name, which is not a valid BFD target vector which caused bfd_openw() to fail with "invalid bfd target" on Aarch64. This has been corrected to "elf64-littleaarch64", matching the aarch64_elf64_le_vec vector registered by BFD.
>   Additionally, bfd_set_arch_mach() was unconditionally called with bfd_arch_i386, which is only correct for the x86_64 build. This is now conditionalized so Aarch64 builds use bfd_arch_aarch64 / bfd_mach_aarch64 instead.

Thanks!

I applied (a slightly modified version of) this patch.

> Thanks and Regards,
> Aswin Kalies
> Inline Patch
> ---
>   winsup/utils/Makefile.am |  2 +-
>   winsup/utils/dumper.cc   | 20 ++++++++++++++------
>   2 files changed, 15 insertions(+), 7 deletions(-)
> 
> diff --git a/winsup/utils/Makefile.am b/winsup/utils/Makefile.am
> index e44079a41..a4521f2ab 100644
> --- a/winsup/utils/Makefile.am
> +++ b/winsup/utils/Makefile.am
> @@ -79,7 +79,7 @@ LDADD = -lnetapi32
>   cygpath_CXXFLAGS = -fno-threadsafe-statics $(AM_CXXFLAGS)
>   cygpath_LDADD = $(LDADD) -luserenv -lntdll
>   dumper_CXXFLAGS = -I$(top_srcdir)/../include $(AM_CXXFLAGS)
> -dumper_LDADD = $(LDADD) -lpsapi -lntdll -lbfd @BFD_LIBS@
> +dumper_LDADD = $(LDADD) -lpsapi -lntdll -lbfd -lsframe @BFD_LIBS@

This should not be needed.

sframe is added to BFD_LIBS if it's present (Yes, this is terrible, but 
it seems to be the best we can do since libbfd doesn't have a pkgconfig 
file).

>   dumper_LDFLAGS = -Wl,--disable-high-entropy-va
>   ldd_LDADD = $(LDADD) -lpsapi -lntdll
>   mount_CXXFLAGS = -DFSTAB_ONLY $(AM_CXXFLAGS)
> diff --git a/winsup/utils/dumper.cc b/winsup/utils/dumper.cc
> index b3151e66d..830cf9ce1 100644
> --- a/winsup/utils/dumper.cc
> +++ b/winsup/utils/dumper.cc
> @@ -703,7 +703,7 @@ dumper::init_core_dump ()
>   #if defined(__x86_64__)
>     const char *target = "elf64-x86-64";
>   #elif defined(__aarch64__)
> -  const char *target = "elf64-aarch64";
> +  const char *target = "elf64-littleaarch64";
>   #else
>   #error unimplemented for this target
>   #endif
> @@ -721,11 +721,19 @@ dumper::init_core_dump ()
>         goto failed;
>       }
> 
> -  if (!bfd_set_arch_mach (core_bfd, bfd_arch_i386, 0 /* = default */))
> -    {
> -      bfd_perror ("setting bfd architecture");
> -      goto failed;
> -    }
> +#if defined(__x86_64__)
> +  if (!bfd_set_arch_mach(core_bfd, bfd_arch_i386, 0 /* = default */))
> +  {
> +   bfd_perror("setting bfd architecture");
> +   goto failed;
> +  }
> +#elif defined(__aarch64__)
> +  if (!bfd_set_arch_mach(core_bfd, bfd_arch_aarch64, bfd_mach_aarch64))
> +  {
> +   bfd_perror("setting bfd architecture");
> +   goto failed;
> +  }

I also added here a:

#else
#error unimplemented for this target

> +#endif
> 
>     return 1;
> 
> -
