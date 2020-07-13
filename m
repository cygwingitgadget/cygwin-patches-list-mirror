Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id D658E3851C12
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 15:21:05 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D658E3851C12
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MC3H1-1k0joz2Hzp-00CU1o for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020
 17:21:04 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 10416A80D1F; Mon, 13 Jul 2020 17:21:04 +0200 (CEST)
Date: Mon, 13 Jul 2020 17:21:04 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] winsup/doc/faq-what.xml FAQ 1.5 Clarify What version is
 this
Message-ID: <20200713152104.GO514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200713125855.17015-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200713125855.17015-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:F+cDByQ3OuTRCEVXNySAydnzc1Ok7y4DxBA8JDCcvneO5CL/JeS
 yTy3HziqnvVzBjLfz1154XN9Uo3ysxyHeyOVnTAouySXxyKIyw8cbgSDZOyDA+vSwGWGLTe
 dQoW4WXAkjKoaxrWWptmFrAKuu1Li2AT53fQklSjVTAaGqRTBcivy6VM+sp/oHLBsTZ+q5z
 OnACxLX1Wyex0PdM2lRmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:LY1I65r+QyI=:1glz49Jww3J2rXjzVmLyxT
 n3/1Ecj4n4NWYNMMoMBY2UEfi4GZZM4rThKKAqmJC5cNRbjMGhEgQ0WxkZa8C0COU1YKZUIRb
 COlA62FjAs9JQzCoTN2PnNGqPrwXY0m32JFXRA45hy/n3IkOxEswwGLQYhcb2qzFt4AbB6Zrq
 t3nSdsIL2s4B8ZrucTeYZoqZcyFq1dB00fiuyijulVAghu9brmBjF5xYRDIIH6ksDpUu0vVX3
 IR7JKR8yD4slt6PalhmjgdO5FQCR8IeUKGiCx3ik8iwg5IKxf11YyYoPuCm//zVb1PVGOwZOU
 jtyFm7yaIa+zhJkXt04w/iWHpul2npcGxlO0t7gjSZiF6QDc6VN60C4HNSOVxEHQMUlcX6L0M
 hHmlcpia3okKwml3vJN+Bb7cZFotqbMblxuaoZs8lwu3MYpCAY4W32xEB1TMRaOWnuc58/ZeS
 qEkn3Rcpk7+OpeUuxETEROY2U6w86b1T7z9VzBcfQK8EUMoC4iun29rtbIRBcULSYi2DT0KfQ
 G5ck1njOo5Mag6yQruaGm95kYFiMiUCJIqqBcZmKlyb22Bzs6gdfq7mJXBn2bO+EBtA8lgPUt
 /PSchCHQYp3lhSKh06eZIlMyPpzhIx+6eGXAJ020H6QF81Ze0W7Qj2FWonJaFx/1CMkPDXIC+
 s+vT86LbY0OB0e12WKvIPeRCbPPcv7pVsCZcadXTwfRZtUf/p/Rhw7afbyNiw673PnGxoG31i
 apKbItwU2GZs1kjrHRo+L3Db0s/NA3atvWnyjAz3paaChuo+LI1WZAYzJr9+iJR7l+k6nbCcN
 +50yrTKdfSE4kJLS8g4ziLR9ciSXkqw/IjlK26Tr4r7sVr3siros4trjqn1ZHGRdz+hywAC1I
 FF0Wkbq5mdgXs2kt5RlQ==
X-Spam-Status: No, score=-98.7 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 13 Jul 2020 15:21:07 -0000

On Jul 13 06:58, Brian Inglis wrote:
> Patch to:
> https://sourceware.org/git/?p=newlib-cygwin.git;f=winsup/doc/faq-what.xml;a=blob
> as a result of thread:
> 	https://cygwin.com/pipermail/cygwin/2020-July/245442.html
> and comments:
> 	https://cygwin.com/pipermail/cygwin-patches/2020q3/010331.html
> Relate Cygwin DLL to Unix kernel,
> add required options to command examples,
> differentiate Unix and Cygwin commands;
> mention that the cygwin package contains the DLL,
> replace setup.exe reference by Cygwin Setup program wording.
> ---
>  winsup/doc/faq-what.xml | 29 +++++++++++++++++++----------
>  1 file changed, 19 insertions(+), 10 deletions(-)

Pushed with minor change to log message subject line.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
