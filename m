Return-Path: <SRS0=kb3c=7N=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by sourceware.org (Postfix) with ESMTPS id 4439B4BA2E05
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 01:34:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4439B4BA2E05
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4439B4BA2E05
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767836043; cv=none;
	b=jKGLdEpKbfciM8GL+vrHwi7AjnNzf0jahIYS8MUAkmOLQ4gNZtDj5A5Uo3aAl83+ZR5ikbZkjyAm3jmw97REBz+PnNcTQrh4YpoIQolKX1Fj5b/6rLAaNpguOFfOh+M1Ljxj7V9R3Wrn9uNw+S5Gglfxwj8jfBxHs2yVXP22Jhs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767836043; c=relaxed/simple;
	bh=SoLfQzfnOKi9GIGwg52kcqG6oANbATT3lN61TLTsjno=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=TWX55MwN9hLpfvOh1Svt3QcQQrR1OJSaaZyQmMztenqinShS0f5LOaordiNGAANojjWcxGnAf0Kih7JNnGIsozWSWHYiMhdDAH7G7/q+4JeZ1sT+8ebpROG3QbS3kdQjeDNBDlgmiYH6FM1x7wB7pLHDN3hyJsmIpFHWR+UI2RM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4439B4BA2E05
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=TE/EpHNu
X-KPN-MessageId: 22bc4659-ec32-11f0-9696-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.37])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 22bc4659-ec32-11f0-9696-005056abbe64;
	Thu, 08 Jan 2026 02:34:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=f0DVQzFxMSpynFpX/kiw3l6jM2RmvNILGaQbFv3cO/k=;
	b=TE/EpHNuw1oHYbUX12EV7piaEzRVumHeFCuSjqL8ngqkmAF8aPPVp8gHY26vORFMApfr4wZyfyufu
	 BlnhADsHX7pXzwqNO9H3rI3znoNLQjtop1vcFZjSryVH+4xQr+BN850y257YJ+gINZY3TMbJLJRww0
	 gKfDSxNxj3PYRM4ep9FhZ62tTstFNeGIB6vUYbF5insI9bSadJPf8tpbRgfyLskn6+c5FRo3s+0S+m
	 LqMdMswt+ORdfSGNPSxyXy2RIwm2o1Nl0otmzngNzFlVlzFBkZQJOlI/XRCe0DPHSympfc+bTm/g3s
	 IaYgMzuGn+mFwCnnQK+07dburEeiWNA==
X-KPN-MID: 33|kFVncEh05K8i3HTeJUaKiX7ElF4i8GGO3TyctsN05alNx3TI1Ue9V6sCEoX38HC
 VFqvCbWHetC7rP1F8pdQ3+sxLDNRLHUaeEgg2c9aaaSo=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|4f/VR3KjgoPnesjLMJ1uwc1QmynWgxkjIWlsZU9ItEV4E1Mpw5d7qUAHc+m9zaF
 x0Nf1drWCJvvo8Xefgt/Zgw==
X-Originating-IP: 77.173.35.122
Received: from [192.168.178.20] (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 1c472716-ec32-11f0-bda9-005056ab1411;
	Thu, 08 Jan 2026 02:34:01 +0100 (CET)
Message-ID: <c475883d-e186-49c9-b56e-342b737ec41c@xs4all.nl>
Date: Thu, 8 Jan 2026 02:34:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Rename cross_bootstrap to skip_mingw to avoid
 confusion.
To: cygwin-patches@cygwin.com
References: <20260106160517.4785-1-dhr-incognito@xs4all.nl>
 <2a9915c7-6c3c-4115-8d1d-0f8a27779d67@dronecode.org.uk>
 <f9babe9b-6d0b-4a04-a42a-555963c34c0c@xs4all.nl>
Content-Language: en-US
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
In-Reply-To: <f9babe9b-6d0b-4a04-a42a-555963c34c0c@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Right, I changed my mind: mingw_progs as the option name is much
more comprehensible.

Regards Henri

On 1/7/26 19:19, J.H. vd Water via Cygwin-patches wrote:
> On 1/7/26 13:51, Jon Turney wrote:
> [snip]
>> Thanks for looking into this. And thanks for providing a patch.
>>
>> Yes, this is all messed up!
>>
>> This all looks fine.
>>
>> I think changing the option name is the best approach, as it's just
>> completely unclear what it means either way around, and would be
>> even more confusing if we suddenly inverted its meaning.
>>
>> But how do you feel about reverting to the previous name '--without-
>> mingw-progs' (this exactly matches what the logic does now, since
>> the extra things that '--with(out?)-cross_bootstrap' was omitting
>> have been unconditionally removed in the meantime)?
> ? The option name was previously: mingw_progs (well, it was: mingw-progs).
> 
> Yes, the switch in the help message was: --without-mingw-progs
> 
> Omitting?
> 
> I guess you refer to the mingw-runtime (was: mingw-crt), a dependency that
> has been moved to the compiler ...
> 
> Of course, "mingw_progs" can be chosen as the option name ...
> 
> BUT ... There is a reason why the macro is named AC_ARG_WITH (and why  it is
> not named AC_ARG_WITHOUT)
> 
>  - switch --without-FOO results in with_FOO = "no",  No matter the word that
>    is substituted for FOO
> 
>  - one cannot specify an argument to the --without-FOO switch; it will result
>    in an error (abort by configure) if one does
> 
>  - the action-if-not-given must be with_FOO = "yes" i.s.o. "no" if the choice
>    is for "mingw_progs" as the option name, because "by default" (i.e.  if no
>    switch is specified), the process should hunt for the MinGW Toolchain.
> 
> As result, the choice for "mingw_progs" will require not testing for "! yes",
> but for "! no"; because the value assigned to with_FOO can be different from
> either "yes" or "no" (as result of a typo).
> 
>     if with_FOO != "no"
>     then
>       Hunt for mingw # also in case of a typo
>     fi
> 
> (and that does also apply to AM_CONDITIONAL macro that follows this test)
> 
> And personally, I doubt that I have the energy to do the whole process of
> fighting against "git" again.
> 
> And that is why I prefer "skip_mingw" as the option name ... Sorry.
> 
> Note: both winsup/{testsuite,utils}/Makefile.am must be modified as well.
> 
> So, go ahead if your choice is for "mingw_progs" :-)
> 
> Regards Henri
> 
> ---
> The choice is therefore between:
> 
> AC_ARG_WITH([skip_mingw],
>   [AS_HELP_STRING([--with-skip-mingw],
>     [do not build programs using the MinGW toolchain])],
>   [],
>   [with_skip_mingw=no])
> 
> if test "x$with_skip_mingw" != "xyes"; then
>   Hunt for the MinGW Toolchain
> fi
> AM_CONDITIONAL(SKIP_MINGW, [test "x$with_skip_mingw" != "xyes"])
> 
> and ...
> 
> AC_ARG_WITH([mingw_progs],
>   [AS_HELP_STRING([--without-mingw-progs],
>     [do not build programs using the MinGW toolchain])],
>   [],
>   [with_skip_mingw=yes])
> 
> if test "x$with_skip_mingw" != "xno"; then
>   Hunt for the MinGW Toolchain
> fi
> AM_CONDITIONAL(SKIP_MINGW, [test "x$with_skip_mingw" != "xno"])
> 
> # --with-FOO      => with_ := yes       Hunt for the MinGW Toolchain.
> # --with-FOO=yes  => with_ := yes       Hunt for the MinGW Toolchain.
> # --without-FOO   => with_ := no        do NOT hunt for the MinGW Toolchain.
> # --with-FOO=no   => with_ := no        do NOT hunt for the MinGW Toolchain.
> # --with-FOO=none => with_ := none      Hunt for the MinGW Toolchain.
> #                             (none = anything else than yes or no)
> 
> =====

