Return-Path: <SRS0=uB2j=I4=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo006.btinternet.com (btprdrgo006.btinternet.com [65.20.50.0])
	by sourceware.org (Postfix) with ESMTP id 565D84BA2E04
	for <cygwin-patches@cygwin.com>; Sat,  7 Nov 2026 16:53:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 565D84BA2E04
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 565D84BA2E04
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.0
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1794070415; cv=none;
	b=Vwq7l70CYgsfLarXssLroH0vIPODNxRl1nwUZSiO1rkynhKZCuWzi8/QGIKVRTYRBjvURqxaA1wUA4FscYChp8J2EMw41whxJWJjJdW2QMbBehwM76NampE3eWUj6EAl51CapuucwCWJrLKA4TpPPyqX8nTRwTJ06O2r2ARc5y4=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1794070415; c=relaxed/simple;
	bh=us9d/VFOq73AkKU4VSOJJLWqys9S95A4yPasAX27ysc=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=e6WfgM2WLU8D4yvJQ0385d0CH/MYRgPgelEy8/DokNIZuC6e/m7yzOAF+QnjdSsHF7EzHhDDGEt60ap6q8qdmdNncXAVcukmsPDPlwBVSvvx+tQ5TTj9N7MYNNoDclzeUUsgjNZMdcI0BlP/QedA3Yqt+1TKT+gDlx80T49UcM0=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 565D84BA2E04
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715E201437415F
X-Originating-IP: [80.176.81.8]
X-OWM-Source-IP: 80.176.81.8
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTGjtRN9vhGnQMqzoimuZ76mS0hkEm9cmyxik5O9hLrK3d5kAuvYCMg0pqRL0avYpFliFZ8V36hTz7IQ2jW76ZD7PkjQffVKjrLqjzpAIU5naspCgrKugPF8DWNUHQQNPI0QSXCyMZpaJme3uFvEuKpCnInpQ45F1bzEVLcMsC0eHn27jc1cCK6xM5G/BWQ8vJECc6F6ajvuhjrvbKa1YXOXJNHjD4+wSQchqFlLl0Me/9wy54edbRADsgmnZodZkhfb7RIkSM1Mp6B99zYviq6FbWqvtgzILEbI3/zTLSTCsc0uaW+1zV6GfTy26i+U1aU1TOB22tdRTKNJYxUl9p0UsNvpyzQ/jRW7ZaMUmsCuRRxgB+eDOAOiHVx4V/9kU7RwZpWXAMNGSX4yPVo0fECY9uB5Po4F6ZnVAZdIxX0PJ6g26un02OwMKRjMVjhsrFpZ0PZ6FFael2eKf7kq9bBhxPpiwBmoooSK1RdE9cz2ap8qfBKcdpvd1l5yUUN8LggosBrXqda8THZwupytHKa1RtUgp4o2KGUAYWW/IpQ2Uo+rMCpVsRvhmacREiJNAt5QjCswIE4OEV4OnAF0bVsriV7R/iMaJcPaR3zr8Kn7QlemgaIP24CtL/M4iH5NA7oXYMWwLRGn/C4MP7DfudNeqe874dzRhfVA/FcCsEFa4g
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (80.176.81.8) by btprdrgo006.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715E201437415F; Sat, 7 Nov 2026 16:53:27 +0000
Message-ID: <58289409-b1ea-4478-bdd6-660952e44056@dronecode.org.uk>
Date: Sat, 7 Nov 2026 16:53:27 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Ms-nfs41-client-devel] [PATCH/RFC] Patch to fix uid/gid lookup
 for NFSv4 filesystems
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
 <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
 <CAAvCNcBwn0F84avS5pFS+oUoHuUAoSuKBEc2ybYScO8RDHV9NA@mail.gmail.com>
 <CAKAoaQk+qgptFfmBugTcvfdLLhEnGPJWY70tLdQg1qNRFT+hQg@mail.gmail.com>
 <83ee12dd-70e3-4e27-85df-c9b860648044@dronecode.org.uk>
 <CAKAoaQ=Fj_junDr_5992EUayLRhmG8Gq81KDMQB6NORoCVNA2g@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Roland Mainz <roland.mainz@nrubsig.org>
In-Reply-To: <CAKAoaQ=Fj_junDr_5992EUayLRhmG8Gq81KDMQB6NORoCVNA2g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 28/10/2026 13:13, Roland Mainz wrote:
> On Wed, Oct 28, 2026 at 1:30 PM Jon Turney <jon.turney@dronecode.org.uk> wrote:
[...]
>> Roland,
>>
>> As the original author, can you please make a declaration about the
>> licensing of this patch, as per [1]. (Ideally covering any future
>> contributions as well.)
> 
> Statement:
> My patches/changes/contributions to the Cygwin sources are under the
> 2-clause BSD license.
> 
> Is that OK ?
> 
Yes, that's all I needed. Thanks!

