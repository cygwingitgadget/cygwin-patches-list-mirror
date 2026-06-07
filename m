Return-Path: <SRS0=Q3Gq=ED=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 0DCC34B7A1CC
	for <cygwin-patches@cygwin.com>; Sun,  7 Jun 2026 07:54:22 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 0DCC34B7A1CC
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 0DCC34B7A1CC
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1780818863; cv=none;
	b=KR6pbReXfqRdBR8lFXsLjbUen/W6aLup5P/31GNo0qbQqVN71cgCx9M+TyawrhgxNOrtPhGdtiCPIukFwqzUT6m37Yf2ODxoYcTB9JXqpcSUAFW8/gDcBNlfLm5ly0tOOvpuUCXFetKhInDO4lxQHy+hPQgRiLbVs9NhO7WEVtg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1780818863; c=relaxed/simple;
	bh=19brGj6GZNYnbrMPw5bNTezuw0rBPteibzLB7j6Kc70=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=rIo6BCc1RMfgKLlfT+m/41ADf03uWxI0W7yT4KpxwlLgs0XjZv+0GPAWbmSbtc/UycziRvJH7NpsbzW+nIeBc0tkK8MSSDV1ZSEkgr3frcfPWcBSmPvfG3nU4o3hRlwvaCQ7kJOulSThiAFrBTrqbsURxSSLgvBcAJAsPGh0Buc=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 0DCC34B7A1CC
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65789bXP087046
	for <cygwin-patches@cygwin.com>; Sun, 7 Jun 2026 01:09:37 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdBZqd2J; Sun Jun  7 01:09:30 2026
Message-ID: <f907bb7e-8817-43e2-a384-6b848f184151@maxrnd.com>
Date: Sun, 7 Jun 2026 00:54:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: Ensure unused fd available for open()
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <https://cygwin.com/pipermail/cygwin-patches/2026q2/014989.html>
 <20260528054307.16582-1-mark@maxrnd.com>
 <19ae30b8-610c-465f-94aa-4599b03c2363@dronecode.org.uk>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <19ae30b8-610c-465f-94aa-4599b03c2363@dronecode.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Jon,

On 6/1/2026 6:30 AM, Jon Turney wrote:
> On 28/05/2026 06:42, Mark Geisert wrote:
>> The existing logic for open() assumes an fd is always available in
>> the fdtable for a created file.  This leads to a situation where, if
>> there is no fd available due to the OPEN_MAX limit being hit, the
>> file is created but cannot be referenced by a Cygwin fd.
>>
>> Move the fd reservation code to an earlier location within open().
> 
> Hmm... the more I stare at cygheap_fdnew, the less sure I am I 
> understand what's going on.
> 
> I'm sure you considered this, but just so I can tell myself I've done 
> due diligence, perhaps you can briefly explain why this doesn't create 
> the opposite leak? (i.e. the reserved fd is released if actually opening 
> the file fails).

Sure.  What happens is that cygheap_fdnew doesn't mark the chosen fd 
reserved (i.e. the fdtable is not updated at all, yet), it's that the 
calling thread has locked the fdtable and knows where the first unused 
fd in fdtable is.

All the validations of open() parameters are done and eventually a file, 
pipe, device, socket, whatever open attempt at Windows level is done. 
If that succeeds, fdtable[fd] is updated with a pointer to the 
fhandler_XXX stuff being carried along in variable fh.  The fdtable is 
unlocked at the end of the __try block by a dtor (see below).

If that Windows-level open attempt fails, a __leave is performed to exit 
the enclosing __try block.  The destructor for cygheap_fdmanip, 
superclass of cygheap_fdnew, unlocks the fdtable.  fdtable[fd] is left 
as it was, NULL.

That's my story and I'm sticking to it, but I'm at the limits of my C++ 
knowledge.  The overloading of "fd" really makes it difficult to follow 
things.. but I have to admit this seems like tight code to me.  H/T to 
CGF warranted.

Feel free to ask more questions.
Thanks & Regards,

..mark
