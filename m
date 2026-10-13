Return-Path: <SRS0=H46o=ID=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id B9A444BA23F9
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 07:18:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B9A444BA23F9
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B9A444BA23F9
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791875883; cv=none;
	b=Ci4fDWTtpgenD1gGyROKymMlOmA6X8SGSsvEJj96dI0XQj0amSHAsaX2aPGWmFqXP56qEO3cx++V4wxzpd0ywk8kd50LxN14IzHQyjsPX95VayIUIwgIu7vHqhGGBMLUfzMufdaKI1zyB2JcnbkW4jdpGVr8o6Gj9DN3meXc4s8=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791875883; c=relaxed/simple;
	bh=K2pWGDfxLpNAxXHKUDta1th6H3Jn8Rv5WdcOwJSQHDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=n4UsNrH3SD7gQqlGhc4ObgcqrjtAs4ZAM1B383hCHLvTwCiGaTenIHS58SvkHN+fEZ9CN590CggERD5rHe+u1cIE7kiTLzi2xOi+wiFzPY5V0DDr2GO0bxY9QoPGwScfzIyFvDG/0QZxg+GUNs2G3mUNQYsF5uXIAFaz5b4k+bQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B9A444BA23F9
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69D7VWd7081840
	for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2026 00:31:32 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdyS8HaP; Tue Oct 13 00:31:30 2026
Message-ID: <bb52ab6a-a3ad-45f9-a781-799bbbc227a1@maxrnd.com>
Date: Tue, 13 Oct 2026 00:18:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: Rename orphan __progname variable
To: cygwin-patches@cygwin.com
References: <20261012090437.1672-1-mark@maxrnd.com>
 <8120d2e7-b3ef-4ca1-8b39-ee4cbe400945@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <8120d2e7-b3ef-4ca1-8b39-ee4cbe400945@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,GIT_PATCH_0,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On 10/12/2026 12:55 PM, Jon Turney wrote:
> On 12/10/2026 10:04, Mark Geisert wrote:
>> The last remaining occurrence of '__progname' in dcrt0.cc was missed
>> when they were being renamed to 'program_invocation_short_name'.  I
>> discovered this when doing my first "#define DEBUGGING" Cygwin build.
>>
>> Signed-off-by: Mark Geisert <mark@maxrnd.com>
>> Fixes: b2476bc (Cygwin: globals: make __progname an alias of
>> program_invocation_short_name)
>>
>> ---
>>   winsup/cygwin/dcrt0.cc | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/winsup/cygwin/dcrt0.cc b/winsup/cygwin/dcrt0.cc
>> index e7a837673..7fe8f26ac 100644
>> --- a/winsup/cygwin/dcrt0.cc
>> +++ b/winsup/cygwin/dcrt0.cc
>> @@ -968,7 +968,7 @@ dll_crt0_1 (void *)
>>     /* Disable case-insensitive globbing */
>>     ignore_case_with_glob = false;
>> -  cygbench (__progname);
>> +  cygbench (program_invocation_short_name);
>>     ld_preload ();
>>     /* Per POSIX set the default application locale back to "C". */
> 
> Thanks! Please apply.
> 
> I noticed that __progname is also (still?) used in cygwin/libc/ 
> bsdlib.cc. Is there something wrong there, or is that expected to be 
> independent?

Thanks for the review; will apply shortly if no changes needed...

Also thanks for the follow-on question.  __progname is export-aliased to 
program_invocation_short_name (in globals.cc).  So one could use either 
name anywhere, really.  I prefer to leave __progname as-is in bsdlib.cc 
because that recalls its BSD origin.  In dcrt0.cc for this patch we 
could go either way, though for __progname we'd have to add an extern 
reference.  I chose to use program_invocation_short_name as the 
remainder of this file does already.  I'm open to keeping __progname.

The two names both refer to the same semantic object.  It is filled in 
by Cygwin as the DLL starts up.  One can later use setprogname() to 
change it.  But that can only occur after Cygwin is done initializing so 
it doesn't matter if it's changed.

Let me know what you think.

..mark
