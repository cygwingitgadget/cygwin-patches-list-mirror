Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 18F9D3857C5E
 for <cygwin-patches@cygwin.com>; Fri,  6 Nov 2020 09:44:52 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 18F9D3857C5E
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1My3AX-1kPKV21yGN-00za3W for <cygwin-patches@cygwin.com>; Fri, 06 Nov 2020
 10:44:51 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id DB6B0A80E0B; Fri,  6 Nov 2020 10:44:50 +0100 (CET)
Date: Fri, 6 Nov 2020 10:44:50 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 00/11] testsuite refurbishment
Message-ID: <20201106094450.GU33165@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201105194748.31282-1-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:udV2gRUP2WHxewBd7WBOzQV6eADsgPhpn7saw9qtMQjycMlV8t6
 c1VV6SzPQIBpv3o/qOJ1pisxyTG49krz7dKzZGj0Dfpgra2jNsXwF7n2p0HMTq975TamgeJ
 ozNlY8OJ+NKPu9q2R9+D+Y+G+qlSp9bmYSQfDheX2ZpwY7oSXUC1S2h5plZapYbdLslvczM
 a+1439JJxIHzc3zK++g0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iQLeUGFbOmc=:XCvxgeZwqmvnrQ7ULH5u68
 Igaw8mn0W/BxazmYjecCzAmR/sDtJwNHjdphUAjnoLTQIA2Hj+v7+RBD+wYd3IR+wo/4dl8aD
 Y+WiAxLi0eDMaVkaZPQborpmBVwbDcu9PDxYt6KM26gJH0GsgPtyhShYeE1Yw3XmfNyyvBAmg
 QqFM4jKNXGbsJtFwsyrQmmEEyMgnLAUC6qK/92ASuvraIhyfjAjAI0cAuDCerh3RZBhvGd32R
 OH2u5UPn4s10ZnidQlc3ClCNuEyWffK4MGYaVCd8c4Om6kuIXVbWX+QolixtUjTqZsqxT26Vk
 l2lt9i5d6xyM4mApSKqfD+N21+mSuUB8yi4vxGbAVXNTmk53AdxrK3cuoJ+SIB89DWU9XrHOq
 zAkaF3h1ONBM33iuM74S7WARMOptbNvga7qCtcYxpUfPy5f71wkOpR043XqV38KnzKjmaYVpU
 ovvexLWxyQ==
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
X-List-Received-Date: Fri, 06 Nov 2020 09:44:57 -0000

On Nov  5 19:47, Jon Turney wrote:
> Fix testsuite Makefile/configure, so I have some idea what it's supposed to
> be doing, prior to cleanup and Automake-ification.
> 
> > $ make check
> [...]
> > # of expected passes            253
> > # of unexpected failures        23
> > # of unexpected successes       1
> > # of expected failures          7
>  
> Future work:
> - Investigate and fix failing tests
> - Tests are re-compiled every time they are run
> - No parallelization of tests
> 
> For ease of reviewing, this patch series doesn't contain changes to
> generated files which would be made by an autoreconf.
> 
> Jon Turney (11):
>   Add testsuite directory to autogen.sh
>   Always configure in testsuite subdirectory
>   Add rule to testsuite Makefile to regenerate it when needed
>   Avoid 'Makefile.in seems to ignore the --datarootdir setting' warning
>   Move adding libltp to VPATH after Makefile.common
>   Define target_builddir autoconf and Makefile variables
>   Detect and use MinGW compilers for testsuite wrappers
>   Use absolute path to libltp includes
>   Check exit code of a test, rather than stdout
>   Set PATH for tests to pick up cygwin0.dll
>   Ensure temporary directory used by tests exists
> 
>  winsup/Makefile.in                      |  16 +-
>  winsup/autogen.sh                       |   2 +-
>  winsup/configure.ac                     |   2 +-
>  winsup/testsuite/Makefile.in            |  31 +-
>  winsup/testsuite/aclocal.m4             | 831 ------------------------
>  winsup/testsuite/autogen.sh             |   4 +
>  winsup/testsuite/configure.ac           |   9 +
>  winsup/testsuite/cygrun.c               |   5 +-
>  winsup/testsuite/winsup.api/cygload.exp |   2 +-
>  winsup/testsuite/winsup.api/winsup.exp  |  24 +-
>  10 files changed, 60 insertions(+), 866 deletions(-)
>  delete mode 100644 winsup/testsuite/aclocal.m4
>  create mode 100755 winsup/testsuite/autogen.sh
> 
> -- 
> 2.29.0

Looks good, please push.


Thanks,
Corinna
