Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 23754383F85F
 for <cygwin-patches@cygwin.com>; Fri,  7 Aug 2020 15:32:20 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 23754383F85F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MtO06-1ksBy82tCQ-00uueC for <cygwin-patches@cygwin.com>; Fri, 07 Aug 2020
 17:32:18 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3D2C1A80A57; Fri,  7 Aug 2020 17:32:18 +0200 (CEST)
Date: Fri, 7 Aug 2020 17:32:18 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: cygserver: build with -Wimplicit-fallthrough=5
Message-ID: <20200807153218.GL1107715@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200807135111.22024-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200807135111.22024-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:grFjtHc4SMjVOeAxY2bTFOgWGUMjJkYK3tCiSJF57Sw7bMp2ka8
 UTKhgtduBPFwKzdpOtALBJB/JDFRmziaWidu55FOcJkRZVuaCGMzEugRbqzBcuo7IymiqVe
 9K6jO0R275IILn7qpxZ+aGsCGP5sEvCIZA5JI2FXPnVBLoW/Ds8c+Llsbs6hSECjvMlT3H+
 TKAO9ZCMQvOWW3ArVJHCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0pnSNVkUw+s=:D5LdLV0Md3xeD5HkJTW+oA
 ewT90rEzlgTzixnHGhQrfU+mfN9dS8pk4QOwB2UK9DQjhQBqZKbqIlK5+iJI+Zlg9NTyq3iQL
 mvC53h5+d6ejzPP48YKSV6R4nfhC76UJtmt7lBnfejsmy7EFYCbTvmzwGUodcenI1zkeKzmcD
 3j6+jYLTPYq4/yOuTJgpLBmtjXvsEF2YghXr9x5bN7s6HYJqAZniWMzyF1e+jVN2mURvLPI/1
 fUbvPX9lvnvOzPOKyzkD3kLBrcn2LGkk3ktG26IGxToSiOka8LMvhNKoT8YzaoIKkc1sWBAIg
 X52vq1r3Bh1rb1/GemkztRd2VzLWqZx4KL1YGSWPj9Nx3yMNnxRCAzhzymMZUjVmeSmaWw7/Z
 rTbefa6GamS1VZwfcSmUQ3p6ydpcAP4IK3kMtU/UpMh3BwrgVnf1VsJbuORxGrE62I7sZ7MWf
 Erc6EFAtWan0RcgqYC7XpOn3LLg5fJqUuc6CNgAwitXdrXtT4uiFeIpRkLyeBtaN6bVTTrZtX
 g7PucOCR72wU1hICnOuuJ1m5yPVE1sp9S5ENdDFdrPNskPs7ny6fQpR90nSReW6a6TY+Y22rg
 HHsRKK6sF3SJAhuiPDhNne3z0i1Dyjb+0PYxB2HR7PAYi6bRvN2rASEd8spryxdwLfEaXLmiP
 ZWTFyu7vTNqx2YSJjHqFNlUs7eVniOuBsr3uA23F6ezvjrNPLbR88W3joj56hIjd0L85wModG
 iUot27THJspLfYytgkKy2p0BRoEHnDxk3yW9JKLVw6Ff2figlBYsUi93FQUNTJQlpnkUjt9ek
 28zi1L08NQGCYIZl8+sbYi3ZQNXrP9W0JzHKL1wBiMbsMA6IrhUXAF8Di/iqsavr0RzckBER0
 j17AqaxNragvtu1flWYQ==
X-Spam-Status: No, score=-99.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS, KAM_NUMSUBJECT,
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
X-List-Received-Date: Fri, 07 Aug 2020 15:32:21 -0000

On Aug  7 09:51, Ken Brown via Cygwin-patches wrote:
> Define the pseudo keyword 'fallthrough' in woutsup.h to support this.
> ---
>  winsup/cygserver/Makefile.in   | 2 +-
>  winsup/cygserver/bsd_helper.cc | 2 +-
>  winsup/cygserver/bsd_mutex.cc  | 2 +-
>  winsup/cygserver/woutsup.h     | 2 ++
>  4 files changed, 5 insertions(+), 3 deletions(-)

:+1:


Corinna
