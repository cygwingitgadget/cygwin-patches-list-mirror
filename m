Return-Path: <SRS0=FkOy=IU=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-044.btinternet.com (mailomta7-re.btinternet.com [213.120.69.100])
	by sourceware.org (Postfix) with ESMTPS id E4EDE3858D38
	for <cygwin-patches@cygwin.com>; Wed, 10 Jan 2024 17:38:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E4EDE3858D38
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E4EDE3858D38
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.100
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1704908291; cv=none;
	b=b9HoMq3vXyJDIommS5/LXRLw0DJ+C5PGj7gwwe4ezmUKc50EIMj2I5jf/m1ZU60TIb+yR5MJ/zXn8E0bsU+adic5VCRMsGpe7Nr1HtyZJpi91a2fyAafIxPJh9Z4tSrzX9kOY8uOA9ThvatbsKpM0vY4sDFTVBw5qGpl9eaU0hQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1704908291; c=relaxed/simple;
	bh=j0kD6kY6RuOv24c7nYRm9AlZMDjLiz+PSddQXsKJCEk=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=ujK0VG6T5Hz9td591QGh6lB6ieBeqwIRXGn+4JAu19rE4qYMxb/3idFIbLhv6ONwAOKDG1UG3X7g8Kdps+O6ifS1Yh4xYdyH/mLB6iCIcrlj96gqxePoEvIwpfgdFX0FjZDD6eKvIPCBAGD3KGJZgWYGzp8Dmt1SirfhT3n1H2I=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-044.btinternet.com with ESMTP
          id <20240110173807.LUNY24338.re-prd-fep-044.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Wed, 10 Jan 2024 17:38:07 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B87C03900BB1
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddguddtudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemuceutffkvffkuffjvffgnffgvefqofdpqfgfvfenuceurghilhhouhhtmecufedtudenuchmihhsshhinhhgucfvqfcufhhivghlugculdeftddmnecujfgurhepkfffgggfufhfhfevjggtgfesthejredttddvjeenucfhrhhomheplfhonhcuvfhurhhnvgihuceojhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgffhgefgffelveejheeiteekveefhfelledvudduvdevledtkeeufeelleeljeejnecuffhomhgrihhnpehmihgtrhhoshhofhhtrdgtohhmnecukfhppeekiedrudefledrudehkedruddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhephhgvlhhopegludelvddrudeikedruddruddtjegnpdhinhgvthepkeeirddufeelrdduheekrddutdefpdhmrghilhhfrhhomhepjhhonhdrthhurhhnvgihsegurhhonhgvtghouggvrdhorhhgrdhukhdpnhgspghrtghpthhtohepuddprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhmpdhrvghvkffrpehhohhsthekiedqudefledqudehkedquddtfedrrhgrnhhgvgekiedqudefledrsghttggvnhhtrhgrlhhplhhushdrtghomhdprghuthhhpghushgvrhepjhhonhhtuhhrnhgvhiessghtihhnthgvrhhnvght
	rdgtohhmpdhgvghokffrpefiuedpoffvtefjohhstheprhgvqdhprhguqdhrghhouhhtqddttdeg
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by re-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B87C03900BB1 for cygwin-patches@cygwin.com; Wed, 10 Jan 2024 17:38:07 +0000
Message-ID: <b1cbea19-824e-4763-ad69-f634beb0c081@dronecode.org.uk>
Date: Wed, 10 Jan 2024 17:38:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] Cygwin: Make 'ulimit -c' control writing a coredump
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
 <20240110135705.557-2-jon.turney@dronecode.org.uk>
 <ZZ64BtnmZtmyRZYi@calimero.vinschen.de>
Content-Language: en-GB
From: Jon Turney <jon.turney@dronecode.org.uk>
Cc: cygwin-patches@cygwin.com
In-Reply-To: <ZZ64BtnmZtmyRZYi@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,GIT_PATCH_0,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 10/01/2024 15:30, Corinna Vinschen wrote:
> On Jan 10 13:57, Jon Turney wrote:
[...]
>>
>> Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
>> write a .stackdump file, even when ulimit -c is zero. (Note that
>> cygwin_dumpstack() is still idempotent, which is perhaps odd)
> 
> Given it's deprecated and not exposed in the headers, and given
> we only still need the symbol for backward compat, how about making
> this function a no-op instead?

We still need the function internally to write stackdumps.

I know it's use has long been discouraged, but doing a GitHub code 
search does find some uses of it.  What is the suggested replacement?

(I'm also wondering if the idempotency is in the wrong place.  Is it 
possible for signal_exit() get called by multiple threads?  In which 
case it probably needs to do something sane in that case)

[...]
>>
>> Future work: Perhaps we should use the absolute path to dumper, rather
>> than assuming it is in PATH, although circumstances in which cygwin1.dll
>> can be loaded, but dumper isn't in the PATH are probably rare.
> 
> I'm not so sure about that.  It's pretty simple to get an absolute
> path from the DLL path, so I would really make sure that the right
> dumper is called.  Otherwise this sounds a little bit like a security
> problem, if the current PATH may decide over the actual dumper.exe,
> isn't it?

Yeah, I'm just being lazy here.

I think this could only actually be security hole if the crashing 
process was setuid (or otherwise had elevated capabilities), which we 
don't support, but I should do this the safe way.  I'll fix it.

>> Future work: truncate or remove the file written, if it exceeds the
>> maximum size set by the ulimit.
> 
> Can't this be done by adding the max size as parameter to dumper?
> 

Maybe. That would make forward/backwards compatibility problems when 
mixing dumper and cygwin versions.

I don't think we can control the size of the file as we write it, we'd 
need to check afterwards if it was too big, and then remove/truncate.

And we need to do the same action for stackdumps, so I think it makes 
more sense to do that checking in the DLL.

[...]
>> diff --git a/winsup/cygwin/environ.cc b/winsup/cygwin/environ.cc
>> index 008854a07..dca5c5db0 100644
>> --- a/winsup/cygwin/environ.cc
>> +++ b/winsup/cygwin/environ.cc
>> @@ -832,6 +832,7 @@ environ_init (char **envp, int envc)
>>       out:
>>         findenv_func = (char * (*)(const char*, int*)) my_findenv;
>>         environ = envp;
>> +      dumper_init ();
> 
> Sorry, but I don't quite understand why dumper_init is called so early
> and unconditionally.  Why not create the command on the fly?

For the same reason we create the error_start debugger command at 
process initialisation.

If I had to guess, that's because calling malloc() when we're in the 
middle of crashing may not be very reliable.

(of course, we go on to ruin this attention to detail by calling 
small_printf to append the Windows PID during exec_prepared_command(), 
even though we also knew that at process startup)

[...]
>>   
>> -extern "C" void
>> -error_start_init (const char *buf)
>> +static void
>> +command_prep (const char *buf, PWCHAR *command)
>>   {
>> -  if (!buf || !*buf)
>> -    return;
>> -  if (!debugger_command &&
>> -      !(debugger_command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
>> -					    * sizeof (WCHAR))))
>> +  if (!*command &&
>> +      !(*command = (PWCHAR) malloc ((2 * NT_MAX_PATH + 20)
>> +				    * sizeof (WCHAR))))
> 
> Not your fault, but the length of this string must not exceed 32767 wide
> chars, incuding the trailing \0 per
> https://learn.microsoft.com/en-us/windows/win32/api/processthreadsapi/nf-processthreadsapi-createprocessw
> The only reason I can see for using these large arrays is to avoid
> length checks.
> 
> We could get away with two static 64K pages for debugger_command and
> dumper_command.  Or even with one if we just copy the required stuff
> into the single debugger_command array when required.  That would also
> drop the requirement for the extra allocation in initial_env().

Well, it's garbage anyhow because we can calculate the exact size of the 
output before we do the allocation, which is presumably usually much less.

> 
>> +extern "C" void
>> +dumper_init(void)
>               ^^^
>               space
>> +{
>> +  command_prep("dumper", &dumper_command);
>                  ^^^
>                  space

Doh!

[...]
>> +
>> +	sig |= 0x80; /* Set WCOREDUMP flag in exit code to show that we've "dumped core" */
> 
> While at it, we could introduce `#define __WCOREFLAG 0x80' to sys/wait.h
> as on linux.  But that would be an extra patch.

Yeah, let's keep that separate.

