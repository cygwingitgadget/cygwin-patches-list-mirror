Return-Path: <SRS0=eX1P=ZF=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by sourceware.org (Postfix) with ESMTPS id 1CC723A46E55
	for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 08:32:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1CC723A46E55
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1CC723A46E55
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750581157; cv=none;
	b=F4GnJkRjkZdgLzCil5VhOrqEo8TI5zdkBg5lfcOAsDS6guExSQUXIdZtWio/wXDWsLbyy8Y9JR7vM1K5J30MTY7EFAY3VRcMgIvnbH7H6vk4aV6eCOhIk91tRQw/7vNLT1jXcseu+gh6y6k2ppDtIZDHgN/g7r1Xhnf3af/C5mo=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750581157; c=relaxed/simple;
	bh=PWjHaihCX8jdBswts+nDptBtaOwFSqbIvrkmR8rcVkE=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=DMWq4pJsQVZWu+LwyOp6UgfF5INNR3ik55A604DJGbN9jI+2kTrbJZDlkaE1gtvOW6nIrHXUQSshB9hYboqB80QLm6BCZORFSEEs03r8Ptk6+z6LA5q3Nw8wuyPCNA0vN73e/8OtoPZvYAzVbSbx9VVX7MiHwq7NbLYyPa+GbCs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1CC723A46E55
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=dGZLEVkx
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso2659406276.1
        for <cygwin-patches@cygwin.com>; Sun, 22 Jun 2025 01:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750581155; x=1751185955; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TmHRnPE/bP16I6tI/XplBldvC1EuNZZeeoLwxQSLGyE=;
        b=dGZLEVkxmVOPmQjvA8zFQAVa395chEHHLfrDoioEICbb46u5zpBlIM5qxDet/4t3Vr
         NVqrs6q3RcHAJKkuT898UvfR5oNoeYU1y/kpHX54MGQDnLTDxZwKiJGzLdTXTZfOHU6C
         DIluzghjWVBDDiCRUcS+oYy0dzXU46mD/kPMgmJ7Inanxo5KTnYhdCQerZYv/w87QVxA
         Xot8q1M6Punj8Ku1I0LJFM1EsiHto8a4V3ez4ESUy9x/tywlaW0RJxO1GjyudqMj5QiX
         y/vuPiXYO1Z5uqamTIaiMPYQfv8d8C6IKrFNu8wH7BrU3NRsUetjqe59MIqu978V8O1U
         NglA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750581155; x=1751185955;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TmHRnPE/bP16I6tI/XplBldvC1EuNZZeeoLwxQSLGyE=;
        b=UT1mW19l4QVWQO+amlJgflUZhckVC61FmoiqUPd61WfiigtIO+go/L9ntL8cmdBPwJ
         1Uvd9mO1ed0uqtlrAk7YoKcZEitbiEI+p7rKSpyGQQO9/pqTec5j/REov6U3u3G+m8lN
         7qVE5z1clA/HyrqQfUG387LXnQLqnP5IIQXvvlkBt8lF8Z+SpXKj9xzBWfHs5ErW7d7c
         HtH/EiHAUd7hfGyaWQ2zVQzrntlj/4q4/C0ar5avCSrxT/bnIWLYZuvtUgbOMNP9lWJ+
         r6ROO/qCSPvyz9TTbf/3QkY+iIS7YRpweOpKdI5AGXUj2EilBsF6HFrTmGY78+hztsK3
         3ybQ==
X-Gm-Message-State: AOJu0Yz6wtnShclDJ3jU302cSgsfxCfN2Za5qhAr2IGOcRJPe00D0pco
	2xYcYuLYJzAKAPIp0mQnUgiQKC8KDks8X3VIFFVWYENGDU5HZ6P2ou/2FZGoWA==
X-Gm-Gg: ASbGncunRZDH6noISZ+sZNn01axF4PEPhAiPERzvKN5dhwAaam248xG4NMfl3ZffzQj
	2h+OqevTVneZBXdFzCXNAIT1qin3MTuE2lo2WnlqJ+qcHTuTvAIsfNqXQ5AieHEgnLG5e2tohVr
	d8SeFe07WtL5WOapF888hZA/CK8ztlCKv4FvpF7QhGvvSrycICUZk313rCVtvrdcRL5bJa5oxxg
	HZvt7SBKQXvtwnpeICAsyFbghdQsvmneOpEPqKqfp0VuqLtdY3wFinH6T16mNdT5X/k+wU8yxOO
	945ezukk0cxioKIAMjrgk1oqM1K5zPhQ0rRDtt8eavdgZ76gI8IflEi3QmU8UOj9VlMnNLhpKw/
	nAs7EVreORiF+HewOfKCvV3KJRD3gXskTnmiGFLwhZqQiyiDJNE31XkDANuw=
X-Google-Smtp-Source: AGHT+IHXBE50BlZBJoE5zC8IYWdDUMXnDjBrmGyP2qkicc7JdzuG2/1CJi0C75kYr8dRIyZGlZg6Rg==
X-Received: by 2002:a05:6902:1708:b0:e84:36f8:aece with SMTP id 3f1490d57ef6-e8436f8af8cmr9089858276.10.1750581154860;
        Sun, 22 Jun 2025 01:32:34 -0700 (PDT)
Received: from localhost.localdomain (h209.207.88.75.dynamic.ip.windstream.net. [75.88.207.209])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842aab9809sm1774586276.1.2025.06.22.01.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 01:32:33 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: jhauga <johnhaugabook@gmail.com>
Subject: [PATCH 4/4] install.html: bold Tip: in q and a
Date: Sun, 22 Jun 2025 04:32:13 -0400
Message-ID: <20250622083213.1871-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20250622083213.1871-1-johnhaugabook@gmail.com>
References: <20250622083213.1871-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: jhauga <johnhaugabook@gmail.com>

---
 install.html | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/install.html b/install.html
index c5c797f3..4069df2d 100755
--- a/install.html
+++ b/install.html
@@ -57,12 +57,12 @@ A: Run the setup program and select the package you want to add.
 </p>
 
 <p>
-Tip: if you don't want to also upgrade existing packages, select 'Keep' at the
+<b>Tip:</b> if you don't want to also upgrade existing packages, select 'Keep' at the
 top-right of the package chooser page.
 </p>
 
 <p>
-Tip: use the <code>-P</code> option to perform a preliminary package search i.e.
+<b>Tip:</b> use the <code>-P</code> option to perform a preliminary package search i.e.
 <code>setup-x86_64.exe -P <i>packageName</i></code>.
 </p>
 
@@ -81,12 +81,12 @@ Performing an automated installation can be done using the <code>-q</code> and
 </p>
 
 <p>
-Tip: if you have trouble with the <code>-P</code> option, try altering the syntax
+<b>Tip:</b> if you have trouble with the <code>-P</code> option, try altering the syntax
 i.e. <code>-P <i>package1</i> -P <i>package2</i> -P <i>etc</i></code>.
 </p>
 
 <p>
-Tip: you can download <code>setup-x86_64.exe</code> in the <code>/bin</code> directory,
+<b>Tip:</b> you can download <code>setup-x86_64.exe</code> in the <code>/bin</code> directory,
 and use it from the command line to install packages (<i>ensure C:\cygwin64\bin is
 in path</i>). Additionally, you can also change the name of <code>setup-x86_64.exe</code>
 i.e. <code>pkg.exe</code>, and use that to install packages e.g. 
-- 
2.46.0.windows.1

