Return-Path: <SRS0=8plw=JO=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id BAE0D4CC456C
	for <cygwin-patches@cygwin.com>; Wed, 25 Nov 2026 09:58:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org BAE0D4CC456C
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org BAE0D4CC456C
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1795600693; cv=none;
	b=OferhPxgSktxxiM/q44m/0seDPXI0BKmZh4fgMYJbutkg+4i2U7ks1hJzkbVYzXzDmVCUTPc0/N8QmJNBjfn7aMgbo5efJJDblRFlrRYn0OKX+46DLaVcs4922gtIl3Yy2k0/zCt9hmk4R4j8EZF1AJVO7/iJqrTWZgf/zCVj7g=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1795600693; c=relaxed/simple;
	bh=GFNv5WhPURXD5H9On5aclao39o3iQtvhirpHOZ5ymAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=IKafo1Ak+6cb7iH+YkKj/JNGz7Cw3sdfCZUfWQeCCB/AmzlI4yHjeMLH14aU2JJB6UHDX9E2rD3ct5WH5X1bKsO6aFZNznJOHPXSVRfULPL6bi9eCLlKlbq2woBpwBZZex2n1lpxCuMJtpTSHhCS9yKss38g9FoVsYXGHCJ0FZI=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org BAE0D4CC456C
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 6APAB5Yk062479
	for <cygwin-patches@cygwin.com>; Wed, 25 Nov 2026 02:11:05 -0800 (PST)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-253-193.fiber.dynamic.sonic.net(50.1.253.193), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdEZiMa0; Wed Nov 25 02:11:00 2026
Message-ID: <abdd00fc-22af-4d70-9bac-aa27113d16dc@maxrnd.com>
Date: Wed, 25 Nov 2026 01:58:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cygwin: pthread: Improve the performance of the
 destructor
To: cygwin-patches@cygwin.com
References: <20261124031736.1926-1-takashi.yano@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20261124031736.1926-1-takashi.yano@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

This patch LGTM.  Nice catch, and nicely done fix.
Thanks & Regards,

..mark

On 11/23/2026 7:17 PM, Takashi Yano wrote:
> Deleting pthread-related objects, such as pthread_mutex, becomes very
> slow when the number of the objects is large. Currently, these objects
> are managed in a singly linked list, where deletion requires O(n) time.
> As a result, deleting all objects takes O(n^2) time overall. Due to
> this issue, freeing a decoder in libde265 can sometime take several
> tens of seconds, because libde265 uses around 100,000 pthread_mutex
> objects depending on the video being decoded.
> 
> This patch changes the list to a doubly linked, reducing the overall
> deletion comlexity from O(n^2) to O(n).
> 
> Fixes: 5c83f260b87b ("(pthread_key_destructor_list::Remove): New function.")
> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
> Reviewed-by:[...]
