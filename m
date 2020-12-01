Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
 by sourceware.org (Postfix) with ESMTPS id C5EF6393D00D
 for <cygwin-patches@cygwin.com>; Tue,  1 Dec 2020 10:07:40 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org C5EF6393D00D
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MN5aF-1kRgCs1hm1-00J4d8 for <cygwin-patches@cygwin.com>; Tue, 01 Dec 2020
 11:07:39 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id B46A0A80D1D; Tue,  1 Dec 2020 11:07:38 +0100 (CET)
Date: Tue, 1 Dec 2020 11:07:38 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201201100738.GL303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
 <20201130102524.GC303847@calimero.vinschen.de>
 <20201130104718.GD303847@calimero.vinschen.de>
 <6fa43a94-c29d-fa48-07d0-1ef095d9f5e3@dronecode.org.uk>
 <20201201091833.GJ303847@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201091833.GJ303847@calimero.vinschen.de>
X-Provags-ID: V03:K1:sAEgXhzikfdG1XnmJp1AV36MR3XbR+aFFtDlSEMYyQYWNFd27IC
 CjFQVGgtrGimTQsqoZG3optBRN3eMJzHg99JY9obY8v3cY9JKZGM4NybaM+gaqQAmrJ2lh1
 84wizSq9OIELsnJWooAPfZKhYczb3DmXjiENmcxPXrR4Y9OGMh7vB7DjRAHVaLnFWIHWjK3
 9Ih19UvGdTiM6q0tok9fw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JRgvVOVb/D0=:mUVJsMLWazMhQAGI11k+ZI
 9BCorUQaupjaixGdh489VRaCcnYn99xanhHu8nLQrQWmMMYeIbbdiXxQXOeyPJ2VvMFQv+yeb
 7L6PGiCfvk3+5mbZi7fzie37iZfByOXbyPHad9vHrk2OSPpSOgxwIu/CV49wmc6hGftAh/wo2
 PenLN7Kva+P2BCdZowH7aWRm4M4f2FyJow79dnIebF8pjYNr0pApGR/ZQmLk7Fofx8ah2p2CE
 vmkcZO8iSqMF8YebXlPiNcLw3QemyQ/PGrFRB/X5K8Y/4gTClqDMlHbRCMq7La5OrQHvxTgMM
 YSRapFYPUYpaM1Epiec+YWwMBOICfULWN9ZZhz6K1YqG4Ll+dRJSSkzdYmeJm4ndMEsgPMFRP
 wz6kUBpslhiVb3i0t7CVt5Q5FF/vV/lU4LnJlzkYpNs3QhSQNCZIB6K3CqRZEIrB/EMuR0wUN
 ueYM2uG9Ug==
X-Spam-Status: No, score=-100.8 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=ham autolearn_force=no version=3.4.2
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
X-List-Received-Date: Tue, 01 Dec 2020 10:07:42 -0000

On Dec  1 10:18, Corinna Vinschen wrote:
> Hi Jon,
> 
> On Nov 30 17:02, Jon Turney wrote:
> > On 30/11/2020 10:47, Corinna Vinschen wrote:
> > [...]
> > >    CXXLD    path-testsuite.exe
> > > /usr/lib/gcc/x86_64-w64-mingw32/9.2.1/../../../../x86_64-w64-mingw32/bin/ld: ../path_testsuite-path.o:path.cc:(.rdata$.refptr.max_mount_entry[.refptr.max_mount_entry]+0x0): undefined reference to `max_mount_entry'
> > 
> > This is a bit puzzling.  I don't get this when building locally, but idk why
> > since there is only a tentative definition of this variable.
> > 
> > I'm not sure how this being built is changed by automaking to stop it
> > working for you (perhaps optimization flags are now being used?)
> > 
> > Perhaps the attached helps, although what is getting stubbed out when
> > testing could be clearer.
> 
> It helps to build the whole lot.  The warnings are still generated.
> I applied the attached patch to avoid the warnings when building
> path-testsuite.exe.  Still TODO are the warnings generated when 
> building libltp, though.
> 
> What bugs me is that the mingw executables are built in utils/mingw,
> but the object files are still in utils.  Any problem generating the
> object files in utils/mingw, too?

I also don't like how test-driver is generated in the toplevel
source dir.  It should either be generated in source level winsup,
if it's a file to be added to the repo (like aclocal.m4, etc), or,
if generated at runtime evey time, it should go into the build dir,
me thinks.


Corinna
