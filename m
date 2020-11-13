Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by sourceware.org (Postfix) with ESMTPS id 4CA943A19821
 for <cygwin-patches@cygwin.com>; Fri, 13 Nov 2020 09:18:17 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 4CA943A19821
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org;
 spf=fail smtp.mailfrom=corinna-cygwin@cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MoOpq-1jxt0x3gD2-00opat for <cygwin-patches@cygwin.com>; Fri, 13 Nov 2020
 10:18:15 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id 2E54DA80D91; Fri, 13 Nov 2020 10:18:15 +0100 (CET)
Date: Fri, 13 Nov 2020 10:18:15 +0100
From: Corinna Vinschen <corinna-cygwin@cygwin.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH 3/4] Fix 'make check' in utils
Message-ID: <20201113091815.GS33165@calimero.vinschen.de>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20201112194629.13493-1-jon.turney@dronecode.org.uk>
 <20201112194629.13493-4-jon.turney@dronecode.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201112194629.13493-4-jon.turney@dronecode.org.uk>
X-Provags-ID: V03:K1:ANDEo3Xs87oK6Cvux4QaUYVw36vph/wI6CqN/i4tNQgDeIiP0WN
 5YmRQLqrMGUWRwQnaThzxZzR0LrBS6nA+TGM5wf0cMabY2uViK5U0ZksIpEnO2GzezPZxbL
 h1zr/JAIk8if5gaOBJJJ84Blt2Dav5SgBFNcmd8ug5WTj+F6vzQnlq1Icnlz9BGpdsWA45v
 JQM+JhWlavGxzbaeqhkNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PeZtaCVyiS8=:mTU4LoZa/Zhl19NvEidhfM
 7hh9Cj11czwJv+7JNIbgimDUeV99T7J1bbOB3SXqyJXjWCeLbhNpHgECgWxiQtvlpVMtyahKB
 QmjU/x05p0q+FHXBowCveBOQJ3zH9XjeXvhVdd5ZsVh/f68/5oeJs+rFsjHp46Yx/fB+cHBhh
 AoiMOdlDYSvTP9GzIVUHCdo+cPqeblOozDHcgEgwsTmMOr2tGLhcCZeNA0riHMDPRS77AJOJ7
 VoR3HzNupXoSuesxp+L033AygCN8/RNyBBl4sAiWVxcdvLP6CNJVajhwKLiTn/nWrwlGJLQG7
 o1yV5qbY6U1vhySPPqt+Ob/PdiVNNNReNA/gIJ2pXlr+PcHy3f9O2kEQmPVog5q4QyUgcsvmF
 v9T0EVgOc4vXjlE2A1/v2RZbBzzV4wCNam1aKXs+HqcdH1IClK3bD0ZYyisQ1/8ayhtAK5ewo
 UeTODqTX/A==
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
X-List-Received-Date: Fri, 13 Nov 2020 09:18:18 -0000

Hi Jon,

On Nov 12 19:46, Jon Turney wrote:
> This has a test of the path translation code used in various
> utilities (mount, cygpath, strace).
> 
> MOUNT_BINARY is replaced with the absence of MOUNT_TEXT since 26e0b37e.
> The isys member of mnt_t struct was removed in b677a99b.

issys?

Other than that typo, the series LGTM.


Thanks,
Corinna
