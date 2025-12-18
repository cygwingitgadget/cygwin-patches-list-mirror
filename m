Return-Path: <SRS0=nogY=6Y=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 6B9594BA2E20
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 23:53:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6B9594BA2E20
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6B9594BA2E20
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1766102021; cv=none;
	b=QNrET25hEgWKrqbesmRks0j9Rh+dM/NBA75M3aTSFbPNun35qTu95MtSGYpuXdaK3h5NYq03SYuvVDWlkXxXCGeLAYT+pL6QbgnBFXGK0lQKQw594ZWs28GsZdqY3NcPS5PmDOinmZWvmKfJVuYekfsVI6eDquEiRTkgj1Nawgc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1766102021; c=relaxed/simple;
	bh=a9EY2SJJIk6h1llQLiJVJPgJ2a8BT5a34TKGgMjk1mM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:DKIM-Signature; b=N0Sm3I/SngRrSu7hqS2omFyBro8JhHnd8J0z5K03uimQDMU58+wZbNaBwEN9elm+Kji+qqp24XG8Rg+d6XTEHxCGS1L7KPC50ay9c2n7ybhEari+4HVnjdTykIFSXeBbTxhBDE+sTxE5mMNf879AtuppkXOFaEvL571EQrmIvOA=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6B9594BA2E20
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=Z/Pb8dyo
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 0543A160375
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 23:53:40 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf11.hostedemail.com (Postfix) with ESMTPA id 917AB20029
	for <cygwin-patches@cygwin.com>; Thu, 18 Dec 2025 23:53:39 +0000 (UTC)
Message-ID: <2fa791d4-9569-432d-b062-68bb8136e1ef@SystematicSW.ab.ca>
Date: Thu, 18 Dec 2025 16:53:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: console: Set ENABLE_PROCESSED_INPUT when
 disable_master_thread
Content-Language: en-CA
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
To: cygwin-patches@cygwin.com
References: <20250701083742.1963-1-takashi.yano@nifty.ne.jp>
 <9a404679-40b5-1d55-db07-eb0dacf53dc7@gmx.de>
 <20250703154710.f7f35d0839a09f9141c63b1c@nifty.ne.jp>
 <259d8a20-46d5-c8cb-1efb-7d60d9391214@gmx.de>
 <20250703195336.2d5900b4988a6918ad397582@nifty.ne.jp>
 <5be83d7c-a19f-a733-7d8f-1d41daa6b9f8@gmx.de>
 <20250715162741.bd33f1249f088ba6947fbd32@nifty.ne.jp>
 <2ad7299d-9561-fcd9-9fec-8b492c48caee@gmx.de>
 <6e67d97e-60a0-4bff-8a4e-cf4e90411603@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <6e67d97e-60a0-4bff-8a4e-cf4e90411603@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: mmt8jxszm8uek5nkpm374fjhmyus5xzp
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 917AB20029
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX199Izc4Wu2sdadOysGawvhxKjQW/WuNAl4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:reply-to:subject:from:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=S47RugXAVZg0mRnkOR6A+Gw2rDgqV6LC58wiq6LbeKM=; b=Z/Pb8dyoTlb3u3aJF8YPoOSKGqUp4M85nlh3kD/inRyoix6teKJqrzNd6Kxazdf04NrVbe7f45K7N+m9caX6Ubi+ggyDfH8/tp3IxacpZQQ51cP6fJx/tA2WsWjSHqQnoU3pcxlSykX9H359jdBqtOWIpEsb3vtcRb8LHi7R2swisJopN0pamp68/rEzJhND40VnxWJ8claj1wWXE1hJ02jtP3tWCRcax+Vv2ZafMdj8A0+gEJb5AFax/xrwOPZjOeeAd/yWfkoHDOw3H8FnOyXpCSSt8zDNBNH9k4o5XuqfYzafySe9TThpaLw8nKbDcVNTKQbm6o6U3+9fUdQVQA==
X-HE-Tag: 1766102019-501016
X-HE-Meta: U2FsdGVkX1/B4NsWKvWA3kznUMenn0SyN5xwMuUT7ZO2TJgeNf03ixAe7G4193jof8W/0CgDVXcgctSAI+N2Voscw4UWc5JqywF6OKEZYbZzMwsm2pwB2s8khsvKi4H5oKpE1gTd4XZqpNwarobvNv1VXW1zP2pZafdOIQwOTdZQ5zVm3PZKRrH/gP+aDgqjeuSknR00eHhrmUbWctu1x6YwXGkIdxHf8KRUJym5dOKO6QoM+rJV8BGmsSrBpfrl1nupFUmvfVHRBwH3OMdMZv8gl+mSZCkhVDXii64Y0Ydc9Bbx8gzbSQCoqWKuUY7PkPQ9q7Q4ZxXBS5Z+r7EN5ckuxbt1s9vsxqotbc5CzCi6DndPyKy23jUebrTO9FgR2G96K1mTOAo5wjFmD2LUjnSRaD9gqnMQ8V3yH+6lIbHl9ovT4ekG6FUFAnafTyX4V74KOPwIRX0=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-12-18 15:24, Brian Inglis wrote:
> On 2025-12-18 00:45, Johannes Schindelin wrote:
>> If Cygwin were merely a personal project of yours, I would understand and
>> probably agree.
>>
>> However, Cygwin is used (via the MSYS2 runtime) in Git for Windows, and by
>> extension millions of users rely on it.
>>
>> Therefore, it would be good to at least publish those local tests.
>> Ideally, a good deal of thought should be spent on figuring out a way to
>> integrate the tests into the CI builds.
>>
>> You mentioned winsup/testsuite, and I do agree that it sounds more than
>> just tricky to integrate the tests there. Essentially, you would probably
>> end up reimplementing AutoHotKey's fundamental functionality: sending
>> keystrokes and inspecting the results.
>>
>> Now, to be sure, running AutoHotKey-based tests is a lot more finicky than
>> running winsup/testsuite. In the absence of any better idea, though, I
>> would take the confidence from having tests over not having tests, any
>> day. After all, you and I are both fully aware of the unfortunate pattern
>> in the code under discussion where on multiple occasions, bug fixes
>> introduced new bugs whose fixes introduced yet other bugs, etc ad nauseam.
>> If AutoHotKey-based tests can help break that pattern, let's integrate
>> them.
> 
> Who will port AHK to Cygwin tools to make it available as a package?
> 
> Alternatively, do we really need to:
> 
>      https://www.autohotkey.com/boards/viewtopic.php?t=9806
Also, you can do a lot using read with -p prompt (example queries xterm info):

	read -s -t 1 -N 128 -p $'\E['"$p"'t' -d t r

where $p are CSI query params in prompt, delimiter 't', reply $r.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

