Return-Path: <SRS0=dDqI=Z4=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id B11E33857C67
	for <cygwin-patches@cygwin.com>; Tue, 15 Jul 2025 19:38:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B11E33857C67
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B11E33857C67
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752608318; cv=none;
	b=Q0x6B34XMP98vt70S5yrzKBo3ahCxXsSl5meMnzledhekdLYodGxYIGBClVu176oN1P8foy+MJYkezXvwWv5gVUdbmJRg/DVdzl9nx+lnkvJcbavzQyq3PEmFfd/YxP1ag6IqFQ9OCooz1wcj7ptb0awsWicYwgnnGfYmdNWjxk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752608318; c=relaxed/simple;
	bh=60GMQ5RL0YkB0IqnWY8/4XkK96n+ucBy+7gRJwFukcI=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=e/p766HjDyrAxq6svoe9OsKOXfTvlr65GcagjDW6R1c0pUlGoEWBHVjWle+4mXkHwXHZtedzxA+ZlzAvUBRpF0iiHR+ULXjBU2xp5dE0SqkXM8hgiNqRo9EbddbEqmgh4xsgKFdhO+kz55QcppMkmprWPKuDE0RGcwpf4OwbDKY=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B11E33857C67
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=ETayPxXS
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 57A8745CC0;
	Tue, 15 Jul 2025 15:38:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=7FSMIxn0PUzq8AGt5sijqe5UPxA=; b=ETayP
	xXSAuwQyAxRSUDlskpRaHn6cna1zJ3Ft2cG5mVZArf1Rcgs8KMjq/GT4MWe//xs1
	SscmO377kPpEqJmFMN7OWrWE8lR1kO6HTUEx07SGg1r1IJ7QRtISojm0y0MjsI0C
	8h7W4d24p3sXPNIv6oqbcgYSRKclqNTKiR4+so=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 3EC3445CBA;
	Tue, 15 Jul 2025 15:38:38 -0400 (EDT)
Date: Tue, 15 Jul 2025 12:38:38 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Radek Barton <radek.barton@microsoft.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH v2] Cygwin: mkimport: port to support AArch64
In-Reply-To: <DB9PR83MB0923D524D8A33D763CBDD0369248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Message-ID: <f9a5570b-728a-14a1-92d4-357a0ca2b062@jdrake.com>
References: <DB9PR83MB0923C4491893524EF694F6829243A@DB9PR83MB0923.EURPRD83.prod.outlook.com> <DB9PR83MB0923D524D8A33D763CBDD0369248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="12017318494208-946804282-1752608318=:74162"
X-Spam-Status: No, score=-9.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--12017318494208-946804282-1752608318=:74162
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Jul 2025, Radek Barton via Cygwin-patches wrote:

> Hello.
>
> Sending the same patch with more detailed commit message.
>
> Radek
> ---
> From e5060aa9afc7346301b7f394515d7a280b3c703d Mon Sep 17 00:00:00 2001
> From: =3D?UTF-8?q?Radek=3D20Barto=3DC5=3D88?=3D <radek.barton@microsoft=
.com>
> Date: Mon, 9 Jun 2025 08:45:27 +0200
> Subject: [PATCH v2] Cygwin: mkimport: port to support AArch64
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> This patch ports winsup/cygwin/scripts/mkimport script to AArch64, name=
ly
> implements relocation to the imp_sym.
>
> Signed-off-by: Radek Barto=C5=88 <radek.barton@microsoft.com>
> ---
>  winsup/cygwin/scripts/mkimport | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/winsup/cygwin/scripts/mkimport b/winsup/cygwin/scripts/mki=
mport
> index 9517c4e9e..0c1bcafbf 100755
> --- a/winsup/cygwin/scripts/mkimport
> +++ b/winsup/cygwin/scripts/mkimport
> @@ -24,6 +24,7 @@ my %import =3D ();
>  my %symfile =3D ();
>
>  my $is_x86_64 =3D ($cpu eq 'x86_64' ? 1 : 0);
> +my $is_aarch64 =3D ($cpu eq 'aarch64' ? 1 : 0);
>  # FIXME? Do other (non-32 bit) arches on Windows still use symbol pref=
ixes?
>  my $sym_prefix =3D '';
>
> @@ -65,6 +66,16 @@ for my $f (keys %text) {
>  	.global	$glob_sym
>  $glob_sym:
>  	jmp	*$imp_sym(%rip)
> +EOF
> +	} elsif ($is_aarch64) {
> +	    print $as_fd <<EOF;
> +	.text
> +	.extern	$imp_sym
> +	.global	$glob_sym
> +$glob_sym:
> +	adr x16, $imp_sym
> +	ldr x16, [x16]

I did a little reading
(https://sourceware.org/binutils/docs/as/AArch64_002dRelocations.html),
and I think this should be

	adrp x16, $imp_sym
	ldr x16, [x16, #:lo12:$imp_sym]

Could you test this?

> +	br x16
>  EOF
>  	} else {
>  	    print $as_fd <<EOF;
> --
> 2.50.1.vfs.0.0
--12017318494208-946804282-1752608318=:74162--
