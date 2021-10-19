Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id A45BF3858D39
 for <cygwin-patches@cygwin.com>; Tue, 19 Oct 2021 11:07:19 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org A45BF3858D39
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MS3rB-1m9xOw2k7H-00TTfl for <cygwin-patches@cygwin.com>; Tue, 19 Oct 2021
 13:07:17 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 89630A80D72; Tue, 19 Oct 2021 13:07:16 +0200 (CEST)
Date: Tue, 19 Oct 2021 13:07:16 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pipe: Use NtQuerySystemInformation() instead of
 EnumProcesses().
Message-ID: <YW6m5AgCpkTy7fyi@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20211019084019.1660-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211019084019.1660-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:M8AdvvLS46bfLJ7IZzct4zVBR/XmPmfNrIuIWHsCGtwhO6kXMVr
 ThumCGvkxX0f5jdqkTIXNmwK12hDHxKve1I++3h01VmmbSwHcWnZ+p8VqR8ltIpLEutXzlh
 0tAxwhrDcT9b1FHatT0JyyrBm9u1DE9kulBwHJo8aiWTg1hvgsOoyljvYoWv+SMMgSTGRv3
 ANKMbq2wNOyhuMOy80Hig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1qkZ4CiBROc=:ho0KpJaEiUXw2SiCMObiC0
 x0XhRPDOvylL5WSyjqhFkKSOtxt4uTl+y+cQeclNO5jtM5UXFWMuzPCfjH4KaEOqLau6P6AGp
 ctBtMGx05Cj2FVNYiWkXWUpnAUNfP24Dez+VYnpp0GZQNFvcw5DwEIfAgoTX8zQtLx/bf6chK
 QhIX5ndgEiKwDOHpp6KNqXT4yzz+5EFrpq1Fv/Jh7TCjCa5CdVX9EhGgbUZbFHsLhWGNXY3Fs
 OVYSVqTBiuVU+6wuwfAaLrtwrTd++IRgZe8rnnUxq1IQTM9CpHVpZtwowo01YQEQ8+k2WrFSp
 QTwmE1F/eIgqRIOWAm3+S1d/GXrqwmjnA+nzBSFrB3iVbF5Ir3GsArxjzYNZYmP9XavjRCeLp
 IwEIHc92kRsutPW01mPyHWT1ZUj6EFgrVMK/SuG2iZqH9+TuXyeBFmjqCHOcWvX54w9xJAyuv
 c+ys0sys7QiSgtiXqBfbAjovdAA4sGnai1T4q5+QQBlmdGfwKupr+8EOz7xqpoL2bPPccSaX0
 MtrhLhyxYX77LGV6Dxc1BfrLdutC1ftgJyja0mVqnDvTuqWFwVoSYK16B7NwXOo3c9k0nuHUM
 2Yjmf0mKjlHZAkDSBgLbX4eWMoUs6V+M7t9KDhw2DoCv3ing+dLyenEwcTAxZbmPCUqqy66bv
 V6Q4w6Hv89r5Gexen33Vytcgfe8wynU3lr9yqnC7vf+e+qRfGNESf9/gZcVm936tPOqGZ2SK5
 RY828+L5rqfKmFCC
X-Spam-Status: No, score=-99.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Tue, 19 Oct 2021 11:07:21 -0000

On Oct 19 17:40, Takashi Yano wrote:
> - Using EnumProcess() breaks Windows Vista compatibility. This patch
>   replaces EnumProcesses() with NtQuerySystemInformation().
> 
> Addresses:
> https://cygwin.com/pipermail/cygwin-developers/2021-October/012422.html
> ---
>  winsup/cygwin/fhandler_pipe.cc | 50 +++++++++++++++++++++++-----------
>  1 file changed, 34 insertions(+), 16 deletions(-)

Pushed.


Thanks,
Corinna
