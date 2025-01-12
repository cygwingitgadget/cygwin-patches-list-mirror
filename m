Return-Path: <SRS0=yEkE=UE=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	by sourceware.org (Postfix) with ESMTPS id CCC403858C48
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 19:57:13 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org CCC403858C48
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org CCC403858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736711833; cv=none;
	b=h6uvj5y1YGftbMat0fD1jZnahnADym71wP3E7UqjW9tXOY8jd30eGvvA0wxog7gyu9RZHXVwiMf4BsOo//G0ETyVJTM+onZhShxZ2msAcjG9quknwOC1nT+xtBehl5rEFSmHbimhy3iCVrH8Q+vGpXeraVkeBfaPntntqJd9vCQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736711833; c=relaxed/simple;
	bh=t77PeZJeTe2U5VuBJITcO4HFU9+kN+z9XoLp4HgcgL8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=nEb4yPb3AsV+wS2AxbMuU0aCR7tdLHN5F9Ymwgf9mqC8G8VrY5iKY2M6CWotl18NuTRZI0SRayqA7791bjvE+IbAK8hpSRuMbFWzEL8ovKx59Or5IZnRR6DhilB7GWndc2xeqOxb54/jJf83Y4w9oYwK2pHY06o10+yTH/DRoO0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org CCC403858C48
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=KV6Fhvo7
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 57FAF1A1A44
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 19:56:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf10.hostedemail.com (Postfix) with ESMTPA id E9B9A3D
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 19:56:37 +0000 (UTC)
Message-ID: <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
Date: Sun, 12 Jan 2025 12:56:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9B9A3D
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: z7rcj44o74teqet9cwuxszxm8b46635a
X-Rspamd-Server: rspamout02
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+TFWPAKOpmcYVBUnFNnxP1KrdMxwYkEFQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=ZsZLctaLuoLDh8o9Lw4k0nSsnhxd+VwRb+vcxj9ZqW4=; b=KV6Fhvo73gTt4AMJXWFBY7m3fhq0Kxs9PNgI9LPQovsIKG52Ru3/kqClUj0D5+NVLh6OsKf1RuS3+LXLzs4xj1+Lt5PwioLCudr0Q22Am/ZxeoUt+Gpc+pnQTuxfgj0bYsYBqaNQXHVNOom0L3hgVEunNTgV4BhpbuOqdD8PYP7iNvlVKe9qjuwSA47PhU4JHW7bHvpjTvNNiNQ1IWPASEIgLRtFK3tOeI1PlnKKw5XUzyvGx83uO3Ztx8HfqAEEEQSo8yI0IIkwPt8rWBNULOD1NRRWlgk+y6eGu85+I8AnFwbXxolECDoqlNwMPZbFCCuEPPkTzK3hGMoQGmBT5A==
X-HE-Tag: 1736711797-718539
X-HE-Meta: U2FsdGVkX1+5f//I9ECDI0crkrLi2amOucA7Nl1ItRA4R5mIepweaeGJPpas1VojGTedpumtqwEuodr2bKNGZTpgyZoCXCyQaDPG70RPHeQhW3MYqcCOLbyS0V2BhaljvGKqDKUEXz2jiE545SgwgfCTiKteCuRYa2Ve/cwzOZM3ELaJAlLk5ISRNOv2hH9Y/xFcvqafLcdFPSKGbvb+CV4Ad3sBMkzGQ8SkoJazvXlPJPP8/PgL+BAQEYXmgV2SkBj/JOc7YvQJQ0QTv3t73qYJxBH6UMsvfEZIQ4aq3JoROGRpekrBowt2fK9U9gYySw+OIip3bq9/cc81mB8OwqHnTEPiOw4T
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-12 10:58, Jon Turney wrote:
> On 11/01/2025 00:01, Brian Inglis wrote:
>> Add POSIX new additions available with din entries
>> or interfaces in headers and packages.
> 
> What does 'din' mean in this context?

POSIX entries which exist as exported symbols in cygwin.din but not mentioned 
elsewhere in posix.xml, so supported but not yet documented as any Unix interface.

Suggestions for better phrasings of these welcome.

$ sed '/\s\+(din)$/!d;s!!!;s!^\s\+!!' posix.xml | xargs apropos -m man,linux
getentropy (3)       - fill a buffer with random bytes
getlocalename_l:	nothing appropriate.
in6addr_any:		nothing appropriate.
in6addr_loopback:	nothing appropriate.
posix_getdents:		nothing appropriate.
timespec_get:		nothing appropriate.

Also is anyone aware of a good html to man page converter to generate Cygwin or 
POSIX man pages from HTML sources available, and are cpp-reference GPL-3 
allowed, or should we prefix the function source with the man doc and generate 
it in newlib?

Looks like getlocalename_l doc needs updated to POSIX.1-2024, added to 
locale/Makefile.inc LIBC_CHEWOUT_FILES, and locale.h feature test to 202405L?

Could CHEW doc be added to cygwin/**/*.cc or elsewhere?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
