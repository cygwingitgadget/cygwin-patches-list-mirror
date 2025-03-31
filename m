Return-Path: <SRS0=GFb7=WS=klomp.org=mark@sourceware.org>
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
	by sourceware.org (Postfix) with ESMTPS id D2DA6385B529
	for <cygwin-patches@cygwin.com>; Mon, 31 Mar 2025 21:41:32 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D2DA6385B529
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=klomp.org
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=klomp.org
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D2DA6385B529
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=45.83.234.184
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743457293; cv=none;
	b=M2O9NQFsgTSvY7GzEfHxeKgCAis5E0dt1lgoY/fvZHdWXjSq9ZLPvWfoHUZ7dNE/TYWlf12PyyxrYwwG75KugJOHCL88qm786Q4KQt443QImcvFoEjgas/hymjnh+/QRMYD5HTDU4UNw0PIzfSBkzp32Uypbpz/sjQRnPt+Y9IU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743457293; c=relaxed/simple;
	bh=JezyffQnz9d8j62vkRlK8DilCbF0FKl/Fnz/7gJXR0Q=;
	h=Date:From:To:Subject:Message-ID:MIME-Version; b=TYsNqgeP0+o6WEf8ouipWpyEFuZimplGt2M+2/FHWaMbR5bLEPm4lyJGnedD4QdhPiysEPiI3L5IU1RpKsAg8yuGcs9KyQSl+r6dKmFFR5YIcY1iWyEracLMDHTosacCxLpZ2Iybakemsi7GK73eKzkik6yU79QAiJKcKMCrEuM=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D2DA6385B529
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
	id E3401303C2A0; Mon, 31 Mar 2025 23:41:31 +0200 (CEST)
Date: Mon, 31 Mar 2025 23:41:31 +0200
From: Mark Wielaard <mark@klomp.org>
To: cygwin-patches@cygwin.com, overseers@sourceware.org
Subject: Re: [PATCH v4 0/5] find_fast_cwd_pointer rewrite
Message-ID: <20250331214131.GA9235@gnu.wildebeest.org>
References: <56da8997-5d48-dfb7-8a41-b3fa6ccfbecc@jdrake.com>
 <bd7bc794-7a50-228f-4f9e-a34a02fd12f6@jdrake.com>
 <Z-pQB1d2It9jkuFS@calimero.vinschen.de>
 <Z-r0vQTnzdkrCIsq@calimero.vinschen.de>
 <ed148947-2ebb-6c44-6b90-acb018b85008@jdrake.com>
 <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-sD0CGk4L-zuyzH@calimero.vinschen.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna, Hi Jeremy,

On Mon, Mar 31, 2025 at 11:06:24PM +0200, Corinna Vinschen via Overseers wrote:
> On Mar 31 13:58, Jeremy Drake via Cygwin-patches wrote:
> > On Mon, 31 Mar 2025, Corinna Vinschen wrote:
> > > Thank you, I approved your request on sware.  You now have
> > > write-after-approval permissions, so please continue to send patches to
> > > cygwin-patches first and wait for approval from Takashi, Jon or me.
> > 
> > I tried to push this patchset but I'm getting Permission denied
> > (publickey) from ssh.  I assume this is still waiting on overseers.
> > Should I expect an email from them when things are ready?
> 
> Usually you should get a mail from overseers.  I CCed them, just to
> be sure.

Overseers, or at least, was a little confused, sorry.  I do see the
account request by Jeremy and your approval.  But I was under the
impression that Cygwin was using gitolite and you handled user keys
yourself. Am I wrong? Is that only for some (other) repositories?

Cheers,

Mark
