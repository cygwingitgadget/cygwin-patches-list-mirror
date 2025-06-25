Return-Path: <SRS0=FsbT=ZI=gmail.com=johnhaugabook@sourceware.org>
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by sourceware.org (Postfix) with ESMTPS id 172993858435
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 01:39:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 172993858435
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmail.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 172993858435
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::b2e
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750815568; cv=none;
	b=tERKEpMFLPx8fPIn9b/Eh3B+oD7NeriRbmdDZ8EElIBAxFjHaAP75623TOmcZS3te/VKnS8U8+ei1n7jD5z4LOBxsdt2K0qUqKJqUgzuuBSrvwxBjoUiWtUR9iAYnPxFeI0qfgpeVyhL2IZpWCoo7ko6KYd1bqqZPEfEa3YkvLM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750815568; c=relaxed/simple;
	bh=8j58oTgDo9ZXPkN8dNZIr0Gwf2c5Kkkug2kooNG6/c0=;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version; b=Vk3XVmIqzb0O8YDsRCI4XZ0anIcyXH3jH3JsNwAxjLb3zQ/KpY7uO3DX+x5PfL2/Q2pRZr+Qp7ILpTexYYX019rIQKcZpbmqagaeTNYSghoExHLb/Tq2L5w63fYmx31/LQg88oXerirBdP0sKQYtgMK5T3yA0qdAdajv4k9Tj5U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 172993858435
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20230601 header.b=X2s/8jy1
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-e733e25bfc7so5086469276.3
        for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 18:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750815567; x=1751420367; darn=cygwin.com;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8j58oTgDo9ZXPkN8dNZIr0Gwf2c5Kkkug2kooNG6/c0=;
        b=X2s/8jy1n/1d5/pyLzB/PnnxXX+o25RcxHe6nBWM/DLM8hZa+OYrZOZ8y0ZSFa7eQH
         oDKe0M2owHhSzgUegPeFdI/2crEbC9GfDzr3xTMDG3EAK61wOOiB2D4NN/KL82mUnKXK
         u4O+fKwEyO5lxK+Wk15JWdfqemA7BbN+C9UTXpA63r4oBy3IUH4eM5ZWaqF07a9dp6LB
         igCkkZqKh/5tTbZkLioZBD4N5cx4XT7qp4nTGtC4l+Hee6wnzdllijXMcP0e8v1KuZBp
         jUaxW8o+eGMZomDVbsiKIT9wkj1y9BjTFggukEYrP8kPpW0o1ZTSFz33RHz0c/WKIeX6
         S0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750815567; x=1751420367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8j58oTgDo9ZXPkN8dNZIr0Gwf2c5Kkkug2kooNG6/c0=;
        b=rDhj2aE9hi1Bjf12C/KnllfTO0pldDQ6YbSuVaAiKUEJFx/DM5EJo7Y1VBbqX/sr1C
         yDHR//NPPYjpyPCbKypOaRsRgT0MmIF6E3+P6ayqQJ3T70wSpZFthEWG4zReycd3cO3T
         oN2t5+a5ormb0RUGdgO+jxKop0m/BlU+MNzIBlLYaMWVCVq/1dIHIJ5tMp3TCGC1mgAO
         +PbmmexOXBMuJi0f9E0N4DpdG4Ut4fg4p2FX1C27TbUhjMJKy0qoXAF8Egt+lxkNyfSd
         IJ/6oyh89OCvIg4YslPjiChs2MQy7+FIWSnAGW7Bf97T2l6FaCMXkjrVAC9B9mRJxjfo
         0LdA==
X-Gm-Message-State: AOJu0YwiWp7rr4O7coGCQ+//oZ6oFUzRy1/HMcJT1/06++8ohwJ5CMn5
	xMz2oaFQLBdc9wgyig/GvSjbLiDJAnVSJY6/XuZJn4PlfrLQVmnF0z1V+8PHeg==
X-Gm-Gg: ASbGnct4/GRsiexJEfnKLgaxQJGRDGLnmqnkhCy58KAMcQT6DzBCgC3WVB7dYCTbp8P
	IFvJ/NjhTjWr3yQxoNNT61BV/EsnYeFNugR0ozuUkTrNEoEPube5TfBCfVn6hnvzIo6hxD8QDNJ
	3Tsdjewi4W89z6Crs06lO/f/Q8CQ4st4AMYETb/9kgbYChv+tOKxK4DoOSu1kU9tudVPXC279uM
	b8+1ovjMWDxTPp+nEtFq0JihKSy0FKR5od5XvmsSK1EPBRfYp/9dysenkV4o36ySanAyDKXvF3W
	RufcWYtEMErlL5s0S7LZKam1gUl9Kb6DcruHm6UMlUcJTTSKyEJmI44YKK4KXcqI8n2PHJrwjHe
	4+a1yr7SfA8i8i+ZTRyXWibO8ypJ1qXypesetRIXI5BUE97UdR/Dq9gPZF6UflEiZL18V
X-Google-Smtp-Source: AGHT+IGD5dURrwNj1lKQZv2uGkl34+0fd6RdJKncYSPuC1ND1JvhZLsTStVDOsDNalvCnpzSN1o8hQ==
X-Received: by 2002:a05:6902:1247:b0:e82:24ae:c3ae with SMTP id 3f1490d57ef6-e8601725ac2mr1552130276.21.1750815567049;
        Tue, 24 Jun 2025 18:39:27 -0700 (PDT)
Received: from localhost.localdomain (h218.203.184.173.dynamic.ip.windstream.net. [173.184.203.218])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e842acb1fadsm3327676276.50.2025.06.24.18.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 18:39:26 -0700 (PDT)
From: johnhaugabook@gmail.com
To: cygwin-patches@cygwin.com
Cc: John Haugabook <johnhaugabook@gmail.com>
Subject: [PATCH 3/5] cygwin: faq-programming-6.21 para about process and time
Date: Tue, 24 Jun 2025 21:39:06 -0400
Message-ID: <20250625013908.628-4-johnhaugabook@gmail.com>
X-Mailer: git-send-email 2.49.0.windows.1
In-Reply-To: <20250625013908.628-1-johnhaugabook@gmail.com>
References: <20250625013908.628-1-johnhaugabook@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: John Haugabook <johnhaugabook@gmail.com>=0D

Adding a paragraph that breaks down the build in two steps; installing the =
required packages, and the install itself. Includes an estimate of the tota=
l install time, as I got varying times for install to complete using Window=
s 10, 11 on both a sandbox environment and on PC's as is.=0D
=0D
This is to make people who have installed the binaries of cygwin, which tak=
es under 5 minutes, aware that this install will take significantly longer,=
 and making them aware that the install will fail if required packages are =
not installed.=0D
=0D
Signed-off-by: John Haugabook <johnhaugabook@gmail.com>=0D
---=0D
 winsup/doc/faq-programming.xml | 7 +++++++=0D
 1 file changed, 7 insertions(+)=0D
=0D
diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l=0D
index b9269187c..fa3f097a9 100644=0D
--- a/winsup/doc/faq-programming.xml=0D
+++ b/winsup/doc/faq-programming.xml=0D
@@ -675,6 +675,13 @@ rewriting the runtime library in question from specs..=
.=0D
 <question><para>How do I build Cygwin on my own?</para></question>=0D
 <answer>=0D
 =0D
+<para>=0D
+There are two processes. One download the required packages.=0D
+Two installation. Note that the entire process may take anywhere=0D
+from 30 minutes to over an hour, so be sure to download all =0D
+required packages before beginning the installation.=0D
+</para>=0D
+=0D
 <para>First, you need to make sure you have the necessary build tools=0D
 installed; you at least need <literal>autoconf</literal>,=0D
 <literal>automake</literal>, <literal>cocom</literal>,=0D
-- =0D
2.49.0.windows.1=0D
=0D
