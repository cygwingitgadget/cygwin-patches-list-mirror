Return-Path: <SRS0=zmdd=G2=shaw.ca=brian.inglis@sourceware.org>
Received: from omta001.cacentral1.a.cloudfilter.net (omta001.cacentral1.a.cloudfilter.net [3.97.99.32])
	by sourceware.org (Postfix) with ESMTPS id 526943858C78
	for <cygwin-patches@cygwin.com>; Mon, 13 Nov 2023 18:46:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 526943858C78
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=Shaw.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=shaw.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 526943858C78
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=3.97.99.32
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1699901209; cv=none;
	b=D3kgTZDvm3qgSrZjYptN8vL9aeQz8W2ryk7gaGLAb6RqHoXMfjvtLl2G6G382hgaGzGzapbKuD/e9lCqrIEfQinBQ9sNtaR42oNGn3yLu/933G8RmfsTlOa1fTaXePMVrRjM0iGc4qvFLFPVhF2SLUhBhsxThst/mSqyckfODhk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1699901209; c=relaxed/simple;
	bh=orX3bpahG+cpMnt/Si4xtoaoGVflpVkplBsxFq4lfqQ=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=ar62PjP6LEccuwlyMmd8vV1R0JmBrhislbSNKWZMFk6Z5o7OI6eoBgs6S1z4suTOEErATzqNjYtbn4RWL3CCtdWK2Hn+bp0chaHW6N/hoHo9ecDAs4D+RxEWj6Eq6I8e/9tnOCudw9R5Z3tjkkYlknVRUwB7mkojNdVYDOW8wUM=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from shw-obgw-4002a.ext.cloudfilter.net ([10.228.9.250])
	by cmsmtp with ESMTPS
	id 2WeFreEtJ8jpT2bxOrXJMU; Mon, 13 Nov 2023 18:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=shaw.ca; s=s20180605;
	t=1699901206; bh=orX3bpahG+cpMnt/Si4xtoaoGVflpVkplBsxFq4lfqQ=;
	h=Date:Reply-To:Subject:To:References:From:In-Reply-To;
	b=sErbMwb2ROtAcwXEHGmeaAbPE6wnESHiF1gn9+jIrofSxfLl1Alh/fWgVm7Ci/9y7
	 PHeq3XFraqF2oFyHAeTAyxKlckMKM2G2Mt2h2Cy7c9LvGtxdsj55Fax4++YLgsNK75
	 rSWl3Va3mL+jxQS0OBKqKuzCkjxpXVHlwCX9eZ3xLD5+X3YtUI4xAL85Tva6rSCUE/
	 R3nf4TETMKhzOSuHnKNZizssA/+0+x4IVtVaYE0S/6Y3iFISPGSqUMEScYbWtwGrld
	 tXCZRvK71oAbTO0pnzjKJsI+HrQ2FzpjK8WXOvAH2YwTpZ+KhtZ5LdkOv9YYEhiXJd
	 oiLc47cRqZUSw==
Received: from [10.0.0.5] ([184.64.102.149])
	by cmsmtp with ESMTP
	id 2bxOrYS7pnCF02bxOrVljr; Mon, 13 Nov 2023 18:46:46 +0000
X-Authority-Analysis: v=2.4 cv=MPFzJeVl c=1 sm=1 tr=0 ts=65526f16
 a=DxHlV3/gbUaP7LOF0QAmaA==:117 a=DxHlV3/gbUaP7LOF0QAmaA==:17
 a=IkcTkHD0fZMA:10 a=GHR8O2WEAAAA:20 a=6lyOYiYQAAAA:20
 a=-DHl6rSPBhkLAOsmDU8A:9 a=QEXdDO2ut3YA:10
Message-ID: <0649bde5-ba16-40bf-a5b1-00ae7b676292@Shaw.ca>
Date: Mon, 13 Nov 2023 11:46:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Brian.Inglis@Shaw.ca
Subject: Re: [PATCH] fix(libc): Fix handle of %E & %O modifiers at end of
 format string
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20231109190441.2826-1-pedroluis.castedo@upm.es>
 <4801ab90-2958-4fa2-87f2-21efdb41bbf4@Shaw.ca>
 <ZU4C+UIcYTtvWrrJ@calimero.vinschen.de>
 <27a7257d-1e06-40ff-89ec-f100b8734802@upm.es>
 <5cd4b96f-cad1-456c-b4d9-a6a649d36e3a@Shaw.ca>
 <ac7355c3-7b25-4410-94eb-9bd2f602f4ac@upm.es>
 <ZVJSDAyKK/h8bZa/@calimero.vinschen.de>
From: Brian Inglis <Brian.Inglis@Shaw.ca>
Organization: Inglis
In-Reply-To: <ZVJSDAyKK/h8bZa/@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEMH1V6aFgo0y3YWQk3N7wfALId4DXxnrvmWYzwL51/s7tn3EVPo/yWN3xeVdhz1xHlcZFO+mGcAKCbZuznBZatD26y91xnH458zb34FTN8R+NHkRE18
 OM2lE8aHoYHWlk73ZIQfpRe2Bl32m0sAndNPG/BqdOZZ5+LgMn5j3OkjQ/YWx/zppgMlChnSJk3k/YfRjlRndAgi0SU2MekW5lc=
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2023-11-13 09:42, Corinna Vinschen wrote:
> Hi Pedro,
> 
> On Nov 11 18:29, Pedro Luis Castedo Cepeda wrote:
>> OK. It's not a newlib problem but a GLib one as it is relaying on common but
>> non-standard strftime implementation details.
>>
>> I attach a short program more focused in g_date_strftime implementation so
>> it can be evaluated if it worths addressing this corner case.
> 
> Tricky.  I wonder what the GLib test is actually trying to accomplish.
> 
> POSIX has this to say:
> 
>    RETURN VALUE
>      If the total number of resulting bytes including the  terminating
>      null byte  is not more than maxsize, these functions shall return
>      the number of bytes placed into the array pointed to by s, not
>      including the  terminating NUL character. Otherwise, 0 shall be
>      returned and the contents of the array are unspecified.
> 
>    ERRORS
>      No errors are defined.
> 
> But, and that's the big problem, POSIX does *not* provide for the
> error case, because it doesn't allow an error like using an incorrect
> format string to occur.  Using an incorrect or undefined format code
> is just not part of the standard.
> 
> And the Linux man page has an interesting extension to the above
> POSIX RETURN VALUE section:
> 
>      Note  that  the  return value 0 does not necessarily indicate an
>      error.  For example, in many locales %p yields an empty string.  An
>      empty  format string will likewise yield an empty string.
> 
> and additionally in the BUGS section:
> 
>      If the output string would exceed max bytes, errno is  not  set.
>      This makes it impossible to distinguish this error case from cases
>      where the format  string  legitimately  produces  a  zero-length
>      output  string.  POSIX.1-2001 does not specify any errno settings
>      for strftime().
> 
> So the below case tested by GLib is entirely out of scope of the
> standard.

C 2023 draft says:

"7.29.3.5 The strftime function
...
     Returns
8   If the total number of resulting characters including the terminating null
character is not more than maxsize, the strftime function returns the number of 
characters placed into the array pointed to by s not including the terminating 
null character. Otherwise, zero is returned and the members of the array have an 
indeterminate representation."

GLib is not tested under Cygwin/newlib only VS2017 and Msys2-Mingw32 native 
Windows:

https://gitlab.gnome.org/GNOME/glib/-/issues/2604

https://gitlab.gnome.org/GNOME/glib/-/merge_requests/2480/diffs

https://gitlab.gnome.org/malureau/glib/-/pipelines/366193/test_report

[may need to navigate not always obvious "tabs"]

Should raise a followup issue there - and point out it is not a Win32 issue - it 
is another POSIX alternate libc issue - hosted under a Win64 environment.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retirer     but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
