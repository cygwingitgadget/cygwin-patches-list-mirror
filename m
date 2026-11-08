Return-Path: <SRS0=iF8p=I5=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id C38A84BA2E18
	for <cygwin-patches@cygwin.com>; Sun,  8 Nov 2026 13:27:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org C38A84BA2E18
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org C38A84BA2E18
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794144428; cv=none;
	b=up0KOBUkBFibiW1wwG9N5GzqmMWhZbyIpUR0Mm/hETGgsamzaOOCBIS9zioqkKUnHTPKKdH4Z3RSYVW7MkdCZ1GoMW6RUiMy1uWt0ZiB2xtsYEmXK6rZzVKHi96izTk6gSj2ly0/bQu22jiU6JwcOqjx5bfa/m5L8as6APMtnAg=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794144428; c=relaxed/simple;
	bh=xxwpE+81t03NK7ETakjsDSCLmsDfDHrFL4mRDXCWyTQ=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Lfl0Qy8fsx+V+RxntkkhX7e5EGNjgK7o2vFcuemNc+EP6CEQnQjEOly8UqzBMY9bKDfL0AKwCqhzwJq4vSVhsd0E48U1/VP2ajhtsrbOAJsTrNHND7o894wZBwg11G7AsKbokIci5oBfbacoZUYJ/0kZk2g1MSSS5QMp/iGv8j0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org C38A84BA2E18
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715CD6146FFBF6
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGzMXFgvfm1P6Sqn6uT/2sTMz5a8ILtajFw5Fl+ij2BLIwwbemYYn0Vv/gBC3dU8uUzvkKKlaUM2nqrTLQ0GkFB6ndnpLLvwc6jRoPy9P/1byfohdF3mrLwXqpUMz6iYSEUR7ffrggfiwxXPInjNz71Wc3MDj1Pyh+yoHflgNeju+chSVUXuV83LQq0wMPnZJ0QgZNL9YLIxkFLtcxjlDN7gGZ2IJvoVHcqo2ybaMaB6WJzKdlf/ni+WSuRxZjV8VCGSDnJsX3UNuEfYoqWqxv2jML2n0XlVLnItbbIZG0jPPzvN2uWPaExS7ti1TignsxQHtqrPIQMEHqEXJ55HtGEGzGuRKL+bdVNAZMtBYenkUl1IrW8OWEOFujQ5MorRx4lvGUvo1/2psTsAGCmw7F2P7h/xEzv/eKJBJaIAeIq3HBwyWleQm880ej7gwNZKbPsnXQFgVGxWpWRn+4dsULdyt3zsXBfbiY0V75VzVfoDTdjwJrQEyyNMu4bv7lDV43G+x9dD+sdDAjxsz8wJTwBOk1AQkvSr/ONaZS3plMBVQV6eDpqYFW7y4Xj5t07XwaLAmiskIToGnlGRrUDYO+dFop2Tosa/wLDiUiNwDWY2mowyhzh5ZvU77gfQrggZXwy65cglhgkfb1SnPAwwIccO5bWHLB6Ym8stdcbTcsKpw
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715CD6146FFBF6; Sun, 8 Nov 2026 13:27:06 +0000
Message-ID: <0d5a6703-fb83-45ac-93c8-1e114816942e@dronecode.org.uk>
Date: Sun, 8 Nov 2026 13:27:06 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: gendef: restore incyg in AArch64 longjmp
References: <PN3P287MB1320FF86B79E02E9DF36286FF79E2@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com,
 Aswin Kalies Ramkumar Mangayarkarasi <aswin.kalies@multicorewareinc.com>
In-Reply-To: <PN3P287MB1320FF86B79E02E9DF36286FF79E2@PN3P287MB1320.INDP287.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 13/10/2026 13:36, Aswin Kalies Ramkumar Mangayarkarasi wrote:
> Hi Everyone,
> On AArch64, any program that loads OpenSSL's libcrypto stops receiving
> signals while it is blocked in a syscall. sshd sitting in ppoll ignores
> SIGCHLD, SIGTERM, SIGHUP and even SIGKILL, so ssh sessions never finish.
> The cause is that longjmp clears _cygtls.incyg instead of restoring the
> value setjmp saw. OpenSSL's AArch64 capability probe runs in a DLL
> constructor, i.e. inside dll_crt0_1 with incyg == 1. It does sigsetjmp,
> takes a SIGILL and siglongjmps back; longjmp sets incyg to 0, and
> dll_crt0_1 then decrements it to 0xffffffff. The patch below saves
> incyg in setjmp (jmp_buf slot 24, offset 0xC0, unused so far) and
> restores it in longjmp.

Huh. This sounds like a similar (although distinct) issue to that in 
https://cygwin.com/pipermail/cygwin-patches/2026q4/015440.html

This is not an area I am hugely familiar with, so perhaps you can help 
me out, by also thinking about if there's any interaction between the 
two fixes?

> A small reproducer does the same thing without OpenSSL: pthread_once
> runs an initializer (inside Cygwin) that does sigsetjmp, raise(SIGUSR1)
> and siglongjmps out of the handler; afterwards alarm(1) must interrupt
> poll(NULL, 0, 5000) with EINTR.

I wonder if you could also attach that reproducer, so I can add it to 
our tests somewhere.

> Testing, on upstream main (06add56f7) cross-built for aarch64-pc-cygwin
> and run on Windows 11 ARM64:
> 
>       *
> reproducer: FAIL 5/5 without the patch (SIGALRM never delivered,
> poll sleeps the full 5s), PASS 5/5 with it (EINTR after 1000ms).
>       *
> winsup testsuite: identical results with and without the patch
> (265 PASS, 17 FAIL, 4 XFAIL, 1 SKIP; the same 17 tests fail in
> both runs: 15 LTP EFAULT checks and 2 posix_spawn tests that
> depend on the local test environment).
>       *
> in our MSYS2 aarch64 build the same change fixes sshd sessions
> hanging and SIGCHLD being lost (350/350 concurrent sessions,
> SIGTERM/SIGHUP/SIGKILL delivered).
> 
> x86_64 has the same flaw: its longjmp also clears incyg instead of
> restoring it. The same reproducer fails 3/3 on Cygwin 3.6.11 x86_64.
> It just doesn't show up in practice there, because OpenSSL detects CPU
> features on x86_64 with cpuid and never longjmps during startup. This
> patch only touches AArch64; I can send the equivalent x86_64 change
> separately if you'd like it fixed there as well.
Yes, please!

