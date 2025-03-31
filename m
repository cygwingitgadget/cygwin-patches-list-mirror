Return-Path: <SRS0=GFb7=WS=klomp.org=mark@sourceware.org>
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	by sourceware.org (Postfix) with ESMTPS id 6BB923856DEB
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 21:57:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6BB923856DEB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=klomp.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6BB923856DEB
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=45.83.234.184
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743458242; cv=none;
	b=WOwYbxC+ijGsM6iVL5aLTW/C/OVLkmgY7UqcsrgLFWdqbi4YROcRoZG0JzmWpfqCMkWDktSYCtlyUSWqiTUBReel2o5t2tyfiGN9vXu6Ma6EunhYvh64qYRzGwZCjAyU7Spn+zkn9OhpO6X0X8HlCrH4l+cy3H5e4ha/1pENSNM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743458242; c=relaxed/simple;
	bh=5d5+R0/kiJeEYxQcxmibsTNBuJu7YCwtQNPhXbKUCag=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=hP+JqEevqv1FIIPlESkiMA4f8Lek4A/ijZrMcknEexpwrmcf053v8MyzvXxyUXLF1XZklgGMGW7VyscxkrwdtJk1R+y/pH6JQPzKyIX9cARNKt3oqpdfIPsF897W+7ceu4TA6KLsxrvhDXKowpieHrPz7naPCT/mpQz8cKsoTj0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6BB923856DEB
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id 962C3303C2A0; Mon, 31 Mar 2025 23:57:21 +0200 (CEST)
Date: Mon, 31 Mar 2025 23:57:21 +0200
From: Mark Wielaard <mark@klomp.org>
To: Mark Wielaard via Overseers <overseers@sourceware.org>,
	cygwin-patches@cygwin.com
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <20250331215721.GB9235@gnu.wildebeest.org>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
 <20250331214131.GA9235@gnu.wildebeest.org>
 <Z-sNmSuwz20-EOzU@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-sNmSuwz20-EOzU@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On Mon, Mar 31, 2025 at 11:48:09PM +0200, Corinna Vinschen via Overseers wrote:
> On Mar 31 23:41, Mark Wielaard via Overseers wrote:
> > Overseers, or at least I, was a little confused, sorry.  I do see the
> > account request by Jeremy and your approval.  But I was under the
> > impression that Cygwin was using gitolite and you handled user keys
> > yourself. Am I wrong? Is that only for some (other) repositories?
> 
> gitolite is only used for the Cygwin distro package upload.
> 
> This here is for the newlib-cygwin source repo.

Aha, sorry. Account created.
Welcome Jeremy!

Cheers,

Mark
