Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.131])
 by sourceware.org (Postfix) with ESMTPS id 20EE2386F836
 for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021 13:27:18 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 20EE2386F836
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MOiLv-1lLTJr3FkN-00Q84j for <cygwin-patches@cygwin.com>; Wed, 27 Jan 2021
 14:27:16 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 5729EA80D7F; Wed, 27 Jan 2021 14:27:16 +0100 (CET)
Date: Wed, 27 Jan 2021 14:27:16 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Cygwin: fchmodat: add limited support for
 AT_SYMLINK_NOFOLLOW
Message-ID: <20210127132716.GU4393@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20210126213050.41241-1-kbrown@cornell.edu>
 <20210127124054.GT4393@calimero.vinschen.de>
 <5b3fbee6-b80f-1a46-4574-059b9b0c951f@cornell.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5b3fbee6-b80f-1a46-4574-059b9b0c951f@cornell.edu>
X-Provags-ID: V03:K1:8SvPm9h48U1cgaV63HuCTyf0m3rP9gSk+CItj+J+zzaBNiC2Fwm
 GOHQeXiKDLZH1DFh8NwxLl1NgV248sJu8Q0PvTm42fNGQb+SE3IAZl0NWoRHJogxUXBcnsw
 Vb12HgG3R8kSionDlVfmRg26svJ2Wm606Code0ZsAUj9KiVsx4nD6NelvadSXBHIFCxAD/v
 w+4gCafrga/KUVseDB36w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w9Ik+AP9Tos=:ZknF03fkddS9u8I6h5UZ9B
 3Xzu8vnip3s4XC3HhV8gwCAEMu2hsN5QY+vEQRevSv51WLTGAcyM3qJdOsxLGrcQdAGLx7WxF
 tKCoRlm4iuR688wjfJcTUaUKewV0pZCiQz7Up9dM9TBEBckodghdWW/6tXDB9ZW5wIlcx2w9f
 zNT40FnbbZAWktSLZZe5sDau7U4FubZol4joXeQcRT4PNbQ+R824pNpdtdUgPdS6Xs+C5b2e8
 qEjwlTsv8Zh/7i1rwX3hTC+Fgh38DJA2Hav5RNh1VXSMwfK0ukPvf6Q1NyTOHSEW5v3VmirwC
 WxiU4AhC7ufUwNVWx7WkhoNE/MLcYMrQlYsPotRmR/4JaRq5D1FhA0d2i0dbJ/WsBrDWULzzF
 n3c8WxmxChMvix8RBKiLyN0pWSWejBAtyg+0+f7WIFGD7VxXwrwMRfTllGe4tXdIbjpnI1Aiv
 XbHbpu8yPQ==
X-Spam-Status: No, score=-101.2 required=5.0 tests=BAYES_00,
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
X-List-Received-Date: Wed, 27 Jan 2021 13:27:19 -0000

On Jan 27 08:22, Ken Brown via Cygwin-patches wrote:
> On 1/27/2021 7:40 AM, Corinna Vinschen via Cygwin-patches wrote:
> > On Jan 26 16:30, Ken Brown via Cygwin-patches wrote:
> > > Allow fchmodat with the AT_SYMLINK_NOFOLLOW flag to succeed on
> > > non-symlinks.  Previously it always failed, as it does on Linux.  But
> > > POSIX permits it to succeed on non-symlinks even if it fails on
> > > symlinks.
> > > 
> > > The reason for following POSIX rather than Linux is to make gnulib
> > > report that fchmodat works on Cygwin.  This improves the efficiency of
> > > packages like GNU tar that use gnulib's fchmodat module.  Previously
> > > such packages would use a gnulib replacement for fchmodat on Cygwin.
> > 
> > Wait, what?  So if Cygwin behaves like Linux, gnulib treats fchmodat
> > as non-working?  So what does gnulib do on a Linux system?  Does it
> > use its own fchmodat there, too?
> 
> Apparently so.  Here's a comment from gnulib's test program for fchmodat:
> 
>               /* Test whether fchmodat+AT_SYMLINK_NOFOLLOW works on non-symlinks.
>                  This test fails on GNU/Linux with glibc 2.31 (but not on
>                  GNU/kFreeBSD nor GNU/Hurd) and Cygwin 2.9.  */
> 
> I agree that it's strange.

¯\_(ツ)_/¯


Corinna
