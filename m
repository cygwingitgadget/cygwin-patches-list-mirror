Return-Path: <SRS0=bbDc=F4=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo011.btinternet.com (btprdrgo011.btinternet.com [65.20.50.62])
	by sourceware.org (Postfix) with ESMTP id 12E574BA23E6
	for <cygwin-patches@cygwin.com>; Mon,  3 Aug 2026 16:02:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 12E574BA23E6
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 12E574BA23E6
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.62
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1785772923; cv=none;
	b=oHKL/SODgAX2s24XYZOeTH/DrNItmDwkgdQn1He7SnnPhKlAmrQ1jR7u2bO4fKsQr8TN4jDWdNNeJbY/Hx6/lT7NmJbkuSAHS5vLlQ0sEAsccjqNsdrIEbhl0V85TYq5fNaU8U6ueGLl+owsgq0q0NamJFSgebBVG4iuU6iXZ24=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1785772923; c=relaxed/simple;
	bh=7sdGhJ4JLZK1CayqUgEqrVMg8mn6z//Y6g8JMih3oew=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=Vd+GPGkHoQkC29c5tN2M5ugKqJxyxtlzIMIKA3yzZvxRlK2IghE5FDLnOCabG2NuQpqP44CUBiUxTGT/KhMhiOQ5vIAO9aXWmjAVPBm0ghYcsi7Q/DcxZupDCOyodquS0csM3SLgpoA5djNQT4H7VUZuqVyTcA/V325WiFHgFYM=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 12E574BA23E6
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A08D39806BE87E9
X-Originating-IP: [62.56.66.111]
X-OWM-Source-IP: 62.56.66.111
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-RazorGate-Vade: dmFkZTGx1YEHJPQuFdSfOyytolJ0yH2SYT1osE5oPXTQDy47c31ZHqLHetLckxQ1o+7LWpU7hsOvW7OSxF6l+fzaEl352LT4UfaFf7FWSyGlww3F63Nne46AKUJct1Lnxb+ZaNKvEafV8ygMGUCw03NEmY9M4DdLa+3pqxoGAeC1yGBpnRwhir2jwEQ/hz68rDkkqEfgGzIEJ/87mTBOrRysxeMvAxKoFFROACwcPGc1UbsRyOW2RKAB6r9s/PoO+4okiW3kNw4VkkG2dV4NLF7LFQNsb/mMMDrWv6fM1tel/J9rL8dwnQtjdLUGeBU2pjs4I7I1ueNdrT0n1Ofz+/KDfgVbtC1olJQ7uVaH9DnuGaJZAM0C0Ha9bp/YUHp1RdZzbEzZn6iSoRSOZeotgL/wE+whliq6mc+6faMvGrdQzPPwCs9MEL7ldnjYMXS55BbS81Stq5eRlX7nfPQHQflVpbGoM8NstXBq9PkwAOqtQ3Mar8DTZSWcEydLxBsD4B0Hn/pCTTw2K2rWCr1IHKDGQl3RTEyNSgsyaYK4iEmmBEEeqigruxgsHSzEHVhudlnas33qvUt9IkHeaDDsR1wmSl//a/1cEjQdfsY0r6l4p2b3c90PL+ytUVcA9fOPsSoU1dq8HjuivL1GRj19VTGYwdQv4lnYLUkV6IuMHhg8kehyqg
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-VadeSecure-score: verdict=clean score=0/300, class=clean
Received: from [192.168.1.109] (62.56.66.111) by btprdrgo011.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A08D39806BE87E9; Mon, 3 Aug 2026 17:01:52 +0100
Message-ID: <0c11f169-4de6-414d-9fda-f3cd1241d742@dronecode.org.uk>
Date: Mon, 3 Aug 2026 17:01:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Cygwin: exceptions: Fix AArch64 non-incyg signal handling
To: =?UTF-8?Q?M=C3=A1te_Dimand?= <mate.dimand@arm.com>
References: <d8339a03-a0d3-4b0c-bb10-f706fcc6da49@arm.com>
 <054a3964-a4db-4add-9531-4b899e356f4b@dronecode.org.uk>
 <2aa3bd4e-2a1e-4511-b90d-1263879fdc28@arm.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <2aa3bd4e-2a1e-4511-b90d-1263879fdc28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 03/07/2026 10:25, Máte Dimand wrote:
[...]
> 
> I will take your suggestion into consideration, however 
> RtlRestoreContext will still need to be used in some form, we can't 
> avoid clobbering any other way. We also cannot forget about the other 
> registers that still need to be backed up somewhere.
> 
>> (It might also be worthwhile looking at the aarch64 implementation of 
>> RtlRestoreContext - since it must know how to restore all registers 
>> without clobbering any of them - which is exactly what we want to do 
>> in sigdelayed?) 
> 
> I looked at its internals, and it uses NtContinue to restore them, which 
> is a syscall (svc 0x43), so unfortunately it most likely does something 
> we can't do in user-mode.
Ah, right.  I was imagining we could do something like pop lr and pc off 
the stack, but that doesn't exist in aarch64.

Looking at the instruction set reference, it seems like the only way to 
set pc is either (i) via a branch instruction (in which case we need a 
scratch register, as you mentioned previously, or (ii) via an eret 
(which we need to be in EL1 to do).

So, yeah, RtlRestoreContext is our only solution.

