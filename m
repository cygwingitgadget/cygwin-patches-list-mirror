Return-Path: <SRS0=e9kc=ZB=jdrake.com=cygwin@sourceware.org>
Received: from mail231.csoft.net (mail231.csoft.net [66.216.5.135])
	by sourceware.org (Postfix) with ESMTPS id C21BD38EAA10
	for <cygwin-patches@cygwin.com>; Wed, 18 Jun 2025 17:56:30 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C21BD38EAA10
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=jdrake.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=jdrake.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C21BD38EAA10
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=66.216.5.135
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750269390; cv=none;
	b=cf2GKmqRdhQ7RQ4jDiTlL3jDQdsdUh/d0NWqB/3gRGxC+dfiH26E9lrGRtMBqSL9m+mNFTa4NbnvCxLKaq1ocUkmMinJG2JD2Prkhtvog6juhSLgvKOE+fddgy2onz6HpYQR6fYnvxHcwqA6NKyjaFg4bSkPBN/bvYkjg5dt2qY=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750269390; c=relaxed/simple;
	bh=tOek6v13pRg9mYQtNMMaogbxw7XrmoSTWTL4yJgYeQk=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=mhQyEW8tLvHG/xiK9GcG+4dmUOyRZdn5Ezcv/1VRXcBsDfnBj+qOsvb+hONwsAAJstsXMX0HSeZydIEqbIyirzxLiIUx++zCZf1LmF66Cb4ekbzqDr/Uf207h5omcr+bWg+akBs2cRLjhMMThiCtTFRHoPmSMLqb19GFnvu4Ckk=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C21BD38EAA10
Authentication-Results: sourceware.org;
	dkim=pass (1024-bit key, unprotected) header.d=jdrake.com header.i=@jdrake.com header.a=rsa-sha1 header.s=csoft header.b=x2IHKsd+
Received: from mail231.csoft.net (localhost [127.0.0.1])
	by mail231.csoft.net (Postfix) with ESMTP id 9B42845D3F;
	Wed, 18 Jun 2025 13:56:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=jdrake.com; h=date:from:to
	:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=csoft; bh=okN2S27DZMwIbZAH5TjmsERMPjU=; b=x2IHK
	sd+Drzzj86jHhKp4SlgoufMIKDlN8pRV+E6qWdR0eceK2vShD1ScQi2jiaRlnCsq
	aEFmhYNinpE9TGBay0KlRuuWqZENuK/kBm4K4+jaCIpHNLvK18ras+qJCMjGzlDC
	TBTVWCRuqdKkUVsxiqSZNOD02JBFwqjWiRQq/M=
Received: from mail231 (mail231 [66.216.5.135])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jeremyd)
	by mail231.csoft.net (Postfix) with ESMTPSA id 84CE145D37;
	Wed, 18 Jun 2025 13:56:30 -0400 (EDT)
Date: Wed, 18 Jun 2025 10:56:30 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: Thirumalai Nagalingam <thirumalai.nagalingam@multicorewareinc.com>
cc: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Re: [PATCH] Cygwin: Aarch64: Add inline assembly pthread wrapper
In-Reply-To: <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
Message-ID: <297cad46-96bf-e3a6-e951-887c847f027e@jdrake.com>
References: <PN2P287MB308587EBC924A773A4F2182E9F6FA@PN2P287MB3085.INDP287.PROD.OUTLOOK.COM> <afdbcb68-30a0-84a5-693c-7a6390e60c6f@jdrake.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Wed, 18 Jun 2025, Jeremy Drake via Cygwin-patches wrote:

> > +	   mov     x0, sp                        // x0 = new stack pointer        \n\
>
> This seems wrong.  Shouldn't it be
>            mov     x0, [x19, #16]                // x0 = wrapper_arg.stackaddr

Make that ldr rather than mov.  Not used to writing aarch64 assembly ;)

