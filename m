Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by sourceware.org (Postfix) with ESMTPS id 3E7843840C3C
 for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020 12:10:41 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3E7843840C3C
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MeTwa-1jrsSJ3nee-00aW8D for <cygwin-patches@cygwin.com>; Tue, 13 Oct 2020
 14:10:39 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8776AA82BDA; Tue, 13 Oct 2020 14:10:39 +0200 (CEST)
Date: Tue, 13 Oct 2020 14:10:39 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/8] Makefile/configure cleanups
Message-ID: <20201013121039.GM26704@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201012192943.15732-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:1VTSAVUTANNxS1vxCn64sz0itf/iedMvjysjbnzCpa1xQBDbDns
 AxxdrDf/vTVJD6vLdxrYSpt+OdDGYCo5o34TGy3z9CiOoPnzZYOQIxyMCCw9s0ALEsAd6gK
 FyrNhcnRzmBh6BK7k6dnP7a0DOZJNTbDxbocdScqfQpo78JyYuAuYY9s2T0FJ3I+UyJ40ft
 txo3LQQWRT2zkTtQuSwWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yBYMt2lvQC0=:rtEq4lUSQJDQw/C47bk2Ij
 n1YFGz01GqrzP6O9snd2D7AZhy6l04uojRnSCFL8rkQ+SoyZqYchu/WY2jyGWK5b3aIzQwOov
 5BBhQ81TGiPKpXzhvKGg5VD3sHhGo+m4WLobnyKiZJzWFvSuxPeiDxah5UTXe9nBGMRhpTrsW
 SFt+WOmprkJrQyoMEDO64xQwYuyXlSoUPFnWcYgFi+6swlTuT/SmQ73WjjkdzBrJoj4gXOpRn
 nePKVy70eOHOD5tjzOwDutxWfkjlkoW3br1hVoVJ+rsy1MqxSZZxL+wjve/OPohsrP2+SfZST
 cX8YKDYAeea6N5TTLWu8qn0tvQOYd2uj0qrM1QJeCcl218yRGloVl9v7O3oCjUB2ZQrg+yjc8
 Bk/onKdxMiTsVmtkonqg/F+keYClofPiYlf/g8KtzWGabc9PCsCsu0KOvIH5uLvw7nXfRmhsu
 CqrEthTobHfvsj25qauU9to195eK0ywbIwAPPGKxlVYx0WQJw72lzgURRyoFtFRbkT9zwyf5D
 VbASArW/D40O3qljHH5EU0dtAm0/IjVZkIvOcECEYMKAMYoc6UsWmFEHlGDaL8pzO+Jht2nnY
 lq2NcGDIyOZV1gR5rL11jv12M5VbU1lJImAvgj1iUN+0j1LDuGLhiHOcXS8AI2ybc24p5y5ep
 c1I+qrBuz4NyXn1plDHfKKr4+lhCWT8lLTROmy6q9nVD/wSu6suJ8P5BqN6K9Ib55xkL6lMI3
 paZsTP+9Vb6juaLRWZn0Tr+M6OMK+5JPb1CRDunt0lJvUjhbdzEhwun/pKlFPESg1xWYA75x9
 zSzuxuCZ9rlrfsN1oyG5cGoUxnSt4+Td1kc9sjg0VYwznEBPwQGbmXDFe4D9qDDW3DRByTYw2
 IHXm7ubM37P7eNmvs/LNDuWdnRmsdTxqU1e9XqCKS6/OinD+FQzfnp83E2nLAN
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 13 Oct 2020 12:10:44 -0000

On Oct 12 20:29, Jon Turney wrote:
> Some Makefile.in and configure.ac cleanups and de-cruftification.  This is
> preparatory to an Automakeification series still being worked on.
> 
> For ease of reviewing, this patch doesn't contain changes to generated files
> which would be made by a autoreconf.
> 
> Jon Turney (8):
>   Drop looking for w32api in winsup/w32api
>   Drop STDINCFLAGS overrides
>   Remove AC_PROG_MAKE_SET
>   Remove AC_ARG_PROGRAM/program_transform_name
>   Drop AC_SUBST(LIBSERVER)
>   Remove autoconf variable INSTALL_LICENSE
>   Remove empty MT_SAFE and MT_SAFE_OBJECTS
>   Remove unused doc/ug-info.xml
> 
>  winsup/Makefile.in            |  4 +---
>  winsup/acinclude.m4           |  2 --
>  winsup/configure.ac           |  6 ------
>  winsup/cygserver/configure.ac |  2 --
>  winsup/cygwin/Makefile.in     |  9 ---------
>  winsup/cygwin/configure.ac    | 18 ------------------
>  winsup/doc/ug-info.xml        | 36 -----------------------------------
>  winsup/lsaauth/configure.ac   |  2 --
>  winsup/utils/Makefile.in      |  4 +---
>  winsup/utils/configure.ac     |  2 --
>  10 files changed, 2 insertions(+), 83 deletions(-)
>  delete mode 100644 winsup/doc/ug-info.xml
> 
> -- 
> 2.28.0

Apart from my single, minor nit, LGTM.


Corinna
