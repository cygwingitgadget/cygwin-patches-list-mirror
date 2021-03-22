Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 3D185385801D
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 11:43:39 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3D185385801D
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MrQMz-1m3kBq1iCd-00oakH; Mon, 22 Mar 2021 12:43:37 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BCCCCA80D44; Mon, 22 Mar 2021 12:43:36 +0100 (CET)
Date: Mon, 22 Mar 2021 12:43:36 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Marco Atzeri <marco.atzeri@gmail.com>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
X-Provags-ID: V03:K1:SPNsI/wPEW/eQF5TiohvbSMWv1KWsPZU2AF11X84tR7SUCldCee
 tgmRa4+XgusIjm/SE1IAtjike3GS7KDiC8hNeW1nGaaLLS/UbJMyVZ45b+ohMpJ986p0yVb
 kW+icGYHKOreImAV0bF9hPomWZQNsNJQo1Wq7ABLyHmvc3Cx92XJHbnnOJ/d4x+OjkX9CKV
 YfoBGb+xFaApmhefjjRhg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9CmOH5RucOQ=:rQCADIpgoJAb6rDnxh8AkL
 iWbyc4LpkSoli3kOaLTeSoa0gqRo1YyHzaQ0tdpii6MhefYZyD6KAYgr7YLFLDtc3jBowuBLA
 bQQdBVwnYfN4mEOvRIbCkGK+dA1rDkhLV+zsAJQGgC00RWkn89DEkyv2EWYyFPnByYrfjGA15
 zvllrLoZTDn7eYcE+Kp1qr8PNihLMKraMfTHc3KqfFLQ9ChkRvzjKjQU6IX5WbEud8RPD3I6S
 nAQ8KShBz42Ffgb2Y5n/CYNM4RFvTy2ZHpH9wo+Si7Q0DweAZcRD4jf1AJ2s10C6xHAF2YbCC
 yEMhNW2DA2AFIO9k4NJ9AP1Pcs5yjSG8OrMZYCnlgb3Pb7hKzwkwwllCibaX6kToTiCHS96XK
 0ky/GpzNzxa1EfsXsDk/13l/Yk07KWn7TFmr0MtWJ2kysHuDHlOwlm0h41Ylhc3PMeU0bNVnP
 cdwGpOIO0A==
X-Spam-Status: No, score=-101.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 22 Mar 2021 11:43:40 -0000

[CC Marco]

On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
> On Sun, 21 Mar 2021 17:44:27 +0900
> Takashi Yano wrote:
> > On Sun, 21 Mar 2021 13:01:24 +0900
> > Takashi Yano wrote:
> > > Takashi Yano (2):
> > >   Cygwin: syscalls.cc: Make _get_osfhandle() return appropriate handle.
> > >   Cygwin: pty: Add hook for GetStdHandle() to return appropriate handle.
> > > 
> > >  winsup/cygwin/fhandler_tty.cc | 19 +++++++++++++++++++
> > >  winsup/cygwin/syscalls.cc     | 13 ++++++++++++-
> > >  2 files changed, 31 insertions(+), 1 deletion(-)
> > 
> > I submitted these patches, however, I still wonder if we really
> > need these patches. I cannot imagine the situation where handle
> > itself is needed rather than file descriptor.
> > 
> > However, following cygwin apps/dlls call _get_osfhandle():
> > ccmake.exe
> > cmake.exe
> > cpack.exe
> > ctest.exe
> > ddrescue.exe
> > 
> > And also, following cygwin apps/dlls call GetStdHandle():
> > ccmake.exe
> > cmake.exe
> > cpack.exe
> > ctest.exe
> > run.exe
> > cygusb0.dll
> > tk86.dll
> > 
> > in my installation.
> > 
> > Therefore, some of these apps/dlls may need these patches...
> 
> I looked into cmake source and found the patch exactly for
> this issue. Therefore, it seems better to fix this. 
> 
> /* Get the Windows handle for a FILE stream.  */
> static HANDLE kwsysTerminalGetStreamHandle(FILE* stream)
> {
>   /* Get the C-library file descriptor from the stream.  */
>   int fd = fileno(stream);
> 
> #  if defined(__CYGWIN__)
>   /* Cygwin seems to have an extra pipe level.  If the file descriptor
>      corresponds to stdout or stderr then obtain the matching windows
>      handle directly.  */
>   if (fd == fileno(stdout)) {
>     return GetStdHandle(STD_OUTPUT_HANDLE);
>   } else if (fd == fileno(stderr)) {
>     return GetStdHandle(STD_ERROR_HANDLE);
>   }
> #  endif
> 
>   /* Get the underlying Windows handle for the descriptor.  */
>   return (HANDLE)_get_osfhandle(fd);
> }

Why on earth is cmake using Windows functions on Cygwin at all???
It's not as if it actually requires Windows functionality on our
platform.

Marco, any input?  Any chance to drop this Windows stuff from the Cygwin
code path in cmake?


Thanks,
Corinna
