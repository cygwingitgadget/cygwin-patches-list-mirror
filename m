Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id 0E6F43844007
 for <cygwin-patches@cygwin.com>; Thu, 27 May 2021 19:08:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0E6F43844007
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1ML9ds-1m3K1S2ICY-00ICph for <cygwin-patches@cygwin.com>; Thu, 27 May 2021
 21:08:32 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E3A2BA8065C; Thu, 27 May 2021 21:08:31 +0200 (CEST)
Date: Thu, 27 May 2021 21:08:31 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
Message-ID: <YK/uL8Y6vR5opKSM@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
 <YKalBKpjhBx6mZBg@calimero.vinschen.de>
 <2c57cf3a-ed8f-f3e8-d3bc-a4c5dbe8edaf@dronecode.org.uk>
 <0d7d66f2-48f6-684d-946a-f05d07b329c3@dronecode.org.uk>
 <YK4PIlepWXUOiCHb@calimero.vinschen.de>
 <104966fe-2e78-c28f-dcbe-53af7221f117@dronecode.org.uk>
 <b3286aea4562bbd9b705060b44892c8fbc3e4a2c.camel@cygwin.com>
 <YK6fCkQurJr8KEPq@calimero.vinschen.de>
 <967c6083-0ce3-2325-c4de-0e707dbde55b@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <967c6083-0ce3-2325-c4de-0e707dbde55b@dronecode.org.uk>
X-Provags-ID: V03:K1:mcJY2Xbhz9LG4Ll7QfMY6ZvexYMSqKm7Uk/1U++DMpC6EzdzV1Y
 OpFpUpb7rwrg1eqwlLoCHHR9MclYSAnF2xnGjQYycjEa/uPwhKl6t58G/8guh5dkceZ6zzO
 s96fJStRWN5dGRY+eUzVIg3YPSf2u3wVmj7v+5gPFlzHdPIuwM2iLGTEOmvIO4mIoeZgAIW
 TC6eUEYc4XiB0IdMTHq3w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JHqas+3sOH8=:jZMC7bo+LYV9fmlBIXA5I7
 ICfMnda3wzDE3Ae3C2SuLTwn3JM+74UTJfRn5fwEIEnJ97ZFX9Pem8m+auPAJwXSzGN3zZLZ6
 3GFDWQOPm0VdPK7lBSZA2HL0EKH8GwuemGQONaGoNUfUUaYrHFuih+MDhVK4Xlmm09xu78ciQ
 XJbescAU9sO4UOMyZtlJuD+KMBxgokytl8tEuh9GQqS7uNj7g2ZD1BJYc1hhlXbb3n7YeJ6W8
 VQplwACrjdKAC7gs/fmI7pLO0jn+gdZnmuKH9rdWjSbwyf+agUEmaN63+vrmsfZ+rtXUUrrtl
 gFuO48vdqAoHIVR+AJnWtLxBylAFuvmX47A6ofJT3rBquAY5BTP2WBV9/Cw5eRMiGzcOBeI7E
 kHs17QtLWLQhGUjjgSMU3OoXdKHG3BWOCix7die0rSSgkSxQOniGbGLeTa6bfe+runZMZO1H6
 foSPRTxYtZlD5T6snJJwI9I/9pMvHbRZRsmNXynXvTV02dY40yg3nGv8RXpIOTGrZgp4SG9qQ
 FCuCYEs4W+e7M34QledlaI=
X-Spam-Status: No, score=-100.1 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_NONE, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 27 May 2021 19:08:37 -0000

On May 27 18:30, Jon Turney wrote:
> On 26/05/2021 20:18, Corinna Vinschen wrote:
> > On May 26 13:04, Yaakov Selkowitz wrote:
> > > On Wed, 2021-05-26 at 17:51 +0100, Jon Turney wrote:
> > > > On 26/05/2021 10:04, Corinna Vinschen wrote:
> > > > > On May 25 22:37, Jon Turney wrote:
> > > > > > On 22/05/2021 16:08, Jon Turney wrote:
> > > > > > > On 20/05/2021 19:05, Corinna Vinschen wrote:
> > > > > > > > Hi Jon,
> > > > > > > > 
> > > > > > > > On May 20 18:46, Jon Turney wrote:
> > > > > > > > > The default PSAPI_VERSION is controlled by WIN32_WINNT, which we
> > > > > > > > > set to
> > > > > > > > > 0x0a00 when building ldd, which gets PSAPI_VERSION=2.
> > > > > > 
> > > > > > In the just released w32api 9.0.0, _WIN32_WINNT is now set to 0xa00 by
> > > > > > default, so this issue is probably going to surface in a few other
> > > > > > places as
> > > > > > well.
> > > > > 
> > > > > I added _WIN32_WINNT and NTDDI_VERSION settings to make sure we notice
> > > > > any problems right away.
> > > > 
> > > > I'm not sure what the mechanism by which we're going to notice is?
> > 
> > Build problems?
> 
> :confused:
> 
> This is a run time problem, not a build time problem.
> 
> #define WIN32_WINNT=0x0a00 ->
> #define PSAPI_VERSION 2 ->
> #define GetModuleFileNameExA K32GetModuleFileNameExA ->
> The procedure entry point K32GetModuleFilenameExA could not be located in
> the dynamic link library kernel32.dll

I didn't mean PSAPI_VERSION above, but the _WIN32_WINNT setting in the first
place.  Changing them can lead to surprising results in terms of what's defined
and what isn't.  PSAPI_VERSION is the icing, of course.

> > > > Adding WIN32_WINNT=0x0a00 everywhere changes the meaning of '#include
> > > > <psapi.h>' in a way that is incompatible with Vista.
> > 
> > Isn't that easily fixed by adding PSAPI_VERSION=1 prior to including
> > psapi.h?  We can add that to the Makefile as well...

What about this?

> > > > So this has broken dumper, and possibly other utils, on Vista.
> > > > 
> > > > I don't know if there are any other imports in other header which also
> > > > have this annoying behaviour...
> > 
> > I think the psapi stuff is the only one changing their imports.
> > 
> > > Does Vista REALLY still need to be supported at this point?
> > 
> > It's probably not much of a problem but per the latest statistics
> > we still have... uhm... about 4 Vista users...
> 
> '4 users running setup per week' != '4 users'

That was a joke :)


Corinna
