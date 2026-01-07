Return-Path: <SRS0=86ZD=7M=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	by sourceware.org (Postfix) with ESMTPS id AB3BB4BA2E07
	for <cygwin-patches@cygwin.com>; Wed,  7 Jan 2026 18:19:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AB3BB4BA2E07
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AB3BB4BA2E07
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.167
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767809971; cv=none;
	b=ITBime6k1XuojdvwvRhc2R8bhMhbqKHUS9bQys0w8geRfnYgSFpg6Sv3pZPYx5KO7TSnB1sRnAd2lanB/AK7H34JZQquJRCSPy8OAfAXGTJ6zIrl157vQLvSrTce3ESj4USK/mPhAbWt7jOgvESGEPMRSujJT3rYqTXLclCEZgM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767809971; c=relaxed/simple;
	bh=5JTWUW4/nquth6EWQckJYvcmLP1Aq1D6lnEbYoBimZk=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=JRZVO1MmJWwkx8GxRv7rjIf5nIRhCECpTMcUIpr4CHCxlrQJ/ABBvYJ25V1mj24q385cCj76YMHvHSBwBdUOmo0hwBfWxvlx/887JVqEhu+d3+BWBN990fhuFTiNck66qMByKiSaGKcUx7t+jeL/pU+b7NbjvOsES1B1ZhstwwM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AB3BB4BA2E07
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=oTdmAVk2
X-KPN-MessageId: 6d83362b-ebf5-11f0-9696-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 6d83362b-ebf5-11f0-9696-005056abbe64;
	Wed, 07 Jan 2026 19:19:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=DUxVI6g1nX1GTS4+no2nYSUaFqHFNch9EpeE6+DKzV0=;
	b=oTdmAVk2JGrtOHmTHxKZnXjzpDt+3WEIUilKW8pexuR72wDXZPWtF7GdH6r06dZIk7uH9LOkn4As8
	 4mNmIDat0n3bPINd1kLLnJzlF1xup/SA7iOFNcNJT7SamSdD406viFA4fWrqoPaXXiqwFUQJZ/pT1I
	 DkdOG2ABDtVPwnLH3lQegchW+/j+lrqGMZOLZHVIeToRtoHJ/IyaqXH0ro6k/wvDzLxqF67vHdlLOx
	 UT0z5ioJgkdgx/P6ed8RDXXd0jRIbwlNcBr6D8/fVLp8uWXZinL+B7t6qeURS2jUmNSf3XV29M5x85
	 cwO+WYCvM3wHelW8p8B57ErJ+zwemQg==
X-KPN-MID: 33|aDgDEdWIHhVraysK3Vy64/2R4qpQf5rGJygihpZ7XPW8KnhSw+NqVQ0gAebD8s0
 1rR3BqK5lDNTorNBOiCYPESXjWy6lBLWJn0BGVRCRBnQ=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|RrpYrY/cjamD4y/BJEHO5TVNhJ1srSI/yAOW9myEDHF95smMGgoSQSoBmSSU6tG
 RMVB7JCZpNl2hBNuJRuxznQ==
X-Originating-IP: 77.173.35.122
Received: from [192.168.178.20] (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 67d0eee6-ebf5-11f0-800f-005056ab7447;
	Wed, 07 Jan 2026 19:19:29 +0100 (CET)
Message-ID: <f9babe9b-6d0b-4a04-a42a-555963c34c0c@xs4all.nl>
Date: Wed, 7 Jan 2026 19:19:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Rename cross_bootstrap to skip_mingw to avoid
 confusion.
To: cygwin-patches@cygwin.com
References: <20260106160517.4785-1-dhr-incognito@xs4all.nl>
 <2a9915c7-6c3c-4115-8d1d-0f8a27779d67@dronecode.org.uk>
Content-Language: en-US
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
In-Reply-To: <2a9915c7-6c3c-4115-8d1d-0f8a27779d67@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/7/26 13:51, Jon Turney wrote:
[snip]
> Thanks for looking into this. And thanks for providing a patch.
> 
> Yes, this is all messed up!
> 
> This all looks fine.
> 
> I think changing the option name is the best approach, as it's just
> completely unclear what it means either way around, and would be
> even more confusing if we suddenly inverted its meaning.
> 
> But how do you feel about reverting to the previous name '--without-
> mingw-progs' (this exactly matches what the logic does now, since
> the extra things that '--with(out?)-cross_bootstrap' was omitting
> have been unconditionally removed in the meantime)?
? The option name was previously: mingw_progs (well, it was: mingw-progs).

Yes, the switch in the help message was: --without-mingw-progs

Omitting?

I guess you refer to the mingw-runtime (was: mingw-crt), a dependency that
has been moved to the compiler ...

Of course, "mingw_progs" can be chosen as the option name ...

BUT ... There is a reason why the macro is named AC_ARG_WITH (and why  it is
not named AC_ARG_WITHOUT)

 - switch --without-FOO results in with_FOO = "no",  No matter the word that
   is substituted for FOO

 - one cannot specify an argument to the --without-FOO switch; it will result
   in an error (abort by configure) if one does

 - the action-if-not-given must be with_FOO = "yes" i.s.o. "no" if the choice
   is for "mingw_progs" as the option name, because "by default" (i.e.  if no
   switch is specified), the process should hunt for the MinGW Toolchain.

As result, the choice for "mingw_progs" will require not testing for "! yes",
but for "! no"; because the value assigned to with_FOO can be different from
either "yes" or "no" (as result of a typo).

    if with_FOO != "no"
    then
      Hunt for mingw # also in case of a typo
    fi

(and that does also apply to AM_CONDITIONAL macro that follows this test)

And personally, I doubt that I have the energy to do the whole process of
fighting against "git" again.

And that is why I prefer "skip_mingw" as the option name ... Sorry.

Note: both winsup/{testsuite,utils}/Makefile.am must be modified as well.

So, go ahead if your choice is for "mingw_progs" :-)

Regards Henri

---
The choice is therefore between:

AC_ARG_WITH([skip_mingw],
  [AS_HELP_STRING([--with-skip-mingw],
    [do not build programs using the MinGW toolchain])],
  [],
  [with_skip_mingw=no])

if test "x$with_skip_mingw" != "xyes"; then
  Hunt for the MinGW Toolchain
fi
AM_CONDITIONAL(SKIP_MINGW, [test "x$with_skip_mingw" != "xyes"])

and ...

AC_ARG_WITH([mingw_progs],
  [AS_HELP_STRING([--without-mingw-progs],
    [do not build programs using the MinGW toolchain])],
  [],
  [with_skip_mingw=yes])

if test "x$with_skip_mingw" != "xno"; then
  Hunt for the MinGW Toolchain
fi
AM_CONDITIONAL(SKIP_MINGW, [test "x$with_skip_mingw" != "xno"])

# --with-FOO      => with_ := yes       Hunt for the MinGW Toolchain.
# --with-FOO=yes  => with_ := yes       Hunt for the MinGW Toolchain.
# --without-FOO   => with_ := no        do NOT hunt for the MinGW Toolchain.
# --with-FOO=no   => with_ := no        do NOT hunt for the MinGW Toolchain.
# --with-FOO=none => with_ := none      Hunt for the MinGW Toolchain.
#                             (none = anything else than yes or no)

=====
