Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
	by sourceware.org (Postfix) with ESMTPS id 91E663858289
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 01:39:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 91E663858289
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 91E663858289
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2b
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750815570; cv=none;
	b=HX5mRMk3KkBL9TNJnUIDBte+fKvCMrXQn5cmo+CC6glKuTNcOaRhxSm9kd4WeUX+Fx+XgRJgd59hgrC78/RmY4CE7eO8vgTiSiMFkgaN8wMJ102gNgb0g4qvvZKf/qSTIe56oaEG21boyFDJBBXpFbJLTbad5xC2TnKMrN3x7Ao=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750815570; c=relaxed/simple;
	bh=q4Q18/QxL/oG/10dXZTP7FgFLHz+NGewA8OK9SwDTy8=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=UawpvCsqYYsaNB9kZrrk+Y68bCQUBQFoV+/p/Ol9ytnNhP2qluoZ9cRJnpz2uvYb05q5eulAuFgYuXjeLotgoLgL9jvggnaISI0ccTLYc5MYnrATRij2FIrt/yufr80LvM296sPEczvznQQo6pVyySLQsTVB/6ezA3Xqr6ja7TU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 91E663858289
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=iG1tQzsb
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-e7387d4a336so998744276.2
        for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 18:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750815569; x=1751420369; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q4Q18/QxL/oG/10dXZTP7FgFLHz+NGewA8OK9SwDTy8=;
        b=iG1tQzsbxSc4jg57jqo0dXi1q7cdt7/vntZwy8oavWpinpAuyYJlxXKbDdAK2aXWDe
         k5ckq6o4Wg8FsTgNNL4Oh+r4a1v0O2E9dWvv97UEkZz+EpGn/JCoNEweJt1uW7GHIdmK
         Ax0zeBlMTq+ARjD2QbSx9QmNlJRg5gP6dMkutwPSh6M4H6J544HHY6YZXnTD/ynF2zw3
         bLkrpPz6SUQmsuhs3DcISkEh/nopdE0Lk5l0jafnqSHAekhD3LwwmpoyBp5kt3WDpvWF
         vnWk1wKWdzsfrYPbmCzAjVS12zI+6p7p2df/6f+mKHSpfLbEzM7nApAjo6JZaUwqVejY
         CftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815569; x=1751420369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q4Q18/QxL/oG/10dXZTP7FgFLHz+NGewA8OK9SwDTy8=;
        b=H5KkD3wMWVpvRtcXwkzxwjkDJmp6zP0kYCKbq+sC8OT5x2pZci9F7L0XTis1EHaG4U
         eIvPyZZu7jGEFa2XQJTXq4j+t91sjRhhyxMVQAuPqPOCAsRl31w8mOFIlxaimd605szW
         4+kGu3k5u1myVRughg30l19pugQzFRcAzfSiLWQJucTaZ3rygzmVzXsVWofTddo0XIeE
         gjj0ByY18630l42IB1a0H2hcx/B7CMmI/6YSI0ro4ZshGMSEAFGneEsfRHmI8DX9oIzt
         /LdMq1QozsUSUA296jwhZi3KvhFSnwbe6gMF+5Z/pJf9RvwOZERbU68QMt2zyqha6SBI
         Z/pw==
X-Gm-Message-State: AOJu0YzeECfsDi7B+Q778IK1deOHquJ6meZnmofnYKzU+AsjXYKuj14Y
	dlynOjwOYLEF0m3Z0bh7aZ2FMqD67Sj9T8rXDAgvq0xWoowusct8lIEo8pC/mA==
X-Gm-Gg: ASbGncv6AElXfs17+NLYIqWgzTprU91jof5knPSB9Rdj0i5zet65poMSvVtUXD3h0d8
	NT9uhEEvy65kh0dqPpnEginkdBWbVX/XMAmaRyrIC7RaBBp48QW5dEwUpxS9KEL6cuzdSVkkEmV
	sYk5AbO7jRdL2wcQa2hIJb4r12S5Hmgr65qFXJyE86MJeQqHvPkQITD5yW0G7b9HOgHB6dyIisQ
	GGt1CEBC/oUGWqFQOwAM9Qw+y7OFhjgNCwsbCysntVZDyh9ZbUxngU3KMRjaD//Sgh9+HgMyu1Z
	cwGmd3NfVqGLKRWj9ePQKYEnCFovHNopkiNLxUpLy3uKA4foi6mVuDZx/FXtpDzKxM5Nj08Hn3C
	fVYq0XW8QucmJsBhQ5GFUyU0DLcdRyIoThohzxq2kDTVpMrlyMmmTq84YzcKeJS9AY1OQ
X-Google-Smtp-Source: AGHT+IEiuxWtZPtgKlW3uTGsI5T6k1tcnhWR8vJufax5wiyb2CmBXYSl81AngjqVHcnxRNuragbrzg==
X-Received: by 2002:a05:6902:4884:b0:e84:38a0:1067 with SMTP id 3f1490d57ef6-e86016cf885mr1444078276.2.1750815569340;
        Tue, 24 Jun 2025 18:39:29 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb1fadsm3327676276.50.2025.06.24.18.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:39:28 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 5/5] cygwin: faq-programming-6.21 unmatched parenthesis
Date: Tue, 24 Jun 2025 21:39:08 -0400
Message-ID: <20250625013908.628-6-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250625013908.628-1-johnhaugabook@gmail.com>
References: <20250625013908.628-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Fix typo - parenthesis without an opening parenthesis.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 2 +-=0D
 1 file changed, 1 insertion(+), 1 deletion(-)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index 093d05940..2b191784c 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -730,7 +730,7 @@ $ setup-x86_64.exe -P dblatex,docbook-utils,docbook-xml=
45,docbook-xsl,docbook2X,=0D
 </screen>=0D
 =0D
 <para>Next, check out the Cygwin sources from the=0D
-<ulink url=3D"https://cygwin.com/git.html">Cygwin GIT source repository</u=
link>).=0D
+<ulink url=3D"https://cygwin.com/git.html">Cygwin GIT source repository</u=
link>.=0D
 This is the <emphasis>preferred method</emphasis> for acquiring the source=
s.=0D
 Otherwise, if you are trying to duplicate a cygwin release then you should=
=0D
 download the corresponding source package=0D
-- =0D
2.49.0.windows.1=0D
=0D
