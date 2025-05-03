Return-Path: <SRS0=bpPz=XT=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id 2ABDD3858D21
	for <cygwin-patches@cygwin.com>; Sat,  3 May 2025 15:39:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2ABDD3858D21
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2ABDD3858D21
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1746286799; cv=none;
	b=XDUVKENXkjzG29IV+dOzWWsMpu4/bOKpG2kSVOnQ5e/sOVuXpJAlbgIsdnOTAjdWRDrgxgdfy4FD/ULqRGNKUdAhLybnvSSr4C5kXah64oYz0qv2n3QDV6hEdy+Sxb0PlNMii7OLIW9TeHJsrqwlEtzxrIJlbmwVGoVFynvnOYo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1746286799; c=relaxed/simple;
	bh=QuSGgAnJ+fGgEyp8C2t1Bqr3VWVa2G0aCp4sD7+eEbA=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=rIHLAwuG83mP7aM9ypz88HCBJe1Y0ZdEvtla9Fs/ogagAkTOr/iLMgeWhGWP83z3UvBtHso+3QhrdLeSeCNfuDHAGWYNuc0DjTa/Uhhc2xWJA4jDiFtxjcHFABCDfjoCVOIzEjwDVuuLWqd7zBpBhRH8+arNRTtmKSgK+1wO+Gk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2ABDD3858D21
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=gRjeGpCA
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 0186545C8C;
	Sat, 03 May 2025 11:39:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=ofaZWbQWMut/VyjbRO2gDXMaQC8=; b=gRjeG
	pCARLnuZPFX1TA81mvhndAW2yxTc7NmGxONSta3bW8FkcVRt3kYc0Vum7mEKcGa4
	o3yIXRoBWV0b3LfYM/fMeRA2tdVWWztH2bt5R8CRPUMlP5IG/8sxYkyTcOHtYt1/
	i8YbuM0NExPqNTUHBEUKWODlrtfY+5Ov4UhjQc=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id DB92145C8A;
	Sat, 03 May 2025 11:39:58 -0400 (EDT)
Date: Sat, 3 May 2025 08:39:58 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Jon Turney <jon.turney@dronecode.org.uk>
cc: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: docs: flesh out docs for cygwin_conv_path.
In-Reply-To: <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk>
Message-ID: <25dc048f-7e3a-a02c-35e9-29acf19bb68a@jdrake.com>
References: <cb20f137-46cb-eab9-27e9-ca098d1364e5@jdrake.com> <4c633aaa-eb33-42ed-a1e5-f75f58af85be@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Sat, 3 May 2025, Jon Turney wrote:

> On 01/05/2025 20:28, Jeremy Drake via Cygwin-patches wrote:
> > Explicitly specify that `from` and `to` are NUL-terminated strings, that
> > NULL is permitted in `to` when `size` is 0, and that `to` is not
> > written to in the event of an error (unless it was a fault while writing
> > to `to`).
>
> That's great, thanks.
>
> Please apply.

Oops, I missed a close tag that the GHA caught.  I applied this quick fix
without pre-approval, hope that's ok.

    Cygwin: docs: fix missing close tag.

    Signed-off-by: Jeremy Drake <cygwin@jdrake.com>

diff --git a/winsup/doc/path.xml b/winsup/doc/path.xml
index de1b95a37b..9665f6b421 100644
--- a/winsup/doc/path.xml
+++ b/winsup/doc/path.xml
@@ -78,7 +78,7 @@ error and errno is set to one of the below
values.</para>
 <para>In the event of an error, the memory at <parameter>to</parameter>
is
 not modified unless the error is <constant>EFAULT</constant> writing to
 the memory at <parameter>to</parameter>, which may happen if
-<parameter>size</parameter> is incorrectly specified.
+<parameter>size</parameter> is incorrectly specified.</para>

   </refsect1>

