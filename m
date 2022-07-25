Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 509743858C33
 for <cygwin-patches@cygwin.com>; Mon, 25 Jul 2022 07:18:15 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 509743858C33
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M6EOc-1o9ImE0UAq-006g2o for <cygwin-patches@cygwin.com>; Mon, 25 Jul 2022
 09:18:14 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AE794A80884; Mon, 25 Jul 2022 09:18:13 +0200 (CEST)
Date: Mon, 25 Jul 2022 09:18:13 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Update FAQs which are out of date on the details of
 setup UI
Message-ID: <Yt5DtU/JDZrJ+HRG@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20220707114428.65374-1-jon.turney@dronecode.org.uk>
 <YsvVC4qwC9Lao/Ho@calimero.vinschen.de>
 <91d1d17c-27d2-a271-a9b6-bcd3811084ca@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <91d1d17c-27d2-a271-a9b6-bcd3811084ca@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:uiCAjUPCAYCOjoOezRJFJzoWPahBpeVBkc3pylFHmSsn6eipG7m
 XpUVXV/mAL/R/IN0aQwWKTfEc0xI0Ei+8xj3+vBpv9U9aIPeyd+2Vl/eSSYomBYzsp21zXV
 bWfUsiEA0VZj3N4WCV29h9XAFnNkzH//p2RhbNriZwtxs+weHek4R8/Plg5ryoWjkWK6uO9
 4L52saTAGH7ozyFcIJmLw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g0i/6YrKeOI=:gN/J1QFN8GUQ/9vanilSOj
 Tocf922vUm+x57Z/zJPtUh7VkBOpgDOdgBGaIrGh0jD00HTasp13UpdzgTMlO4oYjihWAaM4F
 8pRGZr2IyYNLpR08E5iNWvIk0SiYdcRrn82uMPszaE/hkFUHgEavNylJH8hUDVaHoZYSKxH11
 eBkMV1oq/IXDguAnROOTB7Lx8JLtK2f2sams9errByMLV9obaiN2+rrbq6jl5iEPXDrNVPHQw
 LTs7vx5ljCRjW0brbgymZmbGiPdZ429FPZdOua70aY9rcGDFadJe7fLksbN46VfB7RVvYA4C2
 ShFf9WYoMVUQYxgcnOjusA3p0IbmMA3PLcNW2v02WQ42Av1v3QcTMAlQz8R8H/U6Dsv9OgHyj
 G7oKX+A480IbTnpED8aUYaZuo/Gg+qaEws6p133eiGbFO8wmtfBxV99mgjtLRbMlWPPCgm0cW
 zN7W9LpHlXv4vO0fBiowefYsw2iSfUWaa48awIKkmiUoY+BU7MoYQAJ7pS5MfBlrvEP3Edane
 ZdKxxC5b+ZVXdFcr/ja25fcNzyu3IN8OjNMl++GVn4Lyv/eowrcwLAJH0XI0Tls2dYdKtyS4p
 XHcK+D+aXEBAkHebSitSrqzhGCuWnBIclZNgJG18nROVS20AwX31R1zJby6uc7Dh+2EcV5hXV
 AizkrWo3HHcD+GNqDoU/YrvH2tmCIijj0tBrVfFzhUS6350VvMiUcI0X3jnxN9gKDFqKEGZ5D
 ST1f2hv56bWDx4tj2kgbU1sHmLcajH2GSIyCblCFsScrAEuLcW5jjg3J0so=
X-Spam-Status: No, score=-101.6 required=5.0 tests=BAYES_00, GIT_PATCH_0,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, KAM_SHORT,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_FAIL, SPF_HELO_NONE,
 TXREP autolearn=ham autolearn_force=no version=3.4.6
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
X-List-Received-Date: Mon, 25 Jul 2022 07:18:16 -0000

On Jul 23 14:46, Brian Inglis wrote:
> On 2022-07-11 01:45, Corinna Vinschen wrote:
> > On Jul  7 12:44, Jon Turney wrote:
> > > ---
> > >   winsup/doc/faq-setup.xml | 11 ++++++-----
> > >   winsup/doc/faq-using.xml | 14 +++++++-------
> > >   2 files changed, 13 insertions(+), 12 deletions(-)
> > LGTM
> 
> [original did not make it to me; caught up on archive and noticed]
> 
> URL duplicates .html:
> 
> 	<ulink url="https://cygwin.com/package-server.html.html">
> 
> should perhaps also have the self-closing tag delimiter "/>":
> 
> 	<ulink url="https://cygwin.com/package-server.html" />
> 
> where the extra space ensures it is also valid XHTML/XML so it can be
> checked or processed with better tools that can catch issues ;^>
> 
> [attachment extract]
> 
> diff --git a/winsup/doc/faq-setup.xml b/winsup/doc/faq-setup.xml
> index ce1069616..da9fce534 100644
> --- a/winsup/doc/faq-setup.xml
> +++ b/winsup/doc/faq-setup.xml
> ...
> @@ -688,7 +689,7 @@ files, reinstall the "<literal>cygwin</literal>" package
> using the Cygwin Setup
>  this purpose.  See <ulink url="http://rsync.samba.org/"/>,
>  <ulink url="http://www.gnu.org/software/wget/"/> for utilities that can do
> this for you.
>  For more information on setting up a custom Cygwin package server, see
> -the <ulink url="https://sourceware.org/cygwin-apps/setup.html">Cygwin Setup
> program page</ulink>.
> +the <ulink url="https://cygwin.com/package-server.html.html">Cygwin Package
> Server page</ulink>.
> 
>  </para>
>  </answer></qandaentry>
> ...

Sure, please create a patch.


Thanks,
Corinna
