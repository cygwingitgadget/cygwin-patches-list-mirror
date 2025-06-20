Return-Path: <SRS0=YuU3=ZD=gmail.com=sebastian.n.feld@sourceware.org>
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by sourceware.org (Postfix) with ESMTPS id 4A83D388D792;
	Fri, 20 Jun 2025 11:25:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4A83D388D792
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4A83D388D792
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2a00:1450:4864:20::536
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750418725; cv=none;
	b=Qszboy8qLW0dlyUh6W94JEsYMUf9VRbyeGvbtpawGr2VpzSn0+tE5RtHJVK1I/52VWPFjtCvXsUvXplSSir3Jssve6DTVojURrNFVAmBkzyXQlPQ9nPr1Ot9a8QeKGnzlkdQ6DiBUnb3i+AEaLcPGcJMOh53bVQIUuwsFhXeQGQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750418725; c=relaxed/simple;
	bh=L+QWpOngZko+y+2Fv2gowNgD4eH4R/ufgB/557CWMbU=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=MCbTYXKDPL8dtonGoOgsiRrejjVXfuc16CqSm7DS2sEvW1FuwUx5fJFPwccWGRstko2Zxh+rw2WaBKPkk7dtHmq3pSKxRT4Vi0VpULWZd3RywUtVwyfgZSx6UMSiOaz2uWAQjM13azz5bvs/yp/FzfaHaI5ZOTUOxt+K83EUZ0c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4A83D388D792
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=keCuwsKp
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo3248685a12.3;
        Fri, 20 Jun 2025 04:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750418723; x=1751023523; darn=cygwin.com;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wwyTrIYdIqxp4WM1oYZlPGC7HdkErDVmEFPFYa4FUII=;
        b=keCuwsKpfCnJ5+y5BLfU2y8Q6KIlynofNcPDqzaKyhWd/T2/ecEwH0Lkk/fv8facal
         /77HeC8Q6FPkaw1HdxNLth0oE7Dm4kAa3WTE6KKbexjGMN11WaFYF7V/pYLSgt9ROcEh
         yVrqi3uHDwyExuzkjva1q4Y5Dx5yuWekRkrRgdtq4nI2dcJzPZZegFwPd66SvqQPwgOy
         gRDWa4WZPvC3qypD9gl1rZpErC36/nCTU+2CAHMDXtXJX4dK8fMTk7F98A8DXFC0up0W
         y2Br6A4rOYiT9ZYNwx6vp7+VVHKlIx+tvlghD97VQyhidGHXhDeaNDblZXbJjhDS4wiq
         UOrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750418723; x=1751023523;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wwyTrIYdIqxp4WM1oYZlPGC7HdkErDVmEFPFYa4FUII=;
        b=LEqP0xqRdu9XaS4oAK3aBLAVRFtqUDZNvAP1CeWb1WIOIM/UrD8UySXEAxU339Fajl
         G07LajCxgmuAOHGx6gCLvejQW1w5N02MqIrLm4U9Uf3T9IGnS3p7znto1xxQaqbPqcFC
         tbGpg4XTdOKH3dJivGcakyvI0YgL8ZitTzRrulvP3e7FuZEcWwWd3HMxtIPAPzyIzzub
         a6j/xg85aeeMmtgfvCVBQ4Mjtas/kCnYGUrwJFqndz9CBosoBzdQj1cfZFtqsVl93+GE
         iBzymXRs+H/REp+8YeX6gjJpwRdMDNknP8m7d4nKzi3N6ubNsZ4u74sPhOLcUsHQ0uF6
         uvbg==
X-Forwarded-Encrypted: i=1; AJvYcCUSFySjILDKGtnZyYqV+9VP/bj2yS6OjhTeSxohW8rPwLu5tzzPL8h+mtfaGzxiJmIE5jpJCnc=@cygwin.com
X-Gm-Message-State: AOJu0YxU/3fDkKSTZkB5W/cSxJszUvQHhZndA+GyKHlHnLsuYDjpnE1N
	DitwZxZ37cI6m6P+S2L1NG4URGKsfrmUX7W+qTXhHwUn6OitHKMeAuvW9qwbQuwi0o2R5IJCY7A
	pyLe2h9hMXP8gv4o5kWyltWexDeL2YSwy1w==
X-Gm-Gg: ASbGnctr8tKr6Pitawk719uUgimjsxZkNYesMlHyHxVQ0GGI73gH6LbFDEupYIJXTaW
	3zyw9wqF7dkT73La38xlS+Tadg1hFjZtVIo2wVj1BMeq3efF8Cmainb5U6NEzfZZC6j+RTQIE8d
	buNkMSdGvyL1vTHqafPrII6AN1EYVwGY/95NG9LY3pB7g=
X-Google-Smtp-Source: AGHT+IFQAFJbvww5qoivKtCfJ0fC/k/v1VUYXP7TfdpVHGa3E9uBZmTw9b1c/fZ1qhPxnihSkiaRpdHvcE+yKpPI05w=
X-Received: by 2002:a05:6402:50ca:b0:602:c6a3:3f6 with SMTP id
 4fb4d7f45d1cf-60a1cd2fee1mr2337966a12.13.1750418723276; Fri, 20 Jun 2025
 04:25:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAHnbEG+-vkWb3F9HJFNdtMt1wAtm90kz81p8H=0Y7QrGHn50ag@mail.gmail.com>
 <aFFOZ0-JHbJKs1Fc@calimero.vinschen.de>
In-Reply-To: <aFFOZ0-JHbJKs1Fc@calimero.vinschen.de>
From: Sebastian Feld <sebastian.n.feld@gmail.com>
Date: Fri, 20 Jun 2025 13:24:45 +0200
X-Gm-Features: AX0GCFtsr_JfK5ICf8bnnFQKd-T0eJzXa7M6VKXzqWUy3okR-1I_mplkTLURuOw
Message-ID: <CAHnbEGJCqd3cdB-Ky4-PbWzw=PSO7u7WKoL_t0boQotCGK5SfQ@mail.gmail.com>
Subject: Re: [PATCH][API-CONFORMAANCE] Increase SYMLOOP_MAX to 63
To: cygwin-patches@cygwin.com, cygwin@cygwin.com
Content-Type: multipart/mixed; boundary="00000000000035cb9e0637ff1e70"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,KAM_NUMSUBJECT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--00000000000035cb9e0637ff1e70
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 17, 2025 at 1:16=E2=80=AFPM Corinna Vinschen
<corinna-cygwin@cygwin.com> wrote:
>
> Hi Sebastian,
>
> On Jun 17 09:48, Sebastian Feld wrote:
> > The following patch increases from 10 to 63, per Windows spec
> > https://learn.microsoft.com/en-us/windows/win32/fileio/reparse-points
> >
> > Security impact is minor, SYMLOOP_MAX is just an artificial limiter to
> > prevent endless loops.
>
> In case of Cygwin (Cygwin is slow, we all know that), the rather low
> SYMLOOP_MAX was chosen so the path handling didn't get even slower in
> some circumstances I don't remember anymore.  Maybe the times when this
> was relevant are over, so we can try this.

1. Cygwin is NOT slow. Who says that?
2. If there is a performance impact, then this should be documented in
the source code.

> However, please send a real git patch created with `git format-patch'
> and don't forget your Signed-off-by:".

Patch attached.

Are there CI or regression test scripts where I could add a test module?

Sebi
--=20
Sebastian Feld - IT security consultant

--00000000000035cb9e0637ff1e70
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-Increase-SYMLOOP_MAX-limit-to-63-per-Win32-spec.patch.txt"
Content-Disposition: attachment; 
	filename="0001-Increase-SYMLOOP_MAX-limit-to-63-per-Win32-spec.patch.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mc4q0s2t0>
X-Attachment-Id: f_mc4q0s2t0

RnJvbSBmN2ZjZWU4NWE2MDAxYTQyNTY5OTU0YTVjYzBmYWY5Y2JlZDdlZTA0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWJhc3RpYW4gRmVsZCA8c2ViYXN0aWFuLm4uZmVsZEBnbWFp
bC5jb20+CkRhdGU6IEZyaSwgMjAgSnVuIDIwMjUgMTM6MTk6MjMgKzAyMDAKU3ViamVjdDogW1BB
VENIXSBJbmNyZWFzZSBTWU1MT09QX01BWCBsaW1pdCB0byA2MyBwZXIgV2luMzIgc3BlYwoKSW5j
cmVhc2UgU1lNTE9PUF9NQVggbGltaXQgdG8gNjMgcGVyIFdpbjMyIHNwZWMuCgpUaGUgc3BlYyBh
dCBodHRwczovL2xlYXJuLm1pY3Jvc29mdC5jb20vZW4tdXMvd2luZG93cy93aW4zMi9maWxlaW8v
cmVwYXJzZS1wb2ludHMKc2F5czoKLi4uIFRoZXJlIGlzIGEgbGltaXQgb2YgNjMgcmVwYXJzZSBw
b2ludHMgb24gYW55IGdpdmVuIHBhdGguCk5PVEU6IFRoZSBsaW1pdCBjYW4gYmUgcmVkdWNlZCBk
ZXBlbmRpbmcgb24gdGhlIGxlbmd0aCBvZiB0aGUKcmVwYXJzZSBwb2ludC4gRm9yIGV4YW1wbGUs
IGlmIHlvdXIgcmVwYXJzZSBwb2ludCB0YXJnZXRzIGEgZnVsbHkKcXVhbGlmaWVkIHBhdGgsIHRo
ZSBsaW1pdCBiZWNvbWVzIDMxLiAqLwoKU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIEZlbGQgPHNl
YmFzdGlhbi5uLmZlbGRAZ21haWwuY29tPgotLS0KIHdpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3
aW4vbGltaXRzLmggfCA4ICsrKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dp
bi9saW1pdHMuaCBiL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9jeWd3aW4vbGltaXRzLmgKaW5kZXgg
MjA0MTU0ZGE5Li43MjhkZmQ0N2IgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9j
eWd3aW4vbGltaXRzLmgKKysrIGIvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2N5Z3dpbi9saW1pdHMu
aApAQCAtNDMsNyArNDMsMTMgQEAgZGV0YWlscy4gKi8KICNkZWZpbmUgX19TRU1fVkFMVUVfTUFY
IDExNDc0ODM2NDgKICNkZWZpbmUgX19TSUdRVUVVRV9NQVggMTAyNAogI2RlZmluZSBfX1NUUkVB
TV9NQVggMjAKLSNkZWZpbmUgX19TWU1MT09QX01BWCAxMAorLyogX19TWU1MT09QX01BWAorICAg
aHR0cHM6Ly9sZWFybi5taWNyb3NvZnQuY29tL2VuLXVzL3dpbmRvd3Mvd2luMzIvZmlsZWlvL3Jl
cGFyc2UtcG9pbnRzCisgICAuLi4gVGhlcmUgaXMgYSBsaW1pdCBvZiA2MyByZXBhcnNlIHBvaW50
cyBvbiBhbnkgZ2l2ZW4gcGF0aC4KKyAgIE5PVEU6IFRoZSBsaW1pdCBjYW4gYmUgcmVkdWNlZCBk
ZXBlbmRpbmcgb24gdGhlIGxlbmd0aCBvZiB0aGUKKyAgIHJlcGFyc2UgcG9pbnQuIEZvciBleGFt
cGxlLCBpZiB5b3VyIHJlcGFyc2UgcG9pbnQgdGFyZ2V0cyBhIGZ1bGx5CisgICBxdWFsaWZpZWQg
cGF0aCwgdGhlIGxpbWl0IGJlY29tZXMgMzEuICovCisjZGVmaW5lIF9fU1lNTE9PUF9NQVggNjMK
ICNkZWZpbmUgX19USU1FUl9NQVggMzIKICNkZWZpbmUgX19UVFlfTkFNRV9NQVggMzIKICNkZWZp
bmUgX19GSUxFU0laRUJJVFMgNjQKLS0gCjIuMzAuMgoK
--00000000000035cb9e0637ff1e70--
