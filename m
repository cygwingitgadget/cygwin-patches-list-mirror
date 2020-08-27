Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id E50A9386F419
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 08:54:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E50A9386F419
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mgefy-1kq2bv0tJc-00h9lA for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020
 10:54:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CFE11A83A77; Thu, 27 Aug 2020 10:54:34 +0200 (CEST)
Date: Thu, 27 Aug 2020 10:54:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3 3/3] winsup/doc/faq-api.xml(faq.api.timezone): explain
 time zone updates
Message-ID: <20200827085434.GY3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200827071709.18558-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827071709.18558-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:huz4x83pdbmwybCZwwq071AOgB3NLO6JzgHeHRn5ZsGxRZe7qJk
 td2aHkaOkFT7+CA3MO+1ys/WzAgKi3QUfNZFMx+6iY44HSbQAz+vVsjFWOGQHV34w1wW+4R
 ACUVMkdw1NhtJyGIfSz8aoJr1jp1Mnl0YwgixdviCdVJ5bJ9aSIW3j+CjZYjCnD6ZyAekii
 T+SoKKbQ1XVl7wY8tMKrg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+tOj481qOjU=:jlJ0Ubj79VnUpAxkJ9L/BO
 GZW2Mp97gEDfeE7QZA19OtcWXWiUDAWKMPSEMKrlWkXCOCY8b7P81vUudD0+OxPwMPFK2ltDy
 RefiOzXX5oGkWVSHUOoRvV23BPrlPGyt5ZnPdvOxwCRwTBTaL2X9ohYpdacKDA5CRqjF5jfv8
 eCFy7MmXEvDDCVOapcBT46kcKxoepTlqx0tTShKwMwl2DNpGRgdn5EhZqCITGzkWWCaXEWwu6
 K3dMlpr9EcjoslL3UeDh6RtI7fTXkof9jDwXbrGdZuHXY/yqJfZlsNUDUiRiPRgobicMMuoZp
 i8MFTqVQAxc7nFtb6HUljGlCSRMt+igUkJZCHyecSRQk7pdPfhoYhNzkt3QJRADjSNMf65QM/
 lYWQis3rngA+x8rdDQ7EhzWP0vh59zlrLz3JVLrLwoN2e8kJZQo82TRyPpUMtRNzsSjgtady1
 VHZH6Hjd8W8aLpbulT8LhyTrQrJFtB0aktLf6TGaIYZ/kp1DYwePRtfpTyJ5SVXrFFXZNCZ5K
 05IO/QeVSgbW/x/xwtJCRl74iPhfyL2IxxPg8ngehNXAUExwuL6eitZqIUccOXIa0xwE4adC4
 Q9NcbPUYpK4fVj5IMz+1Ip7lgupD7lu3bmgFsWTMnsuamN4lpUfb9/RnfwzMJLZJPq8EXISVu
 FNGUrJg7PWuXAnfHpc5DwVm//tyk2EhG5kpjS8Ms931tg0rfe/og5jzjEO1cM0JXUZK5AlPet
 r5g6rIk40NhIfYurhn8Hmy+MckLgqsUMkXNhAAWI+DIC0VUnWf9Y+ZgVcHONA8yWnZhUs/ge/
 Cp4bST87R404Xn5qTL4qdlwKNQU4ap6b/6cwIJ6oE79SXsRncVmEvpXY0CpfeVcQQLJFnmah8
 7O2yFFqrFvnKWKB88kNA==
X-Spam-Status: No, score=-99.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Thu, 27 Aug 2020 08:54:39 -0000

On Aug 27 01:17, Brian Inglis wrote:
> based on material from tz@IANA.org mailing list sources
> ---
>  winsup/doc/faq-api.xml | 40 +++++++++++++++++++++++++++++++++++-----
>  1 file changed, 35 insertions(+), 5 deletions(-)

Pushed.


Thanks,
Corinna
