Return-Path: <SRS0=U+Cg=EP=maxrnd.com=mark@sourceware.org>
Received: from m0.truegem.net (m0.truegem.net [69.55.228.47])
	by sourceware.org (Postfix) with ESMTPS id 088A94BA23D0
	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2026 08:54:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 088A94BA23D0
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=maxrnd.com
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=maxrnd.com
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 088A94BA23D0
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=69.55.228.47
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1781859269; cv=none;
	b=npT/9LKppL+4BCttV406i9BHKg0o/bfhFFftyO38J/8gxny0jA21prEC6zn5l4ELguHw0JDhREuqalgdGsl5aQ7Z5KNBHU1RZHf+qlvhPDdW3We7HK073Nxggcq6eHPhTLCbn8aeXLRPKAJOk64WCqRFupMbp0YOiHg7haR00SA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1781859269; c=relaxed/simple;
	bh=0Nt8AXB4EF8mUuDQmE9JGizEU7MAXCVZ6de0WQV2XDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From; b=T2HV2hFCjmirjGvrUE2GCKb1PVVeCBHWr8CvMgdYT24deb6NUg38rNlPhmp+XZve9KFcaPT0TmcWO/Up09Wgh/yLaz8Y8abKnl0QsWYhT0CcK4BpI6BY6UWgRvMv7Ljfw+HCGAYrEi3bcImzI+jRDaTQHboWHplSfjlWAB8jB1U=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 088A94BA23D0
Received: (from daemon@localhost)
	by m0.truegem.net (8.12.11/8.12.11) id 65J99XuS007538
	for <cygwin-patches@cygwin.com>; Fri, 19 Jun 2026 02:09:33 -0700 (PDT)
	(envelope-from mark@maxrnd.com)
Received: from 50-1-255-146.fiber.dynamic.sonic.net(50.1.255.146), claiming to be "[192.168.4.101]"
 via SMTP by m0.truegem.net, id smtpdg3XgIl; Fri Jun 19 02:09:32 2026
Message-ID: <c88a00b4-4bff-4c5d-bb7b-336a7a1d45c8@maxrnd.com>
Date: Fri, 19 Jun 2026 01:54:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Status of patches I proposed recently
To: cygwin-patches@cygwin.com
References: <20260612224229.a1b848b8a14bb84a471fc958@nifty.ne.jp>
 <20260613232444.d4bf8f3d8d33908d8be14e74@nifty.ne.jp>
 <20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
Content-Language: en-US
From: Mark Geisert <mark@maxrnd.com>
In-Reply-To: <20260619140542.158c4f34e9083169a1882b9c@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,KAM_DMARC_STATUS,SPF_HELO_NONE,SPF_PASS,TXREP shortcircuit=no autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

Hi Takashi,

On 6/18/2026 10:05 PM, Takashi Yano wrote:
> Hi,
> 
> Is anyone willing to review these pty/console patches?
> 
> On Sat, 13 Jun 2026 23:24:44 +0900
> Takashi Yano wrote:
>> All pty/console patches are not reviewed yet. Three patches are tested by Koichi.
>>
>> * pty patches [New feature]:
>> [PATCH v2 2/3] Cygwin: pty: Discard pcon input buffer when discard_input is called.      +     [13 Jun]
>> [PATCH v2 3/3] Cygwin: pty: Fixup pty state after a cygwin app exits                     +     [13 Jun]
>> (These two patches require following pty bug fix patches.)
>>
>> * pty/console pathces [Bug fix]:
>> [PATCH] Cygwin: pty: Do not set input_available_event when applying line_edit()          (T)   [ 8 Jun]
>> [PATCH v3 1/2] Cygwin: pty: Introduce a helper function get_handle_from_process()        (T)+  [ 8 Jun]
>> [PATCH v3 2/2] Cygwin: pty: Prevent unintended conversion for cursor position report     (T)+  [ 8 Jun]
>> [PATCH v5] Cygwin: pty: Fix race issue between starting and exiting non-cygwin app       +     [11 Jun]
>> [PATCH 1/3] Cygwin: console: Ensure the master thread runs only when it is supposed to         [11 Jun]
>> [PATCH 2/3] Cygwin: console: Fix NOFLSH mode a little                                          [11 Jun]
>> [PATCH 3/3] Cygwin: console: Fix typeahead input for bash                                      [11 Jun]
>> [PATCH] Cygwin: pty: Treat CR/NL in accept_input() the same as in transfer_input()             [12 Jun]
>>
>> * Others [ALl done]
>> [PATCH v3] Cygwin: clipboard: Add workaround for ERROR_CLIPBOARD_NOT_OPEN                (R)+(P)
>>
>> + Patch revised after the last report
>> (T) Tested
>> (R) Under review
>> (P) Pushed

I will start looking at these later today, June 19.  Given this code is 
new to me and (unlike Johannes) I'm not yet using Claude to assist, it 
might be slow-going.  But it's all we've got, looks like ;-).

Anybody else with some free time (yeah, right) feel free to join.  The 
more eyes on this, the better.  That goes for all patches of course.
Cheers,

..mark
