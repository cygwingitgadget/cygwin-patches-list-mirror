Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 2E36E385041D
 for <cygwin-patches@cygwin.com>; Tue,  4 Aug 2020 15:04:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2E36E385041D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M89P3-1k7dS23TmN-005HOa for <cygwin-patches@cygwin.com>; Tue, 04 Aug 2020
 17:04:29 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 4ED7FA808C0; Tue,  4 Aug 2020 17:04:29 +0200 (CEST)
Date: Tue, 4 Aug 2020 17:04:29 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/8] FIFO: bug fixes and small improvements
Message-ID: <20200804150429.GA1107715@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200804125507.8842-1-kbrown@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200804125507.8842-1-kbrown@cornell.edu>
X-Provags-ID: V03:K1:Im/JOgc7+ruIpYQjCU+OdlIsu2N8Q2/vgF2Yim/e3j3P8gggypV
 1I4z07BzSZrXhKEVWnJ2swF40TJtIgg1ScghbjOExCoEYLRztz9gFhpiK/ZQhm+aOZ/4+yE
 QFykHk8ZH+O9Y9wrB473uMbXlETMzfOarxCA3tfpZ28oQLMMdYCJUs8KmhuNCTriVcn8Sf4
 q5fsRLBMSHvAFDtOPUKWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ph6ne8gQ8C8=:8V5XKcof+88JolgVLBGnbA
 AW45gwg2hDB+yoBaW+ZNTidXw/3ygSaB0cA/yWWpNcp6FxXnv67YQdyYkevUm/1nLzkgWPuFl
 m2NnFVKdTM/hiqyQ7TMXozRdAZ7gf2Dg+90N4cDP+Ttun7k5BXLG8q9H1dr8bqIWnILSXHUNE
 vgUyFMLQm+nPpGAKtggpxc1/Dave923l1r/Ju4m9hOfYqzwsxy6Q/VusmXW7wJLIpK3FGYHO2
 EaMt2jZsvZBB92cS2sQThTKJ+t/tmpfdsLCLEH7JBvqTJ04UZNrDRz2reb8dySqWGrBzvZkua
 jF0/AbkKURT7mlilmZ0S2bkHv9Y9eJyVRG1KdIpWsan5fHyRu4e9yJOx+KrjJM2PP4uknpyyG
 4aWHMh8mo5IJxQdTloCP4y0jsqalUYKmj1NdCGos7E22Giu0K/9kxTdE1zGiN/tUrIH8K0BJS
 sVjqSzu7hphS3z/aoVX70w7qRNLxhzu6D5OS1qpvlyEY+napgjrJ99FMlqgH9vewivxW1xh/9
 fNUUePeE+P+UvcizURsg0tajSu0NqNKkQqq5RNXW5XC+yOQQENSC5pJwTVeoO2YYpXjNZiZLG
 /m5ep/YeXd9/RuPTylljEAIRpc23PmBmno810Gvc5d0YBC/yJbf6Tfp912uMc7C8FnA3CpaqJ
 2HWihJ6lpVj+eDFFJiFoO1Ys7H/CnCo3mTV7oWleMFjNP6Tqe+z7ZYT0hvhdDPdIddi0mBoLT
 ZpN2rUcULsT/vGXCuKkVshzVihDoneyHf0zFVL41aeiGmMGnHsEyGB75mkqHy51rlVyTlHDkZ
 Y+Y1tKgjWU7oK3qWXrvdNsDXrcnWL9ONJEyB7+IEIzeTXRucp2UG+3H90SuGD5J/ezmpjkK4c
 oJsvUkUUSVCjYQ2QCy9Q==
X-Spam-Status: No, score=-99.9 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 04 Aug 2020 15:04:33 -0000

On Aug  4 08:54, Ken Brown via Cygwin-patches wrote:
> The second patch in this series fixes a serious bug that has resulted
> in observable hangs.  The other patches are minor bug fixes or minor
> performance improvements.
> 
> Ken Brown (8):
>   Cygwin: FIFO: lock fixes
>   Cygwin: FIFO: fix timing issue with owner change
>   Cygwin: FIFO: add a timeout to take_ownership
>   Cygwin: FIFO: reorganize some fifo_client_handler methods
>   Cygwin: FIFO: don't read from pipes that are closing
>   Cygwin: FIFO: synchronize the fifo_reader and fifosel threads
>   Cygwin: FIFO: fix indentation
>   Cygwin: FIFO: add a third pass to raw_read
> 
>  winsup/cygwin/fhandler.h       |  24 +--
>  winsup/cygwin/fhandler_fifo.cc | 358 ++++++++++++++++++++++-----------
>  winsup/cygwin/select.cc        |  38 ++--
>  3 files changed, 268 insertions(+), 152 deletions(-)
> 
> -- 
> 2.28.0

LGTM


Corinna
