Return-Path: <SRS0=EkV4=ZI=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id E8FD4385AC24
	for <cygwin-patches@cygwin.com>; Wed, 25 Jun 2025 18:37:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E8FD4385AC24
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E8FD4385AC24
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750876656; cv=none;
	b=QyQ+ii7TxvfRoTZEo2XduxpskgVoG92ymViUKrOJr1RUjVTlLlm7vByQKmw5BHmvvvkY5sjFm4bb7Ifb+JVMgbWAOjKNkc6IleM/0aggP64lWkktzHChgLO6OhxUBAyy9+QCh/QVXKtN0UONLEsfENu5RfCPlZKzsZimTk5SZUw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750876656; c=relaxed/simple;
	bh=HRA28eSm5LwfNbynUgp2DK7PVh5oHCd/zwF5bEz/FwQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hNhgfwtKCt+QI9wYTTDhidCNASfsFppEfuKDe8u9l43LJQm1nyQSN9xNIGjNct4Ksm3vyD9NDx85MxT/AtrRZuLLf11rxL+HfXVNyI7m33pRL0XjXd/5q14H2o9IRZCzCXqYqEO3nDvishgVF1DTI0OOm4WLFYOJj74ZhAoUuxM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E8FD4385AC24
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=nBuK290l
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 7BA3A45D37;
	Wed, 25 Jun 2025 14:37:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=EsYnjWEdfT2LtohyPjtvVR8NMa8=; b=nBuK2
	90lgifzt9UTNxspEKAjNy07CuI4F+ogykNsL3SLnCnZrDQko+tg7HKavXQ28oCMu
	cTmmh60McKcMc0Xim6FEbuOt5VN9W27330Bgi5RjivUimWmFD13ZXuk9bJfQKW8D
	rtWtZtWm5/LEHpXPH3d3ng27h3ng1XKz7SXK/g=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 60E5545D36;
	Wed, 25 Jun 2025 14:37:35 -0400 (EDT)
Date: Wed, 25 Jun 2025 11:37:35 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Aarch64: Fix register load order in `ldp` in commit
 f4ba145
In-Reply-To: <MA0P287MB3082CD4D85400059F59A3A449F7BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
Message-ID: <2d238391-3495-515a-2075-2d327508d793@jdrake.com>
References: <MA0P287MB3082CD4D85400059F59A3A449F7BA@MA0P287MB3082.INDP287.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 25 Jun 2025, Thirumalai Nagalingam wrote:

> -      ldp     x0, x10, [x19, #16]  // x0 = stackaddr, x10 = stackbase \n\
> +      ldp     x10, x0, [x19, #24]  // x0 = stackaddr, x10 = stackbase \n\

I am very confused about this.

The struct layout:
struct pthread_wrapper_arg
{
  LPTHREAD_START_ROUTINE func; // +0
  PVOID arg;                   // +8
  PBYTE stackaddr;             // +16
  PBYTE stackbase;             // +24
  PBYTE stacklimit;            // +32
  ULONG guardsize;             // +40
};

below, you have
	   ldp     x19, x0, [x19]       // x19 = func, x0 = arg            \n\
	   blr     x19                  // call thread function            \n"

If this works (and it'd be really very obvious if it didn't), ldp loads
64-bits at the address given and puts it in the first register, and loads
64-bits at address+8 and puts it in the second register.  So wouldn't this
really be

+      ldp     x10, x0, [x19, #24]  // x10 = stackbase, x0 = stacklimit \n\

?

so now you're freeing stacklimit instead of stackbase?  I don't think
that's right.
