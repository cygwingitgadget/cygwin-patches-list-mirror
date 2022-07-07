Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id 882E73858D32
 for <cygwin-patches@cygwin.com>; Thu,  7 Jul 2022 11:11:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 882E73858D32
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N32y5-1nSfb62lDR-013Myf for <cygwin-patches@cygwin.com>; Thu, 07 Jul 2022
 13:11:25 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id CCD4BA807DB; Thu,  7 Jul 2022 13:11:24 +0200 (CEST)
Date: Thu, 7 Jul 2022 13:11:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH htdocs] Align setup help text in FAQ with setup 2.919
Message-ID: <Ysa/XNxVSr0mo4o/@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <0d7b7998-60c3-a21a-71d5-2860bb198997@t-online.de>
 <YsazayJMXQfKlt5v@calimero.vinschen.de>
 <0b6132ea-4244-2ca3-c98c-8e8001e24935@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0b6132ea-4244-2ca3-c98c-8e8001e24935@t-online.de>
X-Provags-ID: V03:K1:q94kwkvjy28pPT479mE7om3ESy2Gea9Q6wdhM6lJlsOmq28wD7q
 QsVC5KcTmH4man07u2dPPPc2rvozBfEAA9qwLNF83TI8joIcTx9gY5J46qELrLoN12Wqmhe
 65d+dQeueugNNzFARuAKOn9y9eYtkpH862BJY0TB0g8HWUaDhbubVvB5k4gR3NtBmXLj4gh
 JNFIWn5zAkrME+cM3DmPQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YRPpuq5xk9U=:IeukiMA0hbaHhiZsK2nTXR
 XBncVdC2haI6jL1x+lgdRVbQ0kmZsOR8aoc4LDJ6T7fDikafaSi70vxCRt+zXcZ3fUAO5C5gn
 ZQp7htchhfK7Wkw9P5QkfhOno0GOhdx2LamQU1pwVuKkYNECy0QA/LWPzH8yhfSoWFhsRMZwY
 cXixqyRarHfX/xQlYbFvH1eh8ES31nZmZx5GxncnFNs1ySApW7njtbQP3IYduq6ZuhEEgBMWk
 Qi8q6g3dCLIRj4krI5dLaq/ktyQL/0Tq4p0/XgBSGiSo02nSgpQuRSXCb0zkr4P/jDGJptO6S
 fIwxGm+h3xp123gJniYiQaeuIYWGqDBHXI9Phzkl9V8FSttA+XjjPGYoNlkQyBJhf6LDBgdAS
 ZyAF/vRImZMJEZ0dEKEMFfvsoEpy2y/WKIsq3UkXOuYO6PU1kzmQgfwllyuTkxFNOj1E1xr3P
 fFefJD4sYduoq6XRWFeCcPkPf8dg/scm3a+cW6lu5VNWNQB+RcFEF+yNn09AgNdN3+r9shLsA
 HcJMwEEpqTbjQkqVFgudOXBFqnp1tXfW+Z+zUTNYchaVYqqmoVJoYe0Y50nzdTvbWWox0gZbC
 mRspfwmzjkPr+zaKkF/Np9i56IpXrEi/DXOQgEOrHO7xR+0mdoUtrQ/TOWM7R7EWtp2Grh3vV
 hJgSafk8zYEy3GTiszGFsmwTwlnFCJb7gCOrX/VT7qeZauBOSZJimP19kfVZai09qZ0s6ZVFN
 TDY9IdVBDUOFqN1OMIbJF8qhfyKaGoXUsDkFbkanpS/2wSQ9b/PcVWxddio=
X-Spam-Status: No, score=-94.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
 RCVD_IN_DNSWL_NONE, SPF_FAIL, SPF_HELO_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 07 Jul 2022 11:11:29 -0000

On Jul  7 12:50, Christian Franke wrote:
> Corinna Vinschen wrote:
> > On Jul  7 12:08, Christian Franke wrote:
> > > Not sure whether cygwin-patches is the correct list for this patch,
> > > cygwin-htdocs is not mentioned in lists.html.
> > The FAQ is part of the Cygwin source, just clone the repo and create the
> > patch against winsup/doc/faq*.xml.
> 
> Of course, sorry for the noise. New patch attached.

Pushed.


Thanks,
Corinna
