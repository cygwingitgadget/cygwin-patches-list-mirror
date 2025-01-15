Return-Path: <SRS0=SYvf=UH=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id 3D26C3857BA3
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 23:21:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 3D26C3857BA3
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 3D26C3857BA3
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1736983310; cv=none;
	b=TWeF5MgZHs5B8l3Qt2QPG2xb3FG2HPpDeh2w6To+BMqk0c/M1ydDP/rroVZ6PsSZx1enSQsH0Ae7C1SjjhigOuCLv4gqj/8pM1ffu0o9qtu+H/WT6qZp1sIP+kXU012BknHEWqyVKksj1ltS9gCNKAQPcWJoB7zBxPK0JQLM70s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1736983310; c=relaxed/simple;
	bh=sxK1nahwFUvPxjnquXXwekptu4seLMLtgwv7wEvIPgY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=X8+mid7+IRZK1QOV1Oy8V5EMrucINSeUJreC62U8byOJVW/L9cucw+IoBGGRnDJfjsIC6SN3vuq27NXN4mylHWKXsmXyABFxazlbhPylM2y27HzVtCAaEh9sgwa+WE8WbqC+t31ziIXyqxsuxHwe/QDlBtNv4K9+c2myJBxFUCw=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 3D26C3857BA3
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=PhqYKAym
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id E4588433FA
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 23:21:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf06.hostedemail.com (Postfix) with ESMTPA id 73CDA20011
	for <cygwin-patches@cygwin.com>; Wed, 15 Jan 2025 23:21:48 +0000 (UTC)
Message-ID: <078eb772-decc-464f-92bb-83bb68679f83@SystematicSW.ab.ca>
Date: Wed, 15 Jan 2025 16:21:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v5 2/8] Cygwin: winsup/doc/posix.xml: SUS V5 POSIX 2024
 new additions available
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <cover.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <1a354471c155501dd2d0abfbc195e8be3e9c0fa2.1736552565.git.Brian.Inglis@SystematicSW.ab.ca>
 <5bde1928-7d96-482e-88ac-0cbb081f5a54@dronecode.org.uk>
 <e75a46b8-3f7e-4049-83c1-89a21b00fef1@SystematicSW.ab.ca>
 <Z4UJVxBngAvsxXwX@calimero.vinschen.de>
 <4ad1d807-42a9-4506-9588-bc843f655df9@SystematicSW.ab.ca>
 <Z4enoJ8FefxhHtaC@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <Z4enoJ8FefxhHtaC@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 73CDA20011
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: zn1ts71bdti4m6gzk5q67d9tei7ffwp7
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19uHZDI+tgLi8X08qHhF/gwfxk7mt64/3Q=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=2hdlbp6cy+3/AuVfqvod/xUuGAfw5hE/RjuITLG78Pk=; b=PhqYKAymiqzQD8/c/rKEFBkTIF037lpcBap9bCcIy/yqVpg222fAEta4VktwoCHNXbEqfH37o+r8Xdt5p56sKeX9vQgqFm7KKdvpKY/BJiPxMRW5yJrFuquCsToe6eXmzLmnr6Usv6XdMgpETmRXWwPMrVUzJDj8+RWAAlZFcFkOUOEqZmS7bvNj4ob8OXOIp/m+ZvEZ4L9R4iISBdqESiX16NJikUgQdxSLRtB1hqzf+Uoer0c95YWh0PkEJXajrq/fYaXzhPfIs30VqDSSoHq/WRvpwG+TYprDXN9wh1b1QA66GHBB23D3qEOXl1sN15uR6P5RUa/bvrkXoRuf1A==
X-HE-Tag: 1736983308-739448
X-HE-Meta: U2FsdGVkX1/O4vGmEsC67FYGqMOpESd7xZEPyX6U6tXiDL0dSZ/f+QDYtK/Le8WK6aerlRhwtvG/P+3GqlIMfnPyI0SEiefu4vXa/wCBE2zTITYhXnVLjntnSHgZ2jcck3KCXVl13qa1hGXTtCUkwnh4Dd0MH+INIrc8dvu5aZO4FsnzDAMj3OAM+2sKq8HAzoA0kk5KYC2MIt7/LSKCArZp3KOPWansevh5T0ZROrGsyayET+YWeG9TDW5M2ANPU6GfpVZEy4/riGS3HgMHPE//sdVhDuBJfjGHAvtqU3t9s5BSx73jtH96eBo48SC/ggYF0ONf1ihZ+Y3bKGzR4nnROwFXT8V7SpZsLhmoEdkd85vSnU0ytdz7zDermUddi3hFNFDLtFviFLLI6P6GUBLEYQIffc/Pw3YjPXHl4xhgPHfc8UX9bGocXbahB9SFkBmEBc0Uej8sKwLJhfeSDZb+/sAh4/BXVKafTNINMY1Dslgv+23UFAY+h6yYxmAH
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-01-15 05:18, Corinna Vinschen wrote:
> On Jan 13 11:57, Brian Inglis wrote:
>> On 2025-01-13 05:38, Corinna Vinschen wrote:
>>> On Jan 12 12:56, Brian Inglis wrote:
>>>> Suggestions for better phrasings of these welcome.
>>>
>>> "Add POSIX new additions available as symbols exported from the Cygwin
>>>    DLL, as header macros and inline functions, or exported from external
>>>    Cygwin distro libs."
>>
>> Forgot about making distinction between newlib and Cygwin functions:
>>
>> Add POSIX new additions available as header macros and inline functions,
>> or exported by Cygwin distro DLL or library packages?
> 
> Good enough.
> 
>> Mark din entries as Cygwin DLL and others as Cygwin PKG...?
> 
> Sorry, I don't understand this question.  Can you make a two-line
> example what you mean?
> 
>>>> in6addr_any:		nothing appropriate.
>>>> in6addr_loopback:    nothing appropriate.
>>>> posix_getdents:	nothing appropriate.
>>>> timespec_get:	nothing appropriate.

Add note (Cygwin DLL) to remind us there are no docs yet.
Add availability notes for others, for example:

+    be64toh			(available in "endian.h" header)
      bind
+    bind_textdomain_codeset	(available in external gettext "libintl" library)

>>>> Also is anyone aware of a good html to man page converter to generate Cygwin
>>>> or POSIX man pages from HTML sources available, and are cpp-reference GPL-3
>>>> allowed, or should we prefix the function source with the man doc and
>>>> generate it in newlib?
>>>
>>> What man pages are you looking for?  We have the man-pages-posix package
>>> and we only have it because we have the official permission to do so.
>>> Keep in mind that all man pages not part of the newlib-cygwin dir are
>>> potentially copyrighted.
>>
>> Latter four above - Cygwin only: very aware of sources and permissions.
> 
> They would have to be provided by the man-pages-posix package at one
> point.
> 
>> Also aware that Austin Group want to keep nroff sources from being
>> distributed

They are not going to make the original man-pages-posix sources available, 
except under licence to a maintainer, similar to their current online HTML and 
PDF offerings, which are for fair (FYI quotes), personal, or research use only.

> I'm not even aware where I could get the original nroff sources from the
> Open Group.  Since 2015, we have an official permission from the Open
> Group to distribute the POSIX man pages with Cygwin, but for the nroff
> sources I was just relying on the Linux version of that package from
> https://www.kernel.org/pub/linux/docs/man-pages/man-pages-posix/

I am maintainer of that Cygwin package since the last update to POSIX 2017a in 
2021 from kernel.org.

> Seems like the package has been pulled from Fedora, though.  I'm
> sure I installed it once, and the files are still under my
> /usr/share/man/man3p directory on my Fedora, but the files are not
> owned by any package.  I vaguely remember there was "something"...

Fedora RPMs gone but still in F34 spec and on Repology under RPM Fusion Fedora 
(below) and OpenSuSE!

%changelog
* Tue Aug 09 2022 Nikola Forró <nforro@redhat.com> - 5.12-3
- Remove POSIX man pages due to disallowed license  resolves: #2116859

https://download1.rpmfusion.org/nonfree/fedora/development/rawhide/Everything/source/SRPMS//m/man-pages-posix-2017a-4.fc41.src.rpm

>> and linux-man maintainer is inactive but participating.
> 
> I assume (i.e. hope) he or she will update to 2024 at one point?

Alex resigned due to lacks of ???, but still posting, so unlikely.

> Otherwise, yeah, would be great being able to generate man pages
> from
> 
>> Only getentropy_r is documented in:
>>
>> 	/usr/src/newlib-cygwin/newlib/libc/reent/getentropyr.c
>>
>> and it is in CHEW files in:
>>
>> 	/usr/src/newlib-cygwin/newlib/libc/reent/Makefile.inc
>>
>> but not included in list of functions in:
>>
>> 	/usr/src/newlib-cygwin/newlib/libc/reent/reent.tex
>>
>> and nor are any of the CHEW outputs in libc.info?
> 
> I'm not deep in this documentation creation thingy.  If something's
> amiss there, feel free to provide patches.

Working on it, also sources for others above.

I have for a tendency to prefer info over man pages when available, possibly due 
to xrefs and links.

Please consider applying the revised v6 initial patches 1-5, as I have 
discovered the limitations of interactive cherry-picking only selecting *MOST* 
hunks, and I can not get that final abbreviation patch 8/8 changes out of my 
current branch tree, no matter what I reset to from the log or branch reflog.
I may just have to reset hard and patch! ;^>

Please also have a look at revised v6 patches 6-7, where I have combined entries 
from the same man page, for most cases where it makes sense, and possible 
without too long lines in posix.xml.
If you just leave the entries in ASCII order, per Jon's feedback, c'est la vie.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
