Return-Path: <SRS0=x0C8=IN=SystematicSw.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id B5DB44BA2E30
	for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2026 02:03:24 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B5DB44BA2E30
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSw.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSw.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B5DB44BA2E30
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792721005; cv=none;
	b=BhtIP4HuW7oNzjUx8fhbfkoM7i8HErLm2jISF2qeHFIuHKaM4ug0L3CMlgp6XCSBUsBualUQD90kIHJD7mVMfUWG91sTguv31+MFjYy7B5h0Q06/G3xYZXl/iqSQxxTSVMH4VT0ws3BL3yXl64J1oPzu1kk7ZRctDFpc69lDhXI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792721005; c=relaxed/simple;
	bh=Zzoc/Bl0cDV8HQFtOr9BfCzEG2op+hckUi4/hfiknPE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=uX/ktfK7Mk2P4RouhZQOggZdtoHw7r5yZIhu7fu0ws2IsPh8G40R2c+Z+r1/I/EjH1YN5mUgP96h/KWim7c/9xW+jpn9RQOf2S7KbtyVwW9PThUEc+IMInu6JMjRRNIgtgrmlx/J49O8qDlgYO+0wCRgQeYOT/IjU3fVIl6ib7Y=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSw.ab.ca header.i=@SystematicSw.ab.ca header.a=rsa-sha256 header.s=he header.b=PN8g0rDE
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B5DB44BA2E30
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSw.ab.ca header.i=@SystematicSw.ab.ca header.a=rsa-sha256 header.s=he header.b=PN8g0rDE
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 5788E1C22DA
	for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2026 02:03:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf18.hostedemail.com (Postfix) with ESMTPA id E019F2F
	for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2026 02:03:22 +0000 (UTC)
Message-ID: <afdc1d88-4c58-4fc6-b2f2-4105b0f83c08@SystematicSw.ab.ca>
Date: Thu, 22 Oct 2026 20:03:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSw.ab.ca>
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
Subject: Re: The meaning of "Signed-off-by:" in patches
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <636bc5ac-7500-4d18-966d-ffb73d87da3c@dronecode.org.uk>
 <96aba361-6358-403e-b2e8-a9f39000f4a4@SystematicSW.ab.ca>
 <e9b5add5-05f6-4911-95fc-eca7384aa195@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <e9b5add5-05f6-4911-95fc-eca7384aa195@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: bfxpgnakq97zi5wcur1cho6yfkhsiggy
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: E019F2F
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19rPw+24hnfmegEX44ICWeg6/or1a7IVy8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSw.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=j4WB6ABirXGmqBaAi526POROASdUbEbng+kId9v7El4=; b=PN8g0rDEqkWFZ332FbfYvGnZ7IdEjCDOHoNtHMjX6QDidF/uqDBukhTZaajQlDHyaMfojaK252JtBUtWhLGd22pimFxBR/3He/QyjnXp8SRud8Ca+bDvUPgeUVxdMv3mIU+zMG+nOoLOqYFLR5/3Q8NmYcIc38y6LH92soacDmiAgnzW0T0l1aeDDdNQk6RFzsAJ5upTfiGN0QekgLt3K1PSqMNg0dqIuceQLRbta6yd/DOXTxxI7jFBe+qCvunAs3/JJxwxqcbEeH+jtI5fmMpM/YlLnZ5iKLNE5j0nLaOAEsJwIYrRjiR772h3Kc3sswcREWtWkZUyxmsO/+kpkQ==
X-HE-Tag: 1792721002-507820
X-HE-Meta: U2FsdGVkX19m4Zw6tIh30pgRrq7htOVqNCMnHBKodQLngEOBIJzKFYaZX+nO1x2+uA8XqjA9nXMrvZzg3CxOZzjOHkSORrlPGfCNeQLoJuacvXgqFu5daMoq5TWJ2Rh199FsNNRjPOTEM8YfDDF3YT9s7Eo/uHQgWEFLpblUy9N8cceVs6rcqGKP0St63qAGxv3tvXGutzcBr1qj0knyIbQKWthcp/b325r1nKYrvyxot7BGF77AvCiDbSuOdk9232Hmx9TSTf5AdKBh3m5Fu5rXLRk+BV4xIaLpMDHqzpqUnAawZxAkGBPzNfgePgKAOUe7IEeK6uxuayrYArs9iAoOirYwFGZXjd9Nf0AOC8F6GZCvXf1GiQfBuxsrABxDdjBTfiU7QrUdOm+hZB6rYXlpe4zXBr045bhSV3ho5TH4gy9WLmUeXYPIt3wW1a02tw5pR1LtWUZE2J585VUM2HFr51m4tscs9RGVV+okBclZB0zlJCBAZvEQH6mjou9JL718T1P4SaI=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-10-22 10:22, Jon Turney wrote:
> On 18/10/2026 18:53, Brian Inglis wrote:
>> On 2026-10-18 04:56, Jon Turney wrote:
>>>
>>> I've made a (long overdue) revision to the "Contributing the the Cygwin DLL" 
>>> page [1], to state what we think "Signed-off-by:" in a patch means (going 
>>> forward), by reference to the DCO [2].
>>>
>>> Hopefully, this is uncontroversial and unproblematic, but please let me know 
>>> if you think otherwise...
>>>
>>> [1] https://cygwin.com/contrib/dll.html#before_starting_legal
>>> [2] https://developercertificate.org/
>>
>> Ignoring the DCO Copyright which does not imply it applies there, but it
> 
> I don't understand what you are trying to say here.

The copyright is (c) Linux Foundation, which was confusing for me, and required 
re-reading everything to be sure what it meant.

>> would be worth while stating something like where the DCO is applied to the 
>> Cygwin project, authors, and contributors; also newlib licence is
> 
> Sorry. Rather than being explicit, I assumed that it was clear from context that 
> I am only talking about changes to the winsup/ subdirectory of the newlib-cygwin 
> repository.

I think you have to be clear and distinguish here for new contributors.

> Yes, as previously discussed ([1]), we should do something about packages and 
> ancillary programs in cygwin-apps and everything else, but that is a task for 
> another day, and preferably for someone who is not me.
> 
> [1] https://cygwin.com/pipermail/cygwin-apps/2024-November/043939.html
> 
>> BSD, but Cygwin is LGPL3+?
> 
> And?

We provide a BSD release which covers newlib, but should not really be necessary 
for just Cygwin winsup, should it, or is there some other reason?

>> What should we be doing about GnuPG2 signed -S commits?
>> I could easily add that, but unsure what the infra and tooling is like for 
>> repo writers?
> I don't think there is any reason not to use signed commits.

So we should recommend -s -S and the other relevant headers?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
