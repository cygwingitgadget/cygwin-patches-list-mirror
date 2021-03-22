Return-Path: <HBBroeker@t-online.de>
Received: from mailout09.t-online.de (mailout09.t-online.de [194.25.134.84])
 by sourceware.org (Postfix) with ESMTPS id A63243858D29
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 21:56:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A63243858D29
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=HBBroeker@t-online.de
Received: from fwd04.aul.t-online.de (fwd04.aul.t-online.de [172.20.26.149])
 by mailout09.t-online.de (Postfix) with SMTP id E8198AC0F8
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 22:54:49 +0100 (CET)
Received: from [192.168.178.26]
 (VsitkGZSgh7jEGGDERvK8NScKnL3EZG2QSHnUeRvQOEcy0LhzlJgaUYFjdp4JokZR+@[79.228.81.44])
 by fwd04.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1lOSVC-40kf1E0; Mon, 22 Mar 2021 22:54:22 +0100
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
 <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
 <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <830d2446-691e-957e-9531-856e58e79c08@t-online.de>
Date: Mon, 22 Mar 2021 22:54:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103221603030.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: de-DE
Content-Transfer-Encoding: 8bit
X-ID: VsitkGZSgh7jEGGDERvK8NScKnL3EZG2QSHnUeRvQOEcy0LhzlJgaUYFjdp4JokZR+
X-TOI-EXPURGATEID: 150726::1616450062-00004F6D-0C97F8C7/0/0 CLEAN NORMAL
X-TOI-MSGID: a33728e6-edac-4ad9-bda8-a9c4f43395c4
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 22 Mar 2021 21:56:17 -0000

Am 22.03.2021 um 16:22 schrieb Johannes Schindelin:
> On Mon, 15 Mar 2021, Hans-Bernhard Bröker wrote:
>> Am 15.03.2021 um 04:19 schrieb Johannes Schindelin via Cygwin-patches:

>> That argument might hold more sway if Windows itself didn't quite so
>> completely hide that information from users, too.

> "So completely"? It at least executes them, and it does offer you to turn
> them aliases on and off (see
> https://www.tenforums.com/tutorials/102096-manage-app-execution-aliases-windows-10-a.html)

That's a completely different piece of information than what you want 
Cygwin to show.

> Granted, the user interface has a lot of room for improvement, but if you
> are dead set on finding out what, say, that `idle.exe` app execution alias
> refers to, you can go to `Settings>Apps>Apps & features>App execution
> aliases` and find out that it is owned by the Python 3.7 package. 

Knowing which package that thing came from has essentially nothing to do 
with what its interpretation as a symlink would look like.  Apples and 
Oranges.

> The `fsutil` program, contrary to your claim, is available without WSL:
> https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/fsutil

And that very page tells me, in a big "Notice" blurb:

> You must enable Windows Subsystem for Linux before you can run fsutil. Run the following command as Administrator in PowerShell to enable this optional feature:


> One of those under-documented reparse point types is the WSL symbolic
> link, which you will notice are supported in Cygwin, removing quite some
> sway from your argument...

I notice no such thing right now, running the currently available 
release version 3.1.7:

stat: cannot stat '//wsl$/Debian/home/hbbro/link_to_a': Input/output error

[other commands that want to show more than just the name behave 
equivalently]

Links made by WSL directly on a Windows filesystem are understood by 
Cygwin.  But that's because WSL uses Windows symlinks in that case.

Microsoft could almost certainly just have used a symlink to implement 
this rather trivial feature.  But for some reason they apparently didn't 
care to explain anywhere, they chose to wildly overcomplicate it, 
inventing a completly type of reparse point.  So for what it's worth, 
that thing _is_not_a_symlink_.  Pretending it is one is bound to cause 
more problems than it solves.

> Well, that's funny: you are talking to one Cygwin user who needs to see
> it. So I feel a bit ignored by you there.

All conclusions based on a single example are wrong.
