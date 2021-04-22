Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by sourceware.org (Postfix) with ESMTPS id E7726385800F
 for <cygwin-patches@cygwin.com>; Thu, 22 Apr 2021 11:57:36 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org E7726385800F
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1N0o3Z-1lNFsI1X9h-00wnK5 for <cygwin-patches@cygwin.com>; Thu, 22 Apr 2021
 13:57:35 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id BD1C5A80EDF; Thu, 22 Apr 2021 13:57:34 +0200 (CEST)
Date: Thu, 22 Apr 2021 13:57:34 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v5)
Message-ID: <YIFkrv4KPAQypN8o@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210420201326.4876-1-jon.turney@dronecode.org.uk>
 <5d7176f9-8d82-9b2c-4717-fdc5041d95ce@dronecode.org.uk>
 <YIBVYytjWjpdFDTo@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YIBVYytjWjpdFDTo@calimero.vinschen.de>
X-Provags-ID: V03:K1:Yoj8Z6BpL6ypWsfceKuVOHvwpNOrujc5buA/Y+eOu6GaNk+HEmJ
 qmKNBxsmq51hMD3cskOQrfokofFWuUEoMbFAUCZm7YyvBdp49liG7o2xjxEIT1i4/hktZQx
 i4IktAZLDHaOfiVaUensJrqbcTzY6bwxdzUAfG4jrQbgRHjUjT98lzUeWHITGCICJwgpGa2
 SwLUWdLXH55OY5g5bwwaQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D9p2Nq2BejE=:WcQRq7FLQ4xH/3wHJEsuVB
 CbzAEvWXoZ+3MDH/bHfFig9p1dYcFrK6YaLsFHLYW0A3TbK4bXg+4X4bCEL6HIWxyAxvi0k3D
 uyWpouD32W+TPkTzBUABS1cMyEvBehFXTzx1FCdfcAd0EArpzbH3kpm361NJZAtevMvokL1Jc
 Mpd3NbZXyLrEs0VixD6M0FYWJx+8PyBskizZwGqWkAwAPdJUb8Mu3Gbl7ZN3/u8HO5SXD64xU
 xXIcXatiw0f16vckQo+UJwRF7SvW44FFlrNPH5PRUAERFRWGgR2B+MyHIagTNtsetkfksYrZx
 I4kIML5wKj4ndaTXVWh7BnpgZ7lElWWX3pKJv+Tv6kiF0d5RI+1+jFOfIRHw7o4dNRChdJDYF
 MdUogy9qI5Y1eUNBzZEHX+W4N7hrvR6Pj+YZogoJTwBbb7gg5gCfB58JKNXbJZJ5bMQ5DyT0K
 5fOgvmDknIJZ8yYYf6RMWiniwySXo9m2iqQiPejOF6UdDkpnWtB860MPc4GuPxLZjl7Mo1ik4
 gXvJ1h23i4aTvmn1CSzDik=
X-Spam-Status: No, score=-100.3 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
 RCVD_IN_MSPIKE_H3, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Thu, 22 Apr 2021 11:57:38 -0000

On Apr 21 18:40, Corinna Vinschen wrote:
> On Apr 20 21:15, Jon Turney wrote:
> > On 20/04/2021 21:13, Jon Turney wrote:
> > > For ease of reviewing, this patch doesn't contain changes to generated
> > > files which would be made by running ./autogen.sh.
> > 
> > Sorry about getting distracted from this.  To summarize what I believe were
> > the outstanding issues with v3 [1]:
> > 
> > [1] https://cygwin.com/pipermail/cygwin-patches/2020q4/010827.html
> > 
> > * 'INCLUDES' is the old name for 'AM_CPPFLAGS' warning from autogen.sh
> > 
> > I plan to clean this up in a future patch
> > 
> > * 'ps$(EXEEXT)' previously defined' warning from autogen.sh
> > 
> > It seems to be a shortcoming of automake that there's no way to suppress
> > just that warning.
> > 
> > One possible solution is build ps.exe with a different name and rename it
> > while installing, but I think that is counter-productive (in the sense that
> > it trades this warning for making the build more complex to understand)
> > 
> > * some object files are in a unexpected places in the build file hierarchy
> > (compared to naive expectations and/or the non-automake build)
> 
> This is the only minor qualm I have with this patch.  It would be nice
> to have the mingw sources and .o files in the mingw subdir.  It would
> simply be a bit cleaner.  The files shared between cygwin and mingw
> (that's only path.cc, I think) could be handled by an include, i. e.
> 
>   utils/
> 
>     path.cc (full implementation)
> 
>   utils/mingw/
> 
>     path.cc:
> 
>       #include "../path.cc"

I wonder if it wouldn't make sense to split out the mingw-only parts
of path.cc entirely.  I had a quick view into the file and it turns
out that of the almost 1000 lines in this file, only about 100 lines
are used by mount.  All the rest is only used by mingw code, i. e.,
cygcheck and strace.

That's obviously not part of this patch, but something we should keep
in mind for a later cleanup.


Corinna
