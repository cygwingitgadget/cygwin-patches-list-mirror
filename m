Return-Path: <SRS0=0Trm=AW=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 5EF814BA2E18
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 09:40:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5EF814BA2E18
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5EF814BA2E18
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1771407617; cv=none;
	b=w5P0cpToPItoEpfLWadbWW+XqxMOj2Yp7aE7n6XOMOII6BApGSvp+qRlE+psX88XYYFVE4STaK4yGdQgB6PygyJkZ1dGLe5ikYmAMluWsFmOc5Cf84Fl/nW7vgE4LCclm1dnMtcqv05g6WHhjFHi+taJNTUX1cX/A4eNeqXs2CU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1771407617; c=relaxed/simple;
	bh=1hvRPHBA2QphG5HLRwLoZY5bRMp3f1thelwQwyBczBg=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=OG1VNIEyxDyIZUuq5Zenw5U9nMO+8lMx8s0ING0wWB/g1qY3yNRPlfJavtXe5hCsuqVmpQwycKOF1EwtCNtzHGLJlCbm1VHVgt+i+iihzpE4roSahajbmAaxVNM1jns3njRWMJKWr3S/J7LYVowrBgDzd0b237peMNKnNIepDN8=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5EF814BA2E18
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 61I9uwE9032652
	for <cygwin-patches@cygwin.com>; Wed, 18 Feb 2026 01:56:58 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdya0eUw; Wed Feb 18 01:56:51 2026
Message-ID: <ca2be7f8-7029-4c41-9a84-9eb957189c2a@maxrnd.com>
Date: Wed, 18 Feb 2026 01:40:10 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Rewrite rlimits using OS job objects
To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <aY97v9UZOl12UOeK@calimero.vinschen.de>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <aY97v9UZOl12UOeK@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,

On 2/13/2026 11:30 AM, Corinna Vinschen wrote:
> Ping?
> 
> Anybody willing to review?

I'll take a shot at this.  First I read your fine explanation below and 
then spent a little time on MSDN reading up on OS job objects.

[...]
> On Jan 26 12:13, Corinna Vinschen wrote:
>> From: Corinna Vinschen <corinna@vinschen.de>
>>
>> The only implementation of an RLIMIT using Windows job objects,
>> RLIMIT_AS, doesn't really work as desired.  The way it uses nested jobs
>> fails if a soft limit is supposed to be raised again, thus working
>> rather like a hard limit only.
>>
>> This patch series takes a new approach.
>>
>> Considering two kinds of rlimits, soft and hard limits, and two kinds of
>> scopes, per-process and per-user.  Especially the per-user scope is kind
>> of tricky when implementing this as job objects.  For all practical
>> purposes, we can only include Cygwin processes and native subprocesses
>> into per-user jobs, and only Cygwin processes into per-process jobs.
>>
>> So here's what this patch is doing now:
>>
>> When a new Cygwin process tree is started, the root process of that tree
>> creates two per-user nested jobs, one for the hard limits, the next one
>> for the soft limits.  The per-user job objects are globally defined.
>> Processes can become job members across multiple Windows sessions.  If
>> another Cygwin process tree is started, the root process of that tree
>> finds that the per-user jobs already exist and just assignes itself to
>> both jobs.
>>
>> The same happens after a user context switch changing the real uid, i. e.,
>> in spawn/exec when calling CreateProcessAsUser.
>>
>> User limits are just set in those job objects across the board.
>>
>> Per-process limits are implemented by adding two more job objects for
>> hard and soft limit and assigning the process to these jobs.  These job
>> objects are session local and they are only created when the process
>> calls setrlimit.  They are setup so that child processes breakaway from
>> these jobs automatically.  The job objects are not inherited, but
>> recreated on fork/exec per PID for child processes.  This localizes the
>> rlimits to a process and changes to per-process rlimits in a parent
>> process don't affect the per-process limits in an already started child,
>> only in children forked or execed later on.
>>
>> I hope I explained this sufficiently.
>>
>> For the time being, we have exactly one per-process limit, RLIMIT_AS,
>> and exactly one new(!) per-user limit, RLIMIT_NPROC.
>>
>> Questions and comments welcome!

The implementation has plenty of comments and is quite straightforward 
to follow.  I think this was really well done.

I have only one minor nit: in patch 2/3 in new function 
__set_rlimit_nproc_single() there is an "else" followed by a comment 
about rounding down to page size.  The comment doesn't apply to this 
function; it seems to have gotten copied along with lines of code from a 
different function.

I applied these patches to my local Cygwin build tree and successfully 
built a new Cygwin DLL.  Normally I copy new-cygwin1.dll and libcygwin.a 
to the existing installed tree (with some renaming) to test things.  I 
attempted to test RLIMIT_AS and RLIMIT_NPROC with 'ulimit -v', 'ulimit 
-u' and a couple test programs but was unable to see any difference from 
prior Cygwin DLLs.  Do I need to install more of the new build to test 
the new code?  It wouldn't surprise me if I'm missing some steps in my 
testing setup.
HTH,

..mark
