Return-Path: <ben@wijen.net>
Received: from 4.mo173.mail-out.ovh.net (4.mo173.mail-out.ovh.net
 [46.105.34.219])
 by sourceware.org (Postfix) with ESMTPS id 1A33B3857C4C
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:58:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1A33B3857C4C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player168.ha.ovh.net (unknown [10.108.57.188])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id A706515E7CE
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 15:58:49 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player168.ha.ovh.net (Postfix) with ESMTPSA id A03881A1D82DF
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:58:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R002d4fc54ee-e2be-4f7b-b2c1-73f45a52f4f4,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 02/11] syscalls.cc: Deduplicate _remove_r
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-3-ben@wijen.net>
 <20210118105603.GS59030@calimero.vinschen.de>
 <6de2f124-c5dd-34cb-1914-4eb0454b41d8@wijen.net>
 <20210118130420.GE59030@calimero.vinschen.de>
 <fed934ea-5942-a80f-bd81-a1a6b03acb24@wijen.net>
 <20210118144927.GH59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <0607e924-ed9d-3cdc-c34e-4113f5c66d3a@wijen.net>
Date: Mon, 18 Jan 2021 15:58:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118144927.GH59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11684870708920403716
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdejvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvefhgefghfdvueekgeejteevgffgtdeljeelhfffvdejffeigeeuveefueetteeunecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhduieekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL,
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
X-List-Received-Date: Mon, 18 Jan 2021 14:58:52 -0000



On 18-01-2021 15:49, Corinna Vinschen via Cygwin-patches wrote:
> 
> Care to send the resulting patch?
> 

Will send with next patch-set.

Ben...
