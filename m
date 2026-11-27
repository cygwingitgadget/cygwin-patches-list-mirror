Return-Path: <SRS0=8Yr5=JQ=aosc.io=arthur2e5@sourceware.org>
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [144.217.248.102])
	by sourceware.org (Postfix) with ESMTPS id 262054307B83
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 262054307B83
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=aosc.io
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=aosc.io
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 262054307B83
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=144.217.248.102
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795784211; cv=none;
	b=vCXhrl8SiQPYxUeJKdQc02INxvwtVyHFN1y7tnRrEUEqcq7SflWvHPkjNp5ej/ktIubLRJmRiDWmjMhtK5lnNHaaDkvfZ68mlXL4dkw7ZUGMRp48mHvpxqQQum5pmenC4pzb3p8PH/UWucc9dtqb2Tid3xJOTNP8VShSqyBQfwA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795784211; c=relaxed/simple;
	bh=+xAAT9F/RlzR247w+Pm6E5rExZ/RZSVTi4J+UBXealw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=EIIIIO17etfqkSNOAVFVXtIahFJUFOCNjKZagPtnB7f0mlRvymRJUrF3aadbuxdmqiO7P0HQDPy1JGwcR5vHvpI1BSWY14Lx6TWtl8rNH9L8Yp8BCKyecK68dcDoTRDZMcwKGnO2CuGieyvcGXnKUYvPEMjklx9u4kUMeTM/K5Q=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=neTjPEwt
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 262054307B83
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=aosc.io header.i=@aosc.io header.a=rsa-sha256 header.s=default header.b=neTjPEwt
Received: from nf2.mymailcheap.com (nf2.mymailcheap.com [54.39.180.165])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id 8675C3EADF
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:50 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.38.223.107])
	by nf2.mymailcheap.com (Postfix) with ESMTPSA id EBAA44007E
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=default;
	t=1795784205; bh=DKfBFay9RQWlH8QoQ3pktlfsMheks0OFGNLYEZt4QvU=;
	h=From:To:Subject:Date:From;
	b=neTjPEwtd5BFUprJbHYVIVlqpJjwxfZ/09xVI7HzjSD4YHRwO/tf7O2359QBYEnOg
	 XD3Erzjdd5+Zr6jGhqfMKVY7r8Ki2dsj0wjvmM8Wd49QYVMlHjiMFf6rNb4+MoB7Ny
	 7nDzCX6FsBbDVVWKymu+UXOJBLRa+/u0ddfnYOKc=
Received: from Arisu (unknown [179.253.246.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 5FAD3E1E6A
	for <cygwin-patches@cygwin.com>; Fri, 27 Nov 2026 12:56:43 +0000 (UTC)
From: Mingye Wang <arthur2e5@aosc.io>
To: cygwin-patches@cygwin.com
Subject: [PATCH v7 0/3] Cygwin: rewrite cmdline parser
Date: Fri, 27 Nov 2026 20:56:36 +0800
Message-ID: <20261127125639.2099-1-arthur2e5@aosc.io>
X-Mailer: git-send-email 2.56.0.windows.4.niugit
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.20 / 10.00];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	R_SPF_ALLOW(-0.10)[+mx];
	R_DKIM_ALLOW(-0.10)[aosc.io:s=default];
	LOCAL_OUTBOUND(0.00)[];
	ASN(0.00)[asn:16276,ipnet:51.38.0.0/16,country:FR];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[aosc.io,quarantine];
	FROM_HAS_DN(0.00)[];
	R_DKIM_ALIGNED(0.00)[strict];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[aosc.io:+];
	PREVIOUSLY_DELIVERED(0.00)[cygwin-patches@cygwin.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]
X-Rspamd-Queue-Id: EBAA44007E
X-Rspamd-Server: nf2.mymailcheap.com
X-Rspamd-Action: no action
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is the seventh version.  The move and the tokenizer extraction are
separate commits now, as asked in the v6 review, so the third patch is
only the rewrite.

Previous submissions:

[PATCH] Cygwin: rewrite cmdline parser
https://cygwin.com/pipermail/cygwin-patches/2020q2/010303.html
[PATCH v2] Cygwin: rewrite cmdline parser
https://cygwin.com/pipermail/cygwin-patches/2020q2/010304.html
[PATCH v4 1/3] Cygwin: rewrite and make public cmdline parser
https://cygwin.com/pipermail/cygwin-patches/2020q3/010559.html
[PATCH v5] Cygwin: rewrite cmdline parser
https://cygwin.com/pipermail/cygwin-patches/2020q4/010772.html
[PATCH v6] Cygwin: rewrite cmdline parser
https://cygwin.com/pipermail/cygwin-patches/2021q2/011367.html

Changes since v6:

* Rebased to current master.  The parser helpers are under
  local_includes now, and globify() uses mbrtowi().
* A trailing run of backslashes at the end of an argument is no longer
  dropped.
* read_file() closes its handle on success and reports read errors
  again.

The v4 export and the winsup.api test are not part of this series.

The quoting, backslash, glob and @file cases pass from a cmd.exe prompt
against the built cygwin1.dll.

AI was used to automate patch-rebasing and testing.  It did not write
any non-trivial new code.  It did find the trailing backslash bug.

I provide all my patches to Cygwin, including this one and all future
ones, under the 2-clause BSD license.

Mingye Wang (3):
  Cygwin: move cmdline parser from dcrt0.cc to winf.cc
  Cygwin: extract command line tokenizer into next_arg
  Cygwin: rewrite cmdline parser

 winsup/cygwin/dcrt0.cc                | 297 +--------------------
 winsup/cygwin/local_includes/winf.h   |   4 +-
 winsup/cygwin/local_includes/winsup.h |   7 +-
 winsup/cygwin/winf.cc                 | 359 +++++++++++++++++++++++++-
 winsup/doc/cygwinenv.xml              |   8 +-
 winsup/doc/faq-api.xml                |   2 +-
 6 files changed, 374 insertions(+), 303 deletions(-)

-- 
2.56.0.windows.4.niugit

