Return-Path: <SRS0=HUyh=VI=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id D6B1D3858D1E
	for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2025 12:35:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org D6B1D3858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org D6B1D3858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1739795757; cv=none;
	b=L493CMpN6zTU8GGMHzLcOREXioNMLmuyXBx54P1I7mpCthbVYdMbG8wYVp2fZI/cIdUNaKegbil1MRbHM42VQU6NojNbJDXUFUlCV6pWROR7C14wBZmQAlu0QhwhDB5R+5dkhiPGQDXiQ3cZVebGALdE5lL2xDan9J/ap9Kp7pA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1739795757; c=relaxed/simple;
	bh=T7TEEbnnugEXossNS0K6MxxDBX/aR3uiIo9g6hScfE4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=XdnmqQTFLCqqR0w6ZVQlDJELq/li8K6DXwdvEwWPBAkP8BZ5AZf86Tg5jE1ie7Ejm/1IAWFFdR7GITgYlZfmfROqfa3ixR87KEowOz8AT67pNnc3MjyIEUFbU04W160JJTS6r3GdTpS0gl0XyWTuDgI/4ADa77IpJN16b/D7E2U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org D6B1D3858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=LUP2CqmY
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 22BEE1601EA
	for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2025 12:35:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf06.hostedemail.com (Postfix) with ESMTPA id A639820016
	for <cygwin-patches@cygwin.com>; Mon, 17 Feb 2025 12:35:54 +0000 (UTC)
Message-ID: <2524d5ed-8a94-4df7-8ec6-4d2210fe4903@SystematicSW.ab.ca>
Date: Mon, 17 Feb 2025 05:35:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: Add spawn family of functions to docs
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20250216214657.2303-1-mark@maxrnd.com>
 <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
Autocrypt: addr=Brian.Inglis@SystematicSW.ab.ca; keydata=
 xjMEXopx8xYJKwYBBAHaRw8BAQdAnCK0qv/xwUCCZQoA9BHRYpstERrspfT0NkUWQVuoePbN
 LkJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3RlbWF0aWNTdy5hYi5jYT7ClgQTFggA
 PhYhBMM5/lbU970GBS2bZB62lxu92I8YBQJeinHzAhsDBQkJZgGABQsJCAcCBhUKCQgLAgQW
 AgMBAh4BAheAAAoJEB62lxu92I8Y0ioBAI8xrggNxziAVmr+Xm6nnyjoujMqWcq3oEhlYGAO
 WacZAQDFtdDx2koSVSoOmfaOyRTbIWSf9/Cjai29060fsmdsDM44BF6KcfMSCisGAQQBl1UB
 BQEBB0Awv8kHI2PaEgViDqzbnoe8B9KMHoBZLS92HdC7ZPh8HQMBCAfCfgQYFggAJhYhBMM5
 /lbU970GBS2bZB62lxu92I8YBQJeinHzAhsMBQkJZgGAAAoJEB62lxu92I8YZwUBAJw/74rF
 IyaSsGI7ewCdCy88Lce/kdwX7zGwid+f8NZ3AQC/ezTFFi5obXnyMxZJN464nPXiggtT9gN5
 RSyTY8X+AQ==
Organization: Systematic Software
In-Reply-To: <Z7MNyLzVvY_Mm_bH@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: 14dy1ajciiaxab8qejqeuu6dwtmcuzoj
X-Rspamd-Server: rspamout08
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: A639820016
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+ngQinBCwqmVA5ezFdMi4AWoeRBn1MpJ8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=90lYBW3XVuIF/bcOHxhH6Cf+7U7oNplI6GC1Y0SxDTA=; b=LUP2CqmY7efMErxVmjysUIefsJQYVexOwNEReL0lV+p6BF4FOGHgX1jvjeyJE/eQF3Hl55HkoQewi398NHY2Ut3KvfCVQPHn3VF+jqWDP6Pw0WCjvlTgvsc/lMEWD4QI83J1evp9LaGLr1xmexfkFGY5JT/6rVa9r5rz03PBUo73xV8+Q4l0N64weU45uiKPq9BprfR8lomNm5+4Yt3DFs7+g33fxJFcQOGuEjgiiLFNaMgpHy0yBXu05mN5c/qXfTwSCJ8tshhiWUzAqjacMFWYNPckgG6oSeVoOfmxPOSzPFxVOIa8A5nSlgs9Yfpz7sIyeQCKpvr6BJUTFLuGaQ==
X-HE-Tag: 1739795754-295674
X-HE-Meta: U2FsdGVkX18xh/wdw0fKBlj94TXnlIFTElt8yIEmiWwvBfWCGA8kwooT4/AlTpvWyQowpEzGj/1dsqGlpVvukKP3dN2mbflQG/r5pq8Ov5mdqG+xZcxc6w+nC2RFl4fO5VGqwpGxn0a3iYAF77Nxu0h2i4+qTTQ6E58b9wReuYs1mMt2fDD3uwspw6ytwbfdfDCbcJBLzd+PawBGitRKW2+rTuzgAMwNGA7sBiJ4U9D9MMG7LkI8b7E+DlAilblGA+fDlyo2BTcSaSZfSKmUY8iJ/2VTG8MNeW/H0DL+Dmv5rg9NNcTpCiKRjXouWsE9iFmuthN4MNrjj7c7qFqT1SIAn7f2aGNi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-02-17 03:22, Corinna Vinschen wrote:
> On Feb 16 13:46, Mark Geisert wrote:
>> In the doc tree, change the title of section "Other UNIX system
>> interfaces..." to "Other system interfaces...".  Add the spawn family of
>> functions noting their origin as Windows.
>>
>> The title change seems warranted as neither the spawn family of
>> functions nor the listed clock_setres() function originated from UNIX
>> systems.
>>
>> ---
>>   winsup/doc/posix.xml | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> Yeah, this is probably the right thing to do.  I'm jsut waiting
> for Brian in terms of the POSIX doc update.  That's why I wait with
> the eaccess and acl functions as well.

I'll resubmit some time this week.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
