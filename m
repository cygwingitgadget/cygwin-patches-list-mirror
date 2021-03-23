Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
 by sourceware.org (Postfix) with ESMTPS id 60CE2385701F
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 12:17:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 60CE2385701F
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MFbiK-1lSX4705fy-00H8Hd for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021
 13:17:17 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 28835A80D4B; Tue, 23 Mar 2021 13:17:16 +0100 (CET)
Date: Tue, 23 Mar 2021 13:17:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFncTItWHhMlNH5Y@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
 <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
 <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210323205717.bf5c3a41695871ec70bf1229@nifty.ne.jp>
X-Provags-ID: V03:K1:wMPP3mf+ZmlDvpvWhRybv3tXdSzc0mU0xmkuydYCMSRTKjpC2S7
 1ur2xSNDNUps91n9687lfEzGL7gBYqKs1rGKV6w4vzboC+aBsVwDQJvDlFO8yaevnZg6F3L
 dts9KT8EtSQoTLmuaHLgcPOyHxsvlGJ0O3Enfh/9rGKA8nVHUlqbeI4TrnthzJCMQnn7PC7
 Aju3/tXmAZgbc4H1Fx9JA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UnS0Tvw0+OM=:S3tk10j7aZf1ULEl2Q2Vrg
 WoGCqr83SD2/kkXMIRiL/54a7a+4YOqvPsb88huScV6wIbDSiqzJYZWgRkig1CeD9mCVN1Hum
 nUsQ0brQ55Dpgrn4f1+Ytap1q7lSKNkaC+dyMbUXseQmrAMfmOP5uW8GikpkXo+BkqDie4fm/
 RRqV3s/vL/vcnDZsTLEHPXWmrF7FXotnRlsauHUo6j4yIsxnJ5jcuKbXl4o77jUV7VJ0Prv83
 add3fQW2BqkYTNhm+s6yT7TImEeE+AvIjo5+FVlX1xKzD+RJhOkDnT71stdurkJDwTo7JjQE2
 JS/oOZyXZPm9EK7JUdxHabIjekP6zHkxzMPCRRM0+UDqHJZvr+4TBgsFlzrplJg3RX3uoVbKq
 dxV8HQMt0wP32LTLDlvdURp/0wUWzqKFgUspRl+Es3pq9t7P5tWeV1EKqz21HQdou74J7sT1t
 RDQVldscZkTnDQlBlS437ARdongQ/u+AdT7Rc2SKI3YJtQt69F46
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Tue, 23 Mar 2021 12:17:20 -0000

On Mar 23 20:57, Takashi Yano via Cygwin-patches wrote:
> Corinna Vinschen wrote:
> > > > On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
> > > > > > And also, following cygwin apps/dlls call GetStdHandle():
> > > > > > ccmake.exe
> > > > > > cmake.exe
> > > > > > cpack.exe
> > > > > > ctest.exe
> > > > > > run.exe
> > 
> > run creates its own conin/conout handles to create a hidden console.
> > The code calling GetStdHandle() is only for debug purposes and never
> > built into the executable.

Sorry, but this was utterly wrong.  run calls GetStdHandle, then
overwrites the handles, but only if it doesn't already is attached to a
console.

> > Looks right to me.  If we patch cmake to do the right thing, do we still
> > need this patch, Takashi?
> 
> I don't think so. If all is well with current code, nothing to be fixed.

How do you evaluate this in light of the run behaviour above?


Thanks,
Corinna
