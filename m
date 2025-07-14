Return-Path: <SRS0=c0Hf=Z3=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	by sourceware.org (Postfix) with ESMTPS id AFE843858D32
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 20:53:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AFE843858D32
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AFE843858D32
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1752526385; cv=none;
	b=WyKECTKqMCa9k98zqr7Q4gFzug9It7YIo/kSfjvryqLVEapqgkETdYcvSm7ZDfJ1hrXHAr2IEBOnB8KvYLfdEzzu3NzKcIHmOzQJNpuy3SpS4CGnd3ePXziJwFH1H2h1YO5ewhNNb9iKDfHZ1PQIdS41HlLo51awVjG+lYrevR0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1752526385; c=relaxed/simple;
	bh=rx+0m6EO5ZBATh3J8XQPMMDWCvABmFNWbJu+/J/JGnA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=b9GEB8gtspsfKKTcFJm212b5O1qGEp+66ScAGOcYb2Hs4+rPLBn82lR4qqSeO3Z1hdP2ohOocWN6Z5XiIKxOM6tgQVS4uWPaxBQFAfntMiGtwJ+k0HetZBYvGDO0jx0XGttKcCEV6T/WxXB4mVFUd10pCHW/8ifFqP1ivh1c4sc=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AFE843858D32
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=VeJ0oti4
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4FBA180326
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 20:53:05 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf03.hostedemail.com (Postfix) with ESMTPA id D7E236000E
	for <cygwin-patches@cygwin.com>; Mon, 14 Jul 2025 20:53:03 +0000 (UTC)
Message-ID: <d6061dcf-2964-41e4-aba4-24d6f50a3999@SystematicSW.ab.ca>
Date: Mon, 14 Jul 2025 14:53:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: malloc_wrapper: port to AArch64
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB092300A5FEDFB941EEB3F5969248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUEhDwuvRmJVZ1X@calimero.vinschen.de>
 <aHUFzEEGq448gvZ0@calimero.vinschen.de>
 <DB9PR83MB09231FD87FE92056367C0D829254A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Organization: Systematic Software
In-Reply-To: <DB9PR83MB09231FD87FE92056367C0D829254A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: nsfh8usigx9mapy336y3nkb9y7anj8c1
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D7E236000E
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19CSWijKpCU9xRGP6sTh5a5AxblRYTbNfU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=Jzp6wnaXCaCSHmmgOLBQv/pVD7TVc2DBcfTQ7QxcEB8=; b=VeJ0oti4J7PlbdGgCbUIOSVSjdzRwiVOumNwQMD/JQYM6hshFkvGP45+LXWIdWSl2S82RkmtyYEl2tYYZeO6gJ7DjXhEvA8s1B1NXubzGecVsZjhzPT6kv9uJNnz7EYjv/1B+OPASbe4v6x82tsnzOhqELeqeqJYr/AOTnaO0MKFPOsrKOKvMLnZVsXauoGPqM0cN9SecSf2iWE9n6ZgDN63pQzMCOrL8r3MlWwqmmKjPvuCxDI3UH6Umo6AEX9iXFpKe7C8KP353LxMVH9UByNZI1nPIJ9Qic7XdXnjfjluNIp2TOaL9ohAI1KfK3KL+Gu8gOkHxGab+Fu/Xp8Iqw==
X-HE-Tag: 1752526383-35568
X-HE-Meta: U2FsdGVkX1+nbxd0CY2UuOVZBZ8dev0Wp3t6OW3RJh5c4rN2N+SdDvw+tmdSnsHOotVq4tq/pX/dCgojIhNtFIf10lXu3SF/EeZnePxlbFcZWQZSwT3GcGWQKId+edZLrJbeRl/US7+Bvh0BWE0lNkcL5slXRUURgR3Km3Yhnk2Gez/fMOe/jQh5Jb3Ex7zpsq6uRuCNqx57AKHrdgKU3I0ydflaQ5ifxKii8gJnITLdFMPzTBf3qs8jkgjgcylE9narQ8g2i81nevi1/rbib0NmDbRd5gJed4bM0X8KGf/8+KWF8gFQE4MoH9vTzhFhfcoYncKE5YDlJM2TVSeD4rS6M2MhPo38W8GMwMydN/hsh7GfkjpSUQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On Jul 14 15:22, Corinna Vinschen wrote:
> On 2025-07-14 07:59, Radek Barton via Cygwin-patches wrote:
>> Uh, my bad. As I need to manually edit the `Signed-off` headed in the `git format-patch` output file, I have done the edit, copy&pasted the text to the message body but forgot to save the file before adding the file as an attachment.

You can avoid editing by adding relevant trailers at commit time e.g.

$ git commit --trailer "Signed-off-by:C O Mitter <committer@example.com>" \
		--trailer "Helped-by:H E Lper <helper@example.com>"

[adapted from git-commit(1)].

>> Sorry for that, especially to Evgeny.
>>> Sigh.  Actually I shouldn't have done that.  While Evgeny is the patch
>>> author, the *attached* patch has you, Radek, in the Signed-off-by, and
>>> that's what I now pushed.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
