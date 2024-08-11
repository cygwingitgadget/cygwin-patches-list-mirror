Return-Path: <SRS0=cVhV=PK=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 712F63858D34
	for <cygwin-patches@cygwin.com>; Sun, 11 Aug 2024 21:37:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 712F63858D34
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 712F63858D34
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1723412260; cv=none;
	b=x7wsbkhwi2w7SI7paO2snhlNzhd1lNFlWwyDu0p/qi9ODN20/2x2BUChgUvBa6Pn+llHa4D7du9Tz3nirVCZWhTUPMuTsVxiN+nnOnl//oxNUXK6zZO8BmuFg+J8UEiq41rxclTsD/YML84QV1lTBU91ftZu/bJip9i9tKDY5zc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1723412260; c=relaxed/simple;
	bh=gXb82/bp9qiYpK1cEM1qvbK2HLqUGrLfv1VwZPiobIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=kuGaE2fuOEowV9wM4hCdTqxZtjuzFKUzZzCv+UJXduY4qUuO/XemS7bVGD15N1UtNRtMr0IO78PIzHafABLPSmvF9WHpkL8iGg9zzzpcV7l1e68rYOlr9yxK8FKTgyvgVMfixPAM5r168oi2Xi/Mgf+UfQ6Sbc7TT0tH8wKjr2U=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 0806DC054D
	for <cygwin-patches@cygwin.com>; Sun, 11 Aug 2024 21:37:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf08.hostedemail.com (Postfix) with ESMTPA id 89BF420025
	for <cygwin-patches@cygwin.com>; Sun, 11 Aug 2024 21:37:36 +0000 (UTC)
Message-ID: <4bafb2a0-472e-4bfc-9695-ab1ac57eb61a@SystematicSW.ab.ca>
Date: Sun, 11 Aug 2024 15:37:35 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 5/6] Cygwin: Fix warnings about narrowing conversions of
 socket ioctls
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20240804214829.43085-1-jon.turney@dronecode.org.uk>
 <20240804214829.43085-6-jon.turney@dronecode.org.uk>
 <ZrCn00PXmRT77OKj@calimero.vinschen.de>
 <4deb7dbe-1ac0-478c-bd36-76d3937864cc@dronecode.org.uk>
 <ZrN_YlBeD31PpxN7@calimero.vinschen.de>
 <659ca957-c6bd-481d-99ef-2516e902be31@SystematicSW.ab.ca>
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Organization: Systematic Software
In-Reply-To: <659ca957-c6bd-481d-99ef-2516e902be31@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89BF420025
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,BODY_8BITS,KAM_DMARC_STATUS,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout06
X-Stat-Signature: 63fjsoccq7ag4sb9an4aji5oiuterpq7
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18Q3wZuJ4v99VK59bRj9OifGh3PqOaF+mQ=
X-HE-Tag: 1723412256-591801
X-HE-Meta: U2FsdGVkX1+UejMf5v3aMgHX59Aga4LMNUBDwwHm/0zQl7wXRWfapq9CrP13N7KZDIwUqUZdKt8rrv4rexyITXwrtra0/4AzNtfzboipvsHt4eYPnWGntdmzTufiClQc7nlaAXlrHjLHw8lepf4dCGT+Mz1FQ/fmVxW5v91Wz+JB5sHaSb+1QS0SOfEmb6CHhTk9rg5BLy9QsHkxiEPF8PQaGClJWZd+XHBslFu0ziXNa8+7Bsm4BDfMNJZFC15i5IkanM4CprNVyMWAfDHkOGW4haILUCriIXZDGM8xvn5JoRrIopxbIdVnW5TRey6ZILANwVRcJDuALnpzR68UWMCniSoPKNDi
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2024-08-11 12:31, Brian Inglis wrote:
> On 2024-08-07 08:06, Corinna Vinschen wrote:
>> On Aug  6 19:58, Jon Turney wrote:
>>> On 05/08/2024 11:22, Corinna Vinschen wrote:
>>>> On Aug  4 22:48, Jon Turney wrote:
>>>>> Fix gcc 12 warnings about narrowing conversions of socket ioctl constants
>>>>> when used as case labels, e.g:
>>>>> [...]
>>>> The only caller, fhandler_socket::ioctl, passes an unsigned int
>>>> value to get_ifconf. Given how the value is defined, it would be
>>>> more straightforward to convert get_ifconf to
>>>>
>>>>     get_ifconf (struct ifconf *ifc, unsigned int what);
>>>>
>>>> wouldn't it?
>>>
>>> Yeah, I'm not sure why I didn't do that.  I think I got confused about where
>>> this is used from.
> 
>> LGTM.  I will additionally push a patch dropping the useless casts.
> 
> Hi folks,
> 
> Trying to rebuild got a couple of issues with gcc12 and likely recent updates to 
> main, as my previous rebuild for /proc/cpuinfo with gcc11 was fine:
> 
> - picky g++
> 
>    CXX      net.o
> In file included from 
> /usr/src/newlib-cygwin/winsup/cygwin/include/cygwin/socket.h:47,
>                   from /usr/src/newlib-cygwin/winsup/cygwin/include/cygwin/if.h:17,
>                   from /usr/src/newlib-cygwin/winsup/cygwin/include/ifaddrs.h:42,
>                   from /usr/src/newlib-cygwin/winsup/cygwin/net.cc:26:
> /usr/src/newlib-cygwin/winsup/cygwin/net.cc: In function ‘int 
> get_ifconf(ifconf*, int)’:
> /usr/src/newlib-cygwin/winsup/cygwin/net.cc:1940:18: error: narrowing conversion 
> of ‘2152756069’ from ‘long unsigned int’ to ‘int’ [-Wnarrowing]
>   1940 |             case SIOCGIFFLAGS:
>        |                  ^~~~~~~~~~~~
> ... and so on
> 
> 50cf10dfa485 Cygwin: asm/socket.h: drop outdated casts
> 
> so change net.cc get_ifconf (struct ifconf *ifc, int what) to unsigned long, and 
> where it is also declared in fhandler/socket.cc?
> 
> - __utoa (and __itoa) declared in stdlib.h inside #ifndef __CYGWIN__
> 
>    CC       libc/stdlib/libc_a-itoa.o
> /usr/src/newlib-cygwin/newlib/libc/stdlib/itoa.c: In function ‘__itoa’:
> /usr/src/newlib-cygwin/newlib/libc/stdlib/itoa.c:57:3: warning: implicit 
> declaration of function ‘__utoa’; did you mean ‘__itoa’? 
> [-Wimplicit-function-declaration]
>     57 |   __utoa (uvalue, &str[i], base);
>        |   ^~~~~~
>        |   __itoa
> 
> 
> 31f7cd1e4332 Hide itoa, utoa, __itoa and __utoa in stdlib.h on Cygwin only
> 
> $ grep -C2 utoa ../../newlib/libc/include/stdlib.h
> #ifndef __CYGWIN__
> char *  __itoa (int, char *, int);
> char *  __utoa (unsigned, char *, int);
> # if __MISC_VISIBLE
> char *  itoa (int, char *, int);
> char *  utoa (unsigned, char *, int);
> # endif
> #endif
> 
> so should this be __INSIDE_CYGWIN__ instead or something else?

Sorry folks,

Did not notice patches 5-6/6 have not yet been applied.
Apply both okay and rebuild proceeding.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

