Return-Path: <ben@wijen.net>
Received: from 15.mo6.mail-out.ovh.net (15.mo6.mail-out.ovh.net
 [188.165.39.161])
 by sourceware.org (Postfix) with ESMTPS id 1C9673858025
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:11:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 1C9673858025
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=wijen.net
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=ben@wijen.net
Received: from player715.ha.ovh.net (unknown [10.108.20.107])
 by mo6.mail-out.ovh.net (Postfix) with ESMTP id C27C623774D
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 13:11:48 +0100 (CET)
Received: from wijen.net (80-112-22-40.cable.dynamic.v4.ziggo.nl
 [80.112.22.40]) (Authenticated sender: ben@wijen.net)
 by player715.ha.ovh.net (Postfix) with ESMTPSA id B553019F44BB2
 for <cygwin-patches@cygwin.com>; Mon, 18 Jan 2021 12:11:47 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003dd1dc0d6-9383-4f3a-ae44-72e322c88bd6,
 1E059570D1A9E336F11081F47AF01A3014A153AE) smtp.auth=ben@wijen.net
X-OVh-ClientIp: 80.112.22.40
Subject: Re: [PATCH 01/11] syscalls.cc: unlink_nt: Try
 FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE first
To: Corinna Vinschen via Cygwin-patches <cygwin-patches@cygwin.com>
References: <20210115134534.13290-1-ben@wijen.net>
 <20210115134534.13290-2-ben@wijen.net>
 <20210118104534.GR59030@calimero.vinschen.de>
From: Ben <ben@wijen.net>
Message-ID: <c96cefe7-3148-5d6b-5839-08f7dd85dc30@wijen.net>
Date: Mon, 18 Jan 2021 13:11:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210118104534.GR59030@calimero.vinschen.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 8863928494775879428
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduledrtdekgdefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpeeuvghnuceosggvnhesfihijhgvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepvefhgefghfdvueekgeejteevgffgtdeljeelhfffvdejffeigeeuveefueetteeunecukfhppedtrddtrddtrddtpdektddrudduvddrvddvrdegtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepsggvnhesfihijhgvnhdrnhgvthdprhgtphhtthhopegthihgfihinhdqphgrthgthhgvshestgihghifihhnrdgtohhm
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00, KAM_DMARC_STATUS,
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
X-List-Received-Date: Mon, 18 Jan 2021 12:11:54 -0000



On 18-01-2021 11:45, Corinna Vinschen via Cygwin-patches wrote:
> Rather than calling NtSetInformationFile here again, we should rather
> just skip the transaction stuff on 1809 and later.  I'd suggest adding
> another wincap flag like, say, "has_posix_ro_override", being true
> for 1809 and later.  Then we can skip the transaction handling if
> wincap.has_posix_ro_override () and just add the
> FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE flag to fdie.Flags, if
> it's available.

Hmmm, I'm not sure if I follow you: This extra NtSetInformationFile is not
related to the transaction stuff?

Also I have seen NtSetInformationFile fail with STATUS_INVALID_PARAMETER.
So a retry without FILE_DISPOSITION_IGNORE_READONLY_ATTRIBUTE is valid here.

I have thought about adding wincap.has_posix_unlink_semantics_with_ignore_readonly
but it is equal to wincap.has_posix_rename_semantics so I didn't bother adding it.

Ben...

