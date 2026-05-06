Return-Path: <SRS0=VIN8=DD=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id 8A7F84BA7987
	for <cygwin-patches@cygwin.com>; Wed,  6 May 2026 05:34:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8A7F84BA7987
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8A7F84BA7987
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1778045687; cv=none;
	b=g7bohbRS7g/xjLar1WJa/Dj9rtTJdLOsKzNPgXqRyBqHa917l/aUek1cnNFt0JChwUiHEDWQua0D4yTKO5zIHrwb1O84GhK5sl8YnEnW0MXori2Z/zGDnSq1U62EQBjD1Kcilo2RW90QNNqxUGua8B9O0tr7frD8dsBRU+mWn+I=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1778045687; c=relaxed/simple;
	bh=SbIVss3U482vALtJWju/PPjcJh2qbjYjYBo4gLHCiZM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=hU+LBYshzckOBFJ465jB2cB7U4w1L3l+bqkm5lVXpj4t7qlSDhOYaSai8Y3eFL4NpZNOK4XPrIaJkyol7HkdXVnP7blumUD6TvL+YXhz4+j0ytKNoKlH4FKE3IyJgRSKDi4LmleQspTJzDJTMHJoTzVXIt6zWvrGdrBXq0gVLF4=
ARC-Authentication-Results: i=1; sourceware.org; dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=d3NfbEzv
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8A7F84BA7987
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=d3NfbEzv
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id ECA0A140715
	for <cygwin-patches@cygwin.com>; Wed,  6 May 2026 05:34:46 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf14.hostedemail.com (Postfix) with ESMTPA id 810432F
	for <cygwin-patches@cygwin.com>; Wed,  6 May 2026 05:34:45 +0000 (UTC)
Message-ID: <8eea2f86-b335-4c7d-8745-d057176c4aba@SystematicSW.ab.ca>
Date: Tue, 5 May 2026 23:34:44 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
Subject: Re: [PATCH 00/11] cygwin-htdocs: website fresh coat of paint
Content-Language: en-CA
To: Cygwin core component patch submission and discussion
 <cygwin-patches@cygwin.com>
References: <20260419052701.513-1-johnhaugabook@gmail.com>
 <3fad00d1-a511-464e-afa7-8ba2957f6f40@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <3fad00d1-a511-464e-afa7-8ba2957f6f40@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 810432F
X-Stat-Signature: 1rjaxtm8mf6b1ufm4qih6tjbeiywkau6
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,KAM_SHORT,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18ErtEoXx5syr8+MUbcctunJgfUPROqYbk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=hL3GtaQ+0RQS1tmVLWnyA+9CN9XtPC0YboD4GQgPdz0=; b=d3NfbEzvM4MFQ27G+cxG0r+2Ur2p/+cuP9vDiZJp1n5uScAdnhCimy6Pc7yiHs7lCarD87sze216AbGAN4mMdpJLjq677kX5cSUvKEskEHlroSnA8WkY5e07Um2IsystdPkQUzI0pljdR3AIQbB06LIMIJT5lHVLEFV937VnFNvsz23AuwM+gw4APQEPfhS62y/f9w6jN7SrhnpHEN+FRqvNA8/sQtG/oxGtsUiRNXbN+etwHGe7OBRGeAnvc+iQBAnnu1LqJuI8BFR7xqUI4CsSBgy6Yh4sLcWgzKOmA01k/C/HgLbzJCFA9hfAgYFrSyJ859V3AJlA+H9nfA8nOQ==
X-HE-Tag: 1778045685-314373
X-HE-Meta: U2FsdGVkX1/S/dqbYDLcoDerHWLgHsLQdu4mveLJ14fn1opKxyco4nib/eEm4cUw0RXsXeTkxo3AU93VObI+LpouO2FSBaevwTI7XkGd0yV7bzHXfwSvmag4iZwRgHxECjj8mNnE3cge36NnErqd4Y2xUNnwtYgraJkWguxnjINCEc2udMlDp4thnlOkktVDKl+0cfyb7sWR6Y6p1UytmcsYs8MqARwXWgH860m+eR9RcpJQ4Z8S5kc3Vi8HxE09nI3cAnXvNLGBrbfhCiwRo1S6dqjUmDgUthAmpeEo6EEy9wpMB5XD9Ef1AnKVX/uejkgk/en2ouQ2asnfp2BXaUs3IHfFoFWyQ6bCu3C158zDGqw2cXf+KoTRA+KFy8WTfCfvsDt44GHNV8V8za9mNMt+WPgMTyRBqCYRmldRjS6LpnAy/oBWDtvt1dcfuUAIoop5nWJTygH2eADlvgVUNsyBW00RYreN/QtgirgLSRXT9bTPsre+LamhH07uaeOvaCEMHH1a/QoI1Jza/wijGWdWD672McfJ
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-05-04 12:52, Jon Turney wrote:
> On 19/04/2026 06:26, John Haugabook wrote:
>> This is an updated, duplicate of a recent PR. It consist of 11 small patches that
>> when put together as a whole give the website a fresh look. A fresh coat of paint
>> so to speak.
>>
>> Sorry for so many patches, but each is specific, making it easier to pick and
>> choose which to apply. The changes (for the most part) are also very small. And
>> since they are in regards to visual aspects, GitHub Pages (thanks Johannes!) is
>> used in order to demonstrate and compare the proposed changes to the current 
>> site.
>> To toggle the changes quickly press "cc" on the keyboard. The link is:
>>
>> https://jhauga.github.io/cygwin-htdocs/index.html
> 
> Thanks very much for working on this!
> 
> Sorry it took so long for me to get around to looking at these patches.
> 
> I've applied several of these, but I have a few comments on the rest.

>> Below are the details of each patch in this pull request:
>> - 0006-h1-header-s-font-family-to-sans-serif.patch
>>    - Set the font family to sans serif for `h1` tags
>>    - Keeping other text as serif makes for good visual contrast
>>    - Sans serif is best for digital:
>>      https://ixdf.org/literature/topics/ 
>> typography#:~:text=preferable%20for%20digital%20interfaces
>>      https://medium.com/the-interaction-design-foundation/the-ux-designers- 
>> guide-to-typography-7ddf87288123#:~:text=preferred%20for%20digital%20interfaces
> 
> I wonder if we should just switch to sans-serif throughout? or just stop 
> specifying the font-family altogether?
Serif fonts tend to be harder to read on LCDs especially mobile with one narrow 
direction where you have to optimize content vs font size.
In general I have always kept sizes to a minimum of 10pt to preserve my 
eyesight, with an exception for condensed/narrow fonts like Arial Narrow, DejaVu 
Sans Condensed, Liberation Sans Narrow, Noto Sans Mono Condensed, Roboto 
Condensed in spreadsheets, and 8pt for long texts needing wrapped or squished.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
