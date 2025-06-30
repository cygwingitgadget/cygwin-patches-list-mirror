Return-Path: <SRS0=55nn=ZN=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
	by sourceware.org (Postfix) with ESMTPS id 2C3EE3854A88
	for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 21:32:25 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 2C3EE3854A88
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 2C3EE3854A88
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b30
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751319145; cv=none;
	b=hSaR9Fgrr9MHXOTDs6c7Fa1aBNo9FVSXAB/WwOfH3O1nNpUyh7Dm0od6fC9/dkv4An7j89ytmocT85+w9+6i/eh+MKYv4bAJPrDGKGmRhnhc1zhzb7RENW5tlw9oeArT8YHZ7FCh0GEO6RbPTrO8ZRoLh/3QCnoJ2qNw/ZWq6P8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751319145; c=relaxed/simple;
	bh=dF0vLFSLHAXONzOfOHHyhmlt9EETT4E2il1ipJMpm98=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=tmK8rMFSmLXOn4KnVKe4sUCU9RQG9aDOhNRhrS2kQmwewuZ3y5fBm/5Sbxx6tWKchVveteLM4/7VHVyQTwVImlffkbQmcS0bVpLfZVeJjY1pxKgDecMVPZsBBio1D3XG4CfxdH7l/R6q9jd9TsTpD/WhabmNWEuLkzCIHZRubAs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 2C3EE3854A88
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=ggtjvMXn
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-e731a56e111so2128369276.1
        for <cygwin-patches@cygwin.com>; Mon, 30 Jun 2025 14:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751319144; x=1751923944; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF0vLFSLHAXONzOfOHHyhmlt9EETT4E2il1ipJMpm98=;
        b=ggtjvMXn1Nk7CsbigypQUf4IljJRZfvxvvUPHinTEq6lXfAPRY8YbdZYUVObCf266N
         g7aznzGPLNB7ZOp3ZUOqKZ+jz3cdgYfs9tBvNKFnDDuG/HzqWNyUfaTRCJOln1dv9Jsb
         iv/bkvfpLCCiMZFqPoDHOsUKaIAopbOmrBYg24DEVId335JYc3wN9ZlV12x+Xoe+2CFd
         sz91DFRe4C0PHOJemH1vobCnCerpd+3F9f3hkhAuOz+hNGt7QNzeizwAfb3Qu+RaFAUJ
         55Ql4JfkLhdldcgbuR8q+g5StZHRbcqfATjDqlHgQDt00b2CbWmR0QixBJlFIK2EjR0H
         hkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751319144; x=1751923944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dF0vLFSLHAXONzOfOHHyhmlt9EETT4E2il1ipJMpm98=;
        b=JFR72dHfP9hHVHUoXKJairm7H3/y1hugRcQpKWhT5yPAGepnSn2/LSOKdifDHucAZ1
         PBJoOl96mxqIb2pA7lmFthU2AwkOr6DagqC7d0KzABTynkq89uqTPoFrZiirNjfcN6Q/
         TmmnEyFkYTWyTNZzYGapc1g/2/k+53NgFfzg05JtSB6AQXYp90XY6v9JV3Niikxz8Cn+
         hYoyTSw5kP/RSdBSQ6waAchE6YFzyhydczFhXQZaBtsoacI2Oq3K8KnqTK2AUrAqE86b
         4oIja56zZFEl6rjgwJoPYvc3vI1OCs+nmzQFdaXAJaefZPPvnLQBJmiyLlqflOwQSjSC
         I+ig==
X-Gm-Message-State: AOJu0YyGZxR5GWAISHkV2WROZjWkPvQr4CyzSqQtnS70W19hWqSK33kV
	aKvYFwfXTDWMgV6QCbNP1a571FZpl5F3ywOCn+p4DlRBjOGvF4M6veX6ZznouA==
X-Gm-Gg: ASbGnctwve1bMihyebOi8IhH9nDQxlbb2VUoQjHVDVcjOJ1vZMNraZApb2yNnBQ0cOv
	0hGDONdsyFU1014BKrHwp2CrBrb4gKsp0/LwX79JdhGo9GNXQSW1h6FGJ1VnRRmpfVPUysg1pXO
	y5qhkwSbQZoVRckR4CN+wC+HJWRqA1ZWuFIV3I79Ov5GURrI0Xa4LFi/3E6LuERruCw/9XPK7/d
	i/bGCmDs3PgLZglrGKY7JQLX9nH8BDYNJYkMy6r2cyq8wepMlENVM2iko8D3emO5t43JSvXSw4U
	9bmZUWhZ6k28AwWksLoNMnd+tLOm2skghX9+sPzVhmU8e2YCg+D5QOVlvCF9kjXQiwfEvlURMya
	zAuiNu6aKhX5hdpe24xKcz77BbkkE1dYPIUJzrj0u5bzQCkOeGt1Dgq3k+ntu0pYOcAMEnhZxxV
	1RUZo=
X-Google-Smtp-Source: AGHT+IGh5Np2dwmuDFArawX6ZYS4UcGz6+PsUd8yaideLO1jeYNwg2zsGnpZroDT15JHpTAJW/1dXw==
X-Received: by 2002:a05:690c:318:b0:712:cc11:aed with SMTP id 00721157ae682-715171383e0mr237476977b3.2.1751319144076;
        Mon, 30 Jun 2025 14:32:24 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71515bee26csm17046267b3.17.2025.06.30.14.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:32:23 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH v2 4/4] cygwin: faq-programming-6.21 unmatched parenthesis
Date: Mon, 30 Jun 2025 17:32:05 -0400
Message-ID: <20250630213205.988-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250630213205.988-1-johnhaugabook@gmail.com>
References: <20250630213205.988-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
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
index fa3f097a9..3bc7ac6c9 100644=0D
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
