Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id C41933857C5A
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 07:17:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C41933857C5A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mjjvp-1kbfNB1qG3-00lGmh for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020
 09:17:06 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 12FD4A80D1D; Mon, 13 Jul 2020 09:17:06 +0200 (CEST)
Date: Mon, 13 Jul 2020 09:17:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: Update FAQ 1.6 Who's behind the project?
Message-ID: <20200713071706.GJ514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200710011544.28272-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200710011544.28272-2-Brian.Inglis@SystematicSW.ab.ca>
 <20200710083530.GE514059@calimero.vinschen.de>
 <06e5b3b4-ad8a-27fa-1b40-8d30ef58655c@SystematicSw.ab.ca>
 <910b7d17-eb5b-6a94-2992-23b2df3b936b@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <910b7d17-eb5b-6a94-2992-23b2df3b936b@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:MFf9Gvd+GbAzQZaejrJ6J4gF3pGg+blSgnZXCM63W9rKxOlET/R
 7S+6kVZmaEpjVdxbUY68Lxa3zI4/iFVpTsU6KKJrPunOpWVyA3Tv4mXVHkYviH+JZnDt+WQ
 USeEwngTZ6UZDSf5S9GBrp9cnnndpVw2c9Bzzw1VGopgpw1AaR5jM3jYFpnuedrJv3H2xTN
 7L+kFKdNLpDmEGGbuUgcg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SAV1yEDN+Rc=:LWETe+eRNa/L4R+HIr90yW
 Td3/XlwKq3fR18jDEJhisdAqkTyeTL1/wvlzl8qVvJlm8skuKSMJIMS6Wce/L5MFo6Gg9CWlO
 drtj3fDcg7WouzsDD5nwLGxazRBzHmJsKKEhZZIQD2jijENLQCs42RTgDI3++JvvgpUGZWLdS
 5U3vlC/XRtN6apKruH/DQWl/u5KPIPY+Ax6NHUJQUeqmjvscg2ch3mGUGdlb3FDxBgTASyudQ
 VXe5YvKUYfpiGZJaPcxFK712fx2/jRDyBbPKdU/qiUpd4MZDgaJJzcCl9sAyoVKz1CQk6QtnN
 d+UJpkyjkjlRVPxUpLJKBpa4bR+xJRjm22CN/jPybN5OyDvc24keXjFzK/EBMVeSTYzaUnUz3
 JLZ4oZy9WXbKQbmOjN6f8k/flg82qDpy3HzX8bjy3OteC/TwE/YS6w2SbVllWP8CrQkwikzm1
 oJv6T12KrByHarGpEG9YMdLoJuFnNrL7Y6KoxuF0d+7VWH4arc/scRH7BGGwmPoFIyYA8wl+d
 ITTz4oGCD+9ZieXsqpdnRaBjpDILCsruUUHD8B3S2Q+mO/J+jaxgt25gilOJIrAw11XTxCMn/
 Dx6RrTCZ1m3sPLgV/z1OTQCRXkLfIivhYfwZORk0phezmp7HbC5D2OJJdjsArwYa/ZXOUd4nd
 Np1ny2RMg+VRz5ysfbUXUiULFYlUtTznafx9zxpQy/PDw9Bv/HZD9tkEKI1sIj2avf0RRd3Gt
 socePfXKdbTiZeGnrIMZmageD4pP8O0y/xpIkgGmMFsmHtMF1J96/kDdzrWAXd5kgwLwn/VyE
 pc5fi0+8y5hSop8/wxrQjYZ1OmKmQzJLRDlpcbMlrC4eUJD0KEzPF0/9AFtLID25zt+mXuZME
 UVj6ccngkQZ9olZLwM3w==
X-Spam-Status: No, score=-98.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 13 Jul 2020 07:17:09 -0000

Sounds good, just send patches...

On Jul 10 12:20, Brian Inglis wrote:
> Suggest also under 1.6:
> 
> 	https://cygwin.com/faq.html#faq.what.who
> 
> which seems to be from when Redhat sold Cygwin, so:
> 
> - omit Redhat from Corinna's entry, and clean up:
> 
> "Corinna Vinschen is the current project lead. Corinna is a senior Red Hat
> engineer. Corinna is responsible for the Cygwin library and maintains a couple
> of packages, for instance OpenSSH, OpenSSL, and a lot more."

..and just drop the package names here, please.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
