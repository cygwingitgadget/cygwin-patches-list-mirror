Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id A8724398C808
 for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021 17:09:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org A8724398C808
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MAP77-1l1Imy1pE3-00BwxZ for <cygwin-patches@cygwin.com>; Fri, 19 Feb 2021
 18:09:27 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 15917A8095D; Fri, 19 Feb 2021 18:09:27 +0100 (CET)
Date: Fri, 19 Feb 2021 18:09:27 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Cygwin: pty, console: Make FLUSHO and Ctrl-O work.
Message-ID: <YC/wxyBubEXfi6tJ@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219084402.1072-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:9XSqkQHiyNfAHHkbtBKf0eYz7e4c50yP8Kpw3OcuJ9Q8YIyAhht
 GRTIqPW4i5xdWargpTSjxNQzbZUYUMECrtk4rI9TH2LczvdZNDtBVlp5NLJY3y4jC3ktAV0
 g9HGdhMhByu9skIupu4kW45ACOCKvaABcx+qf6dUrkxgGJJzSdO37Vw+febwsEdpT7bX6QB
 i7PxALtn3p1C0Ue4CTUaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mTbeSLNTRMY=:XX3aNh0GtM7ksoMaoMfFzW
 opgmRU5DkhIgLN3VPF5T4D6kikhNI+gHSrvieo1FrI8yY1zYpydxFJjoMmbOPkmrfGbePqqbF
 DhLmgJhkT/yPbj9pvvvDizFALQQhVD/V+6HTFXItKNKOTFN1EQ02+RbOkv8KQjIHSgAyK1ohh
 PfQJMJ328OpRwTsax77HQ9lnIuOfzzHjQHrVYYQ+LLK/LzVixRE4OIRf5wbtDMLL6uANivfJg
 etgQjLUNdZhjn7tZtut+vmw2QUcnjTqoKdENiIb4PDUGlmVVf9BsKnGQYT6szRE/PbQXjlBzG
 jtQnk26YxBHR7p+2dqmWAnr31sQlAhcG1s+Y0hJ2QpNtI0nfavZ20qfTKLu0g8xReY6K8EGSN
 3ojHFaD584gAbRl9zC+VgOU9hwO3uDVyc7UC/IGyLsvMnjXdEMlTlIcrO6C1BzohL3ywX3Xzu
 /r3tH0GmgQ==
X-Spam-Status: No, score=-101.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 19 Feb 2021 17:09:30 -0000

On Feb 19 17:44, Takashi Yano via Cygwin-patches wrote:
> - With these patches, FLUSHO and Ctrl-O (VDISCARD) get working.
> 
> Takashi Yano (2):
>   Cygwin: pty: Make FLUSHO and Ctrl-O work.
>   Cygwin: console: Add support for FLUSHO and Ctrl-O.
> 
>  winsup/cygwin/fhandler.h          |  1 +
>  winsup/cygwin/fhandler_console.cc | 11 +++++++++++
>  winsup/cygwin/fhandler_tty.cc     | 17 +++++++++++------
>  winsup/cygwin/select.cc           |  5 +++++
>  winsup/cygwin/tty.cc              |  1 +
>  winsup/cygwin/tty.h               |  1 +
>  6 files changed, 30 insertions(+), 6 deletions(-)
> 
> -- 
> 2.30.0

Pushed.


Thanks,
Corinna
