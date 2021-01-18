Return-Path: <ben@wijen.net>
Received: from 14.mo3.mail-out.ovh.net (14.mo3.mail-out.ovh.net
 [188.165.43.98])
 by sourceware.org (Postfix) with ESMTPS id 727573864877
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 17:07:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 727573864877
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player797.ha.ovh.net (unknown [10.108.57.50])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 094512729D6
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 18:07:39 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player797.ha.ovh.net (Postfix) with ESMTPSA id 1E3621616E622
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 17:07:38 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-106R006af27460f-96a5-47ed-b620-cabd13eb2492,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 11/11] dir.cc: Try unlink_nt first
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-12-ben@wijen.net>
 <20210118121343.GZ59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <1e7f1329-37bc-0e83-ed03-9d7f006acdde@wijen.net>
Date: Mon, 18 Jan 2021 18:07:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118121343.GZ59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 13860672278757132036
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdelkecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvefhgefghfdvueekgeejteevgffgtdeljeelhfffvdejffeigeeuveefueetteeunecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejleejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 17:07:43 -0000



On 18-01-2021 13:13, Corinna Vinschen via Cygwin-patches wrote:
> 
> Your code is skipping the safety checks and the has_dot_last_component()
> check.  The latter implements a check required by POSIX.  Skipping
> it introduces an incompatibility, see man 2 rmdir.
> 

Yes, I missed has_dot_last_component completely.

As for the other checks:
dir.cc: 404: fh->error ():
* Done in unlink_nt
dir.cc: 409: fh->exists ():
* Done in _unlink_nt through NtOpenFile, which will return either
  STATUS_OBJECT_NAME_NOT_FOUND or STATUS_OBJECT_PATH_NOT_FOUND,
  both of which resolve to ENOENT
dir.cc: 413: isdev_dev (fh->dev ()):
* Done in unlink_nt
fhandler_siak_file.cc: 1842:  if (!pc.isdir ())
* Done in _unlink_nt through NtOpenFile with flags FILE_DIRECTORY_FILE
  and FILE_NON_DIRECTORY_FILE which will return STATUS_NOT_A_DIRECTORY
  and STATUS_FILE_IS_A_DIRECTORY respectively.

Have I missed something else?

Also, I think it's better to have isdev_dev (fh->dev ()) return EROFS,
which is the same as unlink.
