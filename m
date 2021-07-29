Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by sourceware.org (Postfix) with ESMTPS id 624983858038
 for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2021 10:23:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 624983858038
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MuUvU-1mzELL3aLq-00rWAo for <cygwin-patches@cygwin.com>; Thu, 29 Jul 2021
 12:23:21 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 561A4A80DDF; Thu, 29 Jul 2021 12:23:21 +0200 (CEST)
Date: Thu, 29 Jul 2021 12:23:21 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 0/3] Add more winsymlinks values
Message-ID: <YQKBmcZgFygx7cDK@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210719163134.9230-1-jon.turney@dronecode.org.uk>
 <YPfYgz0EHe7Yw5ko@calimero.vinschen.de>
 <0b2f3506-b5f8-5e73-b92f-62583dbd4fdb@dronecode.org.uk>
 <YPl+7gROlATG/ggs@calimero.vinschen.de>
 <8c228092-1699-35aa-7558-106f49fde87f@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8c228092-1699-35aa-7558-106f49fde87f@dronecode.org.uk>
X-Provags-ID: V03:K1:eyiwhDoXvuApkAATDX8Mhut/bC6Ab2cjVXE1WSn8KR8FztG14du
 re5D4TE3qGy3q7ltw2Uer7+vQcMd1hWDCR4X7AIpXbpg1g03O8nFfecWJhkuCzWMZei+YyJ
 qcJ1gcbCSJnY1dBqfSLCEbrvEI325KLv8qfpuPw+6NsoBJOdOvIIKbkrVtBHszlC6Nfovx3
 8k1i/N5tGEHaEP8ZunzmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RhNPCXi+nZw=:AFPZ3K3LOQgXban+wFecZl
 QUkpPKoGA9wKBVcHB0RD9Mwr2y+LuniuadOzhvApgX3V9GfeEC4EXR9nvU4qg0pkau+YjO5ml
 891isCaTVayLSBUAKIok4l4fUWkbLVYMzjFLfvrNUFkI63aN6eKqSNr89H2mR5aQr3o4xJ5k/
 E2ijKqs+YnrsvHKPzfYSOqL30GXZfYmKQocaBmVmYd3D+QjSFgMXCe5Bh5MazH/01NHU555r/
 9cYXMYo7ruW3eip998uNiFEG40rPbmGiwaXt4pL/ngmCMXa3HhwA4uaGyISWuJd1Mq9UKldqZ
 YQLW2edzwAYhIBKIjj33xafiZ6d0gJyExAmyH6rD7nc23GKOVBMpOx2oGnlMG4apHZozeXazg
 Ey/K5SlNVi3rShqHR3g/nnqU5rrqFhcAWe1McZMT5+1rKa98BXRBgm8U6N/9iLxUehnMS29Sb
 7a7h1abY/SRZmAi1aUBvcvyzEhwzvJK6P9HOfd9UNxrRnZtN2qZknNYNkGzNfzU0vQ1hv3pyP
 b/YU1BvrG1vVVkVQbMqbp+HAj+J6mPhHFZbZk2V5PqHaYzldRzl/PwXS4fgcy5l8ifWA2F1cz
 5ZHaN1XxPPBTzx+WQeIrLHOTGCrVqsyGrAxs5crg/ynNE1YN+9xMVt7CTeuNJPhWhDh9O/Wgu
 lyl1iFJ6JTmq7rrJihTBYbgITvyd4E2RKIJ9V2awf0+2VODTtEAqGi7jFv8A7Uzv21keS4yA+
 GtkmqsWM1jJKiBeI0wH1aZgkqPLG6SsF2W5KCrxmB3GGw2+TdgAGK0KdBcrZ2dH+GI7m0Xz+T
 H2/R64kMXWja0v8oYKTTwS9PkGREXAat3oqaF+X6PmqhEo3WegT4/KDITGsGZuqwMs/D3kmac
 3xJATjO1U/Fkbpb4zEPw==
X-Spam-Status: No, score=-100.2 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
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
X-List-Received-Date: Thu, 29 Jul 2021 10:23:25 -0000

On Jul 28 20:55, Jon Turney wrote:
> On 22/07/2021 15:21, Corinna Vinschen wrote:
> > On Jul 22 14:53, Jon Turney wrote:
> > > [1] https://cygwin.com/pipermail/cygwin/2020-August/245994.html
> > 
> > Did nobody ask the Docker guys why they fail to support perfectly
> > valid reparse points?
> 
> It seems so e.g. [1]. The answer isn't much beyond "yes, that doesn't work",
> though.
> 
> [1] https://github.com/moby/moby/issues/41058#issuecomment-692968944

D'oh!

> > > I haven't yet looked at adding 'native' symlink support to setup itself, but
> > > it's probably going to be a bit of a pain.
> > 
> > That may be not a bad idea after all.  Setup typically runs as elevated
> > process, so it has the required permissions to create native symlinks.
> > Scripts could then run with CYGWIN=winsymlinks:native by default.
> > 
> > As long as nobody has the hare-brained idea to move a Cygwin distro
> > manually, native symlinks should be just as well as Cygwin symlinks.
> 
> I'm pretty reluctant to add this to setup in any form which isn't initially
> "keep doing what we currently do, unless you explicitly ask for symlinks to
> be made a different way".  (especially since when we changed what we were
> doing in Cygwin 3.1.5, it opened this whole can of worms)
> 
> So I don't think that gets us any further forward if setup doesn't have
> useful control over the kinds of symlinks made by post-install scripts.

Ok, then, by all means, lets' add a few options to the CYGWIN=winsymlinks
setting.  Just s/WSYM_magic/WSYM_sysfile/.

> >>
> > > If we can come up with a fixed policy that works everywhere, there is no
> > > advantage.  But that seems unlikely :)
> > > 
> > > I could buy an argument that 'native' should be the default (although maybe
> > > all that does is slow things down in the majority of installs?).
> > 
> > It may slow down installations a tiny little bit because the target
> > paths have to be converted to POSIX, but I doubt this is more than just
> > a marginal slowdown.
> 
> My assumption was that "the majority of installs" are running where native
> symlink creation isn't permitted, so the slowdown I meant was that adds "try
> to create a native symlink, fail and fallback" for every symlink creation.

Uh, ok.  That's avoidable, though.  The Cygwin code is lacking a check
for SeCreateSymbolicLinkPrivilege being present and enabled in the
current user token.  This could be done once and then stored in a static
var for later consumption.


Corinna
