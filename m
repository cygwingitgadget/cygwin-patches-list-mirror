Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 318AA3857031
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 13:48:38 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 318AA3857031
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MnagF-1kcFiT3Zwb-00jYdK for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020
 15:48:36 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 6C290A80D0B; Mon, 13 Jul 2020 15:48:36 +0200 (CEST)
Date: Mon, 13 Jul 2020 15:48:36 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v3] Clarify FAQ 1.5 What version of Cygwin is this, anyway?
Message-ID: <20200713134836.GM514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200710173450.46857-1-Brian.Inglis@SystematicSW.ab.ca>
 <20200713070433.GH514059@calimero.vinschen.de>
 <ba6d154a-679f-a121-f151-dd84d29ba116@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ba6d154a-679f-a121-f151-dd84d29ba116@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:3N3EhTSNYtinXX2bhY2EvGYPOucd4FJpvSX+7z7XSIpEMa9GoZT
 YjkcqGDnh922Y2R+iC4i/o8TE2VsmfgONG4Qev1TWJEVyomlwMt+O8MyC3zOSIySTWP8xLq
 U5CnFa/bYs6O0Ext/9dHQaH0Naxqh5TMVKE6LK1ZXHa4h6WWh3SSTNYb8tSyRLEW8DTFkUN
 F0J7kqGURbQMSKky9W18w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TeN4e9j9hnY=:s5GzKn1PQ0eHV1b9g9YeGs
 VbMgmG0nrif5Jam75Gr94C6U30/mQAujUlDBc0tyV6jgbAP9QfglxHQOUJqB/uR8mPeEfy/1M
 sRLvGqJF8RRR8uowwXPOwMHgkK1IGev7fXl2xwso96sQ3wOjF3hjcfC5QrxGWlDlfazN3q8Wi
 huRErAifxqG055/bBmKeST6OjMw+dErngEc3JKz+/K4Yt67P1dZ71zLL/baW5QwbJw9at0H+z
 709piJ0iUaIuDZ0ZPiAvIAaGPxi0Z4lBtWKQumla4cdmZRVVQ44VVTfzJYBXnwQm5lZLrfOQs
 1lv1IjXNt/lOe9YxpLVL3SsWhMapKgK8kz5YDowCoXomGddzNfTIuBanNgfp450PN1DU5fXdM
 yAQsWbJlcJkQ9qd6ZgAIefn6AQR3miEGvzE9f1FdZ04F/wX6/ZFM8xRHDWRd3q00EdQQcgpzW
 r1NZfvHmp4FdkI2dvzRIlBa2hgJxUfOT97hnr/QuKoN1K7LxyxUKfIf4eOqWnTlgcGTeRPOB+
 yJZYKtPVKCYU5VDFpovg9JVec0uuBTbrl/jjfTb3XzUCc1oIdaMnqqL/5ADVFnBahGEEMQSU2
 ZmfBrivDAsJjuMxOcf+T+pnXREr/3yeZSCMXfMhbnOGVgpTXJQ8hcqqH7PCUGVbvqNY0SGJds
 tEcKEKTUeKYFZvs/GByRT8n8TgX5YBS0/Mxfnq3gLja9QFjlI9hy7UjDXgWtMBFx3e2vd6LM5
 pPPQwdbKsPMJS5rAOl2A2yUL0xpmpUzkOiMIFb/imsidVV/+cXhvLYDs7Qq9kwuYmyYcZ6e91
 udtnGbp5S4nQcHU0+Ymx+yaeSQnrId/35J6Dtxhqak+5PonXd0Cjk38GgSQDVEqTWWenUHYF4
 FnmlCRGlZEceBs/6EjEQ==
X-Spam-Status: No, score=-103.7 required=5.0 tests=BAYES_00, GIT_PATCH_0,
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
X-List-Received-Date: Mon, 13 Jul 2020 13:48:39 -0000

On Jul 13 06:06, Brian Inglis wrote:
> On 2020-07-13 01:04, Corinna Vinschen wrote:
> > On Jul 10 11:34, Brian Inglis wrote:
> >> Patch to:
> >> 	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html;hb=HEAD
> >> as a result of thread:
> >> 	https://cygwin.com/pipermail/cygwin/2020-July/245442.html
> >> and comments:
> >> 	https://cygwin.com/pipermail/cygwin-patches/2020q3/010331.html
> >>
> >> Relate Cygwin DLL to Unix kernel,
> >> add required options to command examples,
> >> differentiate Unix and Cygwin commands;
> >> mention that the cygwin package contains the DLL.
> >> ---
> >>  faq/faq.html | 49 +++++++++++++++++++++++++++++++++----------------
> >>  1 file changed, 33 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/faq/faq.html b/faq/faq.html
> >> index 1f2686c6..8659db5d 100644
> >> --- a/faq/faq.html
> >> +++ b/faq/faq.html
> > 
> > Huh?  This file doesn't exist in the repo.  The path is not relative to
> > the repo root, and the file is called faq-what.xml.  Can you please
> > check this again?
> 
> See top. So does:
> 
> 	https://cygwin.com/git/?p=cygwin-htdocs.git;f=faq/faq.html
> 
> get generated from:
> 
> https://cygwin.com/git/?p=newlib-cygwin.git;a=blob;f=winsup/doc/faq-what.xml
> 
> which is where I should be making FAQ patches?

Exactly.  cygwin-htdocs is just an upload area for the cygwin website.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
