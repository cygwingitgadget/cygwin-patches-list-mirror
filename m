Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 4114938618BD
 for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020 18:57:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4114938618BD
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M4aA4-1kHMjF3hxe-001j8X for <cygwin-patches@cygwin.com>; Fri, 11 Sep 2020
 20:57:07 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3BA50A80637; Fri, 11 Sep 2020 20:57:06 +0200 (CEST)
Date: Fri, 11 Sep 2020 20:57:06 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Add workaround for ISO-2022 and ISCII in
 convert_mb_str().
Message-ID: <20200911185706.GO4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200911105401.153-1-takashi.yano@nifty.ne.jp>
 <20200911120840.GH4127@calimero.vinschen.de>
 <20200911213515.98a88ca7f186ede9bf8fc106@nifty.ne.jp>
 <20200911140601.GK4127@calimero.vinschen.de>
 <20200912010504.586a156f1712f61c3c696d40@nifty.ne.jp>
 <20200912023843.58ef0f3134d6aea5359c27c0@nifty.ne.jp>
 <20200912033758.d3e898332cb37f8b69f43bd4@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200912033758.d3e898332cb37f8b69f43bd4@nifty.ne.jp>
X-Provags-ID: V03:K1:DWkzr8ypab3NmiCYIUGI8AClFYAWku9KkQ9nzDBweehwWDQoKhL
 tku0fJLLyqBc6Yptue95OA1dbIW1u3pgMmaa4RX8Csl5cwvXfZryvb1Rc8JUUImsdQ4J8Kl
 QsMAIpzEvH3kbwHIiV3jrNkHaMgtiy5VVOIVs9adteNYuFQ9+ylqqOgWpYvcqPknO+0xWAw
 2Z8ZrKQoFm6glIuJTLPLg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:IhreZTNVHSY=:PwLEgZI0w6KKeQTdUIujtI
 UGesfFg3MptpoRwttgrqhogl/nxngBDU5UESdfOTmkebBvqZZo+Hkg1p4gDasncmr5HSObKGc
 4SIVNvEbxCSn29H/ZoVQ2Rvtfk0a945Q+cB1dzP4zlC99R/Nn1HHgDrVrXZaHBiLMSpNriC/N
 n2TZSOZ4GraxVdrPyYfwcsdKi5Nu9lelBQCoTolBXUwD872Rl4+bg4WC0NG0gmhWpJZAKkpMP
 t+87QQ8QbjrHFuLR2xl+2ika8YDKk5hS8/SurC/IDbR4HQvD9Tl4hD1qO1AaOUbiLBOatXaLu
 yO7EvxNproBnPtcJjOpDIzs0fL5hS7VyBhn/xhFDeaCSAVVfbfbHgXOaiksmlmLQIAwetkD2O
 h1kF46kIrepMb27xbibKXhj69/EWNNnUvN4LUqR/p3Op9L4mbSvPwyG2G1fNnPqBrvPlybBd3
 o/vyOBpIEkTEen9HQiOjl3+UiHwN5fyGEWK49QyhZNp0GsidQ2e4fAgeLfkg9zXFCmEf3V15e
 d9Qgq2XzVJJZrLC61yljmuPz/vEeQUbvG2MRx912kXlVnz4l6u1K01Pp99hxbI/y3gCKtBT67
 KR9CB3uj5oGhZIC95PSK8QtIqlBc4dluQSa0lVq1m7+12+UIFZ1Rc5ZUS/eipf/iIK1qpg3Rf
 tMc/sVYmyircIgomYDEzLm03VJEqea8zt+V/+aKH8pT+hIFkJxuUl+BVAPedLiSSeYyowOxnq
 lV5ajLNk+OfcO7tp1+Mt/On/3a25gIuE41v8oFUjTU/BnMpOHOoVnFUt334BWBotbsSL1kvxR
 VyQqwvL5MaMAn0r+YGPetTWBrQkAS2/2Y3i/LfLoJGgfYz8qlSv4ow2OxGMYVwRXW1zeIdZIW
 THkaN/x43wq43DcIaIYQ==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Fri, 11 Sep 2020 18:57:11 -0000

On Sep 12 03:37, Takashi Yano via Cygwin-patches wrote:
> On Sat, 12 Sep 2020 02:38:43 +0900
> Takashi Yano via Cygwin-patches <cygwin-patches@cygwin.com> wrote:
> > How about the patch attached?
> > I think this is safer than previous patch.
> 
> I have revised this patch to fit current git head, and submit
> to cygwin-patches@cygwin.com.

Thanks, but I didn't apply this one because it doesn't really make sense
to go to the extra effort to support outdated and incompatible codepages
we don't handle as Cygwin codeset at all.  IMHO it's not worth to call
another MBTWC just to check if a codepage supports the MB_ERR_INVALID_CHARS
flag.


Corinna
