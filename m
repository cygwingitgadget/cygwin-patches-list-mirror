Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id BC3C3398B833
 for <cygwin-patches@cygwin.com>; Tue,  9 Feb 2021 15:25:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org BC3C3398B833
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N7zJl-1lvXCQ29SN-0155t3 for <cygwin-patches@cygwin.com>; Tue, 09 Feb 2021
 16:25:49 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 06204A807A5; Tue,  9 Feb 2021 16:25:49 +0100 (CET)
Date: Tue, 9 Feb 2021 16:25:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/1] Fix fstat on FIFOs, part 1
Message-ID: <20210209152549.GW4251@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210209151158.57831-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210209151158.57831-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:e6Sx0icZXZDxLZVLANaOo5FOXR7+IknrWtc4rcIkWuiWqtVGiCe
 4muCOSvBNUJjSjFDEWGKPyONtsUsOHybis+x/gg3dn/j0eEC36SRuN9NTvwFqF366XL4f+e
 WxXRUYNT8gP/OjQIXWF0kxKPpHXc9LcYctyhuuL/WtZfM7cMeGeFYe6lT5O0BUIbwJdIrDf
 Sh1uOt+VG05P9wxqAFZhw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/qAHpGTdKls=:vTwahgLTn+UsqO5FUSX42S
 zWQWyXNekZNqvP+WNf4Ah5KvngpR+eq6PLhxUYd7eEHxlyjjyYhcPiYjnpjrnT1e+famqG0YE
 qhWayC9ZZetDt36JzhUk4zReVkejLD/inp6pD6KPSH9mP3EQAI9EJUsZ6AI5GcQYrlPxnIrMe
 RuZTH6UXTNEgmvCJVTczhddbu+ci+OwS7uzIVZfbivUaY+UdbuEouu2EJLpA1KFEUCUuhi9Z+
 S6Ia+k0mxf2Mq7AWpzyV0+tBYrhOQaBFbox2eyYPFx1HDkQ9LR/WJ6ntl0Dv7DEBiXEv6pQMI
 4pJsxkTR4vyBBccGdjqF8a2TiwgS0nvY63mK8bR9keCRaYUa+GFFGB/67TXuQBenOxtJV/zxW
 31q59pb2ettssDSOguKUkAS5oXL+dNWhmkn5kKZwxu6r3t9aPYVcllJizLw0dCo6bwvshMSsw
 s0AVKsGTBA==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
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
X-List-Received-Date: Tue, 09 Feb 2021 15:25:52 -0000

On Feb  9 10:11, Ken Brown via Cygwin-patches wrote:
> Commit 76dca77f04 had a careless blunder, so this patch reverts it.
> 
> Nevertheless, fstat(2) can be made more efficient on FIFOs, and I'm
> working on a separate patchset to do this right.  It's worth doing,
> because every call to open(2) on a FIFO leads to a call chain
> 
>   device_access_denied --> fhaccess --> fstat,
> 
> and this is one of the cases where greater efficiency is possible.
> 
> Ken Brown (1):
>   Revert "Cygwin: fstat_helper: always use handle in call to
>     get_file_attribute"
> 
>  winsup/cygwin/fhandler_disk_file.cc | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Sure, go ahead.


Thanks,
Corinna
