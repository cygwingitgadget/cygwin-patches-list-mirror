Return-Path: <ben@wijen.net>
Received: from 8.mo68.mail-out.ovh.net (8.mo68.mail-out.ovh.net
 [46.105.74.219])
 by sourceware.org (Postfix) with ESMTPS id 0B75E3846013
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:31:46 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0B75E3846013
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player788.ha.ovh.net (unknown [10.109.146.76])
 by mo68.mail-out.ovh.net (Postfix) with ESMTP id 8F270182F17
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 15:31:44 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player788.ha.ovh.net (Postfix) with ESMTPSA id C912E1A271C27
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 14:31:42 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R00263ed059c-505a-46dd-9e0d-baa0308dfaa4,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 05/11] Cygwin: Move post-dir unlink check
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-6-ben@wijen.net>
 <20210118110848.GV59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <16b76b93-400e-34b3-0822-6fe67decfd4b@wijen.net>
Date: Mon, 18 Jan 2021 15:31:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118110848.GV59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11227192397617448708
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdeiiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvefhgefghfdvueekgeejteevgffgtdeljeelhfffvdejffeigeeuveefueetteeunecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejkeekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 14:31:47 -0000

On 18-01-2021 12:08, Corinna Vinschen via Cygwin-patches wrote:
> On Jan 15 14:45, Ben Wijen wrote:
>> Move post-dir unlink check from
>> fhandler_disk_file::rmdir to _unlink_nt
> 
> Why?  It's not much of a problem, codewise, but the commit message
> could be improved here.
> 
Something like this?
    Cygwin: Move post-dir unlink check
    
    Move post-dir unlink check from
    fhandler_disk_file::rmdir to _unlink_nt
    
    This helps in two ways:
    * Now all checks are in one place
    * Even if a directory is removed through
      _unlink_nt, but not rmdir, the return
      value can be trusted.
