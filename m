Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 71BF2385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 12:26:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 71BF2385701F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3sye-1lou9R063E-00zlHk for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 13:26:49 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 774A8A80DBA; Tue, 23 Mar 2021 13:26:48 +0100 (CET)
Date: Tue, 23 Mar 2021 13:26:48 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Rename input/output named pipes.
Message-ID: <YFneiMhPIxZoNUd2@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210323115028.1275-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323115028.1275-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:3XfQnfZPLWduS3ha9xOLvIXAdrowNDXUIhXK5+bfo39vLZl78ie
 /D+hUO91Ub9mHWDmKa683MrtOPMW1PIq171p6AIcHd2OOJ+15tS3/g0wr5WK+8hpHAcCTAT
 Ra9lLomlKlMyypSZHCAyQZ2qMTmbKqG3W3i4YC6AITU5D+o6RcKiD4RjEdCwzCvQzYr5v5S
 2EBm6WbrI/Dqt68LLTtJA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r8ePnGTustY=:OsXR4FOimHKUN2KRXGxv2y
 iDCbCZqxV9TPA3rthithB3r7VZ4+n3Jn2eF0fKK1+El+IGgT+3Aq20cMbH4CAwhKqsiezUfos
 uk+4jVKaZXylPm+tx5/ehzpXJ5DzrSaTvOChy+l3kI856TSaSj1ChxWixZB5hRnjJzDP/PMex
 IBaJB6RqyzFEpoEDtPJSErcFAHGjWee2/WBAjaA/IW4wwnnDGFB5EmNSDq12uWkx25eETdugc
 2L8RlZK7D1CrJPENOp2WZzVyfwHTHdUh6uiFua2Tt+6K11DPMKOSloSAeX1QXp2PPm3eScOJl
 1m6xZ9y4tDHvTCiWSa6PrkMZ1sEAJXtkShXBsieY451tx7/Utp80r7knutLScYnsPWqlyRRfU
 ryTLzNwm40FbwncqGGoS5feaJavZluqLyV9aBU6wlQecMORTMMK7OYyre6dTqP37RstwjHdab
 x/F1qMC6DA==
X-Spam-Status: No, score=-101.0 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Tue, 23 Mar 2021 12:26:51 -0000

On Mar 23 20:50, Takashi Yano via Cygwin-patches wrote:
> - Currently, names of output pipes are "pty%d-to-master" and "pty%d-
>   to-master-cyg" and names of input pipes are "pty%d-to-slave" and
>   "pty%d-from-master". With this patch, these pipes are renamed to
>   "pty%d-to-master-nat", "pty%d-to-master", "pty%d-from-master-nat"
>   and "pty%d-from-master" respectively.
> ---
>  winsup/cygwin/fhandler_tty.cc | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Pushed.


Thanks,
Corinna
