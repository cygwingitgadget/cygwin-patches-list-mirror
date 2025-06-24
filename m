Return-Path: <SRS0=RpLB=ZH=arm.com=Richard.Earnshaw@sourceware.org>
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by sourceware.org (Postfix) with ESMTP id 1597B385734D
	for <cygwin-patches@cygwin.com>; Tue, 24 Jun 2025 09:51:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 1597B385734D
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=arm.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 1597B385734D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750758676; cv=none;
	b=DNl/yIInrt8AZU33kBwK2QAGE9QEvMZsxQYE3FG2aLFPhnmfR103mGroYYdYkbrvCYWDYjRwg2vIddhF8uFxttaUaRic9SvVpLPCxVp0R5vY9DWwIhVa1R7lpTQnpnlBNVsSBeE3vF5sNO8vAe9HOyTxIi0V/p85puXx8c/8Z6o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750758676; c=relaxed/simple;
	bh=Thm1iKZpZNcw7e+agvh4Ue8b5sAw1Hj9hDvqF1Irn5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=d5Y2dVdH5oNI0l1DxBZ3KHiHwJElWuWpMa1rjT9oiA47OgY4AU8xFqr9lk3hWIb6PQlkxrhjpOF/PbFKv4DYh++N9/zAFRqBfYGWiLNCwXa/Nye0Y264w07Qdtl5h2E+wcW1omnqF2vNi2i4Cs5GsSzch6oVzJVmAUM98U73uIg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 1597B385734D
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCCCA106F;
	Tue, 24 Jun 2025 02:50:57 -0700 (PDT)
Received: from [10.1.39.80] (J0CR3MJ6JD.cambridge.arm.com [10.1.39.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D8A683F66E;
	Tue, 24 Jun 2025 02:51:14 -0700 (PDT)
Message-ID: <fb268bfa-9b3f-4a58-bd0c-51afc9075e3b@arm.com>
Date: Tue, 24 Jun 2025 10:51:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/QUESTION] newlib: fenv: AArch64 Cygwin linking fixes
To: Radek Barton <radek.barton@microsoft.com>, Newlib
 <newlib@sourceware.org>,
 "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <GV4PR83MB0941761524523870C31AC5BD9270A@GV4PR83MB0941.EURPRD83.prod.outlook.com>
 <91bf97b2-383c-44a8-a2f3-9c38dfddcfb2@arm.com>
 <aFphi2eE4XmnypdT@calimero.vinschen.de>
Content-Language: en-GB
From: Richard Earnshaw <Richard.Earnshaw@arm.com>
In-Reply-To: <aFphi2eE4XmnypdT@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3495.1 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_NONE,KAM_DMARC_STATUS,KAM_LAZY_DOMAIN_SECURITY,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 24/06/2025 09:27, Corinna Vinschen wrote:
> On Jun 23 16:36, Richard Earnshaw (lists) wrote:
>> On 16/06/2025 12:31, Radek Barton wrote:
>>> Hello.
>>>
>>> This is more a question than patch submission: Without the attached changes, the Cygwin cannot be linked for AArch64 failing on:
>>> ```
>>> ld: cannot export _fe_nomask_env: symbol not defined
>>> ld: cannot export fedisableexcept: symbol not defined
>>> ld: cannot export fegetexcept: symbol not defined
>>> ld: cannot export fegetprec: symbol not defined
>>> ld: cannot export fesetprec: symbol not defined
>>> ```
>>> Can anybody share some insights why are those changes needed and whether there is a better way how to overcome this issue?
>>>
>>> Note that the `feenableexcept`, `fedisableexcept`, `fegetexcept` implementations are similarly defined in `newlib/libc/machine/mips/machine/fenv-fp.h` for MIPS architecture as well.
>>>
>>> Thank you,
>>>
>>> Radek
>>>
>>
>> Ugh, this is a real rat's nest of code...
>>
>> I may be on completely the wrong track, but I think the clue is in the comment:
>>
>>   +/* We currently provide no external definitions of the functions below. */
>>
>> So it is expected that these functions have no definition in a file, but will be inlined into the calling code when needed.  This is why they are provided in fenv.h.  fenv-fp.h seems to be the internal header that is used for code that will create the non-inlined versions; the header file fenv-fp.h isn't exported from the library though (it's only used while building it), so anything defined there will never be inlined into user code.
>>
>> I suspect that the underlying issue is that coff libraries rely on
>> explicitly exporting symbols, while ELF libraries do that implicitly
>> (unless something is explicitly marked hidden).
> 
> I wonder if this is really the issue, because binutils ld performs
> its auto-export magic for coff symbols for ages on Cygwin.  Unless
> you define exactly the symbols to export in a .def file, that is.
> 
> However, Cygwin's .def file explicitly exports the above fe* symbols.
> 
> They are just not actually present in the object files in case of the
> aarch64 build per Radek.
> 
> 
>> What I don't fully understand is what role __BSD_VISIBLE might have
>> here.  If that's not defined (which I'd think is possible in CYGWIN),
> 
> Only for applications built under Cygwin, but not for building the Cygwin
> DLL itself, which is the problem here.
> 
>> then I can't see how your changes would resolve this.
>>
>> I'm guessing (somewhat) that libm/.../fenv.c should perhaps define __BSD_VISIBLE before including fenv.h to force the inline functions to become visible.
>>
>> The other alternative might be to remove the list of functions scoped by the ifdef from libm/machine/aarch64/fenv.c so that the functions that file exports matches the comment I mentioned above.
>>
>> Perhaps you could try this patch instead of yours and let me know if it resolves the issue:
>>
>> diff --git a/newlib/libm/machine/aarch64/fenv.c b/newlib/libm/machine/aarch64/fenv.c
>> index 3ffe23441..fb6a67dcc 100644
>> --- a/newlib/libm/machine/aarch64/fenv.c
>> +++ b/newlib/libm/machine/aarch64/fenv.c
>> @@ -27,6 +27,9 @@
>>    * $FreeBSD$
>>    */
>>   
>> +/* Enable all fenv-related functions.  */
>> +#define __BSD_VISIBLE
>> +
>>   #define        __fenv_static
>>   #include <fenv.h>
>>   #include <machine/fenv-fp.h>
> 
> Worth a try.
> 
> 
> Thanks,
> Corinna
> 

There's another possibility for what is going wrong here: that on cygwin 
we're somehow picking up the wrong implementation of sys/fenv.h.  For 
example there's a version in libc/include/sys that lacks the inline 
versions of functions that libc/machine/aarch64/sys provides.  If that 
is the case, it might simply be that cygwin is not being configured 
correctly to find the aarch64-specific headers.

I think it would be instructive to look at the pre-processed source of 
fenv.c to see exactly which headers are being used.

R.

