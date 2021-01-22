Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id E59C6389247E
 for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021 12:36:01 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E59C6389247E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MzCMN-1lxez51tX1-00wABn for <cygwin-patches@cygwin.com>; Fri, 22 Jan 2021
 13:36:00 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 0817AA80D50; Fri, 22 Jan 2021 13:36:00 +0100 (CET)
Date: Fri, 22 Jan 2021 13:35:59 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2 3/8] Cygwin: Move post-dir unlink check
Message-ID: <20210122123559.GG810271@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210115134534.13290-1-ben@wijen.net>
 <20210120161056.77784-4-ben@wijen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210120161056.77784-4-ben@wijen.net>
X-Provags-ID: V03:K1:uVGUAXR386SSq0YHj0+9YzP0cVvDntmT3nfbXAgokZGhCbMP784
 2fPkAxEqafp2DO9Q7aedAdkXmrstWBbOWQwqaTGt4r3X96zWJ1XCT5LtcQDhykJWy+uZtpt
 +GROL2EfOkdES0T8cSAiHX3bSRZuZpIiyMqkaPOdgm9pdKlwJ2JSaPOZgX8qwyNYFzUAOb+
 KmfHYymSzvtxb3w8BbmDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NsKPpbyFZy8=:i1ZYeqUpDrp4F0G2afKpZx
 xB6EcMumYvFvFUHNYa8tc0IkaeU1+2oQIdgsGNeX7lbfLcROsIHUOhYyliTgjTS0WQaokHMz7
 VOi8MHCkHbCavR9gPD5sIka4ZiJReTKBEvH1bv8xm/9VlWkOIh+MAl+H/eJWKcIzlwVMHPLXW
 W/WAiVoRHA89o2pThLFpf0SkUyB4RrloTzXsJPDilEcIS7KU99QSUqX2ETTs34a1TGpxiXXk+
 BRfjZ8bPA1hAjQRvoagiTmk40OKcvP6aV1TR/khjW10jldOGYaa31zdoljvKoy5nUo/bkK/L6
 +ObwK1ZfCionQDe7L0PRUu916xTmcRZ6qvQ98pJX7Stfcaqc+sTanZb7NpO0oEErOrD9/uA3w
 88/JSMnaKwybwZGjV6yym+aeJCog/tngtYFEBWGKirUnIXpvDVopv9fy3Adn8mX1TxFH9RbBL
 4umB/DBKtA==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Fri, 22 Jan 2021 12:36:03 -0000

On Jan 20 17:10, Ben Wijen wrote:
> Move post-dir unlink check from fhandler_disk_file::rmdir to
> _unlink_nt_post_dir_check
> 
> If a directory is not removed through fhandler_disk_file::rmdir
> we can now make sure the post dir check is performed.
> ---
>  winsup/cygwin/fhandler_disk_file.cc | 20 --------------------
>  winsup/cygwin/syscalls.cc           | 28 ++++++++++++++++++++++++++++
>  2 files changed, 28 insertions(+), 20 deletions(-)

Pushed.


Thanks,
Corinna
