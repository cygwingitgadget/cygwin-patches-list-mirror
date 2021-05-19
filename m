Return-Path: <cygwin@jdrake.com>
Received: from mail231.csoft.net (mail231.csoft.net [96.47.74.235])
 by sourceware.org (Postfix) with ESMTPS id 4177F386FC11
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 18:02:09 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4177F386FC11
Received: from mail231.csoft.net (localhost [127.0.0.1])
 by mail231.csoft.net (Postfix) with ESMTP id C5A94CB6D
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 14:02:08 -0400 (EDT)
Received: from mail231 (mail231 [96.47.74.235])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested) (Authenticated sender: jeremyd)
 by mail231.csoft.net (Postfix) with ESMTPSA id B5A3FCB64
 for <cygwin-patches@cygwin.com>; Wed, 19 May 2021 14:02:08 -0400 (EDT)
Date: Wed, 19 May 2021 11:02:08 -0700 (PDT)
From: Jeremy Drake <cygwin@jdrake.com>
X-X-Sender: jeremyd@resin.csoft.net
To: cygwin-patches@cygwin.com
Subject: Re: [RFC] FAST_CWD warnings on ARM64 insider preview
In-Reply-To: <YKTfJ2kVCsV+yT3g@calimero.vinschen.de>
Message-ID: <alpine.BSO.2.21.2105191040270.14962@resin.csoft.net>
References: <alpine.BSO.2.21.2105181151200.14962@resin.csoft.net>
 <YKTfJ2kVCsV+yT3g@calimero.vinschen.de>
User-Agent: Alpine 2.21 (BSO 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, RCVD_IN_DNSWL_LOW, SPF_HELO_PASS,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Wed, 19 May 2021 18:02:10 -0000

On Wed, 19 May 2021, Corinna Vinschen wrote:

> > +#ifndef IMAGE_FILE_MACHINE_ARM64
> > +#define IMAGE_FILE_MACHINE_ARM64 0xAA64
> > +#endif
>
> IMAGE_FILE_MACHINE_ARM64 is already defined for some time in winnt.h
> so we won't need the ifdef.

OK.  Was just matching what was done with PROCESSOR_ARCHITECTURE_ARM64.

> > +      typedef BOOL (WINAPI * IsWow64Process2_t)(HANDLE hProcess, USHORT *pProcessMachine, USHORT *pNativeMachine);
> > +      IsWow64Process2_t pfnIsWow64Process2 = (IsWow64Process2_t)GetProcAddress(GetModuleHandle("kernel32.dll"), "IsWow64Process2");
> > +      if (pfnIsWow64Process2 && pfnIsWow64Process2(GetCurrentProcess(), &procmachine, &nativemachine) && nativemachine == IMAGE_FILE_MACHINE_ARM64)
>
> We're having the autoload mechanism for that, i. e., your patch can get
> rid of the GetModuleHandle/GetProcAddress preliminaries entirely.
>
> By using the LoadDLLfuncEx() expression, failure to load the function
> will result in a return value of FALSE with GetLastError ==
> ERROR_PROC_NOT_FOUND, so this is safe on older systems.

Nice.

> It's easier to understand with a full example, so I took the liberty to
> rewrite your patch accordingly.  Since the idea and the basic work is
> yours, I'd push this under your name, see below.

Looks good.  Thanks
