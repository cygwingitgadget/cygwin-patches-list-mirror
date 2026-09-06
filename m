Return-Path: <SRS0=Jx4T=G6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo001.btinternet.com (btprdrgo001.btinternet.com [65.20.50.131])
	by sourceware.org (Postfix) with ESMTP id 142404BC7EDB
	for <cygwin-patches@cygwin.com>; Sun,  6 Sep 2026 22:10:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 142404BC7EDB
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 142404BC7EDB
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.131
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1788732635; cv=none;
	b=mVVABRi0zO+WYNm+1nVbfgG5h4z7AHxpQ9BH0J4MD+ljsnFNF9qP97AAvPQywbCtSLDLAsubzuNDclKIziTU+2cAihKDlsJwt4dw4ceYXTYLrclpVwpJmCOVpG7xx5whG0Qaq/iOzwLWYNHsC+SCOhK+YYCKBQZ1SquoDVi8hvQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1788732635; c=relaxed/simple;
	bh=Pk+Jy4WauS1AxFeBq0KuRNqJpQbDmhEKRvyqk9/LpH0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=fPYFJvZ/uwezH1qjKbgS4MdhOp/P+X3fq1a+wp/yk5vHFld9+jxe+RMaV0qOyeZ+ccry7cg6ctth4O8q4lVXP0tZCAfCDEO0RBimjFP8g7PJe8eLyi9wg0ka5r8KsITdtlBUun/4IywK7tvN6Qk9OiHjIce/mOSqsXuypTFWAL4=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 142404BC7EDB
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A700E34064C0CA5
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEZACq1Mqbn1LwnW3zXsflqZoTzC6q+5dwH2PlvLkqjzUk5rOnKhFTbvEVNp++0yqQs50zPRyCU8MucAlKs/UjgAkFjRGQcoo+QYOx3k/PH8j8bwDvbuGWwVZwCb1XdVQ0xsOcEgZsz0njBwMs9jIxfyxvmXJghBlx9pPqMICthdvZP64Jjvca3WTi9kkely7/BgwcO8xKc0qRBiBSKXaTDIiksJuOnbuUNkcsUH3rprZunXMqetvWVnn9os6Q7Sz3Pi/7pzmg6YN6QvQz3JZfZlhvIOvxX0YPJlg+CcaFR2/ysHbitjkfsgGPYifilSyBKOL3b4sB3EoJLquijE69itFrFueELGIiuuc3CAz9bYUBkN+7YhsvpGiyZcbVDKd94JHaE66tALK/CARMxRMUHp6o7C99PU2WFBsVKGn/1o6mOHdZ0wQo0WPjaNohNJSt+aZf6u6gkxKCoqPvfg/3OkNO0VqKTnwX2ia3FIYFLeLov70AFTEYrefsgMZgU6i+wx4jrO0U7xv+kb7AJ1hiBb9cuth7QGDA5zyeSZ495SDytbueVRdHipnUeVMHsdZZuddzjbgqJ3cSKPqsSSLapJVSk8IKCkdSIpL+U9Ep381/x3yLA7D1ZYbWU25nuI8fRzwuptrrF5KlTnziSJOdhsTP0SEZJYxOgQO9VAOcpNg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo001.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A700E34064C0CA5; Sun, 6 Sep 2026 23:10:31 +0100
Message-ID: <c6f2d178-7b2c-44b6-9d70-8f3e4ce461cc@dronecode.org.uk>
Date: Sun, 6 Sep 2026 23:10:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: resolve AArch64 linking by linking to onecore
 instead of kernel32
From: Jon Turney <jon.turney@dronecode.org.uk>
To: Radek Barton <radek.barton@microsoft.com>
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>,
 Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>,
 Mate Dimand <Mate.Dimand@arm.com>
References: <DB9PR83MB09239F1F48DD7D215E1A0B6E9248A@DB9PR83MB0923.EURPRD83.prod.outlook.com>
 <aHUCHQvK7UKMepvh@calimero.vinschen.de>
 <2549df98-c96f-48b7-9ddf-f1272ff505c2@dronecode.org.uk>
 <ecebaf4b-7558-41b1-ad80-a7fe52995673@dronecode.org.uk>
Content-Language: en-GB
In-Reply-To: <ecebaf4b-7558-41b1-ad80-a7fe52995673@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/06/2026 21:03, Jon Turney wrote:
> On 05/06/2026 15:37, Jon Turney wrote:
>> On 14/07/2025 14:11, Corinna Vinschen wrote:
>>> Hi Radek,
>>>
>>> On Jul 10 19:14, Radek Barton via Cygwin-patches wrote:
>>>> Hello.
>>>>
>>>> As Windows Arm64 platform does not carry historical compatibility 
>>>> layers, the structure of Windows API DLLs is cleaner on Arm64 than 
>>>> on x64. For this reason, the x64 linking against `kernel32.dll` is 
>>>> not sufficient leading to undefined references to many Windows API 
>>>> symbols that are in different DLLs that would have to be added to 
>>>> the linking command explicitly.
>>>>
>>>> To address that, there is a concept of umbrella DLLs (https:// 
>>>> learn.microsoft.com/en-us/windows/win32/apiindex/windows-umbrella- 
>>>> libraries), that can be added instead. The recommended replacement 
>>>> for `kernel32.dll` is `onecore.dll` (https://learn.microsoft.com/en- 
>>>> us/windows-hardware/drivers/develop/building-for-onecore#building- 
>>>> for-onecore) that should be available since Windows 7.
>>>>
>>>> In case of Cygwin linking, there is one exception, `pdh.dll` 
>>>> (Performance Data Helper, https://learn.microsoft.com/en-us/windows/ 
>>>> win32/perfctrs/performance-counters-functions), that is not included 
>>>> in the `onecore.dll`.
>>>
>>> The pdh functions used by Cygwin are NOT linked against.  They are
>>> runtime loaded (see autoload.cc, right at the end), so it should not be
>>> necessary to link against libpdh.a.  Can you please check again?
> 
>>   I assume that -lpdh has been added here because the autoload stubs 
>> used during aarch64 development translate into direct linkage.
>>
>> Hopefully, it's not necessary with a full autoload implementation .
> 
> So, my speculation seems to be correct.
> 
> The other issue here is that we can't link against non-well-known DLLs 
> here without making ourselves vulnerable to DLL hijacking attacks. (This 
> detail probably needs to be noted in a comment here).
> 
> It's unclear that to me that the onecore umbrella import library makes 
> that guarantee? (So we could accidentally introduce the use of an API 
> from a non-well-known DLLs without noticing)
> 
> So maybe this needs to be conditional on the arch? Or perhaps the 
> solution is to autoload the problematic APIs here?

CC'ing recent aarch64 contributors, as this seems to be the remaining 
outstanding aarch64 patch without a resolution.

When I try to build with '-lkernel32 -lntdll'

>   CXXLD    new-cygwin1.dll
> libdll.a(exceptions.o): in function `__unwind_single_frame':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:329:(.text+0x420): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlLookupFunctionEntry' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01253.o)
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:331:(.text+0x490): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlVirtualUnwind' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01260.o)
> libdll.a(exceptions.o): in function `cygwin_stackdump':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:500:(.text+0x184c): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlCaptureContext' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01245.o)
> libdll.a(exceptions.o): in function `signal_exit':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:1514:(.text+0x1acc): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlCaptureContext' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01245.o)
> libdll.a(exceptions.o): in function `exception::myfault(_EXCEPTION_RECORD*, void*, _CONTEXT*, _DISPATCHER_CONTEXT_ARM64*)':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:628:(.text+0x1b5c): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlUnwindEx' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01259.o)
> libdll.a(exceptions.o): in function `myfault_altstack_handler(_EXCEPTION_POINTERS*)':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:656:(.text+0x1bd8): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlRestoreContext' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01257.o)
> libdll.a(exceptions.o): in function `_cygtls::call_signal_handler()':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:1872:(.text+0x396c): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlCaptureContext' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01245.o)
> libdll.a(exceptions.o): in function `__unwind_single_frame':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:329:(.text+0x3980): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlLookupFunctionEntry' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01253.o)
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:331:(.text+0x39f4): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlVirtualUnwind' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01260.o)
> libdll.a(exceptions.o): in function `_cygtls::sigdelayed_impl(_CONTEXT*)':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:977:(.text+0x3cc8): relocation truncated to fit: IMAGE_REL_ARM64_PAGEOFFSET_12L against symbol `__imp_RtlRestoreContext' defined in .idata$5 section in /usr/aarch64-pc-cygwin/sys-root/usr/lib/w32api/libkernel32.a(libkernel32s01257.o)
> libdll.a(exceptions.o): in function `getcontext':
> /home/jon/src/newlib-cygwin/build_aarch64/aarch64-pc-cygwin/winsup/cygwin/../../../../winsup/cygwin/exceptions.cc:2222:(.text+0x3e28): additional relocation overflows omitted from the output
These are relocation truncation rather than undefined symbol errors.

Linking with just '-lonecore' resolves this somehow, but since these 
symbols seem to be provided by ntdll, this looks like maybe a toolchain 
issue instead?

