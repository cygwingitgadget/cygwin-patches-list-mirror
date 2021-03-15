Return-Path: <HBBroeker@t-online.de>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
 by sourceware.org (Postfix) with ESMTPS id BD63A3858D29
 for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021 19:05:14 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BD63A3858D29
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org;
 spf=none smtp.mailfrom=HBBroeker@t-online.de
Received: from fwd20.aul.t-online.de (fwd20.aul.t-online.de [172.20.26.140])
 by mailout07.t-online.de (Postfix) with SMTP id C111434595
 for <cygwin-patches@cygwin.com>; Mon, 15 Mar 2021 20:04:27 +0100 (CET)
Received: from [192.168.178.26]
 (ZG7Bn2ZQ8hsWMfgw0hRFpFk8CQQWyV7McBo1cnfHln92bAPcGBQeiAOp9Ayyz9qZPy@[87.154.41.231])
 by fwd20.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1lLsVv-2AbiL20; Mon, 15 Mar 2021 20:04:27 +0100
Subject: Re: [PATCH 1/2] Treat Windows Store's "app execution aliases" as
 symbolic links
To: cygwin-patches@cygwin.com
References: <nycvar.QRO.7.76.6.2103121611440.50@tvgsbejvaqbjf.bet>
 <ff661784-ae78-4a98-8f6d-cddd57b0d216@pismotec.com>
 <nycvar.QRO.7.76.6.2103140115180.50@tvgsbejvaqbjf.bet>
 <86c7c1b6-06f9-9e60-e9d7-072b6e8c806f@pismotec.com>
 <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
From: =?UTF-8?Q?Hans-Bernhard_Br=c3=b6ker?= <HBBroeker@t-online.de>
Message-ID: <69dc492e-cce9-1a1a-7d4b-92a58dbfe981@t-online.de>
Date: Mon, 15 Mar 2021 20:04:23 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2103150408230.50@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ID: ZG7Bn2ZQ8hsWMfgw0hRFpFk8CQQWyV7McBo1cnfHln92bAPcGBQeiAOp9Ayyz9qZPy
X-TOI-EXPURGATEID: 150726::1615835067-000053CC-7D645B38/0/0 CLEAN NORMAL
X-TOI-MSGID: ee34687b-57de-4ca3-ad3f-621df7d46f2a
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE,
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
X-List-Received-Date: Mon, 15 Mar 2021 19:05:16 -0000

Am 15.03.2021 um 04:19 schrieb Johannes Schindelin via Cygwin-patches:
> Hi Joe,
> 
> On Sat, 13 Mar 2021, Joe Lowe wrote:
> 
>> I agree on the usefulness to the user of showing appexec target executable as
>> symlink target. But I am uncertain about the effect on code.
> 
> Maybe. But I am concerned about the effect of not being able to do
> anything useful with app execution aliases in the first place. 

That argument might hold more sway if Windows itself didn't quite so 
completely hide that information from users, too.

I found only one Windows native tool that will even show _any_ kind of 
information about these reparse points: fsutil.  That is a) only 
available as part of the highly optional WSL feature and b) only gives 
you a hexdump of the actual data, without any meaningful interpretation.

For something that Windows itself gives the "no user servicable parts 
inside" treatment to the extent it does for these reparse points, I 
rather doubt that Cygwin users really _need_ to see it.

