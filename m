Return-Path: <SRS0=ExB5=IW=dronecode.org.uk=jon.turney@sourceware.org>
Received: from re-prd-fep-049.btinternet.com (mailomta6-re.btinternet.com [213.120.69.99])
	by sourceware.org (Postfix) with ESMTPS id 7D6743858438
	for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:09:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7D6743858438
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=dronecode.org.uk
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=dronecode.org.uk
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7D6743858438
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=213.120.69.99
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1705068590; cv=none;
	b=JxaMk+j989aZwnTrHuqNc4wr/ua+wVyESdpz1QUcIReSrsDC8++3juyRzE8NkdxgO1ZoS858DKowV/QhlHmQ5xHLVhCpYNUbReXgFP33ZgD9eFQEH5Dl8tuVxt0/TGrbq/ZKcreAu9mxxm/0KvoIk7KrOzvBgua3jhRGp78A1VU=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1705068590; c=relaxed/simple;
	bh=cLUIxTY9tmjBFotxZvzTTWzhrOfHMaqlVDjRXKdg2kQ=;
	h=Message-ID:Date:MIME-Version:From:Subject; b=EgTuNSM2fdvTO06Y38SRuR0Ti7xEoaefJF1tC+0o9+nWOIzIHyIBDbjlPpcbDJkTcSnumI0pDH1gb7EUgwhzptAbk7eu2f/5oUHSHU/bRTl7R/E5KqbipcqiEmoy7WaKNE58MXN3zMiQqUe+XRUYsKC3DrJy6AD3vxIBEQhldDo=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from re-prd-rgout-004.btmx-prd.synchronoss.net ([10.2.54.7])
          by re-prd-fep-049.btinternet.com with ESMTP
          id <20240112140947.RORA8012.re-prd-fep-049.btinternet.com@re-prd-rgout-004.btmx-prd.synchronoss.net>
          for <cygwin-patches@cygwin.com>; Fri, 12 Jan 2024 14:09:47 +0000
Authentication-Results: btinternet.com;
    auth=pass (PLAIN) smtp.auth=jonturney@btinternet.com;
    bimi=skipped
X-SNCR-Rigid: 6577B87C03C863B5
X-Originating-IP: [86.139.158.103]
X-OWM-Source-IP: 86.139.158.103
X-OWM-Env-Sender: jon.turney@dronecode.org.uk
X-VadeSecure-score: verdict=clean score=30/300, class=clean
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgheelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuueftkffvkffujffvgffngfevqffopdfqfgfvnecuuegrihhlohhuthemuceftddunecumhhishhsihhnghcuvffquchfihgvlhguucdlfedtmdenucfjughrpefkffggfgfhufevfhgjtgfgsehtjeertddtvdejnecuhfhrohhmpeflohhnucfvuhhrnhgvhicuoehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkqeenucggtffrrghtthgvrhhnpeeufeekieegvdeuteejtdffteduuefhudduudeiieeghfejuedtkeeggfevveduueenucfkphepkeeirddufeelrdduheekrddutdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehhvghloheplgduledvrdduieekrddurddutdejngdpihhnvghtpeekiedrudefledrudehkedruddtfedpmhgrihhlfhhrohhmpehjohhnrdhtuhhrnhgvhiesughrohhnvggtohguvgdrohhrghdruhhkpdhnsggprhgtphhtthhopedupdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomhdprhgvvhfkrfephhhoshhtkeeiqddufeelqdduheekqddutdefrdhrrghnghgvkeeiqddufeelrdgsthgtvghnthhrrghlphhluhhsrdgtohhmpdgruhhthhgpuhhsvghrpehjohhnthhurhhnvgihsegsthhinhhtvghrnhgvthdrtghomhdpghgvohfkrfepifeupdfovfetjfhoshhtpehr
	vgdqphhrugdqrhhgohhuthdqtddtge
X-RazorGate-Vade-Verdict: clean 30
X-RazorGate-Vade-Classification: clean
Received: from [192.168.1.107] (86.139.158.103) by re-prd-rgout-004.btmx-prd.synchronoss.net (authenticated as jonturney@btinternet.com)
        id 6577B87C03C863B5 for cygwin-patches@cygwin.com; Fri, 12 Jan 2024 14:09:47 +0000
Message-ID: <78da8311-84d6-452f-a41a-4758e1a1bb3e@dronecode.org.uk>
Date: Fri, 12 Jan 2024 14:09:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jon Turney <jon.turney@dronecode.org.uk>
Subject: Re: [PATCH 1/2] Cygwin: Make 'ulimit -c' control writing a coredump
Cc: cygwin-patches@cygwin.com
References: <20240110135705.557-1-jon.turney@dronecode.org.uk>
 <20240110135705.557-2-jon.turney@dronecode.org.uk>
 <ZZ64BtnmZtmyRZYi@calimero.vinschen.de>
 <b1cbea19-824e-4763-ad69-f634beb0c081@dronecode.org.uk>
 <ZZ-39tW-1UK-69eD@calimero.vinschen.de>
Content-Language: en-GB
In-Reply-To: <ZZ-39tW-1UK-69eD@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,JMQ_SPF_NEUTRAL,KAM_DMARC_STATUS,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

On 11/01/2024 09:42, Corinna Vinschen wrote:
> On Jan 10 17:38, Jon Turney wrote:
>> On 10/01/2024 15:30, Corinna Vinschen wrote:
>>> On Jan 10 13:57, Jon Turney wrote:
>> [...]
>>>>
>>>> Also: Fix the (deprecated) cygwin_dumpstack() function so it will now
>>>> write a .stackdump file, even when ulimit -c is zero. (Note that
>>>> cygwin_dumpstack() is still idempotent, which is perhaps odd)
>>>
>>> Given it's deprecated and not exposed in the headers, and given
>>> we only still need the symbol for backward compat, how about making
>>> this function a no-op instead?
>>
>> We still need the function internally to write stackdumps.
> 
> Oh, right, I missed the usage in api_fatal.  I was only talking
> about the exported function, or rather, the fact that it's exported.
> We could split it in internal and external function and...
> 
>> I know it's use has long been discouraged, but doing a GitHub code search
>> does find some uses of it.  What is the suggested replacement?
> 
> ...doing nothing in the exported function was the idea.  There appear to
> be a handful of projects on github though, which call it.  Not sure it's
> the right thing to do, though.  External code should better raise a
> signal in this case.

I was more thinking that anything that's using it for a serious 
purposes, should probably be using libunwind or something similar, which 
maybe doesn't exist or work on Cygwin currently (or didn't back when it 
was written).

In any case, any change to cygwin_stackdump() seems out of scope for 
this work, so can we park that discussion for the moment.

> However, if we take it as given, and if external code calls
> cygwin_stackdump, do we really want it to create a stackdump, or
> shouldn't the behaviour be the same as if a core-creating signal has
> been raised?  See below.
> 
>> (I'm also wondering if the idempotency is in the wrong place.  Is it
>> possible for signal_exit() get called by multiple threads?  In which case it
>> probably needs to do something sane in that case)
> 
> signal_exit is only called from sigpacket::process, and this method
> in turn is only called from the wait_sig function, so it's only
> called from the signal thread.

Good news.

> I just wonder if we really want to create a stackdump unconditionally
> at all, after introducing corefile support and handling ulimit the
> way you do it.
> 
> I.e., we have (basically) three situations:
> 
> - A core-creating signal has been raised
> - api_fatal calls cygwin_stackdump
> - External code calls cygwin_stackdump
> 
> Wouldn't it make sense to handle them equally, depending on
> the ulimit settings?

I don't think we want to get into second-guessing why an application is
calling cygwin_stackdump(), and changing it when it's deprecated and 
going to be removed seems silly.

Looking at the history, the current behaviour (of cygwin_stackdump() not 
dumping based on rlim_core) seems like simply an unintended side-effect 
of where the check is done.

Anyhow, rather than improving this function, there are, or at least 
should be, better user-space alternatives to use.

I hadn't noticed that api_fatal() also calls cygwin_stackdump().

Assuming generating a stackdump at that point has some value, it does 
seems to make sense to treat it the same.  (But given all the 
signal-specific things that signal_exit() does, I'm not sure the code 
can be made common).

>>> Can't this be done by adding the max size as parameter to dumper?
>>>
>>
>> Maybe. That would make forward/backwards compatibility problems when mixing
>> dumper and cygwin versions.
> 
> How's that supposed to happen?  dumper is part of the Cygwin package,
> so, together with using the right absolute path, there's no way to
> use the wrong dumper version.  If so, it's certainly an SEP.
> 
>> I don't think we can control the size of the file as we write it, we'd need
>> to check afterwards if it was too big, and then remove/truncate.
>>
>> And we need to do the same action for stackdumps, so I think it makes more
>> sense to do that checking in the DLL.
> 
> I see.  It's a bit unfortunate though, if dumper tries to create
> a 2 Gigs file which is later truncated, if we're low on disk space.
> But yeah, disk space isn't much of a problem these days, I guess...

Assuming there isn't a clear specification of which of these is supposed 
to happen, I think removing is the better choice, since partial 
coredumps are just useless.

(There's still some potential lossage if the coredump is big enough to 
fill the disk, but less than the (perhaps badly-chosen) ulimit.  But 
maybe that could be fixed by having dumper remove the file if it 
couldn't be written successfully))


