Return-Path: <SRS0=d61H=EK=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo008.btinternet.com (btprdrgo008.btinternet.com [65.20.50.197])
	by sourceware.org (Postfix) with ESMTP id 8683A4B9DB7C
	for <cygwin-patches@cygwin.com>; Sun, 14 Jun 2026 16:17:00 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 8683A4B9DB7C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 8683A4B9DB7C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.197
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781453820; cv=none;
	b=na2w7cwcqOXMPMr/Safszqgj9U5O2aXuaaifuIjGVB4xSUhUlqqbX65q7eFkmL7kdvLVh4XAz+kB62KI1Ome3wAEnLi8Loim/k69KMzwz7Xwnkx8lLrw9UeP+uPURQjE8/jmiJBTta3SeVFP5j1P0iRyU1xUWhfOo7e1omvRsSQ=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781453820; c=relaxed/simple;
	bh=eSWCFNpM8eAFlnltlXr8EQ3EGSdB2Csc/HDax9UWzAU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=o1KqBuZMGhDjALHqKvA2mvysAZKHDc/2oF9ZDtiQnk+6WN/xcAY62TUxTttpiBdl1wbjLc1fwyvzapglJO2B8b1CKsTsoNL3gqhj0L5FWwt6HiN+bg5QGViKTXJqeBklKr++9XJLOlYYm/GNbyJDU9slpsT959U2RBqlWacj+PA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 8683A4B9DB7C
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 69FAABE703306CF9
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTEikD2p4bSKP7x3hRdmix+odSR2JAGekg5RhGRQjmtPJ/m0dy8gFTgD+ZQGqBV7K2+0ESE1aFgDFyR7oT1yh8Yq/jMeIegpiHhU5ML3QVcEEPMF4x2bpKQHhOJTvN8Iy3p4JLF/Tbea/cG82nbiVIDjV37T1HzJexkbDiYRY9q39mott2jjzVK9fnrVF0wGndzhxjDHbLqdTwrIbqVgLav13ktW0PPLuzdOFfJN3esPzcu1NgkTsaOi8rBz7nr1nY2SbbYBJSMdlZS4j5+AgHZcxnOQOR1+uTHJH5EOKV0HA2WVfCiXFYHp+lMJypIqkml1etDaxGMjUqJRGQ1UEWgklrFKMid2pCncY1TVxx6PTZLbVMaG0blhyuIzfMqEZqIkNMw77hrWC9PsF3Gx2LS7LD0X1XfJ+coZIcNbs+hdkDkX+GKazeiCvM0lA3qkH67pSAe2ktFqagPhbwl5zm35B55Dc6VJwhCrNZyWfXCa54JlLANacBLx31FitejnmjjlbFvd//FKEhCkqsrptnXdLNQkJTWMhYrloEISSLeTU4G6Jtm/e8MHjHHWGaBD/ikB48gDOmohwascBvwzkFNl8uQt/qCpeMdYvod6dbpAJ/Q1yJK8gpsMKPRhWAnZZ+xYsh0J7TzhfHMa1vl36guG1i5Y+PFhbzLhUBPbLAMb0g
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo008.btinternet.com (authenticated as jonturney@btinternet.com)
        id 69FAABE703306CF9; Sun, 14 Jun 2026 17:16:52 +0100
Message-ID: <d775f31b-f552-409c-b21b-f280180e8089@dronecode.org.uk>
Date: Sun, 14 Jun 2026 17:16:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: ssp: Add AArch64 implementation
To: Chandru Kumaresan <chandru.kumaresan@multicorewareinc.com>
References: <PN0P287MB02952FCE57C59FF18096B96D920E2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <34b42100-1722-4bdc-abf9-e9d159456ee0@dronecode.org.uk>
 <PN0P287MB0295E9D540A342B741B82CC592122@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
 <PN0P287MB0295F1D93B25FA3B90293E35921C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <PN0P287MB0295F1D93B25FA3B90293E35921C2@PN0P287MB0295.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/06/2026 07:08, Chandru Kumaresan wrote:
> Thanks for the review!
>> did you consider writing something like (untested): [SW_BREAKPOINT_SIZE refactor]
> Yes, adopted in v2. I introduced SW_BREAKPOINT_SIZE as a macro (1 for x86/x86_64, 4
> for aarch64, #error otherwise), unified the PendingBreakpoints struct to use
> real_insn[SW_BREAKPOINT_SIZE] throughout, and renamed the variable to brk_insn on both
> architectures. This eliminates the per-arch #ifdef blocks in add_breakpoint and remove_breakpoint.
> 
>> Hmmm... this is probably just generically right, I guess.
>> (re: only setting running=0 on !dwFirstChance for aarch64)
>   On Windows/AArch64, the single-step mechanism (PSTATE.SS) triggers a first-chance STATUS_SINGLE_STEP
> exception for every instruction we step through. If we set running=0 on first-chance exceptions,
> the profiler would exit on the very first step. Limiting it to second-chance (i.e. unhandled) exceptions
> means we only stop on genuine faults, matching the intent of the original x86 code.

Hmmm... I think the x86 code is wrong in that, if a program normally 
handles and continues from an exception, under profiling we'll just stop 
on the exception.

But I think we can safely leave that until someone actually encounters 
the maybe-problem.

> 
> All other issues (whitespace regression, spurious fprintf indent, missing cmdline_copy comment) are fixed in v2 as well.

Thanks. Applied.

> ---
>   winsup/utils/ssp.c | 154 ++++++++++++++++++++++++++++++++++++++++-----
>   1 file changed, 140 insertions(+), 14 deletions(-)
> 
[...]
> -
> -  run_program (argv[optind]);
> +  {
> +    /* CreateProcess (called below with lpApplicationName == NULL) is
> +       documented to modify the lpCommandLine buffer in place.  argv[optind]
> +       points into our own argv, so passing it directly lets CreateProcess
> +       scribble on it; this was observed on aarch64-cygwin as the command
> +       line coming back mangled (e.g. 'test_hello.exe' -> 'st_hello.exxee')
> +       on later use.  Pass a private writable copy instead.  It is not freed
> +       because run_program() stores it in dll_info[0].name, which is read
> +       later when printing the DLL-profile table.  */
> +    char *cmdline_copy = strdup (argv[optind]);
> +    if (!cmdline_copy)
> +      {
> +   fprintf (stderr, "Out of memory duplicating cmdline\n");
> +   exit (1);
> +      }
> +    run_program (cmdline_copy);
> +  }

Hmmm... from the explanation above, it seems like this is in the wrong 
place and should be inside run_program, around the call to CreateProcess?

Otherwise, the same pointer which is passed to CreateProcess and 
potentially has its contents mutated by that is also assigned to 
dll_info[0].name, leading to a potentially corrupted string appearing in 
the DLL-profile table.

If that supposition is correct, I'd appreciate it if you could come up 
with a follow-up patch to change that.

