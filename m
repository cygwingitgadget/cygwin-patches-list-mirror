Return-Path: <SRS0=oWFo=II=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id CA2FE4BA2E09
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 17:53:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CA2FE4BA2E09
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CA2FE4BA2E09
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792346032; cv=none;
	b=Mhi2VFZCiRQfWkFOrFYXZEUrExFw+XE9AMUHKVsbmCT2ILsmpLXU36fNrPc53nmXqYaWqJ5Es4VHn7ZK4nzI+dy7CpVa86u0iyQKgHwpvxS4jp6Ecvn15E3Zz4NI1UxxAhfz9vQaTAYTrEbG9GRtPR0eRZTJcB15OwCOTyo+e00=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792346032; c=relaxed/simple;
	bh=X9GI4bkaBeTsAfIr6IF8uh9Ybqlj6fdpdgqJucg+3+Y=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=xO7xrCkn57uOfgNJOCszKf1c+VWUmNfHFaIRw5kgjxl3upooqRxAQ184Hohv8Dtxfc9oCjv390OQspeWIJVlN2PGTQray9Y+h6amIH+pbO1nBhD/V2LF3qo4kUzhTAxm3dl1zVcGD3iBeYPoJprVK1gi/YC9RhVsgHJdpX6IZ2w=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=ck85BAME
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CA2FE4BA2E09
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=ck85BAME
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A539AC0546
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 17:53:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf04.hostedemail.com (Postfix) with ESMTPA id 1EDB820024
	for <cygwin-patches@cygwin.com>; Sun, 18 Oct 2026 17:53:50 +0000 (UTC)
Message-ID: <96aba361-6358-403e-b2e8-a9f39000f4a4@SystematicSW.ab.ca>
Date: Sun, 18 Oct 2026 11:53:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: The meaning of "Signed-off-by:" in patches
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <636bc5ac-7500-4d18-966d-ffb73d87da3c@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <636bc5ac-7500-4d18-966d-ffb73d87da3c@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 1EDB820024
X-Stat-Signature: x9b6x6qq4w9kmapgkj7hrhp477i9hnhk
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/d503XDE19EBu7G0kRfyuwTgDpMrKENW4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=yLq3XdvnfT1yeQx2d/ziQmrpZMwEWpjOvDKCGcWtDIw=; b=ck85BAME++mlD1r2g+yVi7qVoOlvfdlhJMt2a5r5tD1P2uAt/KL29fq3ZSGHLGzHyXeFx/g56OxZbQRf2UvY1uKM1brnrfYH1IHEY+6y8ruFN8M5y2iSwg2t9Fl0MmnQ71MITCU/tWAk1yv3Ke7A0qi1/Pt8NzbzwxQISfHRJb8s7I5SMlgRA09BPdcuaRqNlfo0hQ7hKk2Tj9s8M4f4xjuoSqeYK+LNoAWYEWU/TOLNUVfJ0LZcDd/IC1qiiTYjU2jl6F+ZS4bu9ko0jrSfAuhbAREB+UldJ5PRjBppvL77nwq//nT/2BsKSUibQe8THeUQlpf517pVzKfw6d7Mpg==
X-HE-Tag: 1792346030-698452
X-HE-Meta: U2FsdGVkX19PIPUgrTRehkY+Wjgzdqlpg1OkYSFOn7QSG+LUoR2PNsQPJyYI8Mw8rWi7Zm/00rmsRm0EOt+5UaTRChByQW5n/Cpjht0KVHM0w6RHgdly/NEcW3kDcl0KSB3WgklgHM8V7kENttWwGheRKksmzLxCytmOVsrNwWpltE6qaJV5eaEYvrcL3y1BDq1+r0O9BN9zROL4vc+R5DahKkwgda7fidwve9Wkp1CEPg9WkKQp59MwMkwVpgyaLm+/AhZCWVRbtPPpYSXeU5noAtR9M/vNFtUplOJ6Hz/K7YAHVE9tGdadzP1NZmonP49rSXdNeSNfJTq3NVzx4MO50ZHErbE0z34LYSH0V9QR9N04SGCjC9Q3U6lrdp/A4iivoEjYHeBaehAZxW6us8GyUMon1Ejewz+F6i4t2oyOFTPSaQIfjkwl7o5Iowt1SSxAcWLJvPXD9MZIGp/l7tgNaopILeDjY+RblC/Vu0s=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-10-18 04:56, Jon Turney wrote:
> 
> I've made a (long overdue) revision to the "Contributing the the Cygwin DLL" 
> page [1], to state what we think "Signed-off-by:" in a patch means (going 
> forward), by reference to the DCO [2].
> 
> Hopefully, this is uncontroversial and unproblematic, but please let me know if 
> you think otherwise...
> 
> [1] https://cygwin.com/contrib/dll.html#before_starting_legal
> [2] https://developercertificate.org/

Ignoring the DCO Copyright which does not imply it applies there, but it would 
be worth while stating something like where the DCO is applied to the Cygwin 
project, authors, and contributors; also newlib licence is BSD, but Cygwin is 
LGPL3+?

What should we be doing about GnuPG2 signed -S commits?
I could easily add that, but unsure what the infra and tooling is like for repo 
writers?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
