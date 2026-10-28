Return-Path: <SRS0=B3ed=IS=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo010.btinternet.com (btprdrgo010.btinternet.com [65.20.50.133])
	by sourceware.org (Postfix) with ESMTP id DFEF64BA2E13
	for <cygwin-patches@cygwin.com>; Wed, 28 Oct 2026 12:30:57 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org DFEF64BA2E13
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org DFEF64BA2E13
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.133
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793190658; cv=none;
	b=nZ4lGTx8IrfzUl/ABqJJsD7dvnjkuv2lypVahhFw0+dBXR1Zk6a3bgrMp7PwFFI/WJG/PvlgsvmEyVO9mALFIG80ZN3Blp1SG/JdyGxDokcwykRrSyQZdNzX47ic/0SqmubtcaMtbM77bdmbr6WTnXsBjkCzZkfVzgTKAYjOAcM=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793190658; c=relaxed/simple;
	bh=DQv/MqfPVZ1ALSHFREtVjxY2bdSrKrEGZQZF3sIdb2g=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=ZW1V/1S6lHqAamUn5AYC6SCen8n4DEhgCkzalsVT4uL1XY796k/7V/ZkYIv0RspHaajMpJ/bXeNTLtLxPQVWb+jhxzatDxyrWVoUGXVTcG8bOBkJCxiu71Ym2nvJrURC/1fe638drkCQ0pFhxBjnEuHfPeYDn8CgZVhiGUo5DyY=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org DFEF64BA2E13
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A989FAD0BF55637
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=0/300, class=clean
X-RazorGate-Vade: dmFkZTEr06TheWLubBlS+DquLNUtupGmi2XI0QIPitsCvu6TQBrjsiboPf8m0NT1DrHyMNbOc5/hggoXtsasKLI55lBoFF2uJTpyOqiQk6wCDakGcQoZIYn8A1RxN7VpEO7uBj+3/TmEUeE8EUXyIizjBY09LREldXgYx6ybhXPAdVWhZg5QUEBsHQEEcEmRLrjCRDG2Lj/YC2Olq/ZwP6GNvtCg0gE0FvAwl85MtLlaCS/E7O6QnFOjpaR2G5N5JHqOnI8jkjBy1h5rBci6cewoBRs4ZPoGbwP6rilDD0ZxrcXbBVsNJtFIayWk88ocGmaVB09/riH0OcE0aUCvWa5woKvIpmFxp0mNZvZOqzsfscaGzkPWuRkMJsjb2w7PFv0qWgpbjJQikZbHRSpxknTFdb9BW+Mc32CwCYWtobU8Y3Hl/+jTNCdt04cjEl9OL9DMiMtwf731+bFiXn0udlp2axFAxMM+QnMaULV7RI8i1H1AuMJQ77a5+T9xyhWY9pwEgBpC1NZfU+6Ps6DptFVgbFlM5CujTP/ENe0TEBIZagQ1IOAZDp2M+JNTS0k19RqpvtX1dpdupTTvNwjzdEey+nwGhISrMDLWixJjwJmwytPbo0urVudUHoJNVq33nzaDA2TzFle+ZlB65yA0nrN9SNzkNQEH2kJQwO56eMPvIgBsHQ
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo010.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A989FAD0BF55637; Wed, 28 Oct 2026 12:30:47 +0000
Message-ID: <83ee12dd-70e3-4e27-85df-c9b860648044@dronecode.org.uk>
Date: Wed, 28 Oct 2026 12:30:43 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Ms-nfs41-client-devel] [PATCH/RFC] Patch to fix uid/gid lookup
 for NFSv4 filesystems
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
 <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
 <CAAvCNcBwn0F84avS5pFS+oUoHuUAoSuKBEc2ybYScO8RDHV9NA@mail.gmail.com>
 <CAKAoaQk+qgptFfmBugTcvfdLLhEnGPJWY70tLdQg1qNRFT+hQg@mail.gmail.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com, Roland Mainz <roland.mainz@nrubsig.org>
In-Reply-To: <CAKAoaQk+qgptFfmBugTcvfdLLhEnGPJWY70tLdQg1qNRFT+hQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 24/08/2026 12:53, Roland Mainz wrote:
> On Sun, Aug 23, 2026 at 4:38 PM Dan Shelton <dan.f.shelton@gmail.com> wrote:
>>
>> On Fri, 21 Aug 2026 at 17:21, Lionel Cons <lionelcons1972@gmail.com> wrote:
>>>
>>> On Sun, 16 Aug 2026 at 19:35, Lionel Cons <lionelcons1972@gmail.com> wrote:
>>>>
>>>> Repost with proper [PATCH/RFC] tag.
>>>>
>>>> I've attached a patch
>>>> (cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
>>>> ms-nfs41-client project) that resolves an issue with uid/gid lookups
>>>> on Windows NFSv4 filesystems.
>>>>
>>>> Currently, Cygwin assumes that all Windows NFS clients operate
>>>> similarly to the Windows NFSv3 client. It expects that account names
>>>> and numeric uid/gid values are identical on both the client and server
>>>> sides, with LDAP acting as the sole authority for these numeric
>>>> values.
>>>>
>>>> However, the NFSv4 protocol fundamentally changes this paradigm. As
>>>> defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
>>>> for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
>>>> protocol representation in favor of string-based identifiers (e.g.,
>>>> user@domain and group@domain).
>>>>
>>>> To handle this, all NFSv4 clients implement a local "idmapper"
>>>> component that translates these string-based identities from the
>>>> network side into local account data (in the case of Windows, mapping
>>>> user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
>>>> clients manage their own uid/gid translation locally, Cygwin's
>>>> reliance on raw LDAP data fails in these environments and results in
>>>> the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
>>>> owner/group output in Cygwin ls -l.
>>>>
>>>> The attached patch addresses this by detecting whether the underlying
>>>> filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
>>>> performs a direct pass-through of the uid/gid values supplied by the
>>>> NFSv4 client's idmapper.
>>>>
>>>> I have successfully tested this fix against several major clients, including:
>>>> - Exceed NFSv4 client
>>>> - OpenText NFSv4 client
>>>> - ms-nfs41-client
>>>> - ms-nfs42-client
>>>> - Windows NFSv3 client (no change, it continues to use LDAP raw data)
>>>>
>>>> Please let me know if you have any questions or require modifications
>>>> to the patch.
>>
>> This is the same patch as
>> https://github.com/kofemann/ms-nfs41-client/blob/master/cygwin/cygwin_patches/cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff
>> right? Who did auhor it - Roland Mainz or someone else? Why was that
>> patch not submitted before?
> 
> That's my patch. The issue is that - while this patch is ready (and in
> use by CERN&co) - I wanted to do more, but didn't had time to catch
> Corinna for further debates.
> 
> The ToDo-List:
> 1. get this patch into Cygwin
Roland,

As the original author, can you please make a declaration about the 
licensing of this patch, as per [1]. (Ideally covering any future 
contributions as well.)

Thanks!


[1] https://cygwin.com/contrib/dll.html#before_starting_legal
