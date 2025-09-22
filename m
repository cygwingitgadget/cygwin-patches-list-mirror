Return-Path: <SRS0=VCUW=4B=kmaps.co=evgeny@sourceware.org>
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
	by sourceware.org (Postfix) with ESMTPS id 985143858D1E
	for <cygwin-patches@cygwin.com>; Mon, 22 Sep 2025 17:08:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 985143858D1E
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 985143858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d31
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1758560921; cv=none;
	b=DJT9czAsqHu2LDg5nsK9JVF6A//k5RK3iC7oxxbs+D76tNdGK7l4DCXYOoLbit7RAmUlNKTxjX0YY/NusciL4DENVrzm/gYRwtsrXTZ3HCu6YYrC9H3PFN65tVqpbixNLc6S0kUH0O7kdafN4Qku/4n0yi1qqgOYC/hiLRPxDE8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1758560921; c=relaxed/simple;
	bh=5lOPUL5yk1nmh0pg00jrb/XmCUUyDI7VNCOSFIzejz4=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=ccjv0/3V6XivXqWUL4dsCdvcsYJQMDZkc1ZLnPgpjU3rbRu/C0IEn0XJauzsEuq30b0D4qeY9zg353m9Sbrad2jdHTwTfGi1kKD4yk7pHpFNhgIn0gaQspWHl8AeauovmNDLgR92II7aPTtlLlJDt2Vuft2IepZf3xETH8vO8hk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 985143858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=xBdl4Iri
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-88c347db574so147683439f.0
        for <cygwin-patches@cygwin.com>; Mon, 22 Sep 2025 10:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1758560919; x=1759165719; darn=cygwin.com;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQXdAxbjPRFRwYvKggpL4hvGQLsaZgb51DPfT8Loti8=;
        b=xBdl4IriwBF1l4mKesUJT/niMOVpKf+FbaYk2dzgiUdl6ururdfIGjEJTUUuakFtcC
         2OGvV0aH04MzC+gR9rh6CRfvBBLRsnLZR68oabtj+Z2vTm9OTpPhCDYpaTh7m8Owb8Ht
         JXjDKVsoKkNUenOaVhb+SjZewoal7znPyZWxUi+/eJnzPV/xTCHT67x+NrAaeZ8QkqWs
         q7pjRN00l96Gn1qAp0RSI/hgfy6oPW8m776lLIEjpk+GuyQ/L8Ey3oWTTsYjSgThCYn3
         ZjF/d/vSlEKGH480iQ3KjlM+FRdaQpjfhrB2toqILiF5bZqCsI45o2A22Fin6EC/d7bY
         v1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758560919; x=1759165719;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sQXdAxbjPRFRwYvKggpL4hvGQLsaZgb51DPfT8Loti8=;
        b=mEKkJ2AU/oulkvRNnAL1S7i4Jh7TKpQLU8DeQ52fOq/OzuoQcr8JZrUXDpXBXoJAqN
         GOr1lNrR2a12hUj0QuVKxddhxMLzX5Q7t485E5tpyla1dYJMAT0tOZ14Z/1N+M9E8Q0T
         tF+5V7bw2BzwBqJiwJIuV9ugHcdJtOH4EXN6JGnwM7TntHVLi1f+QOiFKGkP6fQJE9dW
         wv8D6yWn8jZvQSFQpO+PF/hOMVZbCEeyHcJzAS7IJWICC3U4PIVgTa2E7BtGy4u4+saS
         6Mk+15MKnCD+alUj8apQ+gF21xe4llp+A6dbYN51p5TqU8KWvmXHlG1u9n/AF50Gy+07
         hJUQ==
X-Gm-Message-State: AOJu0Yxdb10qtshWBmoxOBy7wvA9sIsYHlmUPsObvo16M3p/fqu1Jeuh
	FYHfiJuHlmd92c2dGqoKJSihNWy3buDqSHHaymXjDBp8n3twcoS5UsLcvQCTTkVM4IibI4XzX/b
	+z+S3pmUkS0ssPUpp5K5LUi+OZxWYm5bhQPcVq0wRvwaImTW366qM5HA=
X-Gm-Gg: ASbGncson1Ir+WTrjZImZZA//rwouUqqSp7DJX3TOFeh/+asnORjNYe3anOuwoocNJJ
	mWBIkycVcUhSL7wGCE7EoFfc9CkR5xKw7QNshbTJHEzmULevUNrasJZ95V3aCxABScPartdVzEO
	f+jdN3/4XVHgWCx1tTbOrWIvG9Dj2wpXqZQoj/ulHNqTuG5JCU3TOVY91nSzJVmS6NDMAyoGmc3
	dXWnQ5SNsd/ikAWS/o=
X-Google-Smtp-Source: AGHT+IGewU5/YcFhn9ldWRCxWEg08VEVvTI0RzZ1LNF2mCuxlXflSlsG4HeEWTiZ3rPb2lvMmBefiFrCkB7cONcGDC0=
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:106a:b0:424:824a:79e2 with SMTP id
 e9e14a558f8ab-424824a7b70mr141314765ab.32.1758560919420; Mon, 22 Sep 2025
 10:08:39 -0700 (PDT)
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 12:08:39 -0500
Received: from 1062605505694 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 22 Sep 2025 12:08:39 -0500
From: Evgeny Karpov <evgeny@kmaps.co>
Date: Mon, 22 Sep 2025 12:08:39 -0500
X-Gm-Features: AS18NWCwYzk3g1u6f5sStGlhnZT2i0D85aagto5lNaJIw3uGE6AsQH5kS1G8Xlg
Message-ID: <CABd5JDA8ftx5958KRzqGJH8yhO7bPU23RB5a10XqdJX4VWBgpg@mail.gmail.com>
Subject: [PATCH] Check if gawk is available in gentls_offsets script
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

The patch extends the gentls_offsets script with a validation that
gawk is available. Otherwise, the script does not generate
tlsoffsets and does not fail. The issue appears later during
sigfe.s compilation and it takes longer to understand the RC(root cause).


diff --git a/winsup/cygwin/scripts/gentls_offsets
b/winsup/cygwin/scripts/gentls_offsets
index c375a6106..6a362751d 100755
--- a/winsup/cygwin/scripts/gentls_offsets
+++ b/winsup/cygwin/scripts/gentls_offsets
@@ -6,6 +6,12 @@ tmp_file=/tmp/${output_file}.$$

 trap "rm -f ${tmp_file}" 0 1 2 15

+# Check if gawk is available
+if ! command -v gawk &> /dev/null; then
+    echo "Error: gawk has not been found. Please install gawk." >&2
+    exit 1
+fi
+
 # Preprocess cygtls.h and filter out only the member lines from
 # class _cygtls to generate an input file for the cross compiler
 # to generate the member offsets for tlsoffsets-$(target_cpu).h.
