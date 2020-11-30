Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 4073D383F861
 for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020 10:25:29 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4073D383F861
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N0X4c-1jw05i14aK-00wYWd for <cygwin-patches@cygwin.com>; Mon, 30 Nov 2020
 11:25:26 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 03486A80D0E; Mon, 30 Nov 2020 11:25:25 +0100 (CET)
Date: Mon, 30 Nov 2020 11:25:24 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Use automake (v3)
Message-ID: <20201130102524.GC303847@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201124133720.45823-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:SuP6GDCmwV692jWYY6oF5EFYTOjrsb17nMMfLMqQw0p9YvXffoj
 W6/LvC4Vkal1UNB1iAR0kAR02yCSXSVNcUSxG3xMSzjP2un2Bjl9QzrQWIaqgybj59hHfxC
 2rKQZMab63CzfenZSRLmHO1l2ZfHzamKbTAKxlG7KTbYHg2uQJY4L/mRljFjc/XyhEG3zxj
 t7hgxyw5aWQ9xWdMCJ3MA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xU1qlp8mQqU=:lbsMU87Cwb8OV0gwv7xidM
 FJLyCUxRf72YCypwVModp7gcHgR3bnaLK7XHGosZLIkf27Of8bj/VcKyst3W9gGfoeZYOB/bj
 pFGZxMKyDiAzLgGLum/BuRnEFhm4st3D8fp/1QpfOWuJl7IUwB9fTSv2iGC9INJ/aw8UHYIvv
 xPRsJq/Ju3M+chCMwAuyr0Fi9JHqFnKUQLWWjIyLYe653rf/IEpPddQYb8zPWLl/LIQDcVbqr
 Qv6ldMqznN8ZDmvXbVFjHFj3sE35N5S/lDiy/+bsIVN27beb42cDCtuvHpYf4xcDA024ewOtQ
 hP0NWZ3HN1RponA4eNYsVLxSzPZ6OTuW3DhE4SFGv+XqGinLaa/sdZFE8/u4EPNZisVxyh/4V
 cgibuxCV82BmPuDJl1sMuA4Q8olQW0H1+11Bi6dgqUE3bHJQ4osivomx9onQws3HsGsl2o+dy
 gt6Qs+4QwQ==
X-Spam-Status: No, score=-100.6 required=5.0 tests=BAYES_00,
 GOOD_FROM_CORINNA_CYGWIN, JMQ_SPF_NEUTRAL, KAM_DMARC_STATUS,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NEUTRAL,
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
X-List-Received-Date: Mon, 30 Nov 2020 10:25:30 -0000

Hi Jon,

On Nov 24 13:37, Jon Turney wrote:
> For ease of reviewing, this patch doesn't contain changes to generated
> files which would be made by running ./autogen.sh.
> 
> v2:
> * Include tzmap.h in BUILT_SOURCES
> * Make per-file flags appear after user-supplied CXXFLAGS, so they can
> override optimization level.
> * Correct .o files used to define symbols exported by libm.a
> * Drop gcrt0.o mistakenly incuded in libgmon.a
> * Add missing line continuations in GMON_FILES value
> 
> v3:
> * use per-file flags for .c compilation
> * override C{XX,}FLAGS, as they are set on the command line by top-level make

Running autogen.sh shows a couple of warnings:

configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
testsuite/cygrun/Makefile.am:16: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
configure.ac:45: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')
automake: warning: redefinition of 'ps' ...
/usr/share/automake-1.16/am/program.am: ... 'ps$(EXEEXT)' previously defined here
utils/Makefile.am:15:   while processing program 'ps'
utils/mingw/Makefile.am:14: warning: 'INCLUDES' is the old name for 'AM_CPPFLAGS' (or '*_CPPFLAGS')

Something to worry about?


Thanks,
Corinna
