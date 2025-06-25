Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
	by sourceware.org (Postfix) with ESMTPS id 277B93858433
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 01:39:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 277B93858433
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 277B93858433
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b35
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750815567; cv=none;
	b=IxzaCoaLJG26xezXQMPHwXyeaaQZHPPDMomxptOojs2ca252yY2OByXwRpiUzQ02av8iaZwzAC/3FivW42Aq/V7NpQsO39RHvmweYLJbTUYV+HQHgftKJlC0AGAaUuvrnIinS+LvX8JRkJiGYmONnWnDf08/abE1TrEWzC9xriI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750815567; c=relaxed/simple;
	bh=/DuZXdi0Bdnx2vCHNND8J9dwZNTz0S8eezCPBVqevug=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=GmZeblxCJxdzU6p4cQZWg/2QjrGkAhWaj5xNIszPoH+N9rGudDVemSDQuL2KjwsamSlI7eHsWvlUwVw2wbkViD914lEWBDa0Nj7fYMltJ17hYFALxTapaatnWTaB8TDMI/SBiwnOA/58nZmZvfFKssW5tRIqbjun6XCqLxaeYN4=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 277B93858433
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=mL24x3jD
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-e7387d4a336so998722276.2
        for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 18:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750815566; x=1751420366; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4JCNGV82y91KxTNPxXjSohsv3oWCdkYUlY4kaMvnzAM=;
        b=mL24x3jD1ckxckjj0mMq494P1TZu1YGEil29lWFHBOoDO8S30Uv5gpFiyTYN0L5qwq
         AYP/xbht3ybLyqkkgbPQrigY7pb2cBCkW9USA7BvcTPjsK3X9N7265DjZkUCT4jiZ4GP
         aJsVb/ACwV9GY6L6EdNvWYOKS/PjUwwIlCStK/y3VS4ci+gNC05iRsaNMQvVZ2TtwefC
         vwyqqbCg7928rqv5zOh0NUuv9Qn3Iy8AjWJQWqo6EWzUgGTOYTsMgXxhZxBkKlLBuqRw
         iZKa0HVw7FHt0+8RT9g2JdV/0C9YC8/k43bqe5CEUPQBTFZVZHrWnuXMotZYKBmNJq5Y
         s1lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815566; x=1751420366;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4JCNGV82y91KxTNPxXjSohsv3oWCdkYUlY4kaMvnzAM=;
        b=BAh8Hpl4z2/GhWh7o4gpMZtQVi7TgtUfbmmVOGL86NCS+N12ysmuDUcqqITHAZG+WX
         XCnJQebOGzQfhQKV6BBm3vtEp0F/vSbeCe9GaRNpeFVmIPmrznsoWC+xfRUWRVf9f3A1
         7Jn0eh5rmM61eEM41u8rf7f5iuvTRlFO1ov0Ya/j8frLyNF0vYmcN1FJiCbQWV+4Djxe
         c614ltB+7eQRWbKCgVgEYieqhCbse2scWoVNsMavFF5pfD4X/lmfjnQX1FCfufDp0U+L
         X1wMfJveQqXl6JXKK/Jw6RjOi1Npc5DdeHcZUi9ajXjhRRPit86kOwTVIGZwcdoE/jJl
         MBRQ==
X-Gm-Message-State: AOJu0YxABxpw9dFWeOekYdQr0HuZTtatX6HVB/sI24Mo4Kq6lryePuoH
	P9vQ1g+ScOkuLIr057NtKeJEK6sWzplC7clKkVRxtv8/GArnaXprecN9t5bjvA==
X-Gm-Gg: ASbGncul+RcaKs4s9Ud8Sl+GZ+FjJHlm8nVJFX3rHKVFWWmORSec3jPM/brdoNhQ6Pe
	B66vXE6QzkDmJ7F0n8l2cEb6fqe2EIUaWi+0l7yqppK6lxn2v6fngrNIr3F2N8aPLhGMZ1UmZmO
	+byCy8aBKA4rCTo2nQKJXNDCU/SUVkogj+jhbteUeN9QyU/7EnFhk37ERmcP0xI/J8HwzJ9AcN+
	JxtOhnKpUTMf4QcQhcYOo+q7eF4J96YacKpkH+lFFn6KKZJGFKh07Dx3etJUqgj76jYgAQiTFyh
	beuCwvhO0Ne6P4EBzRVLrbqZgGhYlzPBcmuBAwvQ6I39eM3eUMi3z/ScaRbxN0Wpc9QlFEoYpMn
	zs3R7Du1jFnixXMfP94k/uBPToOuN8AJ06neeGqE3Zb7pA/p1GmdGPqC1dFP/dslaB/w+3K4jPG
	zIofQ=
X-Google-Smtp-Source: AGHT+IG5afpT8BGl4rjsfrjsNKez5nBDLREwl3myqO+RUllI/g/4DtA0KhywzR66K+Jni5eYDNvfMQ==
X-Received: by 2002:a05:6902:1505:b0:e84:2cec:1c9e with SMTP id 3f1490d57ef6-e860179375emr1511927276.49.1750815565779;
        Tue, 24 Jun 2025 18:39:25 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb1fadsm3327676276.50.2025.06.24.18.39.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:39:24 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 2/5] cygwin: faq-programming-6.21 ready-made download commands
Date: Tue, 24 Jun 2025 21:39:05 -0400
Message-ID: <20250625013908.628-3-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250625013908.628-1-johnhaugabook@gmail.com>
References: <20250625013908.628-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Running setup-x86_64.exe and performing an individual search for each packa=
ge, and/or toggling View to "Full" and going down the list to select each p=
ackage is a pain in the neck. And running "setup-x86_64.exe -q -P packageNa=
me" is fickle, and fails more often than works. =0D
So by copying and pasting these commands into the terminal setup-x86_64.exe=
 runs a preliminary search, so when they reach the "Select Packages" window=
 these packages will be amongst the search results. Additionally sorting th=
em makes it easier to go down the list, and make sure all packages have bee=
n checked.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 12 ++++++++++++=0D
 1 file changed, 12 insertions(+)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index 4daeb7079..b9269187c 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -710,6 +710,18 @@ packages. Building the documentation can be disabled w=
ith the=0D
 <literal>--disable-doc</literal> option to <literal>configure</literal>.=0D
 </para>=0D
 =0D
+<para>=0D
+Below are ready-made commands to download the required =0D
+packages. When you reach the <emphasis>Select Packages</emphasis> screen, =
=0D
+these packages should be amongst the search results.=0D
+</para>=0D
+<screen>=0D
+$ setup-x86_64.exe -P autoconf,automake,cocom,gcc-g++,git,libtool,make,pat=
ch,perl                           # download build tool packages=0D
+$ setup-x86_64.exe -P gettext-devel,libiconv,libiconv-devel,libiconv2,libz=
std-devel,zlib-devel              # download dumper packages=0D
+$ setup-x86_64.exe -P mingw64-x86_64-gcc-g++,mingw64-x86_64-zlib          =
                                  # download utility packages=0D
+$ setup-x86_64.exe -P dblatex,docbook-utils,docbook-xml45,docbook-xsl,docb=
ook2X,perl-XML-SAX-Expat,xmlto    # download documentation packages=0D
+</screen>=0D
+=0D
 <para>Next, check out the Cygwin sources from the=0D
 <ulink url=3D"https://cygwin.com/git.html">Cygwin GIT source repository</u=
link>).=0D
 This is the <emphasis>preferred method</emphasis> for acquiring the source=
s.=0D
-- =0D
2.49.0.windows.1=0D
=0D
