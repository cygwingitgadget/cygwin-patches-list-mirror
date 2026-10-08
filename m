Return-Path: <SRS0=0+Cc=H6=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo004.btinternet.com (btprdrgo004.btinternet.com [65.20.50.180])
	by sourceware.org (Postfix) with ESMTP id E446C4BA2E08
	for <cygwin-patches@cygwin.com>; Thu,  8 Oct 2026 10:29:44 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E446C4BA2E08
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org E446C4BA2E08
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.180
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791455385; cv=none;
	b=t17YLxw0TP2wghCUlPZE3VfPl8G1RUci0umdt9RfCPTr5RkrxOLAtPScVW3C05HkL3Ht0lXY3Y2pVJNQBybv6CQmAM1CHoLp/s3MkdiKyGQWd9Oy5z+TgY5BXREIuAx38rOus4ZvYoqt/DZVBhz+DU+60DUe53I7PYfbU0131Z0=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791455385; c=relaxed/simple;
	bh=+VvWBD1Y5CgMyUTSHJjvCzlAW1635v28JaN4O2PBMvk=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=Z4dSf3BDBr5iH1kquEy4up9E/Cu2FHnOy8JrUR06CsV6NvI11H4e7sNzYNfiXXqL+NXdu0cHmLnSpLGAEx8Haojd15kvF74IbL+lh2E9Q/2GcyeXiNq63069EOoMHZP7IZYy7ZjQHioqKnFpyeP1TIj4s0YA5o1KH5rlP1URXEs=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org E446C4BA2E08
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A715CD60C9E3001
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTF5ZJK8HpcEf/t8dtuwvJjsH95a1B6qjDiojac5ELrnhaRg217/E3tfevHW7+ploBCkNy+5IkWhhXes+0zE3RASGcpd3W7okx6v8By+trj2S2uImFqTvQjaYQ6dI3cbDwv3VRlZKynQ2IAEc+0Y0aKrgXOINar5DBbp8mEMePiSjmiM/P+CYYw+JjfuMLTKRnXt7c2hr1AMlAsdFEDX0mMnkThaVfxlGZhMA9T7THbvWxd+u9fh4iR/7WVrKSTnPOoX12cNjPkUWl5RIc6iQJVYbVGpH/vAqvX6u/jarp+oAlVV3MHtBCRTbTSugj6Imam0LBkMr14w/nsz6p71w/2LoFHYjJCi0YqzwJWUSd75hCgJLDF9mJXZh4SrMS/XN3LfFt3XyVOKVnrhMuwELnzMqMDkMw6kX4oPZofQX6AFvpQCCra7W8hu7CWfQtvAlGrR0eJGkYFsCM+aQMfPRzUo+pnfNAxXOlcx0LiJw2pY+JvUJRpaC9VQ1YBL0/5TGGeCSz9/TuSVuNZTJtZc8ScboSgoisiYX/G8tR8w993vuF67EZ0Up21L+th2pGGorGhWGxytwMoGiJxdiJyjr9ncIjpij/S6S1k04RL/35O10bLDYFREGncYjE8pttF3G90A4QeKfOtHs+pCngVelIIqVVH+GVRxlQ4FuA61vLebkA
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo004.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A715CD60C9E3001 for cygwin-patches@cygwin.com; Thu, 8 Oct 2026 11:29:41 +0100
Message-ID: <d3b28759-be02-418b-af63-ef9d7169de42@dronecode.org.uk>
Date: Thu, 8 Oct 2026 11:29:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: sequencer: Implement /dev/sequencer
References: <20261007192542.1049-1-takashi.yano@nifty.ne.jp>
 <b087383d-0d79-4ecb-88a4-42b0fecf0602@maxrnd.com>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <b087383d-0d79-4ecb-88a4-42b0fecf0602@maxrnd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 08/10/2026 03:57, Mark Geisert wrote:
> Hi Takashi,
> 
> On 10/7/2026 12:25 PM, Takashi Yano wrote:
>> This is an experimental implementation of /dev/sequencer for the
>> external MIDI devices. Currently, only output is supported.
>>
>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>> ---
>> v2: Use archetype.
>>
>>   winsup/cygwin/Makefile.am               |   1 +
>>   winsup/cygwin/autoload.cc               |   7 +
>>   winsup/cygwin/devices.cc                | 847 ++++++++++++------------
>>   winsup/cygwin/devices.in                |   1 +
>>   winsup/cygwin/dtable.cc                 |   3 +
>>   winsup/cygwin/fhandler/sequencer.cc     | 452 +++++++++++++
>>   winsup/cygwin/local_includes/devices.h  |   1 +
>>   winsup/cygwin/local_includes/fhandler.h |  53 ++
>>   8 files changed, 954 insertions(+), 411 deletions(-)
>>   create mode 100644 winsup/cygwin/fhandler/sequencer.cc
> I'm not familiar with how Cygwin defines its devices so I may be out to 
> lunch with this observation, but...
> 
> Isn't devices.cc built by cygwin/scripts/gendevices?  cygwin/Makefile.in 
> seems to show that.  Maybe I'm oversimplifying what's really going on 
> (and am, thus, out to lunch).

This is correct, but the file is checked in for "historical reasons".

(since it requires the obscure 'shilka' tool from the cocom package to 
regenerate. In pre-git times I think it was possible do a build without 
it, but the way git arranges timestamps prevents that).


