Return-Path: <SRS0=I/iY=HL=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id A07C84BA9016
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 23:47:35 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A07C84BA9016
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A07C84BA9016
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1789861655; cv=none;
	b=rJipQR0NNaUf7XM34wxNuItRMzKHYntDqR4UhXzyGyQrR9BpOjikN5v5SL2kSOJTvf/PBb4lQ89Sy/i5iGpunGVEzTIeon/nrZ5MEjToljdsmqwLCld8Lq0Jr8AOPazKkl+1HKy1DkkSL9SBa+tclcZ4r6aHjY8t6YQeBXWObno=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1789861655; c=relaxed/simple;
	bh=2qSP8oasvEB3puY7zoo1kCCMhtaroWY/G7Gt7f3Gino=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=kY9XKmhalkkFwSCGf4JC2Flvi93MKg3DABCCVLudEoTiQQ7uHi4nntdQbG4PxZBsvN9mBM9AlHDcpaWPDdulRb7UBNewIxPnj011QvnquYPeNMUQ/Jt5jw7fxd7dSZGQd05PCfpzTOGSUIGQTbIZeT3r00aE/+1eKfpjPX7zJZQ=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A07C84BA9016
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 68K01Pxl027207
	for <cygwin-patches@cygwin.com>; Sat, 19 Sep 2026 17:01:25 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdy05wWG; Sat Sep 19 17:01:25 2026
Message-ID: <229b85bd-da08-4e17-a72c-393985a13556@maxrnd.com>
Date: Sat, 19 Sep 2026 16:47:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH/RFC] Patch to fix uid/gid lookup for NFSv4 filesystems
To: cygwin-patches@cygwin.com
References: <CAPJSo4UZZN2w=RhhsycAgBW9mim928K9MVw+T7O_9W2uynMD3g@mail.gmail.com>
 <CAPJSo4XhJJJxV=FpWQ44Q5NP=Y46-XPsopNhexzSyGYENjhdRA@mail.gmail.com>
 <CAPJSo4WPqHqcxFS6AL8Cauo4Na6=u14Tw8eennKk_27rnd-rtQ@mail.gmail.com>
 <CAPJSo4X2yqaua0LfD-4qeJsMTLgMGfJT-m05b_8poDwtMGc2sA@mail.gmail.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <CAPJSo4X2yqaua0LfD-4qeJsMTLgMGfJT-m05b_8poDwtMGc2sA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hello Lionel,

On 9/19/2026 2:54 AM, Lionel Cons wrote:
> On Fri, 21 Aug 2026 at 17:20, Lionel Cons <lionelcons1972@gmail.com> wrote:
>>
>> On Sun, 16 Aug 2026 at 19:35, Lionel Cons <lionelcons1972@gmail.com> wrote:
>>>
>>> Repost with proper [PATCH/RFC] tag.
>>>
>>> I've attached a patch
>>> (cygwin_dll_fix_uidgid4nfsv4_fs_20260709.diff.txt from the
>>> ms-nfs41-client project) that resolves an issue with uid/gid lookups
>>> on Windows NFSv4 filesystems.
>>>
>>> Currently, Cygwin assumes that all Windows NFS clients operate
>>> similarly to the Windows NFSv3 client. It expects that account names
>>> and numeric uid/gid values are identical on both the client and server
>>> sides, with LDAP acting as the sole authority for these numeric
>>> values.
>>>
>>> However, the NFSv4 protocol fundamentally changes this paradigm. As
>>> defined in RFC 7530 (Section 5.9) and expanded upon in RFC 8178 (Rules
>>> for NFSv4 Domain and ID Mapping), NFSv4 deprecates raw numeric uid/gid
>>> protocol representation in favor of string-based identifiers (e.g.,
>>> user@domain and group@domain).
>>>
>>> To handle this, all NFSv4 clients implement a local "idmapper"
>>> component that translates these string-based identities from the
>>> network side into local account data (in the case of Windows, mapping
>>> user/group names and uid/gid values via nfs3attr XATTR). Because NFSv4
>>> clients manage their own uid/gid translation locally, Cygwin's
>>> reliance on raw LDAP data fails in these environments and results in
>>> the dreaded "Unix_User+<1234>" and "Unix_Group+<5678>"-kind of
>>> owner/group output in Cygwin ls -l.
>>>
>>> The attached patch addresses this by detecting whether the underlying
>>> filesystem is NFSv4. If it is, Cygwin bypasses the LDAP assumption and
>>> performs a direct pass-through of the uid/gid values supplied by the
>>> NFSv4 client's idmapper.
>>>
>>> I have successfully tested this fix against several major clients, including:
>>> - Exceed NFSv4 client
>>> - OpenText NFSv4 client
>>> - ms-nfs41-client
>>> - ms-nfs42-client
>>> - Windows NFSv3 client (no change, it continues to use LDAP raw data)
>>>
>>> Please let me know if you have any questions or require modifications
>>> to the patch.
>>
>> ?
> 
> Can anyone PLEASE have a look at this patch?

Sorry for the delayed response.  The patch looks OK to me.  I'm in the 
process of getting it released.

..mark

