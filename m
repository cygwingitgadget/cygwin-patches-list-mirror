Return-Path: <SRS0=33I6=IQ=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 6E5094BA2E07
	for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2026 22:43:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 6E5094BA2E07
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 6E5094BA2E07
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1793054600; cv=none;
	b=k1IXPzWn20dEYuKSO/X8GuaHbP2TNVct1hW1g6csUlPDC+0S6TVdOJNnaMYcrzZN3SihSQ86VECn+Au+dSHHjAdd0oY1gUaWUU0RRP/oa1kCP1Sfne5JUzIHfue3iI88Mep5juey7Wx9071JKOcjzLu71bwsJfTSbtuSp2eOaYk=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1793054600; c=relaxed/simple;
	bh=w5oz7+5vPqMhK8qlvZaa3NJXh9XHCuGBd8Y/NZDPCUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=BuY0JgLww/r52QEphExZjgSeO4asIqV3kO2FI3S6p/Sm7h8CCsJqknNeTR50z2/0nJGcz+1Y1aocjBmzW0CxGS698TnHdyhijIKmjtrfl4tmsZxQGq0BJKsQ4LPBFzr34L4ZI/iXy4KHLfzrA9kRPjzF+YYLwG92k4UV8a+FrjA=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 6E5094BA2E07
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 69QMue7l005487
	for <cygwin-patches@cygwin.com>; Mon, 26 Oct 2026 15:56:40 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-253-193.fiber.dynamic.sonic.net(50.1.253.193), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdlItxI4; Mon Oct 26 14:56:30 2026
Message-ID: <26df6dbb-9570-4cda-b6e8-268ab1070f47@maxrnd.com>
Date: Mon, 26 Oct 2026 15:43:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Porting "Cygwin: Handle uids/gids correctly on NFSv4 filesystems"
 to Cygwin 3.6?
To: Cygwin Patches <cygwin-patches@cygwin.com>
References: <20260920035524.60008-1-mark@maxrnd.com>
 <CAPJSo4UaKfnUZCB1zjYD1mVXzUcE38c+e_Nu2QTXH0VJUg_k0g@mail.gmail.com>
 <162a3cb8-fdfd-47bb-9bed-4f7b0621743c@maxrnd.com>
 <CAPJSo4XtD0n8+Jjk=BXjZwCwo97mOcUp-7Zw_cVHnd=eoSgK5w@mail.gmail.com>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <CAPJSo4XtD0n8+Jjk=BXjZwCwo97mOcUp-7Zw_cVHnd=eoSgK5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Lionel,

On 10/26/2026 4:47 AM, Lionel Cons wrote:
> On Wed, 14 Oct 2026 at 09:49, Mark Geisert <mark@maxrnd.com> wrote:
>>
>> Hi Lionel,
>>
>> On 10/13/2026 11:24 PM, Lionel Cons wrote:
>>> Can this patch please be ported to Cygwin 3.6-branch? The scope,
>>> impact and risk is clearly defined as being limited to NFSv4
>>> filesystems. As the current code in Cygwin3.6-release does not work
>>> with NFSv4 filesystems this patch would fix things without impacting
>>> anything else.
>>>
>>> Lionel
>>>
>>> ---------- Forwarded message ---------
>>> From: Mark Geisert <mark@maxrnd.com>
>>> Date: Sun, 20 Sept 2026 at 05:55
>>> Subject: [PATCH] Cygwin: Handle uids/gids correctly on NFSv4 filesystems[...]
>>
>> I have no objection to that request.  As 3.6.11 was released just a
>> couple weeks ago, you would need to run an as-yet-unplanned pre-3.6.12
>> test release to obtain the fix.
> 
> How does that work? How can I help?

Nothing additional is needed.

>> I'm checking off-line to see how much further the 3.6.x train is planned
>> to go.
> 
> Cygwin cygwin-3.6.12 was tagged, I PRAY there will be a cygwin-3.6.13
> with this fix,
> 
>> I will backport the patch, if I can, after I get the answer.
The patch was intended for 3.6.12 but that release went out urgently due 
to IMO folks IRL futzing around with updated standard time vs daylight 
time zones imposed with unreasonable deadlines. :-)

There will be a 3.6.13 and it will include the patch.  "Soon".

..mark
