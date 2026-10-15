Return-Path: <SRS0=Lpkk=IF=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 7C36E4BA2E04
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 07:35:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7C36E4BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7C36E4BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1792049759; cv=none;
	b=qerEGqe6Irp5F6phxZ2ZShEpLbEUz388EcyBRpNhajlmV4eMr+xNjUFilZi5Po0MAk7dQoGeEtOCHfF784fM4AWdrRNJgd9lr67SeSVfW5cpXuGk7IyYjPAUV2fato0eCCp67HcCejRX/Yd5V4dzz+B9NVIHXpaRR/FKhZW690g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1792049759; c=relaxed/simple;
	bh=ax/8LkIRsNOhVdMv54BikU5mo6zwPBjw63xBVahwWkY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=SoUl3oG4nzW/eNe20cqiihZh3WnrgmfSbv4W1GOqPZmIysqPDAoEnDoplpurXX6VKdQU6WJ2GUB35uRgnUX80t/qNts7u3IsXASMyTRWo19KSRtVra7ssJnt9i86Iwin+3lYzuRxx0ICY6bmKkgd0/SCRVhwWew5CfjAZ565nb0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7C36E4BA2E04
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69F7nT67026704
	for <cygwin-patches@cygwin.com>; Thu, 15 Oct 2026 00:49:29 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd25HxDv; Thu Oct 15 00:49:28 2026
Message-ID: <7a6afbac-5973-4606-a3e2-4e0cc7d9ac0f@maxrnd.com>
Date: Thu, 15 Oct 2026 00:36:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND 0/2] Cygwin: avoid loading Winsock and iphlpapi at
 process startup
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
References: <PH0PR00MB338699008F36947D666826C5809E2@PH0PR00MB3386.namprd00.prod.outlook.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <PH0PR00MB338699008F36947D666826C5809E2@PH0PR00MB3386.namprd00.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Alexandre,

On 10/12/2026 7:30 PM, Alexandre Zollinger Chohfi via Cygwin-patches wrote:
> Two code paths make a Cygwin process map DLLs it never uses.  bash hits
> both at every start:
> 
> 1/2  When a standard handle is an anonymous pipe (CreatePipe: cmd.exe
>       pipelines, and the subprocess APIs of Python, .NET and Go),
>       init_std_file_from_handle cannot tell it from an LSP socket, because
>       the pipe has no name, so it asks getsockopt.  That loads ws2_32.dll
>       and mswsock.dll and calls WSAStartup.  The patch asks NPFS first
>       (FilePipeLocalInformation), which succeeds on pipes and fails on
>       sockets.
> 
> 2/2  gethostname calls GetNetworkParams, which loads iphlpapi.dll, nsi.dll,
>       dnsapi.dll and dsparse.dll.  The patch tries GetComputerNameExA
>       (ComputerNameDnsHostname) first.
> 
> Measured on msys2-runtime 3.6.10 (the same code in both functions),
> x86_64, Windows 11, i9-14900K: msys-2.0.dll rebuilt with and without
> the series, 100 interleaved runs per arm, paired, medians with 95%
> bootstrap CIs.
> 
>                                                before    after    saved
>    true.exe, stdio = anonymous pipes           14.2 ms  12.1 ms  2.1 ms (2.0-2.1)
>    true.exe, stdio = NUL (neither applies)     12.0 ms  12.0 ms  0.0 ms (-0.15 to 0.12)
>    bash -c true, stdio = anonymous pipes       19.0 ms  15.0 ms  4.1 ms (4.0-4.3)
>    images mapped by bash -c true (pipes)         24       18
> 
> For scale, a process with no imports beyond kernel32 starts in about
> 7 ms on the same machine.
> 
> Behaviour was checked against the unpatched build:
> - readlink /proc/self/fd/0 gives pipe:[0] for an anonymous pipe,
>    socket:[0] for a TCP socket and /dev/null for NUL
> - $HOSTNAME, `uname -n` and `hostname` are identical
> 
> Questions:
> - Is there a configuration where FIXED_INFO::HostName and
>    GetComputerNameExA (ComputerNameDnsHostname) differ?  Both read the
>    TCP/IP host name as far as I can tell, but I have only checked
>    standalone machines.  getdomainname still uses GetNetworkParams.  I can
>    switch it to ComputerNameDnsDomain too if you prefer the two to share
>    a source, as 2166f7dc0d9a intended.

Let me look into that; I don't know offhand.

> - Are LSP socket handles that fail NtQueryObject still a concern on the
>    Windows versions Cygwin supports?  If not, the getsockopt probe could
>    go entirely.

Something else I'll have to look into.

> 
> Alexandre Zollinger Chohfi (2):
>    Cygwin: dtable: don't load Winsock to classify an anonymous stdio pipe
>    Cygwin: gethostname: try GetComputerNameExA before GetNetworkParams
> 
>   winsup/cygwin/dtable.cc | 17 +++++++++++++++++
>   winsup/cygwin/net.cc    | 14 ++++++++++++++
>   2 files changed, 31 insertions(+)
> 
> The two patches are attached in git format-patch format.  They apply
> cleanly to the current main (06add56f7).

This is quite a substantive investigation you've done, with very good 
results.  We appreciate your analysis and the testing you've done.  The 
patch initially looks fine to me.  I will look into applying this to 
3.7.0 and 3.6.12 fairly shortly, after getting answers to 2 questions.
Thanks & Regards,

..mark
