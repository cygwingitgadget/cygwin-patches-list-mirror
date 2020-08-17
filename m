Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id EF3443858D37
 for <cygwin-patches@cygwin.com>; Mon, 17 Aug 2020 09:16:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org EF3443858D37
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N3bb1-1kpQIP2Jhz-010ejn for <cygwin-patches@cygwin.com>; Mon, 17 Aug 2020
 11:16:22 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id D5279A806A2; Mon, 17 Aug 2020 11:16:21 +0200 (CEST)
Date: Mon, 17 Aug 2020 11:16:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Change the timing of set_locale() call again.
Message-ID: <20200817091621.GA3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200815032352.283-1-takashi.yano@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200815032352.283-1-takashi.yano@nifty.ne.jp>
X-Provags-ID: V03:K1:eEyraFNiimVvZJ2mG/6h2r1v/oNiHP+hyrur90OEUbGOB+oCPSE
 F5FG8Qn2QaC6CoN757ZO/U1B/EMoL+VJ57RcrXFP97nZcZW8/ooCUD+ShMeU3HfBkzF+SNw
 UEQ4/E3iOj9HdEtToDxm4m4lekXdF0BiK6rNxWgkFVYLYXAMYQTPYStnkQhD823+fOPFzeq
 AEA0zHV+fEDhNfwFH8vZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HiV/BLNqGfU=:Vj+yPmCkaM3pMSvqvidSxU
 2clUuwNPt8FAPOa/vZ5u2Uj1gzrUanp/aTTNEy1evhh/6j5aj15DezHHcnG4fmhUMzSv4Vsc0
 B3lIeswxUJzMvTN3y+y9aEtBWP7Z1s0FjwMN24nTp/XUBf6c3uC2qHH0qEvOcba1LIvmyln4p
 bXNOaI3dTuq60U0iHLH2uMeSO0RGtmf+YXOiG6Q7sZnwjaIR14AtpWxS2R+QGC/3FNCN3YOvf
 bH0Z28c1JxZare5y/lfFo5iYH2umsVAaTJ/q2L5d0XErfbvcZWObJqWvshtDx+JfnPdg0rscB
 LQ1+/0yF/OFyHfvKOvQK7zJiepbdGFWhpiVEDDnJo/z5YW+XJMM37HEV6TLwP64dXiJnbsQl5
 HAKEgIc9RPPx5FFZP7O4kFtT/XER3ed/73cvoGw3HwuGxzZfZa+6BlLkMWZSdlbRWpcoXI37K
 DCbasyhD/pAiZ/b39DHH7Pckmw/vBY0blKn2c8z7o/U4ywDT2X79UVG/IV43w9sgjU1aViz1E
 hGw0xBwFzi04RL0j58zflurbbGlAYSh9hylQvJN6Q2qvh7XLNFQg+9xwXNsbEdXLiyLa7XxMy
 y+RRFzKAgFLkpgIN+O0CQWc8df/kEqcyHB8HLLj430Zumeni2WqDlwcsKsew82yR+QYNZMQ9I
 diIdqVFeJPNNVTfTKJXudfdfTAx64TuLkDlv34qbj2JRNVHuwEKRyK7fPK9aFOixiCaJyj3xF
 aooWhgrx9Et+j/i7tyWNBXbDK5RZlXfrhwBf9/Rn+zsyqRN5Lo9v8UdyIfyt32J3WHGzpnTg+
 voiVctXcK7tnwhd2qaDTBwuso5GI+W99hCk0tBjYnTNSsvYPBnKhWchBgMugqnyA8Bju7oe0z
 oNc2kX6HMI7/VjSAi+FA==
X-Spam-Status: No, score=-99.7 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Mon, 17 Aug 2020 09:16:25 -0000

On Aug 15 12:23, Takashi Yano via Cygwin-patches wrote:
> - After commit 095972ce5b1d319915501a7e381802914bed790c, charset
>   conversion in mintty is broken if charset is set to other than
>   UTF-8. This seems to be caused because mintty does not set locale
>   yet at fork() call. This patch changes the timing of set_locale()
>   call again to avoid this issue.
> ---
>  winsup/cygwin/fhandler_tty.cc | 10 ++++++----
>  winsup/cygwin/spawn.cc        | 12 ++++++++++++
>  2 files changed, 18 insertions(+), 4 deletions(-)

Pushed.


Thanks,
Corinna
