Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id DD6E13857C5A
 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020 07:14:58 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org DD6E13857C5A
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MMoXC-1kBS7h2SzU-00Inv9 for <cygwin-patches@cygwin.com>; Mon, 13 Jul 2020
 09:14:57 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 3150EA80D0B; Mon, 13 Jul 2020 09:14:57 +0200 (CEST)
Date: Mon, 13 Jul 2020 09:14:57 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] COMMIT_MSG
Message-ID: <20200713071457.GI514059@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200710230432.57869-1-Brian.Inglis@SystematicSW.ab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200710230432.57869-1-Brian.Inglis@SystematicSW.ab.ca>
X-Provags-ID: V03:K1:XbaM3+tSdUurdXDRehRgw1AP0SPwsR4dZv5H2NHp1BCwFUNBziY
 1BBE5ltEc95UOA8hDwxj7kCskTnZoMMSjov/cD3k2ICFOEMHCsLuvHFIPF1rFvF3gbJRSLN
 zU1b+yYZrKhlaEhh4WIcBsReLIgA22crnWWHM8mj5/Dzya9BT2ELIvkcx6Brlg5QXND+hIP
 DGYnn/xjOoTfjIpDBz0pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:U0ljvtc++Ps=:6HSRLi05hPdO1Xne1MWJ3M
 bc7uKe37CQmT8oBaNZVzKCyWbyIyV8P90WrEYNZjmuZw2LVJ8Mkhm6SRWyui4MOUCp1vQYm6g
 bU3xNSvqxdMvXcex2qpOz3s7hkyw+FcMH6xGBejmSK4Xmqtpndy4vUmpwkBJv+bCniwJXo4TR
 l967ud1aRUFjDKMPa8SoK2W4MR8dQKcVt4yCWfBUGDCIfQM9WCf8bfYfLnrWfyckF7V4SVJOt
 jamCp/6NQvD/bo4uClUG7k2H4+raJmoAtRntlA1VPxIrcEshp7BlaCW9uwI3skjS3L05imGIY
 GaxPdQJ1Q+ZYByHBscDgUM1Fv531ciUkMTwjsttX27wUU2tv3ELJmGH8zbkg+6O3/jfvwY3Lm
 SmCZpBep/uAo/lSLg7gLdjG5NKEuSizV+jDbI2/H5d/Kr6za2Tqy/rxrBsCsCLJHGEJbpitEo
 AgqdNSB/we8keBfnWSmf1Ki8zOTdKhswImoTQkFesF+3ngSAoUqxO485XtMuY6InrajY99R6d
 UlO0+TX9aUpyfyYde0g6CAOnuvPLDqVURgeSKYdtPD0fdFqrdZvaVKwIoILLkaom/h+v4wujO
 JHTMaSAkd8NFLRulqVSavUw5Z8x0a4U8I51ECZZu70KR6M2ucy1Km7GsumKfvGDJ51keRA1ms
 aQ+axqKUnjJVVmLmBO3goLvCKSvUJOIMF51dG8+ynQGsWq1min4yeXo39/BMF5E4jpcMq/8he
 QGBJ52qfj7JZ+AoqkshafM0+u8Vn031Dlz3CBO1XIJmTUNy+8lNj+QxsjJGeGNN4lx9IQjgJe
 o7I6d3jAy8S3L77VO0eqTFKZXPo8R+V9kiwvWBvUJIV/HRJL9e+zCiZGJ3oA8uvklwCgr+MD/
 UwZ1R0c7UbA/rEgSGT6Q==
X-Spam-Status: No, score=-98.5 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL, SUBJ_ALL_CAPS,
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
X-List-Received-Date: Mon, 13 Jul 2020 07:15:00 -0000

Hi Brian,

On Jul 10 17:04, Brian Inglis wrote:
> ---
>  lib/src_postinst.cygpart | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

cygwin-patches is not for cygport patches(*).  Please use cygwin-apps.


Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
