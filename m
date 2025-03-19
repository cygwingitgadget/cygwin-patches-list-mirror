Return-Path: <SRS0=/xOy=WG=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 00BB8385840D
	for <cygwin-patches@cygwin.com>; Wed, 19 Mar 2025 05:52:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 00BB8385840D
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 00BB8385840D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1742363537; cv=none;
	b=W+yEe5XqobiWs5Z9WTbsD2DFz11EK25uBknUZKo7UlOFd48V86vdkjKbRlNFHE2NkO2qSoOM2Y8c2jjMDscsAR0zTWvrKvVh+VAmD1MKNfOaKeAYFtPe8Mw/rCUeVXBIPzQM6NYVCkHjoiRZw3RRd0WtGxTmlkelfU4QrQ2skLs=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1742363537; c=relaxed/simple;
	bh=eqPoa6bzcp2cnRSsePvWyIkzuKJ18WTiepLveacCj3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=eFlRkQqiG/BDQb7GFjl95YagXsjKVIr7M2NUrMYfxByxGnXinexpulbz4C3Pqj4kk+dEaoo/5Z51ujArUsnXNW4VnFxhe4egsexqkcike2b1uTbL4kMhW8Bs8asgNkTaJC4z3eJqxa268E1gbANloJdzHTtkJtXLHEZdNrWxacU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 00BB8385840D
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 52J5vb4A092373
	for <cygwin-patches@cygwin.com>; Tue, 18 Mar 2025 22:57:37 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-245-188.fiber.dynamic.sonic.net(50.1.245.188), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdSZkvEd; Tue Mar 18 21:57:27 2025
Message-ID: <45198057-1d8d-410f-bccd-b5dfd79d6bf6@maxrnd.com>
Date: Tue, 18 Mar 2025 22:52:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Use udis86 to walk x64 machine code in find_fast_cwd_pointer
To: cygwin-patches@cygwin.com
References: <6449d894879e33af3e8a4791896d2026f7c3f8bd.1740865389.git.johannes.schindelin@gmx.de>
 <6b8f960b-9ed3-8b00-0995-7187a30e42f4@jdrake.com>
 <Z9k9OcYu5Y47VsjU@calimero.vinschen.de>
 <e63f40de-faf7-2187-9f13-7bce6f7d7238@jdrake.com>
 <Z9nIRlpIEfAbNoJ2@calimero.vinschen.de>
 <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <5097ccfa-83f6-c76e-6c59-28c876cc2db8@jdrake.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 3/18/2025 10:11 PM, Jeremy Drake via Cygwin-patches wrote:
> On Tue, 18 Mar 2025, Corinna Vinschen wrote:
> 
>> Subdir of winsup/cygwin, probably.  What I'm most curious about is the
>> size it adds to the DLL.  I wonder if, say, an extra 32K is really
>> usefully spent, given it only checks a small part of ntdll.dll, and only
>> once per process tree, too.
> 
> I did this with msys-2.0.dll, but it shouldn't matter as a delta.
> all are stripped msys-2.0.dll size
> start:
> 3,246,118 bytes
> with udis86 vendored, but not called:
> 3,247,142 bytes
> with find_fast_cwd_pointer rewritten to use udis86:
> 3,328,550 bytes
> 
> (I know the second one isn't realistic, the linker could exclude unused
> code, I was just kind of curious)
> 
> This is with all the "translate to assembly text, intel or at&t syntax"
> and "table of strings for opcodes" stuff removed to try to save space,
> still a net increase of 82,432 bytes.
[..fascinating (!) code elided here..]

Are discardable code segments still a thing on Windows?  Could some 
pages in the virtual address space be allocated executable to run the 
thing and then free the space afterwards?  If just once per process 
tree, that wouldn't be so bad, would it?

I don't remember offhand if Closing/Freeing a DLL reclaims the address 
space or not.  If it does, putting the code in a tiny DLL for dynamic 
loading could work.

Just spitballing here.. ignore if unworkable or too gross.

..mark
