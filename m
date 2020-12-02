Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
 by sourceware.org (Postfix) with ESMTPS id D28A8396D818
 for <cygwin-patches@cygwin.com>; Wed,  2 Dec 2020 19:03:51 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org D28A8396D818
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MYeV1-1kfEFJ2PwJ-00Vkzd for <cygwin-patches@cygwin.com>; Wed, 02 Dec 2020
 20:03:50 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 71B23A80D26; Wed,  2 Dec 2020 20:03:49 +0100 (CET)
Date: Wed, 2 Dec 2020 20:03:49 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201202190349.GY303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
 <b8610713-5e7d-7b19-93f1-3ded9ca12bc6@dronecode.org.uk>
 <20201202170526.GW303847@calimero.vinschen.de>
 <161bd779-bd17-1e98-5644-bea42c3206cf@dronecode.org.uk>
 <42d8f1f139939b45fef85d00c3e368cf2500b603.camel@cygwin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <42d8f1f139939b45fef85d00c3e368cf2500b603.camel@cygwin.com>
X-Provags-ID: V03:K1:RmJTTcWdSNM4R/bi8tcFftDv7dLXxa5miO62wJVr74/3P/bHXTD
 F+NNBVIFPuiTUTAfI6Pu1UqQ9uOowWhuHHogFIWiCTGQ+zjxqiYy6jFotUy1QiiLg2bUOMT
 tRQDSVnqZUeC52Hiie5Q0Z36bzu2g9MVCJuFmtfXif6AuKcXc+Bp+l4H/8pyc7CIYqSfV5X
 Ie3C5SX28yRAiCVY6dyqQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:768Bye3SQdw=:DQEh10/I6yMeoZH63ZKKaB
 /I8R7XhmC8HNZILs2aBkbShVv277s3i79jUU/C84aVJObCr/2LGMu87VPUFRP+o2CJkSxfDeH
 L7AhXWiZvbbjpS0Y7Pn1dgZue96eDJmLs5OJnhSOwnX9trZr5T7Uuu3Nyl3J4vrqpMx7y0Vz1
 q6c2ztE3OoKa6NIdMNWl/RT1OjJ3TeQH1Efmi+7VrV5iXw/Ic53zhUIfzr/ZR88L9sYP+QLnX
 DE5Ttp9Qf+binh6U2yZJDQhP5pKuf2QfW5y2HTtS8roMYbqXUaQqQoVvFUufhDuMpQomnx1FT
 U6i/1+uVRjhzN9sRevVY9j5Bz3NjOH7xwRlXdDJHN/LXMo+DeJSvt9a5bVE2AGxC/zOafEsES
 m3DbE/GKFJDHuOII4V66qxqoykAZ0eJmf0PeVlMZNPZ1NzSHdVHkV1SnIdyOe/b66sG27cuMr
 RsJRWHeIKQ==
X-Spam-Status: No, score=-100.7 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Wed, 02 Dec 2020 19:03:53 -0000

On Dec  2 13:33, Yaakov Selkowitz via Cygwin-patches wrote:
> On Wed, 2020-12-02 at 18:03 +0000, Jon Turney wrote:
> > On 02/12/2020 17:05, Corinna Vinschen via Cygwin-patches wrote:
> > > On Dec  2 15:36, Jon Turney wrote:
> > > > On 01/12/2020 09:18, Corinna Vinschen wrote:
> > > > > What bugs me is that the mingw executables are built in
> > > > > utils/mingw,
> > > > > but the object files are still in utils.  Any problem
> > > > > generating the
> > > > > object files in utils/mingw, too?
> > > > 
> > > > Not easily.
> > > > 
> > > > This behaviour can be turned off by not using the 'subdir-
> > > > objects' automake
> > > > option.
> > > > 
> > > > But then automake warns that option is disabled (since it's going
> > > > to be the
> > > > default in future).
> > > 
> > > So why not just move the mingw source files to utils/mingw, too?
> > 
> > There's probably some scope for doing that, but not in all cases, as 
> > some files are built multiple times with different compilers and/or
> > flags.
> > 
> > e.g. path.cc is built with a cygwin compiler and -DFSTAB as part of 
> > mount, with a MinGW compiler as part of cygcheck, and with a MinGW 
> > compiler and -DTESTSUITE as part of path-testsuite.
> 
> Then something like:
> 
> $ cat > winsup/utils/mingw/path.cc <<_EOF
> #define MINGW // whatever is needed here...
> #include "../path.cc"
> _EOF
> 
> ??

+1

> 
> -- 
> Yaakov
