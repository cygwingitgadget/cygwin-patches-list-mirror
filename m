Return-Path: <ben@wijen.net>
Received: from 3.mo3.mail-out.ovh.net (3.mo3.mail-out.ovh.net [46.105.44.175])
 by sourceware.org (Postfix) with ESMTPS id 40A3D3846012
 for <cygwin-patches@cygwin.com>; Wed,  3 Feb 2021 11:38:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 40A3D3846012
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player737.ha.ovh.net (unknown [10.110.103.200])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id D7798279908
 for <cygwin-patches@cygwin.com>; Wed,  3 Feb 2021 12:38:35 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id 942201138092C
 for <cygwin-patches@cygwin.com>; Wed,  3 Feb 2021 11:38:34 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G00516017f43-7b64-4e90-8244-9d478fdc02fc,
 34B4DD6D8321AE596D2C59DB52D829039CC1F096) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 09/11] mount.cc: Implement poor-man's cache
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-10-ben@wijen.net>
 <20210118115103.GY59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <36453e31-040d-7918-f19a-2f379b988194@wijen.net>
Date: Wed, 3 Feb 2021 12:38:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210118115103.GY59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 10032612596193314564
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrgedvgdeftdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvefhgefghfdvueekgeejteevgffgtdeljeelhfffvdejffeigeeuveefueetteeunecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Wed, 03 Feb 2021 11:38:39 -0000



On 18-01-2021 12:51, Corinna Vinschen via Cygwin-patches wrote:
> Ok, so hash_prefix reduces the path to a drive letter or the UNC path
> prefix and hashes it.  However, what about partitions mounted to a
> subdir of, say, drive C?  In that case the hashing goes awry, because
> you're comparing with the hash of drive C while the path is actually
> pointing to another partition.
> 
How can I mount a partition as a subdir of drive C?
For some reason I can't:
$ mount /cygdrive/e/Temp/dummy /cygdrive/c/Temp/dummy/dummyone
mount: /cygdrive/c/Temp/dummy/dummyone: Invalid argument
