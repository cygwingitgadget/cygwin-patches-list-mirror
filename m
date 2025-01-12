Return-Path: <SRS0=yEkE=UE=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id B6C893858C48
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 20:00:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B6C893858C48
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B6C893858C48
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736712016; cv=none;
	b=aFHLLnQDqIRRAsGJ/wwDGup9igGRwjlGu+tu7gdk1CuKcoJo9bu1F8z37npFCTdmQyH7/ghkAttwpYj4C0EdJSSdTfDhHL+Jma4bRc95KHoDnRe+eqMew42hMr4rPjUUxZ+ogWTSGs8X5DUKyfG9nmpLNZHoo1N5fSbUxInrAgg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736712016; c=relaxed/simple;
	bh=lx57NnIMqSroJfyUqVzGu/36PiXrV78EdPxoM4c5YyY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=Yc2XUJXgg5zxrJc+3FDhkCAdPMCUL4ALze27bgu67ARLlerCq9Ghm4BabDjxoAXihnWmb55QwuqUz6x6LFmf79M49w/8NYs0i2h8zAk9SMfKNwLc2w7UJHD5H7IElD9n580kt49q6hMZYzOojq1HbLNT35O832xt9fUngJVM2YI=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B6C893858C48
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=sau0y94J
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 63C81140C10
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 20:00:16 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id EAF3320027
	for <cygwin-patches@cygwin.com>; Sun, 12 Jan 2025 20:00:14 +0000 (UTC)
Message-ID: <f714ff40-1b35-42fa-bd26-7eb0c1ebc9fc@SystematicSW.ab.ca>
Date: Sun, 12 Jan 2025 13:00:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5888275d7f48a4418cded1b292b8951506240073.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <32ee8a55-416f-407f-8c33-655718b667bc@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <32ee8a55-416f-407f-8c33-655718b667bc@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: EAF3320027
X-Stat-Signature: ckmk4a85nsdrxba5arzzdwewctoqbrcb
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/KHxrcl9LLSuun5ixw60Jp1Ycl7tErcIc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=GdXLPEZVDiumXpiXpOPTOwxu52zOnp86pqbiJPG5hSA=; b=sau0y94JysIi5fE+fGlXizYpCWX5ncVuH4ee5aQy38NByvM2cKtoQk57lGwxXqHNoftLh91OxMmyxnH4IpYJd/ynh5KifUgzfahO6WzaY3kGyQT9n9F+I/IxNTGkWIFu69fje+uUtCa/X1B2FVrrGRgy6rEISAZvRrfxtXrhQMTyyJolUNvva+JAJ2OC4BNvCmTOUBnCPjtTMiigUmhyohrNKH7uuESSI09Jb98hbmWOS8EvKnyqpTuekB9uXJz/xnUsKiEHYIUkIybNQpwrhS8gWRyXQx6zRNTBZ/z3y4PQBwoLCl6pDp8TPBBDsesFOy64mAE2tunnL7G4RTvr1w==
X-HE-Tag: 1736712014-600124
X-HE-Meta: U2FsdGVkX19fkemgYHrJziH5jDYxWISLLJxv3XVunYiJv3L0Lx/uKRd+auFPx1sTHjQgf22wnRX26Sal1Cdgn08mEYups15hABfKVfNkjAflu43/pUpOak7jcNqFa7oH2/GS3rbuugeSkm5hNy2AqOT5feym31OxGK7b6b6mvajLbzrokjA6u/Fp/P8dH8r7vBM4PCUGohl2Px8DfePsbFoTCSTU41YLgQ5k7l2dhM98Pe1qhoxN9w8MltvQ5h5SOtloJl+s2i16vaE+R01Cf7+bYlsG+iBx5nELWJwI8c2Lk5+MMU9ZPwyT8TDr8K0COFRTeNvskFMYDGPYgii2EWlA7gzfntlW
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-12 11:04, Jon Turney wrote:
> On 11/01/2025 00:01, Brian Inglis wrote:
>> Move entries no longer in POSIX from the SUS/POSIX section to
>> Deprecated Interfaces section and mark with (SUSv4).
>> Remove entries no longer in POSIX from the NOT Implemented section.
>>
> [...]
>> -<sect1 id="std-deprec"><title>Other UNIX system interfaces, not in 
>> POSIX.1-2008 or deprecated:</title>
>> +<sect1 id="std-deprec"><title>Other UNIX® system interfaces, not in 
>> POSIX.1-2024, or deprecated:</title>
> 
> Maybe we've reached the point where this could be split into "System interfaces 
> deprecated in POSIX.1-2024" and "Other UNIX system interfaces, not in 
> POSIX.1-2024"?

Or just drop "deprecated" as these interfaces have been dropped from POSIX 2024, 
which is why I moved getdomainname to Solaris/SunOS and added "(NIS)"!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
