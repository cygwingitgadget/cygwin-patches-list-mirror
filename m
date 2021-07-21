Return-Path: <Christian.Franke@t-online.de>
Received: from mailout04.t-online.de (mailout04.t-online.de [194.25.134.18])
 by sourceware.org (Postfix) with ESMTPS id C1C19385BF83
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 10:24:16 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org C1C19385BF83
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=t-online.de
Received: from fwd28.aul.t-online.de (fwd28.aul.t-online.de [172.20.26.133])
 by mailout04.t-online.de (Postfix) with SMTP id 44D2D3D68B
 for <cygwin-patches@cygwin.com>; Wed, 21 Jul 2021 12:24:15 +0200 (CEST)
Received: from [192.168.2.105]
 (XGZkIMZEghy+BvFYP6ZBxrRqGmCV0FXgYeuyOxCj+rfKaQfMmD7txcmUki0COCbwlx@[79.230.169.184])
 by fwd28.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1m69Og-0Ymga00; Wed, 21 Jul 2021 12:24:14 +0200
Subject: Re: [PATCH 0/3] Add more winsymlinks values
To: cygwin-patches@cygwin.com
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <616f5f9b-83e2-689c-bda3-dddc50dff5f0@t-online.de>
Date: Wed, 21 Jul 2021 12:24:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:60.0) Gecko/20100101
 SeaMonkey/2.53.7.1
MIME-Version: 1.0
In-Reply-To: <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XGZkIMZEghy+BvFYP6ZBxrRqGmCV0FXgYeuyOxCj+rfKaQfMmD7txcmUki0COCbwlx
X-TOI-EXPURGATEID: 150726::1626863054-0000EDA1-F2A6F467/0/0 CLEAN NORMAL
X-TOI-MSGID: 12ed77b0-4c40-4a95-a9b7-b0d95477f338
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NONE,
 TXREP autolearn=no autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Wed, 21 Jul 2021 10:24:18 -0000

Corinna Vinschen wrote:
> On Jul 19 17:31, Jon Turney wrote:
>> I'm not sure this is the best idea, since it adds more configurations that
>> aren't going to get tested often, but the idea is that this would enable
>> proper and consistent control of the symlink type used from setup, as
>> discussed in [1].
>>
>> [1] https://cygwin.com/pipermail/cygwin-apps/2021-May/041327.html
> Why isn't it sufficient to use 'winsymlinks:native' from setup?
>
> The way we express symlinks shouldn't be a user choice, really.  The
> winsymlinks thingy was only ever introduced in a desperate attempt to
> improve access to symlinks from native tools, and I still don't see a
> way around that.  But either way, what's the advantage in allowing the
> user complete control over the type, even if the type is only useful in
> Cygwin?
>

WSL compatible symlinks introduce several issues with non-Cygwin 
Copy/Archive/Backup tools (robocopy behaves strange, 7-Zip stores these 
as empty files, ...). If WSL itself is not used on a machine, there is 
possibly no benefit using such symlinks for Cygwin there.

I usually prefer the old "magic" cookie SYSTEM files, in particular on 
portable installs for "rescue" purposes. Patch 2/3 would allow to select 
these.

+1 from me for this enhancement.

Christian

