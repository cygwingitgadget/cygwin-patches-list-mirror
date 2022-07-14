Return-Path: <Christian.Franke@t-online.de>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
 by sourceware.org (Postfix) with ESMTPS id A2B183858C52
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 14:41:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A2B183858C52
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=t-online.de
Received: from fwd84.dcpf.telekom.de (fwd84.aul.t-online.de [10.223.144.110])
 by mailout10.t-online.de (Postfix) with SMTP id 76719FF5E
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 16:41:44 +0200 (CEST)
Received: from [192.168.2.102] ([87.187.34.65]) by fwd84.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1oC02C-3v8X6O0; Thu, 14 Jul 2022 16:41:44 +0200
Subject: Re: [PATCH rebase] Add support for Compact OS compression for Cygwin
To: cygwin-patches@cygwin.com
References: <e281c355-1ea1-eefa-12d8-17f7538edb60@t-online.de>
 <Ys/u2QmY8E1s0hZd@calimero.vinschen.de>
 <ae3b7f6f-cb27-3ffa-3b47-300db32ffc25@t-online.de>
 <YtAoF7HvCTw177IB@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <f8f4e3af-c39b-415a-7d6e-5e9a7aa07162@t-online.de>
Date: Thu, 14 Jul 2022 16:41:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 SeaMonkey/2.53.12
MIME-Version: 1.0
In-Reply-To: <YtAoF7HvCTw177IB@calimero.vinschen.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TOI-EXPURGATEID: 150726::1657809704-0144CFA9-063FEC55/0/0 CLEAN NORMAL
X-TOI-MSGID: f6f6145c-5053-4d73-a32f-687082b3064c
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 14 Jul 2022 14:41:47 -0000

Corinna Vinschen wrote:
> On Jul 14 14:12, Christian Franke wrote:
>
>>>> +#endif
>>> This ifdef still makes sense, of course ...
>> Could possibly also be enhanced to __MSYS__ and msys1.dll.
> Not sure this makes sense.  Does their installer support CompactOS?

No, AFIAK. Then only (nonexistent?) users who run 'compact /c /exe:lzx 
...' manually on their installation would benefit.


>>
>>> ... and on first glance, the
>>> remainder of the patch LGTM.
>> Thanks. Attached is an alternative patch with most ifdefs removed.
> LGTM.  I'm not going to push it, yet, because... do you still want to
> add the aforementioned MSYS support?  If not, I'll just go ahead.

Please go ahead. I don't want to add platform specific code not actually 
tested on that platform.

Thanks,
Christian

