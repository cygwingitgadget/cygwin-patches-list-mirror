Return-Path: <SRS0=kb3c=7N=xs4all.nl=dhr-incognito@sourceware.org>
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	by sourceware.org (Postfix) with ESMTPS id 554B14BA2E27
	for <cygwin-patches@cygwin.com>; Thu,  8 Jan 2026 10:38:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 554B14BA2E27
Authentication-Results: sourceware.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=xs4all.nl
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 554B14BA2E27
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=195.121.94.169
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1767868726; cv=none;
	b=bgT/WgKjNaPMijysQi2o7uYgIxhDIOBRzsGmUZTn5+eMLJtd6brSD7uUfpY+Uyma61Q7mLgsKfcXqXthU4bitkhGUWT8DbsMmx/grqPIb4BwCKcKAObYb/iifBnbsshtIL4RLcLlNN9g0nfqcli2LjewZeZKtwzAnA1CfoF4k3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1767868726; c=relaxed/simple;
	bh=k6KhBn6MxBllNGPZb+JAhDbSf9JteweZmmS8FDiWNWg=;
	h=DKIM-Signature:Message-ID:Date:MIME-Version:Subject:To:From; b=u/MyRGzBJqF7GUcFJSqO/SLXjNwVTCGgmxWd8ClRzUYaBosM8PKg+3Wt1x3iqC5SYYtW7lyDIlcTw0MAmqYYTmny7u5g2ac2jL3wVsEm1L2V8prtASN9wTwV+PWh4JCMIfBOGAoJgOh0qHWlj8y6+yEDX32XAW+aOW7kT+1wTP0=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 554B14BA2E27
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=xs4all.nl header.i=@xs4all.nl header.a=rsa-sha256 header.s=xs4all01 header.b=o5xF/g7q
X-KPN-MessageId: 361cc7c0-ec7e-11f0-b173-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 361cc7c0-ec7e-11f0-b173-005056abad63;
	Thu, 08 Jan 2026 11:38:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:from:to:subject:mime-version:date:message-id;
	bh=8hecpqMC2+4nlPNwSsW5yBu3Gc5k6jw4VR8Aqbvd1y8=;
	b=o5xF/g7q+s0zHEWHPw3gi09nafqbMTCAT5a4v0Ej1Jnqs20uak1CJRpoi2WOcTXJPJ5Ff3VJ8SaAi
	 k3eLP/o22ZGtcrntIu4eQPtzrVlHbdkhVuXyfi36Wb0CTmHsPMJZZqCjuzpkE1qD0szSQpYqf99cMC
	 gyPrBG9cCFw6+vHo/9cBcQ45nykjjXb7vBPHmPeiqc5l3id/E2KF2gR+nIWozzxu7YN4yFcBqjNpbF
	 5Mz1BTN+h4Yux97ucqrV7mZGKyf4qlR++O0xrQq2i3ZsO/fK4gluDwRvQICpErHz8LfaRwebUcQaUq
	 bKR2DRff+eIOsyLYem/m3X5W1RVCGNw==
X-KPN-MID: 33|aXuFUsm+bwa5Ss3EAcdupy2Pq+7Jr4RZSJV06EeYiZMPkb8WQwVJEP7Z3sCv0n1
 WHTEWtFFWnNhJFZoxjIa85SzdGBGSkySY5Z1FSuSIxlc=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|1//Efxa4zycoJ0WtntudQwrLlBqDR/pB01RNtGjWVQIS3y9XQ0iZvtQLn7POcdM
 ug1zBLwq4zic0HjpEAX5/zg==
X-Originating-IP: 77.173.35.122
Received: from [192.168.178.20] (77-173-35-122.fixed.kpn.net [77.173.35.122])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 324de8e1-ec7e-11f0-a6ca-005056abf0db;
	Thu, 08 Jan 2026 11:38:40 +0100 (CET)
Message-ID: <e1c2a2aa-0881-442b-9e39-a44d942cdc4d@xs4all.nl>
Date: Thu, 8 Jan 2026 11:38:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Rename cross_bootstrap back to mingw_progs to avoid
 confusion.
To: cygwin-patches@cygwin.com
References: <20260108103347.5001-1-dhr-incognito@xs4all.nl>
Content-Language: en-US
From: "J.H. vd Water" <dhr-incognito@xs4all.nl>
In-Reply-To: <20260108103347.5001-1-dhr-incognito@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 1/8/26 11:33, J.H. vd Water wrote:
> Jon,
> 
> As requested. Patches verified (build).
> 
> Regards Henri

Sorry, still wrong. git is a bitch!
