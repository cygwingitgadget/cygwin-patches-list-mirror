Return-Path: <cygwin@hamishmb.com>
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
	by sourceware.org (Postfix) with ESMTPS id D736D3858410
	for <cygwin-patches@cygwin.com>; Tue, 25 Oct 2022 18:50:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org D736D3858410
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=hamishmb.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=hamishmb.com
ARC-Seal: i=1; a=rsa-sha256; t=1666723848; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=XcktJW5+6NvfjwWeS98fok0bUt2RVk4HZbKc/SSIlAOyllMFZeOPz38XEmgbOqCYUq0OE7Jip5aFP92GncBlAxj4NxpF2Sd6HHtUC5wj1qXywn5wf5e6D4/rgA3Is0jkpJDsAtunokmsTAv3YXv+LsWGCPWYEU/vgTQM8QVye4o=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1666723848; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
	bh=UNLZFEJhe7lkqiOAsDOzWqqiQm4JxZGCRqPr3hKWdIQ=; 
	b=XZ0UPOeRjKq2L5uplSVBXnR1IUEVBHV+hm92mW/tVaCclF5+KVzApSrTsaXWxLTgnsjkDjAK/Ex+y7DUcbkKD5ORzFeVMBaxzpW4ZMBKGIf3mS7JAFvzOFp2RkUjGLJ49a1EDJzznYnds+3y74ZTO6UX64t0pS4kvnaBOU/l2LE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=hamishmb.com;
	spf=pass  smtp.mailfrom=cygwin@hamishmb.com;
	dmarc=pass header.from=<cygwin@hamishmb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666723848;
	s=zmail; d=hamishmb.com; i=cygwin@hamishmb.com;
	h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=UNLZFEJhe7lkqiOAsDOzWqqiQm4JxZGCRqPr3hKWdIQ=;
	b=un3jCd6Jk8udqkaYu5km5bD3t2k9lHyH7X4zoU6tqpO1g2s1ISDVZRTDHit/YVrw
	sT/kLY77AeJ4rpVm/Ixagz65eFbzXC7JHfMbT0AYWpk1UYyzfLmcQEk+k1VF3KV10hU
	i1eDKhGkX6XNviiiMx9mORujYBjeP3c5eThRt+ZY=
Received: from [192.168.10.213] (host86-149-41-78.range86-149.btcentralplus.com [86.149.41.78]) by mx.zoho.eu
	with SMTPS id 1666723847689774.0276813567498; Tue, 25 Oct 2022 20:50:47 +0200 (CEST)
Message-ID: <6a50dd6a-e805-bbf0-200a-25a1892bfa5b@hamishmb.com>
Date: Tue, 25 Oct 2022 19:50:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
X-Mozilla-News-Host: news://news.gmane.io:119
Content-Language: en-US
To: cygwin-patches@cygwin.com
From: Hamish McIntyre-Bhatty <cygwin@hamishmb.com>
Subject: [PATCH] Fix typo in faq-programming.xml
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi there,

This is my first time submitting a patch over email, so hopefully I'll 
get it right. Are there eventually plans for submitting merge requests 
directly with git in some way?

This is a simple one-line patch to fix a typo I noticed in the 
programming FAQ. Patch follows below. I follow the list via GMANE, but 
to make sure I see any replies, it's probably best to reply to cygwin at 
hamishmb dot com.

Hamish

diff --git a/winsup/doc/faq-programming.xml b/winsup/doc/faq-programming.xml
index c2c4004c1..7945b6b88 100644
--- a/winsup/doc/faq-programming.xml
+++ b/winsup/doc/faq-programming.xml
@@ -1051,7 +1051,7 @@ a Windows environment which Cygwin handles 
automatically.
  <question><para>How should I port my Unix GUI to 
Windows?</para></question>
  <answer>

-<para>Like other Unix-like platforms, the Cygwin distribtion includes 
many of
+<para>Like other Unix-like platforms, the Cygwin distribution includes 
many of
  the common GUI toolkits, including X11, X Athena widgets, Motif, Tk, GTK+,
  and Qt. Many programs which rely on these toolkits will work with 
little, if
  any, porting work if they are otherwise portable.  However, there are 
a few
