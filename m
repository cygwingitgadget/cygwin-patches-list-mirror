Return-Path: <SRS0=wrpf=JM=gmx.de=Johannes.Schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	by sourceware.org (Postfix) with ESMTPS id 0C8C03858403
	for <cygwin-patches@cygwin.com>; Sat,  3 Feb 2024 14:27:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0C8C03858403
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0C8C03858403
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.15.19
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1706970437; cv=none;
	b=HOPfZcC9/0PzNdyxU0kkzQMYm/CvmA7prs2BZt6kbjhUtuG8RJ5uVhYp9AXJ9irlMVnzAvRL3DvHbwH99S2ISCDc3IlOWo0LuR5NnD/qnxWLJ0z/05oBZZrhxs/HUFQc9Bm4KDn+pCvS31YjQzNI5kI/GeoiF8IGB/CBTNj0tnE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1706970437; c=relaxed/simple;
	bh=Vr3/MRNefIdcm1CnqjBir+JoNbAKEeAcZRz8N+mAXQI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=ID8e/ngr9T4uaHi5LcNlh1J2eUQ7xPX510nCIIMEJ951Dg0z6xdKA9fybWSIEsdYujWQmE2pBoEyodBWjE1Ngjk1gRbJs4FnvK0gRh3WNmPD7ZL54nR2wjYm7eO31tP2jjJzS0bDm0s6BkAWMOINVPRFzVKVpB5Jlb+Ci74qi9E=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706970427; x=1707575227; i=johannes.schindelin@gmx.de;
	bh=Vr3/MRNefIdcm1CnqjBir+JoNbAKEeAcZRz8N+mAXQI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:
	 References;
	b=Vu2kDdz4WJe3gvuzUH/8GBidK//ybswzZqO5oY5ylnXIJnLwISySChUBwq9gv+dt
	 WbaVcV1M2eNkv9TVf+f7+7eYEpEnflpk3O2eDuYG5LFKw32CIrjF9rJaSCcS2FQNN
	 4TKTpT909WBF6ybY6avpAkgCZ2/Nz5rS+tVdACvh2DDkLVMexubBJdhF8lwN7/fo5
	 no1+hAHHa9Yo6CxBTmm6LdtSzQVQGQlQ1pPfzrACvDVIgdNCs/xz/2P+G/sSseBKR
	 f0wDjftp4v1mqDOKOgDeMMVG+0Yk9VceQh8o3pYd0KLGQFO6sze8YxNTneFqv8tqs
	 2HHZgmbpqymmR3MAng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Msq2E-1rCXEx2LIe-00tCBo; Sat, 03
 Feb 2024 15:27:07 +0100
Date: Sat, 3 Feb 2024 15:27:06 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Takashi Yano <takashi.yano@nifty.ne.jp>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Fix exit code for non-cygwin process.
In-Reply-To: <23727ea4-229b-cf13-057d-e9f0e2790b61@gmx.de>
Message-ID: <9d19f0fe-b547-0ec7-146b-fbaf12baa986@gmx.de>
References: <20240202052923.881-1-takashi.yano@nifty.ne.jp> <23727ea4-229b-cf13-057d-e9f0e2790b61@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:RG5BvWsImlHAx68+npx0TTLiQK58DqfDqpPraup4HDqfbiYH3nh
 jD8HPgp81dmzoWsU4Z8bLhsrblcRUupOhEuA1QVB6qsQemydx1rzpMgIsFf50a1Tu3BZBcy
 Y5MocZa1EcI8WEAR6dSMBg0oPbLFVC/EJRMMuZdNGLmTWU+U4LTuqJ2YVeXzZvsZDfyhX35
 KaX+vHzZ28E1mgjIGM21w==
UI-OutboundReport: notjunk:1;M01:P0:VCxwflwk7Q4=;LGTRm0ekg5dJdP7dyjzTdY0KsvX
 GDhXsNmxXc20D1kJKm8W4Y5+M2nwUQjp0bAst1MhybogGIH3KFXM0ghbZzwFP4pP5PWLra1Wt
 IDbwn0zyHcvfopfbQYLUVj45fiCX2r3zrGMxXMM3CYY/WcRRHQ+ZT5Oh0GcYayiikGgqViLwy
 mbBrLd5ZousmOmsUDLJVHahp1j4HLVygydtqzgpACBBzZboB0yGA+VhF0CxL7HhusfPBok1Pp
 wOEPOPupEsA7P0bQL9G//HDQo0R4rYvkyYAOjI4le4PMwzdsyL+9ERlX9yO6wZ3biuWCs9TE0
 WwNfKoTaExvubibyXSe6fRgFm8IqyyR40BILF6MS0Hf9C2Ud/71mYnJ5KBhZ9tuyc7oioH5B6
 cFmhTJAHRVVAStt4ECn7VgC4fyZS0HtcKNiMWnQxkoreJzUQMsfL0Wta0I/NOZj7EdfT64bi9
 sRUhNaSyrnYF9zotaC41FBv9GhRO1IO0NPEYMsemRp0d/nOgXkBMtX/TUj0NHNU5ORXpEjFOB
 GdWDrDHR+vPmiwrDRdDCpyqHAxjUrdGAfJ2BASn5E2m3rgOEs5keqWRsopjMrr7zjK/EDDqvH
 GUQ7+MjVXv2n4ybWZ4YjbguwhUlMcmY5erSV8Cpq/9ijDfYExD5UyRGXK3suTCPAcF5oiELfI
 djWPqUgJBH67+ZydGJWYED/hMxprd7VXcpAdlPiygpN/O3qVNCHHKuTTZf0vn9JqmQceIKPEc
 /YAiccJiXHFvdJxY8RNZs4s5K90/TA088xHl2pHQfDdkHSGjdCm1F3c1EqQOSDqg33+0EDPDF
 FQ4AoQ5AjNbzE2jylUqP8cPp9MQkKhRQH1J1Vuv33aujk=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On Sat, 3 Feb 2024, Johannes Schindelin wrote:

> On Fri, 2 Feb 2024, Takashi Yano wrote:
>
> > If non-cygwin process is executed in console, the exit code is not
> > set correctly. This is because the stub process for non-cygwin app
> > crashes in fhandler_console::set_disable_master_thread() due to NULL
> > pointer dereference. This bug was introduced by the commit:
> > 3721a756b0d8 ("Cygwin: console: Make the console accessible from
> > other terminals."), that the pointer cons is accessed before fixing
> > when it is NULL. This patch fixes the issue.
> >
> > Fixes: 3721a756b0d8 ("Cygwin: console: Make the console accessible fro=
m other terminals.")
> > Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> > Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>
> Thank you for fixing this so swiftly. I still wish the logic was
> drastically simpler to understand so that even mere humans like myself
> would stand a chance to fix such bugs, but I am happy that it is fixed
> now.

On IRC, you reported that the thread would crash if `cons` was not fixed
up. The symptom was that that crash would apparently prevent the exit code
from being read, and it would be left at 0, indicating potentially
incorrectly that the non-Cygwin process succeeded.

I wonder: What would it take to change this logic so that the crash would
be detected (and not be misinterpreted as exit code 0)?

Ciao,
Johannes
