Return-Path: <SRS0=+Hn8=2D=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	by sourceware.org (Postfix) with ESMTPS id B8A993858D1E
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 21:52:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B8A993858D1E
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B8A993858D1E
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.10
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1753221177; cv=none;
	b=fg4zQ1cenkXu0HyGTAkxHe5JJ9fdV3Sk/WFv0Yvgb30YVOiCnHY9NQwi8fsJ3BSLsTvaTYRXh0D9OHy9uLhehp+HCrt/yk9OGUge/ZFd0ua5o3DpMfvPwIhiW+Rj26wFICSDMaxBWSPjcEd2mLd455xqXcZViLMFhgfGZcSN29A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1753221177; c=relaxed/simple;
	bh=9E5976PJOPFcOUG0+vFwys1KZqVZkOkWDe7EylEaR4c=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=gPn7duZi5qbuYKsUgZ65gRbhtkT+lEywrxtuWTm0GK3EmSBlt0MG+LWG4q/8dvJybMejpraJE/hTfUKdMS3oYb2K1AqagWmPlXbzQ6M/9GiMLi548V8SLAosOJG1IJ+XHDcqSlXXF/8jXYX0p5UZGIz+AfTeAL/FAM768sCvKE8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B8A993858D1E
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=EN1Af2C7
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 5C3DC13197E
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 21:52:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf10.hostedemail.com (Postfix) with ESMTPA id EB5EC2F
	for <cygwin-patches@cygwin.com>; Tue, 22 Jul 2025 21:52:55 +0000 (UTC)
Message-ID: <d5184a8b-d0a4-4a25-b7cd-f08d1eeb493e@SystematicSW.ab.ca>
Date: Tue, 22 Jul 2025 15:52:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [EXTERNAL] Re: [PATCH] Cygwin: mkimport: implement AArch64 +/-4GB
 relocations
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <DB9PR83MB0923E3D187978CF43940B188925DA@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aH4NM_WJNC2KHpHT@calimero.vinschen.de>
 <23af2767-7e76-74fd-198f-2abdee7cc73e@jdrake.com>
 <GV4PR83MB0941B168699D42E77A73814F925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9Pi6bJNDa_Q7V1@calimero.vinschen.de>
 <GV4PR83MB09417042234459A19594C15C925CA@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <aH9jZCS92AGUaP-o@calimero.vinschen.de>
 <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
Organization: Systematic Software
In-Reply-To: <b76de53a-24a7-0983-c756-2fd7213950f2@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EB5EC2F
X-Stat-Signature: yjfp1zp37sfkqaj3usw9n74eq8xusg64
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Rspamd-Server: rspamout02
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX1/hwCeXiVHCUb6YjNYUvldQHrMaCcqBMMo=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to:content-type:content-transfer-encoding; s=he; bh=vXjsA9vFzDourqyJeW80i4u1T6yF8zW+Jr/3/u1f7vs=; b=EN1Af2C7BmqGkxQLoqvS1txNCWlWRQtGHHJauAIWxtFDcJNB3jCJcX3FfAJvzhBPbN08Tl95bWwlRal8iiQ1u8GZ6VzH3bUwKFPFwYRwcL1ZxaeUe4UihhWN2qP1M8jTqQOuRIc6jGPxbyeoSfh+xqj9qFsrvMcIX9BQnkizybNOCOS4uSUMd+2iNxD0H/AgZbGqM5IbiiW/ptetWlIkHlYtfjiKn69sVa4vdQu3bUT38v2/xEeSwsg/tHyTWlX2lSkedEZpKEgxhLBvN43ofXo2MNEDuc0V0aRAYuA1lpiX7ibNojHQGJALw/D0r0/Pq/hRy93tF/FJeqepIv6HVw==
X-HE-Tag: 1753221175-846717
X-HE-Meta: U2FsdGVkX1+eTQq71dnWyG9GJtZisWnXdKENwR4h0GkdGIkt0wqWN9PI94EoMLta5aM4bVYaFc9/pnlEE731X3eMiZ5XnplJE/qFSx+pHaRAgnQWShwxv2YB33rGlW69QAll6sZfZ/bbUW//WLiB2Bk0ywZlpYJlMs3LpJuwHRxV5WLu5rouN7cwly1IWM/kW6wavbFvl8q+nY/GtMUoGoidW/7/U/CQ2in0YKdLsbfJGp5knWhRFooKmt2hpJrgV4OSaaFeNtyUQ1CNrmIQ4Sbl1gdC36dEEVb4SmHEOfMSAiPpte4Nnx5LAry7aPNxgmztdUID5NCLl+IwQliqa1hg3sd6IFed
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 2025-07-22 11:20, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 22 Jul 2025, Corinna Vinschen wrote:
> 
>> On Jul 22 09:12, Radek Barton via Cygwin-patches wrote:
>>> Hello.
>>>
>>> Thank you for this insight. So, if I build tcsh using AArch64 Cygwin
>>> GNU toolchain, I should see if this behaves correctly with debugger?
>>
>> Yes, that would probably be helpful.  tcsh overwrites the malloc/free
>> entries of __cygwin_user_data in _cygwin_crt0_common(), which is linked
>> into the executable.  This occurs after dll_crt0_0, but before dll_crt0_1.
>>
>> So what you should see is somthing like this:
>>
>> (gdb) br dll_crt0_0
>> (gdb) br dll_crt0_1
>> (gdb) r
>> Starting program: /bin/tcsh
>> [New Thread 1832.0x4ac]
>> [New Thread 1832.0x22d0]
>>
>> Thread 1 hit Breakpoint 1, dll_crt0_0 ()
>> [...]
>> (gdb) p __cygwin_user_data.malloc
>> $6 = (void *(*)(size_t)) 0x7ffc8504cee9 <malloc>   <== pointing into cygwin1.dll
>> (gdb) c
>> Thread 1 hit Breakpoint 2, dll_crt0_1 ()
>> [...]
>> (gdb) p __cygwin_user_data.malloc
>> $6 = (void *(*)(size_t)) 0x100448940 <malloc>      <== pointing into tcsh
> 
> This wouldn't be an import though.  I guess malloc would need to be
> imported from a different dll for that case...
> 
>> Theoretically import_address() is only required to be able to resolve
>> pointers into the Cygwin DLL itself correctly.  If it can resolve all
>> variations of import table entries created by gcc for the Cygwin DLL,
>> it's sufficient.  If other variations exist, but are never emitted by
>> gcc(*), it would be entirely sufficent if import_address() returns NULL.
>>
>> tl;dr: As long as it always recognizes
>>
>>    import_address ((void *) user_data->malloc) == &_sigfe_malloc
>>
>> we're good.
> 
> ... But apparently it doesn't matter if it gets the jump stub or the
> imported function for that case.
> 
> Just for the record, these import jump stubs are generated by the linker
> (or dlltool as part of the import library).  Apparently for the Cygwin
> dll, the import library (or at least these parts of it) are generated by
> mkimport rather that via the normal dlltool process.  So it's probably OK
> if this code only recognizes the form of import stub generated by mkimport
> which with this patch now matches what MS and LLD generate).  It's strange
> to me that binutils' dlltool uses an additional instruction that doesn't
> seem to be necessary.  It may not be a bad idea to either support that or
> at least add a comment documenting that that's the case, in case
> something later wants to use this function for some other import case.

Perhaps an implementation glitch, erratum, exception level or execution state 
issue in some early ARMv8 AArch64 SoC target loader?

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
