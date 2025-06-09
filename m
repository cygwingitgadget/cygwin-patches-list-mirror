Return-Path: <SRS0=6Xew=YY=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 005FD3858D38;
	Mon,  9 Jun 2025 21:46:02 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 005FD3858D38
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 005FD3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749505563; cv=none;
	b=DzF6YZkHlOR1SiQtqDmBEcJ7wVk10FzKUefFM9iEtTlzyP6PX5Pw1rFturtNoUc5o9mP6lCpt8atux1y8q9th1IjGy62wLX3b+MEAkJLlNwaCssWMGEfIXyvUywlzZX9uJM8P0JKJ8uj9KVXfbfe8QZT5msSzNINmvII2ri20Xs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749505563; c=relaxed/simple;
	bh=/TwhiDsosg3KrCFfEgWlrNiPP2fzY1L20XD0elrImUM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=Lr3LuwQujCMmXI9cYGcTxKARmoRD7di9LrBQgsvg1ZWPfJE06pKeH6cIS5NqTxfqgUKTTcRDuxXmR+zulpvoKjWEHaft29SU+7PEU1oENd0muZJUM2boDq+1JM9kq3J4lJfGypEkqVuPyG5NunX1eXhjgysB/xi1yJynC+Zu+7U=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 005FD3858D38
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=TdtujExr
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 87BED14037B;
	Mon,  9 Jun 2025 21:46:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf20.hostedemail.com (Postfix) with ESMTPA id CCE2B20027;
	Mon,  9 Jun 2025 21:46:00 +0000 (UTC)
Message-ID: <4f39b6ee-c8de-47f9-a48b-1bd0524eb987@SystematicSW.ab.ca>
Date: Mon, 9 Jun 2025 15:45:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-apps@cygwin.com
Subject: Re: Updated: w32api-{headers,runtime}
 mingw64-{headers,runtime,winpthreads} gendef 13.0.0-1
Content-Language: en-CA
To: cygwin-apps@cygwin.com
Cc: cygwin-patches@cygwin.com
References: <971dee8b-9df9-4aed-83b5-0d04afcb031c@gmail.com>
Organization: Systematic Software
In-Reply-To: <971dee8b-9df9-4aed-83b5-0d04afcb031c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: yntjt3jwgg4r3gdjjaytidiyk6zqtxiu
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: CCE2B20027
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+GF3VUswvANMbp+q0s+QwZArXvOztDPqQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:cc:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=itTUFq0+A/3P7HSSA7RhKi6iyNKofwX4sZlhufR/Ev0=; b=TdtujExrugPnoeSXGgrnfBK6asTAU23J8dJB1IhPL5JoKV7bfh0yp9Vo4NQQJHzcYARiovSgWnWmEYhZ+5HuEI6xQgBZ5nmEw8gA5MVn2xd2C17c3MBlKKjdC0eB43VBuePSz6pbxnsneeOyFUmepEoRx6IcTWNmYvFArhdp/jwv6F2rTGZ8TtEqNZ9uPTmh/ukxrVi5ONiS6CY5uJkEDwYtCMiBMnMx3AqGwzmTUuXTDo+x3ibiZb4Vx7Aj5KKYs4tpbNHMwKWw3Kxn23+ET+991PAAStuZ4MFlf+bgzHHotTTS5G/rVIlVbX8FGhqHX5LZEgfFSP/eTzG0sQoGHQ==
X-HE-Tag: 1749505560-467685
X-HE-Meta: U2FsdGVkX19alrAyOOiLzkoPP81Re8Y+g+yirYM0G0GqWUcteVe0xskBM/lkBNH2/wV/U6clNqv6Ja0uegoPxn59oAtnMHXWBoVYT85Zp5xWvfw5UolX8GXhgdxIblu+D0mzQodAiaOv2k54YPNwJnZrDQGKokfs4PUV7loSR2M8CKtnSzzWfREdJ3YQG9rOTkABCJe7isqnCsACI2prgS/EmNO/Rsz0+ynktLn0etH8/9cGXxD6T1vHoKATHxVXmNmm7I0ALS9zIi3a7LZHL3vkCLZz//U1OzId37ec8fetzbTVbpB0V8n/9pnVgK7lBhzR7bbbo4WF2XOrkcNxARNczC5x4M8ry0rbYgl1Gd8J1i5K85EiLYJe4DRjG532cbXBwl+1YIh+xW1phy7+iXUotXyG0BCClEuZmDbJ+zR+K1sXZr/oyUVftOGJkvid/J1CuudGLbc=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-08 06:04, Jonathan Yong via Cygwin-announce wrote:
> Now released for both 32bit and 64bit Cygwin:
> 
> Notable changes:
> * Added import libraries for msvcr40d.dll, msvcrtd.dll, msvcr70d.dll, 
> msvcr71d.dll, msvcr80d.dll, msvcr100d.dll, msvcr110d.dll.
> * Better CRT API consistency between UCRT and MSVCRT, making many APIs available 
> to earlier versions of the MSVCR* runtime as well.
> * CRTDLL stat API fixes.
> * Updated Hyper-V headers.
> * Synchronized with Wine headers (from Wine 10.9).
> * Many other new win32 APIs.
> * Fix _atexit call differing between DLLs and EXEs.
> * Basic support for ARM64EC targets (arm64ec-w64-mingw32).
> * Make it possible to build winpthreads with MSVC and clang-cl.
> * Many small fixes for gendef, genidl and genpeimg.

We have reports of failing Cygwin builds after this update:

	https://cygwin.com/pipermail/cygwin-patches/2025q2/013754.html

https://github.com/cygwin/cygwin/actions/runs/15537033468%C2%A0workflow%C2%A0started

https://github.com/cygwin/cygwin/actions/runs/15537033468/job/43738461428

Was this upgrade tested with a current Cygwin build before deployment?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
