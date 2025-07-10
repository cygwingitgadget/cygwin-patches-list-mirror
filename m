Return-Path: <SRS0=Wh5C=ZX=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 625CE3858CD9
	for <cygwin-patches@cygwin.com>; Thu, 10 Jul 2025 19:44:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 625CE3858CD9
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 625CE3858CD9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752176663; cv=none;
	b=E2KrgNM86xYTxjCj6AfOJtaTALxzkU1wdsu32m7ElAOnQBPLm6EbdiEZnFpampn9srBmwhyX3X0ZsSNou5OP1sWRRSet0bVEkTiVF5LgE/7w9Zmimp+DfZhojnjBM9Hpl/ZsOPkvsYOPOP6PbSH6jWJ7zk2hgQV/xgQpkJ+wyJg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752176663; c=relaxed/simple;
	bh=iSjJOI8wxnN5cIcL1j4XnlGe7TlDBrUrCtlhwc1et7o=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=u/HO1JLrH0YA6WEC/x1CGO+RuW8/KOqyiSIGQc+HsNF72T4b0wvPzjxAIFXSwNYRIo+MNJkwF9z7QAq62g+NEXU20qNAZ4WeJfdRbtbM3qQZAOLhLpYISIT/NkkEkHcJevpOW6KWi9mWl3Ns2XSIT+CpUv8wukZBMi+poc2m19c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 625CE3858CD9
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=RaQs6Ag0
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 1D69145CC3;
	Thu, 10 Jul 2025 15:44:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ZTDHzWsR7yf9tG4ueeH8Npil8pQ=; b=RaQs6
	Ag0YWEAQcO80kL3D3vY1gtgka6cxOCL4q6llfY7YBCzGRLi14ksu2Xvc8c8w/riR
	DgX3DWLdDIO3Y0mx9/569FN7Ps3c3dkNbJZl54RwhCWVX91hWNWxPzhcHf7/d13j
	7RWJ9ePdNMymcNJGa+akPVDIwDGhePUSZWHmdo=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 18A6F45CBF;
	Thu, 10 Jul 2025 15:44:23 -0400 (EDT)
Date: Thu, 10 Jul 2025 12:44:22 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [EXTERNAL] [PATCH] Cygwin: testsuite: link cygload with
 --disable-high-entropy-va
In-Reply-To:  <DB9PR83MB0923C10CF1CE91D0AE67EA7A9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <d23037db-5c5e-a08c-f87a-c93e31ce4912@jdrake.com>
References: <e997b36d-d166-8bee-4eff-fea7ebbdd7fb@jdrake.com>  <DB9PR83MB0923C10CF1CE91D0AE67EA7A9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="12017318494208-963180657-1752176663=:74162"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--12017318494208-963180657-1752176663=:74162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025, Radek Barton wrote:

> Hello.
>
> Does this disable ASLR completely, or `-Wl,--disable-dynamicbase` is
> needed as well? If it would just disable High-entropy VA but not ASLR,
> wouldn't it make the situation worse because there would be higher
> change for address space collision?

It just disables high-entropy VA.  This matches what other mingw utilitie=
s
that load cygwin1.dll do.  I believe that high-entropy VA allows the stac=
k
(and apparently PEB and TEB) to be relocated in a way that could place it
in the way of some fixed-address Cygwin data structures.


>
> Radek
>
> ________________________________________
> From:=C2=A0Cygwin-patches <cygwin-patches-bounces~radek.barton=3Dmicros=
oft.com@cygwin.com> on behalf of Jeremy Drake via Cygwin-patches <cygwin-=
patches@cygwin.com>
> Sent:=C2=A0Wednesday, July 9, 2025 8:47 PM
> To:=C2=A0cygwin-patches@cygwin.com <cygwin-patches@cygwin.com>
> Subject:=C2=A0[EXTERNAL] [PATCH] Cygwin: testsuite: link cygload with -=
-disable-high-entropy-va
> =C2=A0
> This is a mingw program meant to demonstrate loading the Cygwin dll in =
a
> non-Cygwin process, but the Cygwin dll still initializes the cygheap on
> load in that case.=C2=A0 Without --disable-high-entropy-va, Windows may
> occasionally locate the PEB, TEB, and/or stacks in the address space
> that Cygwin tries to reserve for the cygheap, resulting in a failure.
>
> Fixes: 60675f1a7eb2 ("Cygwin: decouple shared mem regions from Cygwin D=
LL")
> Signed-off-by: Jeremy Drake <cygwin@jdrake.com>
> ---
> =C2=A0winsup/testsuite/mingw/Makefile.am | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/winsup/testsuite/mingw/Makefile.am b/winsup/testsuite/ming=
w/Makefile.am
> index 25300a15d9..775d617aef 100644
> --- a/winsup/testsuite/mingw/Makefile.am
> +++ b/winsup/testsuite/mingw/Makefile.am
> @@ -23,7 +23,7 @@ cygrun_SOURCES =3D \
>
> =C2=A0cygload_SOURCES =3D \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ../winsup.api/cygload.=
cc
> -cygload_LDFLAGS=3D-static -Wl,-e,cygloadCRTStartup
> +cygload_LDFLAGS=3D-static -Wl,-e,cygloadCRTStartup -Wl,--disable-high-=
entropy-va
>
> =C2=A0winchild_SOURCES =3D \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ../winsup.api/posix_sp=
awn/winchild.c
> --
> 2.50.1.windows.1
>

--=20
All true wisdom is found on T-shirts.
--12017318494208-963180657-1752176663=:74162--
