Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 05CDA3857C56
 for <cygwin-patches@cygwin.com>; Tue,  8 Sep 2020 07:55:48 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 05CDA3857C56
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mw8cU-1kWGW51JAK-00s2gH for <cygwin-patches@cygwin.com>; Tue, 08 Sep 2020
 09:55:45 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 8FE33A83A95; Tue,  8 Sep 2020 09:55:44 +0200 (CEST)
Date: Tue, 8 Sep 2020 09:55:44 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] fhandler_pty_slave::setup_locale: respect charset ==
 "UTF-8"
Message-ID: <20200908075544.GN4127@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200902163836.GL4127@calimero.vinschen.de>
 <20200903175912.GP4127@calimero.vinschen.de>
 <20200904182149.18cd752eef58c67ee8d39135@nifty.ne.jp>
 <20200904124400.GQ4127@calimero.vinschen.de>
 <20200904235016.9c34d04e809b5ad9f2bdfdf3@nifty.ne.jp>
 <20200904192235.GW4127@calimero.vinschen.de>
 <20200905174301.adbb3c147122fbe0636a0d56@nifty.ne.jp>
 <20200907082633.GC4127@calimero.vinschen.de>
 <20200907192713.54ca04cdc8264c6a03ce6f59@nifty.ne.jp>
 <20200907224056.bdd8818cd7013248b41871a4@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200907224056.bdd8818cd7013248b41871a4@nifty.ne.jp>
X-Provags-ID: V03:K1:F+QvSdcqMiPxDiS0qu/gArs1iJ0HSyqSYHreP8dUFHRQzL/VH3F
 3RMnagdMQG0bt5svszJmWuzpQJaoAFB3vTOJEWD0iWA1gXOd2ziJj804LspBeW9lITytYq4
 hZLhI5WpZiro0M78QGmKq/KO8hRahCsB4LdNhV3tildro9RdZHJbMSHWL/3kH/TIOX9K8W7
 ah/rIWoXB/QHnj/D55HlA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CiYt4fD90rc=:WNoqdeNrrV+eUVOuEMnUlQ
 CWsakubm2hKkxlV5VEdFaDm/SJzPe49xk42oboQQA+kGY08reIcI7D32rQynyZk1jlMB6HD4V
 pVuSSOmPc0pEb7R5yNNh/o2CV9A+rMrp8FtOfOnByFhPrik8GRT/mk8L+kciwYAA8gP87+oUP
 7uiUEjGCznltumv3Dses5hMsG1fs5+3em6RNdsc+cpYbpKBZxCJhZlGoh2cwb711uwrUYitQj
 aG81wSZBDwP4sUM7LN7dXPOuCwcIJJJljAD/owZM5ecJ67atbpvMrwTd4ZCd9zbpfCdy/Bucl
 JGpeBHqv5Z5RsHT8IBiuQBFXO65HCGIWPmSDdDW/Z9Bl4i4NUILrungaDkH0hlfkJ9k9V9S3k
 NkHhqiBoDB8YF7enhZ+qSS2dkLWK0wUuM6UNp8xzL97bKwBsIfbb4XI/zzNIiTiuW1Nb1s5pR
 YdfdVAAMrmx0WBfhy4afzHlYMGE5+0wTtSm6cJYunw9AmKBaLRDY/xqzSc7U6Ja5oQ16fSvc+
 NpT5Uxzwl3CauMnNcEgOZfuunAxDuZM2eTjCpMiEOaXvFeBJXI1kFrHS9bYJFcYxfXgHWecxK
 PhHYqYRDOZ73qAqga2iDCfz+hZNxm/xCPQ7JO72Ax1cC+JIfjUh2qGRtFZnaXexE/I7J1oe5x
 PzcN7H1WJ/tvvyJZTrqgPusa+vOvfF6oQz7rtDcgr1fcP7NaUXXR5h5DC8s3U3OsPUfQQt6oo
 MjI4QMlnLizxo6EBpSgig/fhtKTowlZPNvuRlTcK3AzPEC2HCEZ3oU2nRw4cjgXKDpG6oCIF9
 IYDyVlIIXK9GOcs5nsjKNOqvVGaC8FF3OhMFDrIEaQc3kZpxnxCTD6pDNXKqbvfeuK1vkrTNj
 M/OBT0VNXj4FU37SB8ew==
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
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
X-List-Received-Date: Tue, 08 Sep 2020 07:55:50 -0000

On Sep  7 22:40, Takashi Yano via Cygwin-patches wrote:
> Here is a summary of my points:
> 
> [Senario 1]
> 1) Start mintty (UTF-8).
> 2) Start another mintty by 
>      mintty -o charset=SJIS
>    from the first mintty.
> 
> [Senario 2]
>   int pm = getpt();
>   if (fork()) {
>     [do the master operations]
>   } else {
>     setsid();
>     ps = open(ptsname(pm), O_RDWR);
>     close(pm);
>     dup2(ps, 0);
>     dup2(ps, 1);
>     dup2(ps, 2);
>     close(ps);
>     setenv("LANG", "ja_JP.SJIS", 1);
>     [exec shell]
>   }
> 
> 
> Q1) cygheap or tty shared memory?
> 
> Consider senario 1. If the term_code_page is in cygheap,
> it is inherited to child process. Therefore, the second
> mintty cannot update term_code_page while locale is changed.
> 
> Consider senario 2. Since only the child process knows the
> locale, master (parent process) cannot get term_code_page
> if it is in cygheap.
> 
> Q2) Is checking environment necessary?
> 
> As for senario 2, setlocale() is not called. So it is
> necessary to check environment to know locale.
> 
> Q3) Where and when should term_code_page be set?
> 
> In senario 2, LANG is set just before exec() in the CHILD
> process. Therefore, term_code_page should be determined
> in the child_info_spawn:worker or in the execed process.

What bugs me here is that in scenario 1, the codeset of the master side
is the defining factor, while in case 2 the slave side is the defining
factor.

Actually, the only defining factor is the codeset of the master side of
the pty.  If the master side interprets all input as utf-8, then the
slave side should either send utf-8, or live with the consequences.
It's the task of the *user* on the slave side, to set the env setting
matching to the master side.

I tend to agree with Johannes.  We should not enforce a codepage setting
inside Cygwin.  The bytes should go to the master side and the master
side interprets them.  If native apps produce garbage, well, I'm not
overly sympathetic.  Especially given the fact that even Microsoft is
now doing a lot to switch to UTF-8 as much as possible.  It's the only
sane option anyway.


Corinna
