Return-Path: <SRS0=UDMs=BF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 4C0384BA2E0B
	for <cygwin-patches@cygwin.com>; Thu,  5 Mar 2026 10:20:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 4C0384BA2E0B
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 4C0384BA2E0B
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1772706027; cv=none;
	b=TDyqKJrYhJpXJNvrsM29nsWXWLm9qwkn+ygLToHXbr5kHUTRAIZPK//Oz/2dOLjr7AsGOQey2g5yOWupCrh1459NX/OnF9i3sr6KCPD5LT9lTXOw1d7RNCojwiOR9O7YEnOCcjf5i3hJE/JRBDtC1z+lmP4zcDZK5HgyMx5GSGE=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1772706027; c=relaxed/simple;
	bh=AcAfZ7/tAqbPA+TPzPNPLtgRAxZxoUqKwXso6QLuyXw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To; b=s1UlQ8S+RslXhGQctTXl1N8fJ7no+gF2FPeGlFueITJjMU76Ffz3V/wAdfldMU/HyOUQuFcJzzCRdxNBp9QWG2qNReDkoSomvLAmtwjlXvQQMOfTGdOMkyUhukG3gAZcDiwP9y85W1T3BoN7V1IGXULdAZ/8YXfQOQItX2eeHko=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 4C0384BA2E0B
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 625Aau9E096926
	for <cygwin-patches@cygwin.com>; Thu, 5 Mar 2026 02:36:56 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdfyyB7f; Thu Mar  5 02:36:50 2026
Message-ID: <8ded5830-4507-4e10-82a5-d1b8874aec7e@maxrnd.com>
Date: Thu, 5 Mar 2026 02:20:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Rewrite rlimits using OS job objects
From: Mark Geisert <mark@maxrnd.com>
To: cygwin-patches@cygwin.com
References: <20260126111345.386303-1-corinna-cygwin@cygwin.com>
 <aY97v9UZOl12UOeK@calimero.vinschen.de>
 <ca2be7f8-7029-4c41-9a84-9eb957189c2a@maxrnd.com>
Content-Language: en-US
In-Reply-To: <ca2be7f8-7029-4c41-9a84-9eb957189c2a@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Corinna,
There was one thing I had neglected in trying to test: updating my 
system's /usr/include/sys/resource.h to add RLIMIT_NPROC and change 
RLIMIT_NLIMITS.

I subsequently built local copies of the shells dash, mksh, tcsh, zsh 
but could not build fish nor posh.  This to see whether all could 
support the new rlimit feature implemented by Corinna's patch set.

The shells differ from each other in whether they allow a limit to be 
raised after it had previously been lowered.  For some, one can only 
raise a lowered limit if one is running elevated.  Known situation.

However, the tcsh 'limit' command doesn't support a virtual memory limit 
(using RLIMIT_AS).  The zsh 'ulimit' doesn't support a process count 
limit (using RLIMIT_NPROC) though its generated config.h does see that 
RLIMIT_NPROC is available.  The bash 'ulimit' doesn't allow changes to 
the process count limit, even if elevated, and seems to be hard-wired to 
CHILD_MAX.

Apart from the quirks above, both the RLIMIT_AS and RLIMIT_NPROC limits 
seem to operate correctly in the shells I could build.  I tested with 
home-grown memory grabber and recursive forker programs.

I saw that hitting the process count limit produced messages like:
  251204 [main] forker 7130 dofork: child -1 - CreateProcessW failed for
'C:\cygwin64\home\Mark\src\forker\forker.exe', errno 5

CreateProcessW() is failing with Windows error 1816, 
ERROR_NOT_ENOUGH_QUOTA, which Cygwin is mapping to errno 5, EIO.  This 
should be changed to EAGAIN per POSIX.  I'll submit a patch for that.

Also, a case could be made that debugging messages like that are 
holdovers from the 32-bit Cygwin days when fork()s could fail for a 
large number of reasons.  I plan to submit a second patch to have that 
message appear in strace output only and not to appear to the user.

All this to say the new rlimit implementation looks good and works good 
as far as I can tell.

..mark
