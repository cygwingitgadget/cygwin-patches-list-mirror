Return-Path: <ben@wijen.net>
Received: from 2.mo173.mail-out.ovh.net (2.mo173.mail-out.ovh.net
 [178.33.251.49])
 by sourceware.org (Postfix) with ESMTPS id 99B023864877
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 17:15:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 99B023864877
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player688.ha.ovh.net (unknown [10.108.4.8])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 7ADCA15E614
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 18:15:08 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player688.ha.ovh.net (Postfix) with ESMTPSA id 30D111A10C55D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 17:15:08 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-105G006f6e97b06-26a4-4105-b3e0-d913649e6b1d,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 08/11] path.cc: Allow to skip filesystem checks
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-9-ben@wijen.net>
 <20210118113630.GX59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <a1fb688c-a327-940a-ec99-651760ce02eb@wijen.net>
Date: Mon, 18 Jan 2021 18:15:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118113630.GX59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13987054543758771972
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgddutddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepuegvnhcuoegsvghnseifihhjvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevhfeggffhvdeukeegjeetvefggfdtleejlefhffdvjeffieegueevfeeuteetueenucfkpheptddrtddrtddrtddpkedtrdduuddvrddvvddrgedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieekkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpegsvghnseifihhjvghnrdhnvghtpdhrtghpthhtoheptgihghifihhnqdhprghttghhvghssegthihgfihinhdrtghomh
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 17:15:11 -0000



On 18-01-2021 12:36, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 15 14:45, Ben Wijen wrote:
> 
> Without any code setting the flag, this doesn't seem to make any
> sense.  At least the commit message should reflect on the reasons
> for this change.
> 
Something like this:
    path.cc: Allow to skip filesystem checks
    
    When file attributes are of no concern, there is no point to query them.
    This can greatly speedup code which doesn't need it.
    
    For example, this can be used to try a path without filesystem checks first
    and try again with filesystem checks


If you want, I can also squash some of these related commits.

Ben...
