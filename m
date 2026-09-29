Return-Path: <SRS0=6Xlj=HV=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 106D64BA2E29
	for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2026 06:46:59 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 106D64BA2E29
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 106D64BA2E29
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1790664420; cv=none;
	b=cS2NGYC8ksW3braBPEOxs05LwImL54BM5K2BxuiIaoiea3IL9Cw31yt0xn7MoTe+HSs01sFkPGp52/QmdFmfFwqIaX1Krkc7B1FywJR/NVuXROuVPBR4ufZYns4MomtYVy6yddAaNBfmVdOtUjd4cXckj+8ssXZTJ7d0CvtstV0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1790664420; c=relaxed/simple;
	bh=kSjg33LMjWt/vr32uRV8douahHXU5pWq6MkhheXWBeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=bbN0ClS3Uiv6zpCB94KKocaNHNXt9yektzNOI51sr9DMhf5U6yyWFw95tY0rpQr/FdOqaJa7XKuygCSRNau7c/1vLwClOcuRTN/f4Jy1wcMKPRBsQARJ1KpTmSmfwfHL7TwfE+ESg4CQwzeAgs5G+d6HoiQ2JZjui+9I9MDuYM8=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 106D64BA2E29
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 68T70fPG010818
	for <cygwin-patches@cygwin.com>; Tue, 29 Sep 2026 00:00:41 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpd7Ewc98; Tue Sep 29 00:00:32 2026
Message-ID: <84f0a1d9-6bd6-4973-b926-ea74b68cc767@maxrnd.com>
Date: Mon, 28 Sep 2026 23:46:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cygwin: define IPTOS_DSCP_VA in netinet/ip.h
To: cygwin-patches@cygwin.com
References: <20260920043247.4589-1-omikorin@disroot.org>
 <c251f9bf-1881-47bd-a4a4-3a14b6f542f0@maxrnd.com>
 <79fbb95bf37e309b0f235b89bbf8a2ff@disroot.org>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <79fbb95bf37e309b0f235b89bbf8a2ff@disroot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Michał,

On 9/26/2026 11:00 AM, Michał Korczak via Cygwin-patches wrote:
> Hello Mark,
> 
> Thank you for accepting the patch.
> 
> As I was fixing my issue, I have compared Cygwin ip.h code to the 
> FreeBSD one [1] and I think it is slightly outdated for a few years.
> 
> I do not know if these files should be kept synchronized as this is my 
> first contribution into Cygwin.
> There were some additional deprecations years ago. I can only guess if 
> it will end with more incompatibilites like presented in the patch.
> 
> Does it matter here? I am curious.
> 
> Michał
> 
> [1] https://cgit.freebsd.org/src/tree/sys/netinet/ip.h[...]

Here is my personal opinion, as I don't think I've heard of any specific 
Cygwin policy or goal on this subject.

We don't synchronize with other OS projects in real-time.  If we come 
across something that's missing and needed for our development, or 
needed to support an application being ported from Linux, we'll add the 
missing bits or complete files on a case-by-case basis.

We don't just bring everything over because not everything in Linux (or 
the BSDs) is available in the same form on Windows, if at all.  Often 
the OS interface is different, which leads to complicated situations 
within Cygwin as it tries to bridge the differences so Linux, etc., 
applications can just be recompiled and work on Windows+Cygwin.

So, we accept patches for things that are missing, especially if you 
have an immediate use case.  But we don't track other OSs looking for 
things to keep up with.  We don't have the staffing for that :-).

Anybody else on the list have an opinion on this and can chime in?
Thanks for the question!

..mark
