Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id B3D5A385BF9E
 for <cygwin-patches@cygwin.com>; Tue, 23 Mar 2021 10:10:07 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org B3D5A385BF9E
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBDvU-1lWqNX2VJe-00Ckzy; Tue, 23 Mar 2021 11:10:05 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E18CAA80DBA; Tue, 23 Mar 2021 11:10:04 +0100 (CET)
Date: Tue, 23 Mar 2021 11:10:04 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Cc: Marco Atzeri <marco.atzeri@gmail.com>,
 Jan Nijtmans <jan.nijtmans@gmail.com>
Subject: Re: [PATCH 0/2] Return appropriate handle by _get_osfhandle() and
 GetStdHandle().
Message-ID: <YFm+fEONY3wLq3Sp@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com,
 Marco Atzeri <marco.atzeri@gmail.com>,
 Jan Nijtmans <jan.nijtmans@gmail.com>
References: <20210321040126.1720-1-takashi.yano@nifty.ne.jp>
 <20210321174427.cf79e39deeea896583caa48c@nifty.ne.jp>
 <20210322080738.6841d7f2a1e09290a929ad90@nifty.ne.jp>
 <YFiC6FXrnGeW8v1M@calimero.vinschen.de>
 <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <58c7be6c-42db-cc09-9f89-461ac7c87747@cornell.edu>
X-Provags-ID: V03:K1:dR3DJ1WdznLzK78NKpuaTUrQ7m4pOsPSNmoOPoz/jGegQaovv1c
 8Jt+2cY6/5v8aVVSN3XoPf6FhehE0bIQMxRClfCGn8IJtmSQqEG71wUfa9n16bfKlyXLqyu
 BW4BcljNaqZec5lM2mghBJlTnQJKl+jZ0JbXa0/sau2y7gTXnkY2q8yujSY4vHmJYxtGJp1
 mnFvXcZk/3JIuWzmTabAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D+Uq4PFmTcg=:dUY1H3+qnS+sf3Tz/TWprc
 LMuqgNEbYuokLD0U0OPSya9fhCwAC+bulriB5IrrDwZaunwyltIh8nz6FAi5Sxs7edTZxN3UC
 WICbxoqGESn3Uqxvie1AteaarlBPHOOhWLZ5pKDib7MqHQ9kfltV5ZXwb4Xl5ualTW7PEDaf8
 /Ikt2c5oxJNOyNHECs72iK3hw1RqclntrBYuHeu+nv76Cdewe8Uqgo2qGw91OaZ+1WtEVqnJb
 sxCK2F+MpMpPP4D0Cw/hXDScBdJwDZVXgfQH4uOI6w4ykog81MKXWrqDxG5fjCzn6bpKitgtm
 zwGicZ3tAn/3snNrnztGYXfyQlx3hgc/ZqlAs5F+fcq49ee/WZuVDb5/B5T/bffiq53bmm5wr
 HCdFM8K7dMJlxX4qapBc2vlcd5ax/h7qvV0jRey/XHdOzhdBWrE8RSJpIx24QSb8eHDipYXSk
 e74tuTuVFA==
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
X-List-Received-Date: Tue, 23 Mar 2021 10:10:09 -0000

[CC Marco, CC Jan]

On Mar 22 13:02, Ken Brown via Cygwin-patches wrote:
> [Still CC Marco]
> 
> On 3/22/2021 7:43 AM, Corinna Vinschen via Cygwin-patches wrote:
> > [CC Marco]
> > 
> > On Mar 22 08:07, Takashi Yano via Cygwin-patches wrote:
> > > On Sun, 21 Mar 2021 17:44:27 +0900
> > > Takashi Yano wrote:
> > > > [...]
> > > > However, following cygwin apps/dlls call _get_osfhandle():
> > > > ccmake.exe
> > > > cmake.exe
> > > > cpack.exe
> > > > ctest.exe
> > > > ddrescue.exe

I'm pretty sure ddrescue needs the osfhandle just to access raw block
devices.

> > > > And also, following cygwin apps/dlls call GetStdHandle():
> > > > ccmake.exe
> > > > cmake.exe
> > > > cpack.exe
> > > > ctest.exe
> > > > run.exe

run creates its own conin/conout handles to create a hidden console.
The code calling GetStdHandle() is only for debug purposes and never
built into the executable.

> > > > cygusb0.dll

This lib tries to access USB devices only.

> > > > tk86.dll

Not sure about this one.  In theory this shouldn't happen, given our
tk is built against X11, not against the Windows GUI.

Jan, can you please check where and why tk86.dll calls GetStdHandle.
I found a few places in the source where GetStdHandle is called, but
it's not clear to me which one is called.

> Out of curiosity, I took a quick glance at the cmake code.  It appears that
> this code is designed to support running cmake in a Console.  I don't think
> that should be needed any more, if it ever was.
> [...]
> I think the following might suffice (untested):
> 
> --- a/Source/kwsys/Terminal.c
> +++ b/Source/kwsys/Terminal.c
> @@ -10,7 +10,7 @@
>  #endif
> 
>  /* Configure support for this platform.  */
> -#if defined(_WIN32) || defined(__CYGWIN__)
> +#if defined(_WIN32)
>  #  define KWSYS_TERMINAL_SUPPORT_CONSOLE
>  #endif
>  #if !defined(_WIN32)

Looks right to me.  If we patch cmake to do the right thing, do we still
need this patch, Takashi?


Thanks,
Corinna
