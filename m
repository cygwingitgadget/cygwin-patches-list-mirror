Return-Path: <SRS0=POI0=YV=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	by sourceware.org (Postfix) with ESMTPS id 6EF78385771D
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 23:26:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6EF78385771D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6EF78385771D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1749252370; cv=none;
	b=KcmZyUdKFRqtx6fhbX1/kbv5JQDNXuzEuvjorP5NC5nLOeRv2esa7poiQ5p7CMhaFR+Cjht2KZ1pWVeje2od+vih4o6Iap7UBRx+7tRzjw1hdtPG/SNm5cYi1z/Ag4cYXa95jWfO5odaWGVVEF8CzkS96cf24xealHbQOg09Cec=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1749252370; c=relaxed/simple;
	bh=PnK9QUrf1jcAd6GsyYtZHzedHptyXFvcoBQDbuaF6EA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=bjr2a5Or8yQifUm7YoJwy0IupDQuNiVQbQrFRRKaL32FX4KtdRfWFjI1KJM9aGoCejV4OEheHURoFQVTd6bW3cxRBQpNgZP8aEeskHxAVt771+QP2DGGTwIApGz/n1pNfRUeCTMkLiVqxiPXQopwBaKJAQ+QFt9XDE0EjPmBlcU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6EF78385771D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=B5Kj1XvS
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 1F66A1409E3
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 23:26:10 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf19.hostedemail.com (Postfix) with ESMTPA id A639120027
	for <cygwin-patches@cygwin.com>; Fri,  6 Jun 2025 23:26:08 +0000 (UTC)
Message-ID: <0ae19049-e7c0-49e3-8939-1a439c9c417e@SystematicSW.ab.ca>
Date: Fri, 6 Jun 2025 17:26:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: Website Suggestions
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <CAKrZaUst28O+9Z6TBbQU0Ha3o9ZSRPzGYbpb7NiQ+1cmsUiT2Q@mail.gmail.com>
 <79bde4c8-658b-438d-9c40-202e03ef23ba@SystematicSW.ab.ca>
 <CAKrZaUuNGaC=kzDb-nRZmk3r4vm-3GM8W+AbbOgaWvoihQR7gw@mail.gmail.com>
Organization: Systematic Software
In-Reply-To: <CAKrZaUuNGaC=kzDb-nRZmk3r4vm-3GM8W+AbbOgaWvoihQR7gw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A639120027
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout08
X-Stat-Signature: k9txe9ykqmqx1784i1kxwgd1n1jeiskz
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1+TkBzXEm0f9/xx5Ir3MGpKdZeMPRT96z8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=V91iNF/VS3Ntm0sWbbAMph2K4Zl6ageMslGHgeKucUE=; b=B5Kj1XvS4egKV1oUA/o+darg1x4bRpMWZfJE6wuFw1YXhtHLPOI4vh6vzxtiF253tQtqp6MTZXzZ84zd92ENomZ3cwO7HZjXjDK0GpeVrPBnAT98m2kIN5ucVKNblrJBG0sSn6rARagx8j69BGIDtuV5RvQGM3J2nMTz4HocQhXfod+xICjWECX5LgUIkon/p0L8FBANoOaPndHZcZdVVh4jpNHWjv93BIOuBGdXhc5eHJZ5vnPuZyhbRHIOEEPhI14RmoefMoeHwWpYMMl79gdcI9VcZRZha0hRAmbmiiBpJ6C4sHUICG8lpkgzlGrmHSb2hSy/FeSsOJDkgU4eZQ==
X-HE-Tag: 1749252368-431703
X-HE-Meta: U2FsdGVkX1+Qg2z9e+jRvuh8U73fMKE8RDtzFWs06yyK7QJ0gfFziMiRM39NABcImd6u/9ZJO5kfjHVnDCkoqzjrV0Ygv4w1tb7r/NQ45AWmnjEss89CwdPZTVNHKnRcq2tNKlHTp8j9gzyLTU3oaZZLNQlmCBKXFWK8ADNpg8DhRX/67svYublgij675M4eSHO0lMjyWx9P8NTHGsNToOK0snn5TwbcQbGtmq5jkUyR4POMJtu7HtsTvD9Osb9WC+Vo/EGLSZy54lMyZjnEGM4fsBNyPIz+XkteMPW/fKS+sTb+M3ZJNwRi8FVIfiedoAet77LTmdfrbW6Op1YpKcl+GLF7Xdiscfe/1AaRAHu5/4EBltqdShJWQFX/P4Ye43IBGCbfxxZ90d0JvT9J4M30CEWadR/7qYpoDOcC9EdqX1tBQNmvX80Y3YsULcW+85NIXIL7tqd4HTLueaTKOQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-06-06 14:50, John Haugabook wrote:
> On Fri, Jun 6, 2025 at 1:06 PM Brian Inglis
> <Brian.Inglis@systematicsw.ab.ca> wrote:
>>
>> On 2025-06-05 19:50, John Haugabook wrote:
>>> I made a few small edits to the website, and included the patch as an
>>> attachment. Below are the changes:
>>>    - Changed links to template elements to absolute, using "/" before the page.
>>>    - Included template elements in nested pages.
>>>    - Made an edit to "Install.html".
>>>    - In style.css edited elements for better UX, and edited comment
>>> markers for consistency, ending at col 78 for comments marking style
>>> section.
>>>
>>> I wasn’t sure where website suggestions should be sent — this list
>>> seemed most appropriate, given its name. If there’s a better place or
>>> process to submit patches like this, please feel free to redirect me.
>> Rather than the *generated* HTML you sent many of your patches against, you will
>> have to redo many of your changes against the applicable source repos below,
>> build Cygwin and docs to check the appropriate contents are generated and
>> appear, then format and send the patches from the commits against each of the
>> source repos, either as separate individual patches, or a series of *related*
>> patches against each repo.
>>
>> Send git-format-patch output against current:
>>
>>          https://cygwin.com/git/cygwin-htdocs.git
>>
>> sources using git-send-email so they can be reviewed and applied with git-am.
>>
>> Most other website and doc package contents are generated from DocBook XML:
>>
>>          https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/doc;a=tree
>>
>> sources in the above repo: note all the includes of other, sometimes generated,
>> XML files, most of which are generated from embedded API comments in function
>> sources:
>>
>>          https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/cygwin;a=tree
>>
>>          https://cygwin.com/git/?p=newlib-cygwin.git;f=newlib/libc;a=tree
>>
>>          https://cygwin.com/git/?p=newlib-cygwin.git;f=newlib/libm;a=tree
>>
>> in DocBook XML and other doc formats, and which should be sent using the same
>> process; except all Newlib changes should be sent to the newlib sourceware
>> mailing list rather than the cygwin patches mailing list.
>>
>>> Totally understand if the changes are rejected or revised. Thank you
>>> for maintaining the project and reviewing contributions.
>> To generate the API info and man pages, you can change into the newlib directory
>> and:
>>          $ make info man
>>
>>          $ make install-info install-man
>>
>> I have no idea what the process is to deploy the generated HTML files into the
>> cygwin-htdocs tree, unless it may just be the presence of a parallel repo during
>> the build, and/or scripts run from one or the other, or the infrastructure.
>>
>> It would be useful if we could be pointed to docs on how to reproduce the web
>> site locally.
>>
>> --
>> Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada
>>
>> La perfection est atteinte                   Perfection is achieved
>> non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
>> mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
>>                                   -- Antoine de Saint-Exupéry
> 
> Thanks for getting back to me. I might not be able to work on this for
> the next week, but in response.
> 
>> I have no idea what the process is to deploy the generated HTML files into the
>> cygwin-htdocs tree
> 
> I'm not able to find anything on that either. It doesn't seem like I
> can do much without simulating the generated HTML. Is it built from a
> cronjob, then uploaded to the site?
> 
> If so, then adding:
> 
> ```
> </title><link rel="stylesheet" type="text/css" href="/style.css" />
> and
> <body><!--#include virtual="/navbar.html" --><div
> id="main"><!--#include virtual="/top.html" -->
> ```
> 
> to the file that generates the html should work - right?
> 
>> To generate the API info and man pages, you can change into the newlib directory
>> and:
>>         $ make info man
>>
>>         $ make install-info install-man
> 
> Didn't work for me. I can use the xml from:
> 
>   https://cygwin.com/git/?p=newlib-cygwin.git;f=winsup/doc;a=tree
> 
> and do a makeshift build, but doing that doesn't really do any good
> unless I can generate the html as it is done from however newlib
> generates the html page from xml.

For both Newlib and Cygwin doc builds, the html is generated into subdirectories 
of the parallel build or prefix/install directories defined in the build 
configuration.

You have to start by running winsup/autogen.sh before configure, then follow up 
with the newlib doc makes and doc make install-s.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
