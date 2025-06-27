Return-Path: <SRS0=dcB5=ZK=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by sourceware.org (Postfix) with ESMTPS id 626C1385C6C2
	for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 21:45:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 626C1385C6C2
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 626C1385C6C2
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b31
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1751060759; cv=none;
	b=cRdbJGIZb+QK7P3smwHuaXxMjAt9uSuldzz7Tpi9cJ1BA5e7VPMA6mjnlfnKIUvmsHqbqUkmVyomkiSQjBQNt7muKcOhpDsqy4/erWGZ8eJY3veJ5JahWTtR5YG1Zy+2oZ6hah8Ykb/+sKE4/up4ZskBrxUiUPUdHkx9Ynwjx58=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1751060759; c=relaxed/simple;
	bh=pwo1Y4LfK5MhUSB++kkTJn+x2kjTNKTBk8d750jgQqw=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=QIuq8lhsVn0uz2EKM3U30hV4jJctFn0wWAud72Ik8zGL4gx7ywhJ0siI+stQBweUmB9KboFRuKNCN9WHojJALKnLL5w/bSsfzu1DHxmwmOET3veYlTpV+LohsbFDNePSVP93MzphE1a2Mz+EWO/t02tPabBjJmKOmnNynz5wo/Y=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 626C1385C6C2
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=evAV5z9+
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-e8259b783f6so284244276.3
        for <cygwin-patches@cygwin.com>; Fri, 27 Jun 2025 14:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751060758; x=1751665558; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k/sURzasJQSC++AWxK8CqLlYGtHox9LwWvb4yGB355Q=;
        b=evAV5z9+Thu66lLoGB/A8B4oc9Com/2AZEOavQ4lSbm4BR41mTX8etNFWUqaCbhM3M
         vGjMEzTWowVZw7wPFv4khYEgzTEwKZB8VVkAYSRIsjx0nOYy/lwFK1wss0KWrm54LZl8
         yhpS9qRMab04FtH3fW2Xmnbkm+iWxwsFOAMvObmb0S+LjyoeqHHngim6+jPtK6fs5NuD
         8HcrjY8xJN+QpIom274pMQdJQG46tkXqwb5chrrtEL5viMEz7OlPkubDvd77H2FZJc4k
         RU4SzOLo5wK9CH+rFDyBHin8HlOPhE0o2aXD9yvhJejXXRKAUBWss1Mi6ORUydDrLV4Q
         Krsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751060758; x=1751665558;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k/sURzasJQSC++AWxK8CqLlYGtHox9LwWvb4yGB355Q=;
        b=J/hw2wNyBWz3MSqbb0SLPZUqVzpY3QfG/7AuD8TkxEn7wl0CMCyg6ifq0M88G/Eh2R
         081/1cNeO7sNp+SCSh+z1Ncs/UASiyhfhE0fPcDSA2PRm+3mv0V8wwKBrrbr3nKR/SJd
         1/Ulfi2YairQZvbr4TbnuO/uEsoW7aWIQ6CYkBiElRNLTWLm2EL9hA7XNf4AHmxKllLC
         kBJFLVajP3UKlM0AFDqaD6B+gov2ABixhymDhvMj+Bs/lM7Be9rWN4BaNn4VEVTu1ZHD
         S6YMXZWRAek70GhC/u1hgsCSLzqeNHj0WcoLe88PM5zyBpZzMblAYcTLC2rEuB0LMIUl
         HFYQ==
X-Gm-Message-State: AOJu0Ywn1iKfvlue6/OjrtoKmIZPAg0vHO85aq7H7PLD0zYM44oRB5YC
	AQi2gS1Fuo1ogw43w3ycHveJvoj4+y0flZIPVusQ2h0r66KzLnsVqBpy4iJPoQ==
X-Gm-Gg: ASbGncvpn/AHmetMw1yphGbrqOJOgQeuTEDsE0Jcji9lkf9n5RJekOHSOvPhktmkAH0
	6L1wfQ6k2yoqJ3ZHXuySg4JqqZt7npcITqqRi7Ih7mDsW0jpUOmSb3ynrb9ZgAXMwZzYP1mUfta
	5MlDe6LYFjpOot3T8Vq+NxiUWIPTqxwilnHYSJTC9qIk4XK0soDw8ugnEBN3dQjcDozUfm5l3ke
	bgn9MZJKRhZbaYMo2ZipbPp/MlUK4SiIGbNgZ+7EwC0Z0m6vONXA4tvqfNIZsMsVXfXyGONdMb7
	F0RtiCgRmc10Rau8DUZFW1R+61x9/fJlCXNwclUP6yBdyOkr0fooVfKrJf68BcMcfURd3gdzNQn
	ByHtbg0ZyqaF3Tu+DV8x6E6WMezwRX1Yrm+lvp/phHdFnfjII68JnMhYRsgLVoLxpHHkR
X-Google-Smtp-Source: AGHT+IGeaAmdZtUbHAqiaChSAYynm6nm859WIPyQoh1tBWaE/4UngW/QwFRMPnjRlirZZBvzlIttQA==
X-Received: by 2002:a05:6902:1541:b0:e84:1b38:7ff0 with SMTP id 3f1490d57ef6-e87a7af55a7mr6432258276.3.1751060758145;
        Fri, 27 Jun 2025 14:45:58 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e87a6b4c35bsm806340276.1.2025.06.27.14.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 14:45:57 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH] install: add Q&A: What packages are available
Date: Fri, 27 Jun 2025 17:45:45 -0400
Message-ID: <20250627214545.221-1-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

This patch adds a Q&A regarding finding available packages, linking to the=
=0D
package search and cygcheck page, and includes a tip on performing a=0D
command-line search with cygcheck so that existing tools are more accessibl=
e=0D
and visible to users.=0D
=0D
---=0D
 install.html | 13 +++++++++++++=0D
 1 file changed, 13 insertions(+)=0D
=0D
diff --git a/install.html b/install.html=0D
index 85c1cb49..ff07fc81 100755=0D
--- a/install.html=0D
+++ b/install.html=0D
@@ -100,6 +100,19 @@ installation.  Be advised that this will download and =
install tens of gigabytes=0D
 of files to your computer.=0D
 </p>=0D
 =0D
+<h2 class=3D"cartouche" id=3D"packages">Q: What packages are available?</h=
2>=0D
+=0D
+<p>=0D
+A: To find available packages, and view what package contains <i>X</i> see=
 the=0D
+<a href=3D" https://cygwin.com/packages/">package search</a> page.=0D
+</p>=0D
+=0D
+<p>=0D
+<b>Tip:</b> Perform a search from the command-line using=0D
+<a href=3D"https://cygwin.com/cygwin-ug-net/cygcheck.html"><code>cygcheck<=
/code></a>=0D
+using <code>-p package</code> or <code>-e package1 package2 ...</code> opt=
ions.=0D
+</p>=0D
+=0D
 <h2 class=3D"cartouche" id=3D"verify-sig">Q: How do I verify the signature=
 of setup?</h2>=0D
 =0D
 <p>A: e.g.</p>=0D
-- =0D
2.49.0.windows.1=0D
=0D
