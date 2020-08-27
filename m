Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id D9C63386F43F
 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020 09:05:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D9C63386F43F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([217.91.18.234]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MI41P-1kMRC42Rr5-00FDP6 for <cygwin-patches@cygwin.com>; Thu, 27 Aug 2020
 11:05:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 267ACA83A77; Thu, 27 Aug 2020 11:05:35 +0200 (CEST)
Date: Thu, 27 Aug 2020 11:05:35 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: pty: Disable pseudo console if TERM is dumb or
 not set.
Message-ID: <20200827090535.GB3272@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20200826120015.1188-1-takashi.yano@nifty.ne.jp>
 <20200826173606.GP3272@calimero.vinschen.de>
 <20200827130720.f9f618c1313e18848a995f8c@nifty.ne.jp>
 <20200827084756.GU3272@calimero.vinschen.de>
 <20200827175948.e814342d1dd56e69e3c77c58@nifty.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200827175948.e814342d1dd56e69e3c77c58@nifty.ne.jp>
X-Provags-ID: V03:K1:TNz/svnyICWtNj55WwH433lEtpH9PWUBViTUQLdeqQDsULJ8Byh
 FmMY6XI/qVsZZhXGx4e1El4kFYvppSDgr9KnfA2fo1AVd3NXtzyZxJ7AHw4uNefSFxtgX58
 v39HSGzmWE0u+j8qmenzhMhxzRD7q9NRJS3VK8nsgShCwN5kYljN+wLha4vS+kOLjS/vXXd
 cOGXVrWdVbewDO7GAe/fA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fenID6/+Yuk=:uRHdF9dgf/YyR5fm9xLLwI
 SeT6l/ZXaKntqTtYexbySKsYFkwQgeM5OMD+t/RQ1igKNoUvA8hlNj5hxQGVwXjJi1BoS/jdU
 SgijmhpZdC0Xd31Yyq2kUuV1BdlwLrrXSsiSDwcx5UHc/U0n10fuPSlDwY33BsYAE3HcgCgLS
 mE5ScOr+njOSP08YqZlW2Qare22bEAtHOUjZLe4BB/4M58bxrjNbk0LYIlE3uitw1LJBDFuVd
 s1DX7Kg1Xa1BmUy96hwgLurOLEMCQI420RUOh3Amh0x4csUD0CscewhpRv0b87EF1LXrz8lEY
 bk7nIo/0U/Ez6x1uZHQEokBunUiiMKU0/7SyKjGLFflNEG9WU3fgnEGtdspiH3Cv3oScfYEfc
 JXz+IgxzEmJlacvPU3iXnfg2FhUIh2VuYqBRzsJLhljRnH5mWS6ivRZ/nB71GOCT9ETXCZTG0
 lKxZXOZeF1jj+7AvkrPXRqkZDFuTGs3LO/gPZpHiVBmaP8OK67kTdUnBKw1qaZuIZ3/uwDDig
 YzbVAfkClmrbgrl/wzOeSxLHzbwrYyqeBKjsMPLLJZBIGrLP4ekq+UNrJSXcQx37oSu/cfOtM
 RF80gPpvVeOcv1eEO0XTAnT75GvPohLgdL0mvLxSZsscZebdn4c2R5M1TwIOkvGLfbKMntRfH
 IBMPqkV5sEON/3BLsecr+IVQOtAbogGDg2HcT1GIJWTck3SG1dEqdlPnYEqe15d2aK+hmo8bQ
 WotzfLh+wtrFw9XzQGWQfhFtGioavcAw4p9bwRQ8zp8BgZ1hQ6RHxkCF980sracDVoKEg+riG
 L7/cjnWmvIFHb51SNo/RUrcjsX5Uxw8oyiCJJUH8AnDzSPMnPk0AuxrFlQbMBzth3R9dAyi+i
 aubtFZTjsJoTJWcT+alA==
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 27 Aug 2020 09:05:39 -0000

On Aug 27 17:59, Takashi Yano via Cygwin-patches wrote:
> On Thu, 27 Aug 2020 10:47:56 +0200
> Corinna Vinschen wrote:
> > On Aug 27 13:07, Takashi Yano via Cygwin-patches wrote:
> > > On Wed, 26 Aug 2020 19:36:06 +0200
> > > Corinna Vinschen wrote:
> > > > On Aug 26 21:00, Takashi Yano via Cygwin-patches wrote:
> > > > > Pseudo console generates escape sequences on execution of non-cygwin
> > > > > apps.  If the terminal does not support escape sequence, output will
> > > > > be garbled. This patch prevents garbled output in dumb terminal by
> > > > > disabling pseudo console.
> > > > 
> > > > I'm a bit puzzled by this patch.  We had code handling emacs and dumb
> > > > terminals explicitely in the early forms of the first incarnation of
> > > > the pseudo tty code, but fortunately you found a way to handle this
> > > > without hardcoding terminal types into Cygwin.  Why do you think we
> > > > have to do this now?
> > > 
> > > What previously disccussed was the problem that the clearing
> > > screen at pty startup displays garbage (^[[H^[[2J) in emacs.
> > > Finally, this was settled by eliminating clear-screen and
> > > triggering redraw-screen instead at the first execution of
> > > non-cygwin app.
> > > 
> > > However, the problem reported in
> > > https://cygwin.com/pipermail/cygwin/2020-August/245983.html
> > > still remains. 
> > > 
> > > What's worse in the new implementation, pseudo console sends
> > > ESC[6n (querying cursor position) internally on startup and
> > > waits for a response. This causes hang if pseudo console is
> > > started in dumb terminal.
> > > 
> > > This patch is for fixing this issue.
> > 
> > Would it be feasible to implement this using a timeout instead?
> > If the response isn't sent within, say, 100ms, just skip it?
> 
> Hang is caused at CreateProcessW() call, so there is no way to
> use time out. It is possible to send ESC[6n before creating
> pseudo console for a test and wait for responce with timeout,
> however, if the terminal is dumb, garbage ^[[6n will be displayed.

Doesn't sound so great either.  That would slow down process
startup on dumb terminal a lot, right?

Ok, if you don't see any other way to fix that, I'll push that patch
in a while.


Thanks,
Corinna
