Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 2B5F5386FC21
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 19:18:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 2B5F5386FC21
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M5xDJ-1lnsau2fIh-007Xln for <cygwin-patches@cygwin.com>; Wed, 26 May 2021
 21:18:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id AEF10A8065C; Wed, 26 May 2021 21:18:34 +0200 (CEST)
Date: Wed, 26 May 2021 21:18:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
Message-ID: <YK6fCkQurJr8KEPq@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
 <YKalBKpjhBx6mZBg@calimero.vinschen.de>
 <2c57cf3a-ed8f-f3e8-d3bc-a4c5dbe8edaf@dronecode.org.uk>
 <0d7d66f2-48f6-684d-946a-f05d07b329c3@dronecode.org.uk>
 <YK4PIlepWXUOiCHb@calimero.vinschen.de>
 <104966fe-2e78-c28f-dcbe-53af7221f117@dronecode.org.uk>
 <b3286aea4562bbd9b705060b44892c8fbc3e4a2c.camel@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b3286aea4562bbd9b705060b44892c8fbc3e4a2c.camel@cygwin.com>
X-Provags-ID: V03:K1:NN8Q01P2JhNpcP07ihM7tNYLg+PuCGshTtW5kSDt6tsVDrhygfc
 7fskF3yaDg/4uxRtqV8rPYwBclVmx4MSQhJE82DSdPLE0Vctiap6pC6cMXCJtdaeOR4ad+P
 LMS7ysG+Y4cyN48hmdbzcSUqn8Rx1BtMCC7+CAZEWUxdSc94ITjrzTCq999qO+YkosqmqDR
 7L5tK5hqMsbD92hvZKxIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nE0gemNu4Tk=:ZXA3ZoflSAEvV3Okprfluv
 2UVWfC9fSrznw90EkYlgw2JSM6P3Z1Jvf0Yu0DD3NMsnv0rMkmHTLT8llgRrptBmYX0aZKYa8
 5GUjwI4E9NLCqUjjVGAIpcPjPWGkb2pfwhKouNamJ8nAIM72PqKesuo81SWnQlGOspYI4r7ko
 o6q0+mVWnULCnNIoWaf/trUrRGfeJqCS1Dj73zMWXE8CASxbvSCuNcqB1FQy1FXNlMoY/ezUt
 zyjDLy9+5Ynpxbeh026+fYbUNw56NAhbugBWNCxCKsIVlt5HISgRqxUyolIdST4SQFWoGAQUb
 7tyxcGA+gWlhCOrbFNJvDm6/nLIUJNIs0+Oi15PrKhWOUsGjuKKK7vU4eZ32slxPbAo5yvTel
 Gm13I+HNue0/qGndPJVsP8nDWhZzUtAyunIaQNOmVpLyyPvDhWxrnnCozPz+3RyG2t6U2Oxfk
 UxzXmzeM11UkdfJqDYDNN9DPF3TmKAop9BrACS5PwZk0fufecblIy0uFFDxaRu3na5kFw+gEj
 ROuyDbVP9s2Gr+LSLfpil4=
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
X-List-Received-Date: Wed, 26 May 2021 19:18:41 -0000

On May 26 13:04, Yaakov Selkowitz wrote:
> On Wed, 2021-05-26 at 17:51 +0100, Jon Turney wrote:
> > On 26/05/2021 10:04, Corinna Vinschen wrote:
> > > On May 25 22:37, Jon Turney wrote:
> > > > On 22/05/2021 16:08, Jon Turney wrote:
> > > > > On 20/05/2021 19:05, Corinna Vinschen wrote:
> > > > > > Hi Jon,
> > > > > > 
> > > > > > On May 20 18:46, Jon Turney wrote:
> > > > > > > The default PSAPI_VERSION is controlled by WIN32_WINNT, which we
> > > > > > > set to
> > > > > > > 0x0a00 when building ldd, which gets PSAPI_VERSION=2.
> > > > 
> > > > In the just released w32api 9.0.0, _WIN32_WINNT is now set to 0xa00 by
> > > > default, so this issue is probably going to surface in a few other
> > > > places as
> > > > well.
> > > 
> > > I added _WIN32_WINNT and NTDDI_VERSION settings to make sure we notice
> > > any problems right away.
> > 
> > I'm not sure what the mechanism by which we're going to notice is?

Build problems?

> > Adding WIN32_WINNT=0x0a00 everywhere changes the meaning of '#include 
> > <psapi.h>' in a way that is incompatible with Vista.

Isn't that easily fixed by adding PSAPI_VERSION=1 prior to including
psapi.h?  We can add that to the Makefile as well...

> > So this has broken dumper, and possibly other utils, on Vista.
> > 
> > I don't know if there are any other imports in other header which also 
> > have this annoying behaviour...

I think the psapi stuff is the only one changing their imports.

> Does Vista REALLY still need to be supported at this point?

It's probably not much of a problem but per the latest statistics
we still have... uhm... about 4 Vista users...


Corinna
