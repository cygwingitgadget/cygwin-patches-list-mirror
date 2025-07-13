Return-Path: <SRS0=CAkv=Z2=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
	by sourceware.org (Postfix) with ESMTPS id 54FA73858C54
	for <cygwin-patches@cygwin.com>; Sun, 13 Jul 2025 05:29:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 54FA73858C54
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 54FA73858C54
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b29
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752384575; cv=none;
	b=sMJaxFAlSVmXE0VNZTu9qSnUsVOxcoLtNL+1CB9U+AozpLbMzNi7bWmdVh+HJEl0KNAkFmGqwR+aJ6d3WzPIwUtioFiq+SQTkxA6R3GbTGsrWZ5UZdhz+zOVFZ6DUClkxukHVIgeGwF9/hcHiltlk/x6VY70EV6CqVBvkk79oGg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752384575; c=relaxed/simple;
	bh=64gjhINRfszOafs3avYSoxea1+zkmpPGGjdswUa0R80=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=bMLIGbEwmsgtfTiDIi8b4hO7qlO26hm2biLhxUOMZWalOuHp0sa0DrEhBVXYFgU7aa2EZ3nL1EFK5iw3Q/n6I3AbT6SToYbySMkQhKNKAIn8nO1YpMY4IoErfwFcsulV5gHm0N6mXazXnyfGX4J6eOk+THlzZNeM4Eg6swnCwxI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 54FA73858C54
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=RUe3c0Ci
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-e8187601f85so2842809276.2
        for <cygwin-patches@cygwin.com>; Sat, 12 Jul 2025 22:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752384574; x=1752989374; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BfUjtphyrd9s0xkcaqPzWG+WAg5nSW5pyl0VIsx7oW4=;
        b=RUe3c0CiLmvzIW/ed1c5We7p6R6wAABaTnJsL23lFrsColJLYUYDu1WJwhI5UWnQBp
         5FU9GABTo4SaW+GiITV8XBewM+SbxARXNURMXzTXlkv4CvoklZesUStG1Nmk+DV2HM6x
         dEpn3INRj2siFbESaprkEajD4Md0ERyhXKwMRY5DbDW2G4TekaCmBy41qXBkm890lx16
         wy8yFZzdnIr5WG8NR9MkLvlSBGfz0STHtVX1UKqQUadirRAAkBfA8gbA/Ar/Xr03VTv/
         99urcKOVs/w88ibbxliQLGDisKpxeUzmYvhPFE7KEB7W2Jbfs+Pkdnc65jK7byOGJ2DJ
         sE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752384574; x=1752989374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BfUjtphyrd9s0xkcaqPzWG+WAg5nSW5pyl0VIsx7oW4=;
        b=W+jFwPsvRYTrexwUZUCDiiOOrM0siBolrW9lNNCYtYAFbHThzTCb+kVjQJHRtZfLqZ
         pQPgG+pZBMVIpldet+MWPDpPc4ltXTyAf4ACSuKSEn6RTE67Ut3B3MZAbpLl2WHfe5Ym
         SWjysqherfyeDiBPEeI6sJIj1Ioxe2EFe5EpMhEj/iN/2+bMFFu/YI3c3iXju6LNNvd3
         uWlWekU90VNUKGdes63WsnWDVBk5uc5XDZGdoMQ8KuDvETBnF5AACfwtm6CpY0AWeoGR
         D8mU6y5e7JGrHa1/xju1X6IIfmsu0o0Gf/+we35d/u7GTOXuWRqhQ7wIOJSNmVrTHxV/
         N14w==
X-Gm-Message-State: AOJu0Yyt436LKN5kJPV7Qiy6kInJFFuSQitEySE1ZGwUieRmLNO8F6c1
	J9E5+L/RpDk4gHH+T744yYHAPxrt0XjPSAGAAY95n8QV6NVyEQuE9VEQ/3v1mQ==
X-Gm-Gg: ASbGnctOAYg6F4PA/c2tVAa0bhH/wn6BVkKm8I22kB9BJtEiiihSw69V4EPk2bnR3MU
	O6D4J8/MInlewZfS/CGRiXThlmkM2xMPpYpbMWKxXnBk+xm9gkM32P45Rlzi4c43s+7gVfKQkVu
	cbxz7pMflJdj0UVV5F0f8ZokxBTERjx66DMkAPWqzByY+1rBlM54fXNIGiGMLCR3hsNe0CXHrxo
	x0D0AOZ8bDap9FqEHZjxwM8FoLOWTSDPpOBDz6vXPNY0m4TV5ReVhsEPP8TjRS9kAdJqvC5+VdQ
	ZKA+PPp1yA0DfcfcCeL9+nse1748EvtcAAMMbh+yAfFlY+0sWrR86Zu6wfsMOQQsUClEWLAz3Am
	ctf47bGndIqpA0hLLwn9PhY3+a75RRswoOBiy36tWO40HL9gKY22bmEGf+AKzQpc1VL/eYF8EZE
	LRbdQsDjrqEuZzuKpVZAVgGIOvW+Dd
X-Google-Smtp-Source: AGHT+IG4KfHO7ayB1O3oPdyC4sdo+rmiJtdDTW+5h0UWTQUiXCoSsMB0/zBcDEAGKS1pEI3h/pDr1Q==
X-Received: by 2002:a05:6902:2289:b0:e8b:9440:77ce with SMTP id 3f1490d57ef6-e8b94407a2amr5017157276.20.1752384574228;
        Sat, 12 Jul 2025 22:29:34 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8b7aff2a4bsm2169924276.57.2025.07.12.22.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 22:29:33 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 2/4] cygwin: faq-resources-3.4 example httpd.conf
Date: Sun, 13 Jul 2025 01:29:11 -0400
Message-ID: <20250713052913.2011-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250713052913.2011-1-johnhaugabook@gmail.com>
References: <20250713052913.2011-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>

This patch provides an example httpd.conf file, which allows for the virtual 
includes to be rendered. It also overrides the .htacess files, but for the 
purpose of making local edits seems appropriate. I wasn't sure about making 
a note on adding httpd.conf to .gitignore as that may be something that goes 
without saying. 

I made s support repo that illustrates a variation of the 
httpd.conf file, accounting for a Linux Environment. Visit 
https://github.com/jhauga/patch-newlib-cygwin-faq/tree/reproduce-local-site/cygwin-htdocs#readme 
on how to see a working example.

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 winsup/doc/faq-resources.xml | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/winsup/doc/faq-resources.xml b/winsup/doc/faq-resources.xml
index 9b8439b4c..4ef6f70bd 100644
--- a/winsup/doc/faq-resources.xml
+++ b/winsup/doc/faq-resources.xml
@@ -68,5 +68,33 @@ which works well for this purpose, then create and configure the
 use software like <literal>XAMPP</literal> or <literal>AMPPS</literal>,
 and configure the default <filename>httpd.conf</filename> accordingly.
 </para>
+
+<para>Below is an example <filename>httpd.conf</filename>.
+<screen>
+	# httpd.conf (in current folder)
+	ServerRoot "[path_for]/Apache24/bin"
+	Listen 8000
+	ServerName localhost
+	DocumentRoot "[path_for]/cygwin-htdocs"
+	LoadModule rewrite_module "[path_for]/Apache24/modules/mod_rewrite.so"
+	LoadModule alias_module "[path_for]/Apache24/modules/mod_alias.so"
+	LoadModule mime_module "[path_for]/Apache24/modules/mod_mime.so"
+	LoadModule dir_module "[path_for]/Apache24/modules/mod_dir.so"
+	LoadModule include_module "[path_for]/Apache24/modules/mod_include.so"
+	LoadModule authz_core_module "[path_for]/Apache24/modules/mod_authz_core.so"
+	LoadModule log_config_module "[path_for]/Apache24/modules/mod_log_config.so"
+	&lt;Directory "/"&gt;
+		AllowOverride None
+	&lt;/Directory&gt;
+	AddType text/html .html
+	AddOutputFilter INCLUDES .html
+	Options +Includes
+	DirectoryIndex index.html
+	TypesConfig "[path_for]/Apache24/conf/mime.types"
+	PidFile "[path_for]/cygwin-htdocs/httpd.pid"
+	ErrorLog "[path_for]/cygwin-htdocs/error.log"
+	CustomLog "[path_for]/cygwin-htdocs/access.log" common
+</screen>
+</para>
 </answer></qandaentry>
 </qandadiv>
-- 
2.49.0.windows.1

