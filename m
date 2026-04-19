Return-Path: <SRS0=C0l8=CS=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
	by sourceware.org (Postfix) with ESMTPS id 43E3D4BA9023
	for <cygwin-patches@cygwin.com>; Sun, 19 Apr 2026 05:27:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 43E3D4BA9023
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 43E3D4BA9023
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::112e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1776576442; cv=none;
	b=BXTiVRYAa8esBTEwcNAln3X7H1AfsmT8nYn3T5CJkE07iUJ4L4i3NMN30VhOaseUhAbvdXgNcprvugRZ8mXfld02DTRX1zw06OVT2vuNuUeyhOmlqH7ssk8iaSkI7AFoPpBqczQ38c1GA2VK/EaNNhLt7iCQSemQrrMO6ChVa5Y=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1776576442; c=relaxed/simple;
	bh=uWkIe4RxlNrfVr4g9gb1YIpQ/bopb6NUeh+I7Bev2Cs=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=QpvjIefmQkyXg14elxiXRDd7nEtHyMqhXxzxe2YqzWvWaigRT0xBU1k8SSGz18AQ5w7jQ2y5JCiUSKLR3oCe6VYsUeZ+24OOcqBObVWi3j0tYcoJPriWqB1vfHdn9vJcqYInnkdeg18gTcTABJn/EWJXTBVEmJtkpoHiq2BdaR0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 43E3D4BA9023
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eJshL4ZV
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-7947cf097c1so16428597b3.2
        for <cygwin-patches@cygwin.com>; Sat, 18 Apr 2026 22:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776576441; x=1777181241; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWoEnpCNI44DcazVecwD0xcH/wiTQ+UwZ+F5OmY9zPA=;
        b=eJshL4ZVGMwfiUVCO8bCaivzt5TfNyu5YF2CCiJI1yZUzudr+T+wbjd+qWczpq/zI3
         cGJr5V7I6CROaxmuxlqL55eE2t7pkojqkN5Axqgl9LhE+7zKEty/u6qruUr61TwOV9rx
         8xOh/5YuwmpOF0BwiJfvucww0NOt4LVgSabgNZ1dSxpfLpbpPqeZWpYBtfpXevH9/h0T
         QB9peXup9nIcdlhz2/4ZHkAkc8JnpdY3OknXUBUzBrpI8LzxEnZIZRxS/dPAxz2roYDJ
         f8L/xPkqZ6MMNT8sbM/vqUhc0dAbQp5BseqMXXKi1JrhJa5hoG2F8K2g68caLutCNFOq
         PX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776576441; x=1777181241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWoEnpCNI44DcazVecwD0xcH/wiTQ+UwZ+F5OmY9zPA=;
        b=bVI/eQsyUGZM86qvb5pnzFG8XSMCFjFTzp0nStKIgy5I9QfB+vLk47UEiQm1j4xTSb
         7suQaBKcC3nL1aLOoZxa3O4cZrEgdD3FIHdoDhXDcV1jBfGrn/2kDYJogo7NlEwkyrNG
         Tceo5+pofWW6H/BvPsAed59RLMSRv9HrSSTwbuOu9JfXCzv/8Zw8fFshu6Xy+WAIScZ7
         h6dayF6O0fCDo7Puugn8UIemYKq3j5XYCj2DLsyS5U5vrEW8unggJ+bhn/zCq3gAM96t
         DgZqVA6Cuwq4pOXDl/zYhJ2VG0qp/5qRMifIObCSLL5h3VJkqM+F6wyH+a8yNMBjVSQP
         9Ieg==
X-Gm-Message-State: AOJu0YzVVNSjZX5FKlXkAh1ilFimyz5DwqdadMw101dO0VON3JNyAgWw
	/B2UySpk/rXco6J7+O/tzGBHyjdeDWRPdEpN/nhyPp+C3G8POEvCeoxtZ1sqOg==
X-Gm-Gg: AeBDietfxnG0uTkDXsvC8AnGV4aRB2SsXQDXhNGr2l5e280OlHo1yENMYGo9qTXSveu
	UuAuJC7d+9pW9c/o0ctslq17F6bGQCN/FzJe4d0OdoWSQ0sHZwBSVwn1CVyZwSAz+j8iEv/keog
	UcSSbO9uR7HYV7FHfMBBt3FTByedo2xhxBlyXTClhtWn6WkrVONeKTmjz75GCilu4rQT05udUJ5
	C1MuNXPeiS8lDApadWX5SvV2EjLYIiu6jNiAounCp8WT2/wVAip4IIGrs17U1ILjAVDp2iXSn4P
	qemq8ARagGAzy0sVNf3AEz99+z1Nqt5uBkjow+rKUslOg2jbrPuS/fIL7xcKekEsACIuOtYQAkG
	znCMe2P1EQz89h3cMH4Fg9/VP3jmRwiuZg4N7ay72HvG/+RXdYMDYgEffVTBefA3l984csrACi4
	bXsYj3b4CybwXmY9BTPs3VlajLpllxXHs5D00LEn19Dk6uFyulG0I1TraM8YKpSChXP2T6nL+DW
	81K3Ne9EFL8xA/otv5DD3wuOpNFQaD5wPQ5KQ==
X-Received: by 2002:a05:690c:e04e:b0:7b7:5f48:d9ae with SMTP id 00721157ae682-7b9ecfb3437mr75185307b3.24.1776576440965;
        Sat, 18 Apr 2026 22:27:20 -0700 (PDT)
Received: from localhost.localdomain (h174.204.88.75.dynamic.ip.windstream.net. [75.88.204.174])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee99bc3bsm27777047b3.27.2026.04.18.22.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 22:27:19 -0700 (PDT)
From: John Haugabook <johnhaugabook@gmail.com>
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 04/11] cygwin-htdocs: website fresh coat of paint
Date: Sun, 19 Apr 2026 01:26:52 -0400
Message-ID: <20260419052701.513-5-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.46.0.windows.1
In-Reply-To: <20260419052701.513-1-johnhaugabook@gmail.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Signed-off-by: John Haugabook <johnhaugabook@gmail.com>
---
 style.css | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/style.css b/style.css
index 5e815292..6fef11ba 100644
--- a/style.css
+++ b/style.css
@@ -19,7 +19,7 @@ text-decoration: underline;
 {
 position: absolute;
 left: 0.5em;
-max-width: 11em;
+max-width: 12em;
 background-color: #80a0a0;
 color: white;
 text-align: left;
@@ -72,6 +72,34 @@ color:gold;
   padding-left: 0.75em;
 }
 
+/* Add menu hierarchy for sections */
+#navbar ul li a
+{
+  font-size: 13pt;
+  font-weight: bold;
+  padding: 2px;
+}
+
+/* Suppress style inside .nohover */
+#navbar ul li.nohover a
+{
+  font-size: initial;
+  font-weight: initial;
+  padding: initial;
+}
+
+#navbar ul li.nohover li
+{
+  margin-top: 5px;
+  line-height: 1.1;
+}
+
+div#main
+{
+  margin-left: 30px;
+}
+
+
 /* ----------------------------------------------------------------------- */
 
 #top
-- 
2.46.0.windows.1

