Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 54B77385802D
 for <cygwin-patches@cygwin.com>; Fri, 30 Apr 2021 19:06:12 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 54B77385802D
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mrfgi-1lFbi2323A-00nhVE for <cygwin-patches@cygwin.com>; Fri, 30 Apr 2021
 21:06:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 1831CA80571; Fri, 30 Apr 2021 21:06:10 +0200 (CEST)
Date: Fri, 30 Apr 2021 21:06:10 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] format_proc_swaps: ensure space between fields for clarity
Message-ID: <YIxVIjqTpV+5Sf7T@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210430131921.36002-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210430131921.36002-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:cwgyd7zyZLDAxZNiOKq8J2WnpHjZ76EFzdpokU09vCcvVk8a5OK
 bJgA4KV9WZV6c1hukYvRhWem+QflIQvqrOL0ibVNIKEK28phPoKQr9tUgmBCWMkBt6ngySA
 F3JXv2YEGKBQDLr9VkM1RboaPDyk0zukQKSCvkundFf+kWXUl+UbPnHL71hP3CxKIP3AqZI
 nzwV7xZC9VDjGlaK+PRuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Z4CnwotI0W4=:uhloen4tUS/LuF3exQ+Ww2
 Eq4DIhHMueq/KipY6gowopRwbrNq+0IW1YE2FbGF9KwyZolHtnCxnfROwx5IRT5KxiMYII3z9
 AMy16bIiTKhgKjUcuBenzZMIyKqcOCLBPs4V2nu32Xox3uYPErdIgEUsr+pYULnENP7HPMtT7
 SDM3flvEigNqtNbrCaoiLWihr4mmBz9x6jgT2Oo75s0PYZcvkh69Beby+GvfQQJK6WA1lrlRm
 bbfkjt4EQmMdXsLHTvzPqENtiY/xTWPN4C/eKQrAdUZz9Q3Ilzxoamb11PUYTv6ezWyJdZ08z
 mhfGgJuXVdZsfiR7mk74hi+hfxXcSQk4bFnu/0gCvhpA44CBhXGoFw2cdydI8M72KQUyytryT
 Xyk+oWPb0cv9yLCrmtYm5kGXq8fbRs3cT/NJjRM7DBY0HiQqSirVU7v2TeipUIiK0hTXg4LHK
 L8MXrunWOwx6BSL3Bvp01hqbVhW5sGoHSpMOL66sJFrlDojW0oOJW/uEURqewPOsXENyblzwh
 2PDiiqsn3ec9CzWo2Vep1w=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Fri, 30 Apr 2021 19:06:13 -0000

On Apr 30 07:19, Brian Inglis wrote:
> page/swap space name >= 40 or size/used >= 8 leaves no space between fields;
> ensure a space after name and add extra tabs after size and used fields;
> output appears like Linux 5.8 after changes to mm/swapfile(swap_show);
> 
> proc-swaps-space-before.log:
> ==> /proc/swaps <==
> Filename				Type		Size	Used	Priority
> /mnt/c/pagefile.sys                     file            11567748292920  0
> /mnt/d/pagefile.sys                     file            12582912205960  0
> 
> proc-swaps-space-after.log:
> ==> /proc/swaps <==
> Filename				Type		Size		Used		Priority
> /mnt/c/pagefile.sys			file		11567748	241024		0
> /mnt/d/pagefile.sys			file		12582912	182928		0
> ---
>  winsup/cygwin/fhandler_proc.cc | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)

Pushed.


Thanks,
Corinna
