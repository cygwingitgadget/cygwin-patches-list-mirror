Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.133])
 by sourceware.org (Postfix) with ESMTPS id B0FC93939C38
 for <cygwin-patches@cygwin.com>; Mon,  3 May 2021 10:40:27 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B0FC93939C38
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N6bsM-1lV5Wu1Uli-0186vQ for <cygwin-patches@cygwin.com>; Mon, 03 May 2021
 12:40:26 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 00CE9A80D64; Mon,  3 May 2021 12:40:24 +0200 (CEST)
Date: Mon, 3 May 2021 12:40:24 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v5)
Message-ID: <YI/TGPry90KWULi1@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <d4964f52-518e-205b-c44f-02bea6a225d6@dronecode.org.uk>
 <42e189c7-5a2a-790a-a5c5-78b66fbcc516@SystematicSw.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42e189c7-5a2a-790a-a5c5-78b66fbcc516@SystematicSw.ab.ca>
X-Provags-ID: V03:K1:zvt15VzK6wo0lcpYqPDNT0YHm30hOzQZN+JR9rv+MuXWkSc8QwD
 UmKVkF9z+UDgo3s2ewIEM3BG79gcWfLkPZzOd//4MbiIzj6SBe4nQqtm6OX5fb4biuhgoQi
 LrTrmzTbq80KyVReq6EFdzJUMB31U8qXHviH3gTLRg+03GTZk/OBvy9rJICx2KYpeGCXHO2
 g46Xw7bGcWJBg1pDRDtOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qtP1YWNMsw0=:CCDYTd0xzf0mDtZU24pS+D
 GnuYtSByANFihQ5ILbabf3jlQFqta2ovYLfc4wJ7KWlU20DmyOMY9Fc4wiEEFfdNO3Z9ZxbH9
 GHM+oxtE7ZBwU2NfMyVsP7kGrK1KGLFy0eAlbcT+zcgULyi54zl13inyQvmWXZtItCyDjX4TB
 SxvDVpWxuCmsXlkbm0WGz4vaKtkLQo6KL4G1R9j8Xi5jP5G2u62ZmcA53Gku/h1BQSaaspG9l
 f6ASdsggRlVX6bd1Cfpak9DlJeAAEGiseocSaWyNzAxXM7PYok70IXZwVUGEhY4wpnA3RYT5q
 YlEKUx+PF05TdyoM5c/7JDf3kAMk1Bvf+pdgvrsVctj1NFbEskttPxJx3URCJVUDqpQFGSmY7
 AfKb+JjmSUlMOZIAioPwY4R9GFTcgo1bDAe8uqwS5Tn2akXRqX7bpuXlcpofwz5qv+EsHE16b
 Z/M6bdTmYhZ920uHuZujRJH8c88jbgGTHzGBduqc/6HF/pD4+yWzET7NN3+F2ErCXX1R3ST9+
 JtgrubJqeq+pbjW//qt57I=
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
X-List-Received-Date: Mon, 03 May 2021 10:40:29 -0000

On May  2 12:25, Brian Inglis wrote:
> On 2021-05-02 09:28, Jon Turney wrote:
> > Some possible items of future work I noted:
> 
> > * -Wimplicit-fallthrough, -Werror could (should?) be set in top-level
> > Makefile.am.common, rather than individual subdirs

Careful, the implicit-fallthrough values are different.  Not saying they
*have* to be different, but that certainly requires code changes.

> Perhaps keep -Werror for Cygwin sources only where we can directly deal with
> new warnings generated due to prompt gcc releases with improvements under
> Cygwin (thanks to Achim and JonY).

No, -Werror should be used for all source dirs under winsup.

> With other distros' gcc releases lagging, package builds are getting more
> warnings during cygport builds, which would have to be dealt with either by
> more Cygwin patches and/or working with upstream, by toggling off -Werror,
> or specific -Wno-... options which could result in suppressing useful
> output, as well as delaying package releases.
> 
> -- 
> Take care. Thanks, Brian Inglis, Calgary, Alberta, Canada
> 
> This email may be disturbing to some readers as it contains
> too much technical detail. Reader discretion is advised.
> [Data in binary units and prefixes, physical quantities in SI.]
