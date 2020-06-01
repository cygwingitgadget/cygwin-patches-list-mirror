Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id B901E3851C08
 for <cygwin-patches@cygwin.com>; Mon,  1 Jun 2020 08:59:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B901E3851C08
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1Mirb8-1j0rso1Hgi-00etZ7 for <cygwin-patches@cygwin.com>; Mon, 01 Jun 2020
 10:59:10 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id A1EA7A8100A; Mon,  1 Jun 2020 10:59:09 +0200 (CEST)
Date: Mon, 1 Jun 2020 10:59:09 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Fix screen distortion after using less for
 native apps.
Message-ID: <20200601085909.GA6801@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200601061618.893-1-takashi.yano@nifty.ne.jp>
 <20200601152115.3b5492035b186072ea6ead5c@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200601152115.3b5492035b186072ea6ead5c@nifty.ne.jp>
X-Provags-ID: V03:K1:U38JDSLHkFbd1zSkYudll/qRx7qrX8IVceVR7hQis5xq37vpeTh
 BxLSnnz6yhmvlQvtdWyt89sqM8AoWwcUZlIJUCap7aMrec5XOeMwLbxbS/BZm8Vdd4uy6L2
 UqQCH0RrLffYKY6ARIq2J9INPiKbHnpzvvFS/aQA5xDdM404Y3PVRn/+WBe/c3mG4u5UWCA
 3X6jQoIk9ubWTCLISUFvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eh0GDxb8Tdg=:AeZCX7RMoJ6KpdB+Gz+hjg
 9iRzF8KML+orCqrSwzxXYZ7njbKfQGJAo6nCM/B6uiO9FRTDh2jERnCfZItNQ31ZQVMLrtFtW
 apUUPaG36lC9noAxjNDqOSZ/O+OI7CIULj81UIEa4erL0siBR/7OPjRc1uJAkgYPCBMCMWr3i
 IfY2PgRFFP/RRMELGMz5uQxatA1A2Ad4h5Ild8i0GeckyoMvGvV/IKP+guV7/Oqjt0CXYTYrC
 /5AQnTcMkVEngL0oIoPGRu3vc4y1+P7MXCSdatHx3LOkkHG8R1mVk+nGVarAIDEFmS+weQn5Q
 aBzwIP1oo6SfE/c/5jKrbjXwc1/OiKVP1z+6EfHnZAurmIWrlkGs2zrg6Uu4Ior030ydDeSEm
 KC9ssYbFE22NtOCq8LN7D4/8sJEXg2qBjSXw4VN+ZXypglzXj0xpdyPXh319IcvpRTOdtxAKe
 qp2D7XFRG5Zl6mHGXfHZ+QDeGqK2RTBbEBzI3dMxB6v1vx+FI3aq6XBCpifcNMcH6u1r9AE7u
 VAcUJ4D0/RA3rnFYhYZtgiDJZu09B8rGgxlettOJao0V6nSavOKiwF2XtS1ZkGHQsSLETWI77
 y4U1uO1Ya+Z8on58QEh7jazpHv+khTcczHT2Io7sDkwo0XrfX8gz54muEok5/W6EnbX+iw5pN
 lulm9YzwWwfHkL01audhPFX/LClL6eS3yMrcW66Eb2T9bdYrOAqpL7uUOqOX8fawh5Uwy5+Fz
 nQ7fICRbJlRVeWJs+Ored5dvIeeeocBb/2wrC3cuWFjFj11LFCw2j90gCkyqQRWGdvxTPMSwE
 HKphNahNix0mdFuwF5LJA6mJr11tmCfY2qA+83/RG1Ql90E5iUbWCEUgOybwyiuu1eHF2v8
X-Spam-Status: No, score=-99.1 required=5.0 tests=BAYES_00,
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
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 01 Jun 2020 08:59:13 -0000

On Jun  1 15:21, Takashi Yano via Cygwin-patches wrote:
> Hi Corinna,
> 
> On Mon,  1 Jun 2020 15:16:18 +0900
> Takashi Yano <takashi.yano@nifty.ne.jp> wrote:
> > - If the output of non-cygwin apps is browsed using less, screen is
> >   ocasionally distorted after less exits. This frequently happens
> >   if cmd.exe is executed after less. This patch fixes the issue.
> 
> I have submitted this patch, but it's up to you to decide whether
> to include it in the cygwin 3.1.5 release.
> 
> I apologize again for the submission at the very last minute.

No worries, pushed.  I marked this as the 3.1.5 release and will
release it today.


Thanks,
Corinna

-- 
Corinna Vinschen
Cygwin Maintainer
