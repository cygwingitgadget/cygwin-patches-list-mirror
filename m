Return-Path: <ben@wijen.net>
Received: from 1.mo179.mail-out.ovh.net (1.mo179.mail-out.ovh.net
 [178.33.111.220])
 by sourceware.org (Postfix) with ESMTPS id 9DA7C386F022
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:52:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 9DA7C386F022
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player687.ha.ovh.net (unknown [10.108.57.153])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4398018459D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 11:52:03 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player687.ha.ovh.net (Postfix) with ESMTPSA id D08631A1840B9
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 10:51:59 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G0026cb26066-797f-4d33-8f5f-e7df8ad931c8,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 07/11] syscalls.cc: Implement non-path_conv dependent
 _unlink_nt
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-8-ben@wijen.net>
To: cygwin-patches@cygwin.com
From: Ben <ben@wijen.net>
Message-ID: <a4f67eee-79e7-6a72-c091-fe037851dde7@wijen.net>
Date: Mon, 18 Jan 2021 11:51:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210115134534.13290-8-ben@wijen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 7517070730686711556
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgddvudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecunecujfgurhepufhfvffhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuegvnhcuoegsvghnseifihhjvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevjeejgeefgfejueejffejgffhteetteetvddtledvteethfdvveeigeekkeeggfenucfkpheptddrtddrtddrtddpkedtrdduuddvrddvvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegsvghnseifihhjvghnrdhnvghtpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 18 Jan 2021 10:52:06 -0000

Hi,

After reiterating over my patches, I see this must come after
implementing the 'poor mans cache' commit.

I will reorder in a new patch-set.


Sorry about that.

Ben...

On 15-01-2021 14:45, Ben Wijen wrote:
> Implement _unlink_nt: wich does not depend on patch_conv
> ---
>  winsup/cygwin/fhandler_disk_file.cc |   4 +-
>  winsup/cygwin/forkable.cc           |   4 +-
>  winsup/cygwin/syscalls.cc           | 239 ++++++++++++++++++++++++++--
>  3 files changed, 228 insertions(+), 19 deletions(-)
> 
