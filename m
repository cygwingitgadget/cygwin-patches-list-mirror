Return-Path: <SRS0=1UnV=AS=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	by sourceware.org (Postfix) with ESMTPS id E505D4BA23C7
	for <cygwin-patches@cygwin.com>; Sat, 14 Feb 2026 10:36:21 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E505D4BA23C7
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E505D4BA23C7
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.13
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771065382; cv=none;
	b=tnPu6T0YNuOb8ehYlFl0ihJe9CQmD3S6ASytZi30NXCDXOYUWp9bTaF3QhBXqZKMukX5pnddl3w6DkePCWoL4ezx58S46gcp5B1r1GaZH6au9TOxHdgIllodLVyTx/IWkn707r3e0tawKWLgnqkOjdcXHRQ0SlP7l6zXu6t6Bw0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771065382; c=relaxed/simple;
	bh=uts3NBboOrZTlAtiISuM2i9vMr8cKVFeqtOA8HBrFYY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=xQMq+9lb6LkzCUR4KX13/LpCnJ26DX2+NumnJnlbzQglXpvcmWIZdiIz9ABCjooTGaZYFdCr40gqktDPPYZLE8DbTXmJQKZsWwCyiH8jjWGQXTQWDksPxyVgwTR+Ff0t26ol2hhc5fYbBbc+audfEeyieGn7xDzktDXJhvQ62Yg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E505D4BA23C7
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=OaudoQ4Q
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 77A05140830
	for <cygwin-patches@cygwin.com>; Sat, 14 Feb 2026 10:36:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf01.hostedemail.com (Postfix) with ESMTPA id 1304E60010
	for <cygwin-patches@cygwin.com>; Sat, 14 Feb 2026 10:36:19 +0000 (UTC)
Message-ID: <f6ac6e63-24d9-4fdc-b064-dedcc57fd041@SystematicSW.ab.ca>
Date: Sat, 14 Feb 2026 03:36:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Cygwin: improve PCA workaround
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <20260126111345.386303-4-corinna-cygwin@cygwin.com>
 <b081744f-c953-4ca2-bdc9-fdd260acb494@SystematicSW.ab.ca>
 <aZBHUzq6ttMgLEgT@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <aZBHUzq6ttMgLEgT@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 1304E60010
X-Stat-Signature: 36y6yo9cbjy9sqfbfomiki54wypmb8r3
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX18EumCHcRmYknn14JzcGZ1+JgfqKhZ4exU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=5ySDWj6nRpZl3ndlnHAUlIQQRiYMClSAjFw8IoD2mWU=; b=OaudoQ4Q8WZD9KX0Zxh5gXUxny+tC/3dGR1S/hFIVBZksOY1tn75CRD8bD9sAYCuZhfS/N9kTmEcmZklpKXXcfPLrhprFSSiNc5KMksJO4c2vpfMbSE/F891XQlNh97vVQRzPp+Vf/eEwRXENlSZA3k+e2Q4Lt7BcdSTxtchLfPwhiF+zJCjZE29w1bzcOHl/oxDgcd92tNrOBqxciJZW/MvlcFKo8QMiNUf94ZspGBQ19p2KPdZAQTgbFse5PwCsjbw9fU7wwRnWqkqB8dSp+Q9mSm53OJs3ITc7+l1Bd85OLY+ZZT/JRQzuxz/81dtRs+YMz468CeMMqPm0AYRmw==
X-HE-Tag: 1771065379-509534
X-HE-Meta: U2FsdGVkX1/V4fPbI6s1JXeUJ0WWQ13u8dlDWVwmjCZChDHzu3ZawYys2a3wT0TOJwfkIz/4jiqmsoI4uxN80v6PbGNnBd+WDaHUTQqhGwvBgUA1pf7QB2vT8nJVQ83M7hQqGLbpG1OVNEwNKdF6PcfXVhseIja8CbWw/qK2hQrprlHxUMNU4f74StAPnxrBH3VaBkQiwfi+kb8tqmKFCBqMRPQWkT/WD2AL+SzrVNA9riC0DBGkko12gPd7JVuneL56Wd04fX0BnwMti8OSbTOUokDI4MPXM7R5emctjDDrdUklP3tl7K4boqx0TPZoWunJT+bwJeAGBgxlSSdl0EBFaOqz98PL4bC13qyWV5YPwKi53c3H2w==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2026-02-14 02:58, Corinna Vinschen wrote:
> 
> [CCing Thomas]
> 
> On Feb 13 17:36, Brian Inglis wrote:
>> On 2026-01-26 04:13, Corinna Vinschen wrote:
>>> From: Corinna Vinschen <corinna@vinschen.de>
>>
>>> Perform the check only if we're the root process of a Cygwin process
>>> tree.  If we start mintty from Cygwin, the PCA trigger doesn't occur.
>>
>>> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
>>> index 1d5a452b4fbc..e080aa41bca2 100644
>>> --- a/winsup/cygwin/dcrt0.cc
>>> +++ b/winsup/cygwin/dcrt0.cc
>>> @@ -253,6 +253,17 @@ frok::parent (volatile char * volatile stack_here)
>>>         systems. */
>>>      c_flags |= CREATE_UNICODE_ENVIRONMENT;
>>> +  /* Despite all our executables having a valid manifest, "mintty" still
>>> +     triggers the "Program Compatibility Assistant (PCA) Service" for
>>> +     some reason, maybe due to some heuristics in PCA.
>> All makes sense and looks reasonable to a non-Windows type!
>>
>> There are no differences between the windows or either mingw64 default
>> manifests, but mintty has extra, after tweaking its order and layout to
>> match, so perhaps something there needs updated in GH:
>>
>> $ diff res.mft default-manifest.mft
>> --- res.mft	2026-02-13 17:21:21.491931500 -0700
>> +++ default-manifest.mft	2026-02-13 17:18:08.759527200 -0700
>> @@ -3,40 +3,22 @@
>>     <trustInfo xmlns="urn:schemas-microsoft-com:asm.v3">
>>       <security>
>>         <requestedPrivileges>
>> -        <requestedExecutionLevel level="asInvoker" uiAccess="false"/>
>> +        <requestedExecutionLevel level="asInvoker"/>
>>         </requestedPrivileges>
>>       </security>
>>     </trustInfo>
>> --
>> -  <dependency>
>> -    <dependentAssembly>
>> -      <assemblyIdentity
>> -        type="win32"
>> -        name="Microsoft.Windows.Common-Controls"
>> -        version="6.0.0.0"
>> -        publicKeyToken="6595b64144ccf1df"
>> -        language="*"
>> -        processorArchitecture="*"
>> -      />
>> -    </dependentAssembly>
>> -  </dependency>
>> -  <asmv3:application xmlns:asmv3="urn:schemas-microsoft-com:asm.v3">
>> -    <asmv3:windowsSettings>
>> -      <dpiAware
>> xmlns="http://schemas.microsoft.com/SMI/2005/WindowsSettings">true</dpiAware>
>> -      <dpiAwareness xmlns="http://schemas.microsoft.com/SMI/2016/WindowsSettings">PerMonitorV2</dpiAwareness>
>> -    </asmv3:windowsSettings>
>> -  </asmv3:application>
>>   </assembly>
> 
> But the mintty manifest looks correct. Compared to the default mainfest,
> it just tells the OS that it's a GUI process and that it's DPI aware.
> 
> Maybe the older dpiAware could be set to "true/pm", but I can't judge
> that, actually.
> 
> The rest of the manifest claims compatibility with all Windows versions
> since Vista up to Windows 10/11, as usual.  So it's no surprise that
> task manager prints no downgraded OS compatibility context for mintty.
> 
> But then again, why on earth is mintty running in PCA job at all?!?
> 
> iIt would be great if we could get rid of this code in Cygwin.
> 
> OTOH, what keeps the PCA heuristics to change the rules with every
> OS release?
> 
>> Cygwin seems to have no mintty repos available!
>> Perhaps GH mintty/mintty should be mirrored on sourceware?
> 
> All but a few projects in the distro are not on sware.  As long as
> it's OSS and the sources can be found on a public repo, all is well,
> isn't it?

Some maintainers and others will not touch GH, so have no access to those 
upstreams, except via package sources, unlike most other apps and packages, 
where I first looked for a mintty repo.

I know Thomas is working on getting mintty to a point where it can be built with 
cygport in CI, like cygwin et al.

Wouldn't we all be happier if main CI was not on MS GH, and sourceware could 
host some Windows build environment(s)?

I have asked the question, but other than responses saying that would be a good 
idea, I am unsure if anyone knows what the policies are about hosting and 
supporting commercially licensed software, and if there would be any capability 
or technical support available?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
