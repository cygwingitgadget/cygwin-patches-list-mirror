Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by sourceware.org (Postfix) with ESMTPS id 23F653858036
 for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020 09:36:03 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 23F653858036
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MLz3R-1knq0u2OrR-00HuHK for <cygwin-patches@cygwin.com>; Fri, 23 Oct 2020
 11:36:01 +0200
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 24550A81039; Fri, 23 Oct 2020 11:36:01 +0200 (CEST)
Date: Fri, 23 Oct 2020 11:36:01 +0200
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/3] Remove recursive configure for cygwin
Message-ID: <20201023093601.GV5492@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201021194705.19056-1-jon.turney@dronecode.org.uk>
 <20201021194705.19056-4-jon.turney@dronecode.org.uk>
 <20201022172710.GS5492@calimero.vinschen.de>
 <fb4a8bf6-9b4a-3e77-cb32-bdd7fcce49fe@dronecode.org.uk>
 <20201023092700.GU5492@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201023092700.GU5492@calimero.vinschen.de>
X-Provags-ID: V03:K1:bf0ctGft9hUX/CDs6QWS01JOEweMrMkCdIcJudu0CQn92FXVRJo
 jmKuniI/hU1CbxHSTX/ik2NPAxC9lTy4cpVLGCoKliDk1tF6EiBus9g9xf8QVXDh0tXl7Yy
 8e1+D6hSeuq/erTntKGKzzSE6VaevvSGRbG529CbRgUu86asl9s4Hv2L8rSqPynHAxwuryd
 0QBSgKGamsxTHhroY17Cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FEawsW8Vqzc=:1SJ0u4pPyiULxFlP24bRHR
 T1Fg/j/ULycB+rcr3nxkiAHiVD10sYUjnN1w4z806DwJflIatATltYLvrpMFxwssBXjXIoiGV
 1nZcC70OFoqGLYiCrcVJ6PBu7Rpi4CAw+3wCxh97i7UlxIxCmXLp0TwNzm4GBQUFXDu4gCd1A
 r0bWOGUYDi8htkX2O0i9QUliucjEzWjfj+7izVKZgD1fiH6ehJymgaPMdKTMkA+ibCDUnXq9L
 +uA/Jeya20VmTgVffunB2Xzhwo6vV2NUdmSjY770dy7DwgjDLYVDM+T+lx/sUe0/Hoxm0T5Np
 9snisamsvwTCCl9aVcdOkTzylAhK4qDOVcaScpVoW0YW6PoZ6o+zi6qcV5sP6UaYiNxBhFN1j
 StnzUEMlI9Xapt+EM72OWMNSz4QPGv/ltGurz5GcIoHcOz7M8U1L1GfOtAszHeRaCnN/llRn+
 zZdDSnFsWQ==
X-Spam-Status: No, score=-100.9 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, KAM_SHORT, RCVD_IN_DNSWL_NONE,
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
X-List-Received-Date: Fri, 23 Oct 2020 09:36:05 -0000

On Oct 23 11:27, Corinna Vinschen wrote:
> On Oct 22 19:57, Jon Turney wrote:
> > On 22/10/2020 18:27, Corinna Vinschen wrote:
> > > On Oct 21 20:47, Jon Turney wrote:
> > > > There's doesn't seem to be much use in independently building these
> > > > subdirectories,
> > > 
> > > Uhm... that doesn't match how I'm working in these dirs.  I'm building
> > > the subdirs independently all the time, especially during debugging
> > > sessions.  I'd not want to lose the ability to build in the
> > > cygwin or utils dirs independently.
> > 
> > Sorry for being unclear here.  What I mean here is we are currently handling
> > those subdirectories as if they are independent packages, which could
> > distributed and built separately.
> > 
> > (See discussion of AC_CONFIG_SUBDIRS in [1])
> > 
> > [1] https://www.gnu.org/software/autoconf/manual/autoconf-2.69/html_node/Subdirectories.html
> > 
> > This doesn't remove the ability to run make in those subdirectories.
> 
> Ok
> 
> > > > so allowing them to be independently configured seems
> > > > pointless and overcomplicated.
> > > 
> > > There's not much of a reason to allow independent configuring, I guess,
> > > but apart from the base configure run during a build from top-level,
> > > I sometimes run configure only in the dir I change or add files.
> > 
> > I actually skimped on writing the rules which reconfigure when needed when
> > make is run in a subdirectory, as working them out seemed complex and a bit
> > redundant, as when I convert to automake, it writes them for you.
> > 
> > I guess I should take another look at that.
> > 
> > > > The order in which the subdirectories are built is still a little odd,
> > > > as cygwin is linked with libcygserver, and cygserver is then linked with
> > > > cygwin. So, we build the cygwin directory first, which invokes a build
> > > > of libcygserver in the cygserver directory, and then build in the
> > > > cygserver directory to build the cygserver executable.
> > > 
> > > Does creating a new subdir called libcygserver just to build the lib
> > > clean up things, perhaps?
> > 
> > I did experiment with something like that, but I'm not sure if it makes
> > things any clearer, as:
> > 
> > (i) It's the same source files built with/without -D__OUTSIDE_CYGWIN__

Oh, btw., this is bothering me for a while now.  This may have been
a nice idea at the time, but wouldn't it be much better to put
common methods into headers and otherwise split the source between
client and server code?


Corinna



> > (ii) building libcygserver requires the generated file globals.h
> 
> I don't actually see a reason to keep this.
> 
> There's nothing wrong simplifying this stuff, removing mkglobals_h and
> creating a static version of globals.h inside the source dir.  For
> instance, defining enum exit_states or enum winsym_t in global.cc just
> to generate a globals.h from there is kind of weird anyway.  Getting rid
> of another undocumented perl script and getting rid of the globals.h
> build rule sounds rather good to me.
> 
> 
> Corinna
