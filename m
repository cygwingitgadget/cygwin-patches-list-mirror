Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
 by sourceware.org (Postfix) with ESMTPS id CC6D73861843
 for <cygwin-patches@cygwin.com>; Wed, 26 May 2021 09:04:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org CC6D73861843
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MRTIx-1m75FP3mB3-00NSQQ for <cygwin-patches@cygwin.com>; Wed, 26 May 2021
 11:04:34 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 172FFA80D78; Wed, 26 May 2021 11:04:34 +0200 (CEST)
Date: Wed, 26 May 2021 11:04:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Ensure PSAPI_VERSION is 1 when building ldd
Message-ID: <YK4PIlepWXUOiCHb@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210520174635.24163-1-jon.turney@dronecode.org.uk>
 <YKalBKpjhBx6mZBg@calimero.vinschen.de>
 <2c57cf3a-ed8f-f3e8-d3bc-a4c5dbe8edaf@dronecode.org.uk>
 <0d7d66f2-48f6-684d-946a-f05d07b329c3@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0d7d66f2-48f6-684d-946a-f05d07b329c3@dronecode.org.uk>
X-Provags-ID: V03:K1:+XRT9kB7uPFAtJRAShtjCEMuqzl8x/iSQ8+aGlfRJxGUGPndgib
 QlG5zFwt+z508JfPiUgRnlG4wZSsFXDT7Pp+JohnRarFC9qVNKBssb6W7w6l1B4ILID+QLR
 NAZXitkSCYz9hYN67H7Cu737xCpSXwQqLwpSxHN6RMdNyUqtwnX8vQ7fOe7OwPRUEqZzS1p
 E7hCxOisx2SPGs54oReXQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yNg37xJ+U4g=:Di855yiNX5GETWpzTEwCUm
 3Oh8KAqQsOJ/+DogicZG0z43Xd8cpiVTP41EzPLUMiDitMUeo7tCmObVsrZyzu+mBwcMeLDHs
 BfH1hmdMLGWJ5TfW8iJzozm1LRuIH7RtH5jv3ubx+XCk2htWDrJIM6j6HURuwMKpN1Sc9WT6E
 aHZCebHKWcb7O09QgnAUn/uFUi8j1dpFVJzjVACMFe6oiP0eh0RW5mysd5d24tNWh8lXHeiOX
 cK+p0FZ26LwTdWNoiCkqWx8jYS4ba5C8YJ3UcSOW4u0RLBuQ5uxALfysF17/dzAZtR/Zaa9GM
 fYHvOPBqRjMPFcUzm7mg0dsZTwqRNyj83wnZviVqRPobImjpqFK0rBRjF4xRcrEdj+IqTylaD
 EINHZsTAZz+VlPdnXrnOQu1K9kmEjhYtxqeS8YxqOpJ62c+ak0fWOFVOcz9FgoW7FOZc4iy8f
 3n+Z/ydVmYdL0Y567RHZXtzwD7XoxC9ZwaP5dhgItwBrRNl/mi736B5PMs2psVXq9tS5o4GfG
 MTLK3UHuT6zaMz1XAnKJa0=
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
X-List-Received-Date: Wed, 26 May 2021 09:04:42 -0000

On May 25 22:37, Jon Turney wrote:
> On 22/05/2021 16:08, Jon Turney wrote:
> > On 20/05/2021 19:05, Corinna Vinschen wrote:
> > > Hi Jon,
> > > 
> > > On May 20 18:46, Jon Turney wrote:
> > > > The default PSAPI_VERSION is controlled by WIN32_WINNT, which we set to
> > > > 0x0a00 when building ldd, which gets PSAPI_VERSION=2.
> 
> In the just released w32api 9.0.0, _WIN32_WINNT is now set to 0xa00 by
> default, so this issue is probably going to surface in a few other places as
> well.

I added _WIN32_WINNT and NTDDI_VERSION settings to make sure we notice
any problems right away.

In utils, I did this by tweaking CFLAGS_COMMON.  Maybe we should add a
generic utils.h instead, which contains all common definitions...?


Corinna
