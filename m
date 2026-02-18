Return-Path: <SRS0=GRho=AW=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	by sourceware.org (Postfix) with ESMTPS id B0D7E4BA23C6
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 18:07:53 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B0D7E4BA23C6
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B0D7E4BA23C6
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.12
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771438073; cv=none;
	b=Kzp5bqy6ZL7QAuQXRmEoFhXp/jDYj+HXGQFbMOXl24cwwr5Dg8gy/zODCzeDrMyZ3qr4Oe/RKIusc5oSV307BvY/n8JnJ2VuWgr8YoUZhq6ql5CX1UrsXTenX8kdRHw/f12oyQlyGRReWPLGDwJPMp47sajw+Wte6fdhNeV6mls=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771438073; c=relaxed/simple;
	bh=xqm64vFBx+KVMHy24B1LfjcAdDXbSt33b4flsCU+w1E=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=oLLIETqedRoD1/12hvm5SCp9hcDlpT0jrpISijHXXF35bc3C2SiqGgnM4gEM+YajTN7PzgPyw59yiNXHziyIKMKi43aE/Ya1KsoLgMuqCtaWTh4G7ku+DPmvlfrw89cbabQ6REgdchFDJuUyJnyGoyFaRx0W9omOe9N4c0Kpd/c=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B0D7E4BA23C6
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=Mob5gHoH
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 3B0C157995
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 18:07:53 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf09.hostedemail.com (Postfix) with ESMTPA id B482320024
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 18:07:51 +0000 (UTC)
Message-ID: <3dddb543-47e8-4ae2-9ced-7344e7e31580@SystematicSW.ab.ca>
Date: Wed, 18 Feb 2026 11:07:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Subject: Re: [PATCH 3/3] Cygwin: improve PCA workaround
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <20260126111345.386303-4-corinna-cygwin@cygwin.com>
 <b081744f-c953-4ca2-bdc9-fdd260acb494@SystematicSW.ab.ca>
 <aZBHUzq6ttMgLEgT@calimero.vinschen.de>
 <f6ac6e63-24d9-4fdc-b064-dedcc57fd041@SystematicSW.ab.ca>
Content-Language: en-CA
Organization: Systematic Software
In-Reply-To: <f6ac6e63-24d9-4fdc-b064-dedcc57fd041@SystematicSW.ab.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Stat-Signature: d5k93tgwtuico6m9z6wi4gzqjndq699x
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: B482320024
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,BODY_8BITS,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,LOTS_OF_MONEY,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX19M69adT1rGVjOCfv+ETvrX/X0DnFOq1Ag=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:subject:reply-to:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=ustQLFcbU+3vdMrTgSFd+j4j1bQ+Y+lITlCnxVlzIPQ=; b=Mob5gHoHrhGxvYbsZ4Mzh8FpvB5mJlV60BhXMoYX0xcqrUQ632l8ZB4DnRjIgsZ8g6sRtTSO42qUhiZYGh5e9ZA4wHlwvDhoMaJigCsw689KC048+NXFk71uIpJ/Q3tcYyK6uVjoRHOuNsyaBtCMLyKMzFsXnnJVa5QozpTQYb/TAgnD1U1mGFJnnVTqc16+ETXKTInV0qwmEH3EORu+8UO2MGggYRscgQQG0NuxeMucjLPY8k6vQJXC/O4ak1tYE7mlfWFGmRVl1dpI5JjJ8oYCU2LMEeOV1wYFwVAMjX7TZRZ+hDi1Zyr7tL5SAuf454d2Knjof1gSBDi6RbNMAg==
X-HE-Tag: 1771438071-924576
X-HE-Meta: U2FsdGVkX184G4sS1StXFsZDjelcHnC6NWYrZzU+aNCE5ch5sGnrcXYBHG/7/qRGhj9EKN8hQyrP9scL7ccS5S3fOBQm77g7P4D/IJWkhti5h+JMiJpdUMo4zL+TBhWBaPuD99WQriSF2wv4miCdrBiUY6N87s8ZEDrzxgzlVcHS9iw06dMeq34nhTIJfV8qqzpIUaNqo7dhy/DohnvPdn8vBIWt0LTv8Y0ttLZsHgyyGGmYTJ38QuM0qDqbav9TtmVdp2TFsi72wni8VXSeCMFKt4x/2+fibzfKKGPIqQmeXOjw40L7Oq9k5bhirJHlvNyfJ6DrV/U8Z4BS8d0n55BSJulnRrjC9H/DEGffApu+1aSHl1kCQAjxDgaNULYfaGP7JKwq4GpeGx06DmTggOmcokjHc8VQup0yGJdCcWxKg2yW2tCRP04iyxwfB2kmrO6pI6YXZYcQK7MRgFK/xqBnYcMzi/gNirQucj2lHQDVW3yAwetXfkPh8Fof4MKtjH3+V7dX4vUxOFNyj4wdbvbeQQ5MM8XN
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-02-14 03:36, Brian Inglis wrote:
> On 2026-02-14 02:58, Corinna Vinschen wrote:
>>
>> [CCing Thomas]
>>
>> On Feb 13 17:36, Brian Inglis wrote:
>>> On 2026-01-26 04:13, Corinna Vinschen wrote:
>>>> From: Corinna Vinschen <corinna@vinschen.de>
>>>
>>>> Perform the check only if we're the root process of a Cygwin process
>>>> tree.  If we start mintty from Cygwin, the PCA trigger doesn't occur.
>>>
>>>> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
>>>> index 1d5a452b4fbc..e080aa41bca2 100644
>>>> --- a/winsup/cygwin/dcrt0.cc
>>>> +++ b/winsup/cygwin/dcrt0.cc
>>>> @@ -253,6 +253,17 @@ frok::parent (volatile char * volatile stack_here)
>>>>         systems. */
>>>>      c_flags |= CREATE_UNICODE_ENVIRONMENT;
>>>> +  /* Despite all our executables having a valid manifest, "mintty" still
>>>> +     triggers the "Program Compatibility Assistant (PCA) Service" for
>>>> +     some reason, maybe due to some heuristics in PCA.
>>> All makes sense and looks reasonable to a non-Windows type!
>>>
>>> There are no differences between the windows or either mingw64 default
>>> manifests, but mintty has extra, after tweaking its order and layout to
>>> match, so perhaps something there needs updated in GH:
>>>
>>> $ diff res.mft default-manifest.mft
>>> --- res.mft    2026-02-13 17:21:21.491931500 -0700
>>> +++ default-manifest.mft    2026-02-13 17:18:08.759527200 -0700
>>> @@ -3,40 +3,22 @@
>>>     <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
>>>       <security>
>>>         <requestedPrivileges>
>>> -        <requestedExecutionLevel level="asInvoker" uiAccess="false"/>
>>> +        <requestedExecutionLevel level="asInvoker"/>
>>>         </requestedPrivileges>
>>>       </security>
>>>     </trustInfo>
>>> -- 
>>> -  <dependency>
>>> -    <dependentAssembly>
>>> -      <assemblyIdentity
>>> -        type="win32"
>>> -        name="Microsoft.Windows.Common-Controls"
>>> -        version="6.0.0.0"
>>> -        publicKeyToken="6595b64144ccf1df"
>>> -        language="*"
>>> -        processorArchitecture="*"
>>> -      />
>>> -    </dependentAssembly>
>>> -  </dependency>
>>> -  <asmv3:application xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">
>>> -    <asmv3:windowsSettings>
>>> -      <dpiAware
>>> xmlns="http://schemas.microsoft.com/SMI/2005/WindowsSettings">true</dpiAware>
>>> -      <dpiAwareness xmlns="http://schemas.microsoft.com/SMI/2016/ 
>>> WindowsSettings">PerMonitorV2</dpiAwareness>
>>> -    </asmv3:windowsSettings>
>>> -  </asmv3:application>
>>>   </assembly>
>>
>> But the mintty manifest looks correct. Compared to the default mainfest,
>> it just tells the OS that it's a GUI process and that it's DPI aware.
>>
>> Maybe the older dpiAware could be set to "true/pm", but I can't judge
>> that, actually.
>>
>> The rest of the manifest claims compatibility with all Windows versions
>> since Vista up to Windows 10/11, as usual.  So it's no surprise that
>> task manager prints no downgraded OS compatibility context for mintty.
>>
>> But then again, why on earth is mintty running in PCA job at all?!?
>>
>> iIt would be great if we could get rid of this code in Cygwin.
>>
>> OTOH, what keeps the PCA heuristics to change the rules with every
>> OS release?

Suggest maybe change Company and Copyright to "Cygwin authors" to drop "Andy 
Koppe" or change to "A.Koppe" if you insist?

Details are missing below and docs may be for W7 not later, but dumps .

https://learn.microsoft.com/en-us/archive/blogs/yongrhee/download-windows-10-assessment-and-deployment-kit-adk

https://learn.microsoft.com/en-us/archive/blogs/yongrhee/download-application-compatibility-toolkit-act-for-windows-10

https://learn.microsoft.com/en-us/previous-versions/windows/it-pro/windows-10/deployment/compatibility/compatibility-fixes-for-windows-8-windows-7-and-windows-vista

https://github.com/libyal/assorted/blob/main/documentation/Shim%20Database%20(SDB)%20format%20specification.asciidoc

https://www.geoffchappell.com/studies/windows/win32/apphelp/sdb/index.htm
https://www.geoffchappell.com/studies/windows/win32/apphelp/sdb/shimdbc.htm
https://www.geoffchappell.com/studies/windows/win32/apphelp/sdb/shimdbdc.htm

$ grep -ail 'm.\?i.\?n.\?t.\?t.\?y\|Y.\?T.\?T.\?N.\?I.\?M' `cygpath 
-UW`/AppPatch/*.sdb
/proc/cygdrive/c/Windows/AppPatch/sysmain.sdb
$ grep -abo 'm.\?i.\?n.\?t.\?t.\?y\|Y.\?T.\?T.\?N.\?I.\?M' `cygpath 
-UW`/AppPatch/sysmain.sdb | cat -A
39118:YTTNIM$
3330486:m^@i^@n^@t^@t^@y$
3330542:m^@i^@n^@t^@t^@y$
$ grep -abo 'm.\?i.\?n.\?t.\?t.\?y\|Y.\?T.\?T.\?N.\?I.\?M' `cygpath 
-UW`/AppPatch/sysmain.sdb | cut -d: -f1 | xargs -I@ printf "%8d %08x\n" @ @
    39118 000098ce
  3330486 0032d1b6
  3330542 0032d1ee
$ xxd -g1 `cygpath -UW`/AppPatch/sysmain.sdb | grep 
'^00\+\([0-2]\|98[cd]\|32d1[b-f]\|32d20\)0:\s'
00000000: 03 00 00 00 00 00 00 00 73 64 62 66 02 78 72 5d  ........sdbf.xr]
00000010: 02 00 03 78 e8 2a 01 00 02 38 07 70 03 38 01 60  ...x.*...8.p.8.`
00000020: 16 40 01 00 00 00 01 98 d4 2a 01 00 45 58 45 2e  .@.......*..EXE.
000098c0: 4c 4c 41 54 53 4e 49 4d 50 28 13 00 45 2e 59 54  LLATSNIMP(..E.YT
000098d0: 54 4e 49 4d d0 29 13 00 41 4d 52 4f 52 52 49 4d  TNIM.)..AMRORRIM
0032d1b0: 01 88 16 00 00 00 6d 00 69 00 6e 00 74 00 74 00  ......m.i.n.t.t.
0032d1c0: 79 00 2e 00 65 00 78 00 65 00 00 00 01 88 16 00  y...e.x.e.......
0032d1d0: 00 00 41 00 6e 00 64 00 79 00 20 00 4b 00 6f 00  ..A.n.d.y. .K.o.
0032d1e0: 70 00 70 00 65 00 00 00 01 88 0e 00 00 00 6d 00  p.p.e.........m.
0032d1f0: 69 00 6e 00 74 00 74 00 79 00 00 00 01 88 20 00  i.n.t.t.y..... .
0032d200: 00 00 6d 00 69 00 72 00 72 00 6f 00 72 00 6d 00  ..m.i.r.r.o.r.m.

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry

