Return-Path: <ben@wijen.net>
Received: from 9.mo6.mail-out.ovh.net (9.mo6.mail-out.ovh.net [87.98.171.146])
 by sourceware.org (Postfix) with ESMTPS id 5639F388C01A
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 17:18:04 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 5639F388C01A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player690.ha.ovh.net (unknown [10.108.16.177])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id 58417237B5D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 18:18:03 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player690.ha.ovh.net (Postfix) with ESMTPSA id A9A4E1A085021
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 17:18:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-97G002998464a7-bc8e-4b33-856e-c1dde6bba499,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 11/11] dir.cc: Try unlink_nt first
From: Ben <ben@wijen.net>
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-12-ben@wijen.net>
 <20210118121343.GZ59030@calimero.vinschen.de>
 <1e7f1329-37bc-0e83-ed03-9d7f006acdde@wijen.net>
Message-ID: <b1daffbc-c898-2c50-c20f-cec1b2889654@wijen.net>
Date: Mon, 18 Jan 2021 18:18:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1e7f1329-37bc-0e83-ed03-9d7f006acdde@wijen.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14036031192281401092
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffhvfhfkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuegvnhcuoegsvghnseifihhjvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevhfethfffveffhefgiedvkeevjeeiieetudejledukeeufeeifeehtdeifffggfenucfkpheptddrtddrtddrtddpkedtrdduuddvrddvvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieeltddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegsvghnseifihhjvghnrdhnvghtpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 17:18:05 -0000


On 18-01-2021 18:07, Ben wrote:
> 
> Have I missed something else?
> 
Alright, I now see unlink uses isproc_dev and rmdir uses isdev_dev.

Is this correct?
Why are files and directories handled differently?

Anyway, I will add isdev_dev to the new unlink_nt

Ben...
