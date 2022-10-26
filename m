Return-Path: <cygwin@hamishmb.com>
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
	by sourceware.org (Postfix) with ESMTPS id 20C82385AC3E
	for <cygwin-patches@cygwin.com>; Wed, 26 Oct 2022 13:26:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 20C82385AC3E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hamishmb.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hamishmb.com
ARC-Seal: i=1; a=rsa-sha256; t=1666790794; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hZIEzFloEYtNm3jAtGLdUOGuVDNtdZe5TR6fXMnHBQzLn30QAwXr7AZkoTMfWb7DqbsPleVrhfM/CXj0bQqnnOr9Ry0i20dZ+HIhpTpu75/r6aopwxZu4nF8qWzoqSHAqmB/IgtudvAuupI3paAG0afW7Q7DzbfGeEt0w+JV70A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1666790794; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=zXUAvpayPm2XnwgQwrz/NPd9mIUuqT5t6BteeeVi1so=; 
	b=PAfWuezD7LfSenEV2GQ3S+VjX9tAo2Sy+1Hi4HZX4ta+I2k+2CmN/7dd2opgNFt9/neW2aVb9ezYFdP5sptPfUCxQPPs6kakkrHft6R/2AmS31kFleAgZknszxOv/6Y7KKiftPB2Woei3q8ymuNKMP5eMf6knJbWqdj7csPZyjM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=hamishmb.com;
	spf=pass  smtp.mailfrom=cygwin@hamishmb.com;
	dmarc=pass header.from=<cygwin@hamishmb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666790794;
	s=zmail; d=hamishmb.com; i=cygwin@hamishmb.com;
	h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=zXUAvpayPm2XnwgQwrz/NPd9mIUuqT5t6BteeeVi1so=;
	b=In2KggdFkVkTF5MNeNHSM12WzLwtBR6NpA2sRWNNn+Hy+2scanDgFnQXpRLJ5wRe
	Eeazcv5vMgxOHp9K5r+6EWQN09UcOKk7Mgr8ijFa/1dX1Spn+Su8SuGyZuXMvyC4CKK
	70sgs5YtIZ6vIiloBE1oQGYbW1vj3Z3EmYE4ohPc=
Received: from localhost.localdomain (host86-149-41-78.range86-149.btcentralplus.com [86.149.41.78]) by mx.zoho.eu
	with SMTPS id 1666790793640829.4828071768328; Wed, 26 Oct 2022 15:26:33 +0200 (CEST)
From: Hamish McIntyre-Bhatty <cygwin@hamishmb.com>
To: cygwin-patches@cygwin.com
Cc: Hamish McIntyre-Bhatty <contact@hamishmb.com>
Message-ID: <20221026132616.280324-1-cygwin@hamishmb.com>
Subject: [PATCH] Fix typo in faq-programming.xml
Date: Wed, 26 Oct 2022 14:26:16 +0100
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

From: Hamish McIntyre-Bhatty <contact@hamishmb.com>

---
 winsup/doc/faq-programming.xml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xm=
l
index c2c4004c1..7945b6b88 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles automatica=
lly.
 <question><para>How should I port my Unix GUI to Windows?</para></question=
>
 <answer>
=20
-<para>Like other Unix-like platforms, the Cygwin distribtion includes many=
 of
+<para>Like other Unix-like platforms, the Cygwin distribution includes man=
y of
 the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, GTK+,
 and Qt. Many programs which rely on these toolkits will work with little, =
if
 any, porting work if they are otherwise portable.  However, there are a fe=
w
--=20
2.25.1


