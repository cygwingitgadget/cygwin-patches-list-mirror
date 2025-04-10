Return-Path: <SRS0=GeuV=W4=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	by sourceware.org (Postfix) with ESMTPS id 0B33D3858039
	for <cygwin-patches@cygwin.com>; Thu, 10 Apr 2025 21:39:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0B33D3858039
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0B33D3858039
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1744321157; cv=none;
	b=KoDrtToB+sH1GIOwnkZep7I8d6eDgA4VIcBer+vEaf/n7tJvM/KhKgEC44VFmO3pClEYAzvCL4QDoZX5KUd/hLu34otpQ7fz9xJj137RSb10FuzYh+IHOdHXQbbRMkdRO61O11qtAkW6PUAxMQyAZpeBuaQMv1I8LrFYbWfqtiI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1744321157; c=relaxed/simple;
	bh=1bUiMuBjgrX5eSDwLLjuilNOfkjE/ZSEsr8yI1vDobY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=Lt6cN1UTktLEJZ86c8ppk6QgXvlCup4YjIXe5jv/lERg0n+5SJrNeWBoMVKqEngX+PT5dWlgn0oq7SkvnT3I87Jqwtv1Jyz8/1c9gZ/HRE1Xf9z2pHy6UNNQo7iq3EX/z9Va85N0hFUJdHxscLXfvnwshS9KNxU68geFb6WHeoo=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0B33D3858039
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id A8D9C121535
	for <cygwin-patches@cygwin.com>; Thu, 10 Apr 2025 21:39:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf07.hostedemail.com (Postfix) with ESMTPA id 3F2F32002D
	for <cygwin-patches@cygwin.com>; Thu, 10 Apr 2025 21:39:00 +0000 (UTC)
Message-ID: <75e51a8e-8c25-414d-905a-60b380d939d4@SystematicSW.ab.ca>
Date: Thu, 10 Apr 2025 15:38:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: compiles fail with sys/unistd.h ...inline... setproctitle_init
Reply-To: Cygwin Patches <cygwin-patches@cygwin.com>
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <f34666fe-f8da-4364-a5e7-b2328b2f1c80@SystematicSW.ab.ca>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <f34666fe-f8da-4364-a5e7-b2328b2f1c80@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3F2F32002D
X-Stat-Signature: wern7beo7yd9jj5qf14yb1iwem1y731y
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout01
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18otI519z6zbG40Wr5OIeS/lv2aMAeNgGk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:subject:reply-to:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=zkVCH6za/NDPakuhKH2esZG2EJyfMw3xb4O5W5AC3uM=; b=iukZ1/N/nOuCMjxxX2XYU5kfNz8pnviNMz28seg1MduQDJWSp/JotyPBwAkiihH6XNMjqCy3B549Xbkkkipfe/SIe0c5JN4L7tHmrfARDqU6NSZMBwOsoakltW2/OQEdo/gCHCQcJ8knwEZw4cfutNQMjDMPgS14Sb6NwZKOychyPQs0c87hvHLqU5W0Ho9feNfGwXjRqgEeThJavZnukShKa3ga7jSbp5T2bQIrvS7aix9PJD7h1rlLyO90hp33PbCZnk7E7fxM/CxHirB48ZQrvxClLEqC9iF+IWv55eHC2KGM8AJe6aln+rDNZVjOgCcDbYhSmYmYyCPqyF2mBQ==
X-HE-Tag: 1744321140-819956
X-HE-Meta: U2FsdGVkX19AuCYEBFsoW9qfyUhA1pMKOULk8pgpgRx1R3xXoTMZ9g16rcNEUC/Vdc/3fipbj8Q7HMlIpMVyMww29YBC1Wc6k5WSOSmYhJaOPsjW4nxI5/sdo5MBWrnWplP7Pi0l+u2cgbY9fV0sTgPikgPeSnlBdfd+C9r48A/KlN6h7sAPOwzk86uXRlzBZ+knHExYAJXbffMEpw+suUPhNzv3sFyEGQVC+bKLAEt0xjFjTWboh3wh2h0VVPCXFooDJunVjI0mzSDFrVPRZ3RIGyv5vYtmOcLkJeY5bviaio/Ke4ST2dHTTZLPcQ/Ey+u8AOS+0+NCDjfv83ajCix1/lLsCQ/L
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi folks,

Latest c-ares build failing with gcc 12.4 and Cygwin 3.6.0 header:

$ uname -srvmo
CYGWIN_NT-10.0-19045 3.6.0-1.x86_64 2025-03-18 17:01 UTC x86_64 Cygwin
$ gcc --version
gcc (GCC) 12.4.0
Copyright (C) 2022 Free Software Foundation, Inc.
...

/usr/include/sys/unistd.h:218:14: error: expected ';' before 'void'
    218 | static inline void setproctitle_init (int _c, char *_a[], char *_e[]) {}
        |              ^~~~~
        |              ;

Doing some more `make`-ing in that directory with permutations of specifiers, 
complaint comes after `inline`; seems like it does not like `inline` anywhere in 
that line, although `__inline__` works just fine!

Perhaps a patch is warranted, possibly conditional on GCC <= 12?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
