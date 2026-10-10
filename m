Return-Path: <SRS0=F8mx=IA=dronecode.org.uk=jon.turney@sourceware.org>
Received: from btprdrgo012.btinternet.com (btprdrgo012.btinternet.com [65.20.50.227])
	by sourceware.org (Postfix) with ESMTP id AE1464BA2E10
	for <cygwin-patches@cygwin.com>; Sat, 10 Oct 2026 13:28:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org AE1464BA2E10
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org AE1464BA2E10
Authentication-Results: sourceware.org; arc=none smtp.remote-ip=65.20.50.227
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1791638931; cv=none;
	b=msKuvhCXe9riI5+xMvqjgCe4co3b5BeEVToqwohqfALbHtxvOs16Hz3lyPZfUxuPNEJQDrf0gX0B8RVhowwxmDwzQtI/RrzxwfoToY6yTbaI9CqacwHdm7PdCDePebbvyAYbDa+8VBTtvU0+27PFb+WJLbJvL6lF2h0uu5so27M=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1791638931; c=relaxed/simple;
	bh=m87dJIeYPjO2oYIFn3Or29uZuj0YVGxukR5WlcGG2uQ=;
	h=Message-ID:Date:MIME-Version:Subject:From; b=PEzrb42xKuAPU5XUjKUAyFOWykWW9v5iPNiNlw+OyzdM+MaIXvZsMyFyGBlRiWBwuZc+EMN2G8PNJBNGbxmobCw55fEFtUTgIGXhH7YpBMy4NeIojh+NGXMT0/Jjqw52QVy5exbfcaxEkl6na5PQFXKAkQ8FARRMo2NuH0RmpLg=
ARC-Authentication-Results: i=1; sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org AE1464BA2E10
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com
X-SNCR-Rigid: 6A7161CE0D126003
X-Originating-IP: [62.49.190.104]
X-OWM-Source-IP: 62.49.190.104
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: dmFkZTEmLgwzxlvjNVzL2Te50w0oT3NKXEhVGY/x31ta8fd8+9FGQ+UTZbCs9ppp8PlgkELpcJfp94QBp0TomHBM2ajV1mkBwpSMVtEvA2wNvTdEDsay/moliaW0yJXsHl0hMGMZCA/vf4ofIA3k4YB310V0CoXcdjTQ0Z591LJthB4ZLtr9DjunnX6TLepbAob0yH4fkqAS5hGyVRDPb+FYKPaSwa8JnpDYVDrFw8TlbfGYi4tku0DKsTZX5kUjl2Z56ZbeKiGBnzhXmVo/QmlW63BM89KQn1ABVh+phMceJTj5YSwhSovMQSbwYSSrc0PiJwqiZOnVHVWQdo8RFa7rVAldtpgD3/M0x67wrht4kClpTT0QQTzoM6Rkjtf9E2htAVRp5l2fePjKATlpNF7ld9GDc6Mf8Be2wjgedgiNF0y1hPuTAluxbhKY3lxr0hdHOO9PJtXTC4ZmH/0Vd3KeccX8BlZYknGL6Z4bXJmthWI1vUtbTPKF2q/qK5/qxt7spNR1B9+mJzBoFwEok1qtFWr9acTWac46YXq7S0UTPBhpdGSOsZ7/QNpDRrbibbI3mJYowZIzoo2EwEMUuGwJX0LUjHTwyah9wieAOPsFUxjDtPncTljkfl2jL22BuBbgbVVqAS2kVqLr8eZlyxBmGJh/HccrBU3c6z2tFtm5QsICOg
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.109] (62.49.190.104) by btprdrgo012.btinternet.com (authenticated as jonturney@btinternet.com)
        id 6A7161CE0D126003 for cygwin-patches@cygwin.com; Sat, 10 Oct 2026 14:28:46 +0100
Message-ID: <c660a54d-e63a-4f7f-ae57-380c10c184d5@dronecode.org.uk>
Date: Sat, 10 Oct 2026 14:28:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Cygwin: sequencer: Implement /dev/sequencer
References: <20261007192542.1049-1-takashi.yano@nifty.ne.jp>
 <b087383d-0d79-4ecb-88a4-42b0fecf0602@maxrnd.com>
 <d3b28759-be02-418b-af63-ef9d7169de42@dronecode.org.uk>
 <20261009133836.b9c96eec087ebb9d54784b0e@nifty.ne.jp>
From: Jon Turney <jon.turney@dronecode.org.uk>
Content-Language: en-GB
Cc: cygwin-patches@cygwin.com
In-Reply-To: <20261009133836.b9c96eec087ebb9d54784b0e@nifty.ne.jp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,BODY_8BITS,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_PBL,SPF_HELO_PASS,SPF_PASS,TXREP shortcircuit=no autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 09/10/2026 05:38, Takashi Yano wrote:
> Hi Mark, Jon,
> 
> Thanks for having a look.
> 
> On Thu, 8 Oct 2026 11:29:41 +0100
> Jon Turney wrote:
>> On 08/10/2026 03:57, Mark Geisert wrote:
>>> Hi Takashi,
>>>
>>> On 10/7/2026 12:25 PM, Takashi Yano wrote:
>>>> This is an experimental implementation of /dev/sequencer for the
>>>> external MIDI devices. Currently, only output is supported.
>>>>
>>>> Signed-off-by: Takashi Yano <takashi.yano@nifty.ne.jp>
>>>> ---
>>>> v2: Use archetype.
>>>>
>>>>    winsup/cygwin/Makefile.am               |   1 +
>>>>    winsup/cygwin/autoload.cc               |   7 +
>>>>    winsup/cygwin/devices.cc                | 847 ++++++++++++------------
>>>>    winsup/cygwin/devices.in                |   1 +
>>>>    winsup/cygwin/dtable.cc                 |   3 +
>>>>    winsup/cygwin/fhandler/sequencer.cc     | 452 +++++++++++++
>>>>    winsup/cygwin/local_includes/devices.h  |   1 +
>>>>    winsup/cygwin/local_includes/fhandler.h |  53 ++
>>>>    8 files changed, 954 insertions(+), 411 deletions(-)
>>>>    create mode 100644 winsup/cygwin/fhandler/sequencer.cc
>>> I'm not familiar with how Cygwin defines its devices so I may be out to
>>> lunch with this observation, but...
>>>
>>> Isn't devices.cc built by cygwin/scripts/gendevices?  cygwin/Makefile.in
>>> seems to show that.  Maybe I'm oversimplifying what's really going on
>>> (and am, thus, out to lunch).
>>
>> This is correct, but the file is checked in for "historical reasons".
>>
>> (since it requires the obscure 'shilka' tool from the cocom package to
>> regenerate. In pre-git times I think it was possible do a build without
>> it, but the way git arranges timestamps prevents that).
> 
> What happens if devices.cc is removed from git repository itself?
> Will anything problematic happen?
Probably nothing.

But I know this has been on Corinna's hit list for a long time, so if 
someone is going to touch this, the ideal outcome is just to remove the 
reliance on cocom entirely.

(I did start taking a look at using re2c here instead, but that kind of 
fell off my list. In any case, deep archaeology would be needed to 
discover the performance drivers behind the current implementation...)

