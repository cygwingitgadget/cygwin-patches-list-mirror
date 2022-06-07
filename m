Return-Path: <takashi.yano@nifty.ne.jp>
Received: from conssluserg-03.nifty.com (conssluserg-03.nifty.com
 [210.131.2.82])
 by sourceware.org (Postfix) with ESMTPS id 03AB23814FCD
 for <cygwin-patches@cygwin.com>; Tue,  7 Jun 2022 16:49:49 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 03AB23814FCD
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=nifty.ne.jp
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=nifty.ne.jp
Received: from HP-Z230 (ak044095.dynamic.ppp.asahi-net.or.jp [119.150.44.95])
 (authenticated)
 by conssluserg-03.nifty.com with ESMTP id 257GnGX8008983
 for <cygwin-patches@cygwin.com>; Wed, 8 Jun 2022 01:49:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 257GnGX8008983
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;
 s=dec2015msa; t=1654620556;
 bh=kjLCCNstT25ytV8bUf7ebTkesiqMqaeXbl58G26HOyI=;
 h=Date:From:To:Subject:In-Reply-To:References:From;
 b=fzDfczs+otB8UulUrO0ncmrY+mBe8G5wLjCt4pOTAMGBaAfR/ReNrmGHKU2rYm4Yx
 LiHEK+Lbw3Zu2R5Ov35yzeQ3l21Si64gMUFq804OocUFliVifOBwssYHMH6+dwmvGQ
 Oq2fCh7v8n6QjUgTGuteZRxsnTjgwCNhPhx/tnrP+SCoYmDJC5CMXM17Q8iirEk0zM
 eJ8SSPt671T+A5fp92Pe4OQmYPzkB0pTOkpk6BiSjm5f6R//2AH92pgDbd6UoIE1bX
 JmPffNhTeFnNqVDbQ1rt7WRSxj2+32rDggNlF1z1pnC+kndU58Vz9LDb8NeMZ3vvZk
 PrhmXwF3XdTeQ==
X-Nifty-SrcIP: [119.150.44.95]
Date: Wed, 8 Jun 2022 01:49:16 +0900
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: remove most occurrences of __stdcall, WINAPI,
 and, __cdecl
Message-Id: <20220608014916.df0275787115d55138757a3c@nifty.ne.jp>
In-Reply-To: <b5f56fb5-48eb-8596-5855-35a35dcb8a55@cornell.edu>
References: <2d54f846-365f-848f-4fdb-1c22d4c1bfa0@cornell.edu>
 <c9c7e7fe-adc6-c845-2720-06bc40591255@dronecode.org.uk>
 <b5f56fb5-48eb-8596-5855-35a35dcb8a55@cornell.edu>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.30; i686-pc-mingw32)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.3 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, GIT_PATCH_0, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS, TXREP,
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
X-List-Received-Date: Tue, 07 Jun 2022 16:49:53 -0000

On Mon, 6 Jun 2022 12:24:15 -0400
Ken Brown wrote:
> On 6/5/2022 4:24 PM, Jon Turney wrote:
> > On 03/06/2022 15:00, Ken Brown wrote:
> >> remove most occurrences of __stdcall, WINAPI, and __cdecl
> >>
> >> These have no effect on x86_64.  Retain only a few occurrences of
> >> __cdecl in files imported from other sources.
> > 
> > While you are correct that it has no effect on x86_64, I'd incline towards 
> > retaining WINAPI on Windows API functions, because it's part of the function 
> > signature.  But other people might have other opinions on that...
> 
> I ended up retaining all occurrences of WINAPI.  Those that don't directly occur 
> in Windows API functions are mostly used for thread functions passed to 
> CreateThread, and the latter expects a WINAPI function.

_dll_crt0() is declared as
extern void __stdcall _dll_crt0 ()
  __declspec (dllimport) __attribute__ ((noreturn));
in winsup/cygwin/lib/cygwin_crt0.c, however, this patch
removes __stdcall from winsup.h and dcrt0.cc as follows.

diff --git b/winsup/cygwin/dcrt0.cc a/winsup/cygwin/dcrt0.cc
index 0d6c1c3b9..71215ace6 100644
--- b/winsup/cygwin/dcrt0.cc
+++ a/winsup/cygwin/dcrt0.cc
@@ -1013,7 +1013,7 @@ __cygwin_exit_return:			\n\
 ");
 }
 
-extern "C" void __stdcall
+extern "C" void
 _dll_crt0 ()
 {
 #ifdef __x86_64__
diff --git b/winsup/cygwin/winsup.h a/winsup/cygwin/winsup.h
index 9d204434b..8774f3bec 100644
--- b/winsup/cygwin/winsup.h
+++ a/winsup/cygwin/winsup.h
@@ -147,7 +147,7 @@ extern int cygserver_running;
 class per_process;
 /* cygwin .dll initialization */
 void dll_crt0 (per_process *) __asm__ (_SYMSTR (dll_crt0__FP11per_process));
-extern "C" void __stdcall _dll_crt0 ();
+extern "C" void _dll_crt0 ();
 void dll_crt0_1 (void *);
 void dll_dllcrt0_1 (void *);
 
To be consistent these, shouldn't _dll_crt0() retain __stdcall?

Changing cygwin_crt0.c is a bit weird because it looks as if
it might affect binary compatibility, even if it really doesn't.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>
