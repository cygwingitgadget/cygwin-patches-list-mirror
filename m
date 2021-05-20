Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 35184385E44B
 for <cygwin-patches@cygwin.com>; Thu, 20 May 2021 07:17:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 35184385E44B
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MyKYE-1lXjt911G0-00ydHm for <cygwin-patches@cygwin.com>; Thu, 20 May 2021
 09:17:31 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 96C6BA82BED; Thu, 20 May 2021 09:17:30 +0200 (CEST)
Date: Thu, 20 May 2021 09:17:30 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] FAST_CWD warnings on ARM64 insider preview
Message-ID: <YKYNCkVLFY75At7L@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <alpine.BSO.2.21.2105181151200.14962@resin.csoft.net>
 <YKTfJ2kVCsV+yT3g@calimero.vinschen.de>
 <alpine.BSO.2.21.2105191040270.14962@resin.csoft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.BSO.2.21.2105191040270.14962@resin.csoft.net>
X-Provags-ID: V03:K1:UBmOTQsQIZPVpqGx1Y2HNjm9bjye4R9pcytKML9M3fjiACO1GCB
 hYFcrvX9NsNnpHbVxur6E6r3X8C8vxP5ZlBl0+spPFb+pqdT5m6EB3Sdcov5BHEbYxuBlZl
 e0qNBmP8UXMR2uoASLGc2KD2yb12ZOF7MFq+iiMuXRoZh0GEHe3ARbEskybETxq5zbe4qio
 G+Lw9HEwBQOnzPZQvcCSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MX4pSKwS/J8=:HL6E8wclc9YVFwQ1aXcbz2
 i/YmUavJotjvL/pMkskFQpzPIs50nGGJdBBPlWgSLN2ISiLNH3jE7kG+ea8GdmzfmqECLjtql
 1lh18ieDQtjZSEstLQuVjIjGSvS17AIL6VXrF3SIdWw2iJkV6l2/wDVpMMcS6cMt5ZSgRvdBk
 qEklgAhL1X6EAZmFh6tVDUl8wUWJOwsCYt7bXuiMT3/YGmaRBfmCfwjZzr+2uzn5w8FTSoS0Y
 3YlpiM6FUDi/hp8wIzx87UE+vwS7LTrOi/fFQaoe+HCej4L7wi5+BSjugPA6vAf1VMoiJYhxm
 VpJmjqxsqiiO0FgEMBbB4UFZrh6AKKaUQ1nA3DaWIk+fTppkYl97Pepzorcmltc9P9W44tflW
 7ykmRFEzHwGzTpRswWTSU29HdFu2UCnM8omdThc0LttIE0o6OMzxlhJSlFsgEaipaOAPcfEYq
 X/FmChIuYW1Anu8BuhNKMvjXtcO3M1G/ty9HHQJuGOvZ+EWWv5uNQ3oYJstheH70Cpc8mXdV6
 Wjn+daXrfDgagsqX8tflBY=
X-Spam-Status: No, score=-100.4 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Thu, 20 May 2021 07:17:34 -0000

On May 19 11:02, Jeremy Drake via Cygwin-patches wrote:
> On Wed, 19 May 2021, Corinna Vinschen wrote:
> 
> > > +#ifndef IMAGE_FILE_MACHINE_ARM64
> > > +#define IMAGE_FILE_MACHINE_ARM64 0xAA64
> > > +#endif
> >
> > IMAGE_FILE_MACHINE_ARM64 is already defined for some time in winnt.h
> > so we won't need the ifdef.
> 
> OK.  Was just matching what was done with PROCESSOR_ARCHITECTURE_ARM64.
> 
> > > +      typedef BOOL (WINAPI * IsWow64Process2_t)(HANDLE hProcess, USHORT *pProcessMachine, USHORT *pNativeMachine);
> > > +      IsWow64Process2_t pfnIsWow64Process2 = (IsWow64Process2_t)GetProcAddress(GetModuleHandle("kernel32.dll"), "IsWow64Process2");
> > > +      if (pfnIsWow64Process2 && pfnIsWow64Process2(GetCurrentProcess(), &procmachine, &nativemachine) && nativemachine == IMAGE_FILE_MACHINE_ARM64)
> >
> > We're having the autoload mechanism for that, i. e., your patch can get
> > rid of the GetModuleHandle/GetProcAddress preliminaries entirely.
> >
> > By using the LoadDLLfuncEx() expression, failure to load the function
> > will result in a return value of FALSE with GetLastError ==
> > ERROR_PROC_NOT_FOUND, so this is safe on older systems.
> 
> Nice.
> 
> > It's easier to understand with a full example, so I took the liberty to
> > rewrite your patch accordingly.  Since the idea and the basic work is
> > yours, I'd push this under your name, see below.
> 
> Looks good.  Thanks

Pushed.

Thanks,
Corinna
