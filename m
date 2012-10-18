Return-Path: <cygwin-patches-return-7730-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23252 invoked by alias); 18 Oct 2012 15:58:05 -0000
Received: (qmail 23132 invoked by uid 22791); 18 Oct 2012 15:58:03 -0000
X-SWARE-Spam-Status: No, hits=-4.4 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,KHOP_RCVD_TRUST,KHOP_THREADED,RCVD_IN_DNSWL_LOW,RCVD_IN_HOSTKARMA_YE
X-Spam-Check-By: sourceware.org
Received: from mail-ea0-f171.google.com (HELO mail-ea0-f171.google.com) (209.85.215.171)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 18 Oct 2012 15:57:56 +0000
Received: by mail-ea0-f171.google.com with SMTP id k14so2255134eaa.2        for <cygwin-patches@cygwin.com>; Thu, 18 Oct 2012 08:57:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.179.136 with SMTP id h8mr32024205eem.6.1350575875071; Thu, 18 Oct 2012 08:57:55 -0700 (PDT)
Received: by 10.14.213.134 with HTTP; Thu, 18 Oct 2012 08:57:55 -0700 (PDT)
In-Reply-To: <CAEwic4Z3J4E5N97XJiv=okWow4HDNuz_rqfm9qzEBCby1CufOQ@mail.gmail.com>
References: <CAEwic4ZBrjVPDV1Y3tc6r7baGzxNbrjgj1MUgse6zYSMHiCUhQ@mail.gmail.com>	<20121017164440.GA12989@ednor.casa.cgf.cx>	<20121017170514.GD10578@calimero.vinschen.de>	<20121017193258.GA15271@ednor.casa.cgf.cx>	<1350545597.3492.59.camel@YAAKOV04>	<20121018083419.GC6221@calimero.vinschen.de>	<CAEwic4Z3J4E5N97XJiv=okWow4HDNuz_rqfm9qzEBCby1CufOQ@mail.gmail.com>
Date: Thu, 18 Oct 2012 15:58:00 -0000
Message-ID: <CAEwic4ZH91sdRbgZ=RL4Nbp-2jdNXe5vMFA4K9UyUo3DzdcBMg@mail.gmail.com>
Subject: Re: [patch]: Decouple cygwin building from in-tree mingw/w32api building
From: Kai Tietz <ktietz70@googlemail.com>
To: cygwin-patches@cygwin.com
Content-Type: text/plain; charset=ISO-8859-1
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q4/txt/msg00007.txt.bz2

Hi Corinna,

2012/10/18 Corinna Vinschen:
> Hi Yaakov,
>
> On Oct 18 02:33, Yaakov (Cygwin/X) wrote:
>> On Wed, 2012-10-17 at 15:32 -0400, Christopher Faylor wrote:
>>> But, anyway, nevermind.  This shouldn't be a requirement for getting
>>> these changes checked in.  I'm more concerned with just nuking the
>>> now-unneeded mingw script.
>>
>> Draft patch attached, based partially on Kai's.  Yes, it needs a
>> ChangeLog entry, but it also needs more testing first.
>>
>> On Cygwin, you need either mingw-gcc-g++ and mingw-zlib, or
>> mingw64-i686-gcc-g++ with Ports' mingw64-i686-zlib, available here:
>
> Any problem to move mingw64-i686-zlib into the distro?

Hmm, wouldn't assume so.  I can give JonY a ping for that.  I assume
he would provide such a package.  Shall I ask him?

>> ftp://ftp.cygwinports.org/pub/cygwinports/release-2/CrossDevel/mingw64-i686-zlib/
>>
>> On Fedora, you need my cygwin-gcc-c++ plus mingw32-gcc-c++ and
>> mingw32-zlib-static.  Unfortunately F17's mingw32-headers isn't
>> (aren't?) new enough, so two files in winsup/utils wouldn't compile
>
> Indeed, unfortunately.  The Fedora maintainer cut the latest version
> right before I started to apply my changes to mingw64.
>
> Kai, do you have a chance to bump the Fedora maintainer?  An update
> to the latest state would help our cause a lot.

I am about to give the Fedora-maintainer a ping about this.

>> until I manually upgraded to
>> mingw32-headers-2.0.999-0.13.trunk.20121016.fc19.noarch.rpm from
>> rawhide.  F16 (which uses the mingw.org toolchain) should also be okay.
>>
>> Apply the patch, rm -r winsup/mingw/ winsup/w32api/ winsup/utils/mingw,
>> run autoconf in winsup/utils, then configure and build.  Tested so far
>> with CVS HEAD on Cygwin and Fedora 17 (with the aforementioned issue)
>> with our new w32api and the i686-w64-mingw32 toolchain; I have NOT yet
>> tested the resulting cygwin1.dll.
>
> Just FYI, there's a branch in sourceware called cygwin-64bit-branch.
> It contains all of Cygwin but omits the winsup/mingw and winsup/utils
> dir already.
>
> The idea of the branch is to collect all changes required to make Cygwin
> 64 bit work, while keeping the trunk intact for normal releases for the
> time being.  Since we would like to keep Cygwin working on 32 bit,
> cygwin-64bit-branch is supposed to make sure that Cygwin still builds on
> 32 bit as well.
>
> I had a brief look into the patch but didn't test it yet.  It looks good,
> but it misses out on one important thing:  In contrast to Kai's patch, it
> does not test for the target CPU, so these patches don't allow to build
> with --target=x86_64-pc-cygwin.

 Hmm, where do I check --target option?  I use host-triplet for
 detecting cpu's architecture name. See in utils/configure.in file.

Regards,
Kai
