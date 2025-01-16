Return-Path: <SRS0=CW6W=UI=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 867623857831
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 00:23:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 867623857831
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 867623857831
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736986984; cv=none;
	b=nIFYsKFe1odBBRVl2nuBLHH44yM/yF15LJKjWPQKfQO5s94JV5wnF9kH0Wsrqm3Wf3FdhRbokOcSxeL+LVouCRnptgTcKy5C6LV7TiTM2mkILNhTsRZNf4z9Wf8I1fvLyRwGLV/Xq33bw7kB3sSBFVpYcedBgng+WBD4FlyBSuM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736986984; c=relaxed/simple;
	bh=ozURcaKweROVh6tPpgKyWoqbmL/dK+SbViwDtEjwZN8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=PQ9aE0mt2kEnVqYAWpZoEouYy9OPRjSUCJ1CpEnwnNK0DsCIyt9qwIfxxaI3ygiNXI+Nq0WTpLZgd5l+bBMzZd9NvRuzyK555kb9W/BiR6xh4PngaUycoSbgLEA2pvIZ4yb/XEPlzU3xqFxuciqWhB0HaUm5uG8m4cdUB7Jaf0I=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 867623857831
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=jsmrslh/
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 3953B140477
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 00:23:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id CAF3420025
	for <cygwin-patches@cygwin.com>; Thu, 16 Jan 2025 00:23:02 +0000 (UTC)
Message-ID: <28d690d6-046a-414b-804a-4cc9580752a5@SystematicSW.ab.ca>
Date: Wed, 15 Jan 2025 17:23:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v6 4/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 move or remove dropped entries
Content-Language: en-CA
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <cover.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <6da73f73a786a556d4c7be93ed05bc50b268bb30.1736959763.git.Brian.Inglis@SystematicSW.ab.ca>
 <4434e97d-ce1e-f05a-c06b-405f6b2d67c7@jdrake.com>
Organization: Systematic Software
In-Reply-To: <4434e97d-ce1e-f05a-c06b-405f6b2d67c7@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: tubd9pm5s1wf3u35h7mkqf9q8se4fifi
X-Rspamd-Server: rspamout02
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Queue-Id: CAF3420025
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18g94uoY8t1wdv0XTg0Di6feojHZJMgyD8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=5hfE/UY1xuev+MVwC9bNlJuunIn7uU+Z7/e0YoKd1dE=; b=jsmrslh/NwgmbE17g/h48fgcrDlTv/IpDt1j/HmB6Fe/6DRAwNcGdJ8yVGYXir4hE1AmRAD/rlM8KFujdaa4Ly/tCOvtr93L5dN9Zz/foGopwvV5QexOnbp/rAx/RX8sCgG1fXCuuPH7QCpuV72tpNhjhMDk3mabIVp+xqYIWrHLDxhCvC/iUKh/u30zlQ/onIQHBynU3F8HGHcQ0kilwubZUp1UHmWHaUm2RSxonn1n+PPcS7TnLnPG+CYAdW8lHresIXa60kQ+QBkeGXwjHnI/T3rWjnRlAxM7pA67S/jrB7507Ed+tbjkrNS3148L1FJIsVFicbrh972lQJBA3g==
X-HE-Tag: 1736986982-547883
X-HE-Meta: U2FsdGVkX1/6ha1RqX4GnnJxKJonHQem+feIkqlJP0IP6rqMu+AYT0FGEa2/6rfn45LU4BaMIYWNmdJl4TUOZ3Qcrf/mjhcE8Gk9dSOim1A7Snrlg0h+RBMghFBtQVlzUod9vpiNuEP79rRw1rxAZ5KfQp/ZdMpR0I7leLt8O7MYdxau2vaqVFNb5/Hu8Qq8lv+2QkHg2CoOnscAJIqIsiFGcDa0Xj3rPGP89Q8rATj1IrP/zBQC68VxVDEnDp7Wb4XRVOzue2JZ6A01yssUIgRMmsI2xHF0Wr3hfwu0ADm2BwVw8NPmA8z0gVp+noH6dWacFpwQyICJ5XS9Msm+iQWsbyujy959
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-15 16:53, Jeremy Drake wrote:
> On Wed, 15 Jan 2025, Brian Inglis wrote:
> 
>> +<<<<<<< HEAD
>>       isastream
>> +=======
>> +    kill_dependency		(not available in "stdatomic.h" header)
>> +>>>>>>> 5888275d7f48 (Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024 move or remove dropped entries)
> 
> Conflict added here, removed in next patch (5/8).

Thanks - finding limits to interactive rebasing and cherry-picking - and that 
they do not always work as expected, or smoothly!

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
