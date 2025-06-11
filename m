Return-Path: <SRS0=FaLI=Y2=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id E9470385C6D9
	for <cygwin-patches@cygwin.com>; Wed, 11 Jun 2025 16:43:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E9470385C6D9
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E9470385C6D9
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749660199; cv=none;
	b=IgmFK6dM8B+f6TOsM47PO1iGBRZvApdq3ZiuOqCypLUdQybLg5FOOUEe9ZM9kARwfofXftPej54LACHgfyEa1la0Fuz3niK5SVvE2FFPmnvcI6/CupEEpK7h0Duz3E6B9SxwBJtgPp/Xd4p45ke+w1/4jNJtovl5L1KPFvGn3ts=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749660199; c=relaxed/simple;
	bh=5HXzewI7kOyxAjB9kq4WpAXbyd0/EakrW/Yo0XuazPw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=IX1naecK0U1npBwhuJ3wdUsAp9vvh4NCd1/lgwjlrWriomZmufG/z/bjFt2qSsPJGGJ07DDkOdHSL8UKt0QtZdw7/OawtgggWvsSw1bE1NZYFkwnW4eGuBguvDpXT2B401l9DB74z+E3gpYuwrMngw70c646i3Cw3L+LKDYkU4I=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 929AFBEC3C
	for <cygwin-patches@cygwin.com>; Wed, 11 Jun 2025 16:43:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf04.hostedemail.com (Postfix) with ESMTPA id 19BBB20024
	for <cygwin-patches@cygwin.com>; Wed, 11 Jun 2025 16:42:59 +0000 (UTC)
Message-ID: <7bcfc648-51d8-4437-8e12-b1fb1543a795@SystematicSW.ab.ca>
Date: Wed, 11 Jun 2025 10:42:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix compatibility with MinGW v13 headers
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB09238924363B70583AA08BA5926BA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <7178d417-9d6b-14b2-95cb-b5c4fb53b463@jdrake.com>
 <1ef68eee-d80a-4dde-af43-c4fdea1e4c40@SystematicSW.ab.ca>
 <2aa8fb0c-9a96-b260-2f28-aea8dab08bcc@jdrake.com>
 <0f598539-d282-47d8-817a-4c3fc4f7235e@SystematicSW.ab.ca>
 <c7b12c5d-7298-47c3-8ab4-40a8fb67e84c@dronecode.org.uk>
Organization: Systematic Software
In-Reply-To: <c7b12c5d-7298-47c3-8ab4-40a8fb67e84c@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 19BBB20024
X-Stat-Signature: ti4qdnusnwc7k1xg144fxbujs9jttqkf
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/uXPdfS0Mg7jQGqdbIxdJqLTp/OXzM3Gg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=BHc5i7wed6E1V7e4P4NfmvzM8scfb096ICeK+ZrHmw8=; b=pd8UxExmSug22PysBfX4BUTlnihkFA7l3zK/ug+ZSOUzInK9KznHiB7AfxpUBotcUnGGfqJ7R2FT6V9TYpAaVQb0UhZYDyU948SsBq9nwIydHW6X9GqLJL8ZZz4mlpczqm/8Fhe6cRASX4tYD1YpjuEFTnGpalNwneGZ3tb6KRUciloAsyQFFLz8MmVd3Bfdw3BAtMivF6bFCU1ziU7TfwNKXDrYY7N96ke9/Ls4oCHnE0fE6Hl50MgdIp29AoJCFcSa5u1sYywfr/RINGvbu/3G8bkEqDUkACd27WRd0lE98sIl/LCKLb68WhJP7bnmgIqhZYKekyA2rRtIuU+mXA==
X-HE-Tag: 1749660179-906871
X-HE-Meta: U2FsdGVkX18h5NwqF9PVtGM8UQX6UMxGF5zqY8Q93LnJoaXAne/C8ERVRaya0K269RZGB+c71YFTzkqVs886MhyZFeoixeKgg9bEv2p7H3tKkqquyeFY14BEynRSsbLtUQVb4sR08OEHuaMRmhdoWpEOnoxUB8T0aTceHxgF+9pWZEA8r+R+GmCDC09FgW+q40159Knrfkooiu8ZP95fnIAsA0qYXowHmX+3+L7F2FzMd53CmfrtRXsRDr5/g3ls0dqmdRL3SdhNgLihVYjW0uks3wN5pGTLJRVv57dZEQA4nYQaRkRGdBApchwopdNugBjpU3O01DmDbR9lQEHbLpJGP3XZZqJJoVDvZiRHE3lAJigU9IQ7VQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-09 17:10, Jon Turney wrote:
> On 09/06/2025 23:20, Brian Inglis wrote:
>> On 2025-06-09 15:56, Jeremy Drake via Cygwin-patches wrote:
>>> On Mon, 9 Jun 2025, Brian Inglis wrote:
>>>
>>>> On 2025-06-09 12:54, Jeremy Drake via Cygwin-patches wrote:
>>>>> On Mon, 9 Jun 2025, Radek Barton via Cygwin-patches wrote:
>>>>>> Since today,
>>>>>> https://github.com/cygwin/cygwin/actions/ runs/15537033468 workflow started
>>>>>> to fail as it seems that `cygwin/cygwin-install-action@master` action
>>>>>> started to use newer MinGW headers.
>>>>>>
>>>>>> The attached patch fixes compatibility with v13 MinGW headers while
>>>>>> preserving compatibility with v12.
>>>>
>>>> Perhaps in the case of this build, but not necessarily anywhere else in Cygwin
>>>> using BSD sockets.
>>>>
>>>>> The change to cygwin/socket.h concerns me, that is a public header, and
>>>>> you can't assume they are including MinGW headers, and if they are how
>>>>> they are configuring them (ie, _WIN32_WINNT define) or which ones they
>>>>> are including.  It looks like the mingw-w64 header #defines cmsghdr, maybe
>>>>> an #ifndef cmsghdr with a comment about this situation?  Or how do other
>>>>> Cygwin headers handle potential conflicts with Windows headers?
>>>> I appear to be missing where Mingw headers other than ntstatus.h are included
>>>> in these Cygwin headers so how would Mingw version be defined here?
>>>
>>> Inside Cygwin, additional Windows headers are included, including winsock
>>> headers to implement sockets within Cygwin.
>>
>> I understand that happens during the DLL build, but I am still not seeing 
>> where any of those nested header includes, whether __INSIDE_CYGWIN__ or not, 
>> includes any Mingw headers to define that version.
>> So I do not believe any such fix should be applied here.
> 
> Try adding e.g. '#define __MINGW64_VERSION_MAJOR 99' before the comparison, and 
> compiling. The results might be enlightening:
> 
>>   CXX      x86_64/fastcwd.o
>> In file included from /work/cygwin/src/winsup/cygwin/local_includes/cygtls.h:300,
>>                  from ./globals.h:5,
>>                  from /work/cygwin/src/winsup/cygwin/local_includes/winsup.h:281,
>>                  from ../../../../src/winsup/cygwin/x86_64/fastcwd.cc:9:
>> /work/cygwin/src/winsup/cygwin/local_includes/ntdll.h:493:9: error: 
>> ‘__MINGW64_VERSION_MAJOR’ redefined [-Werror]
>>   493 | #define __MINGW64_VERSION_MAJOR 99
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~
>> In file included from /usr/include/w32api/_mingw.h:10,
>>                  from /usr/include/w32api/windows.h:9,
>>                  from /work/cygwin/src/winsup/cygwin/local_includes/winlean.h:58,
>>                  from /work/cygwin/src/winsup/cygwin/local_includes/winsup.h:82:
>> /usr/include/w32api/_mingw_mac.h:17:9: note: this is the location of the 
>> previous definition
>>    17 | #define __MINGW64_VERSION_MAJOR 13
>>       |         ^~~~~~~~~~~~~~~~~~~~~~~
> 
> (and certainly quicker than grepping through a maze of include files :))

I have no doubt that is the case in a cygwin or similar Mingw package build e.g. 
setup, using the network!

My concern is that building POSIX network apps should not be impacted, and that 
other low level Mingw junk is not currently and should not be be dragged in to 
pollute POSIX headers.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
