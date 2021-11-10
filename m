Return-Path: <corinna-cygwin@cygwin.com>
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
 by sourceware.org (Postfix) with ESMTPS id 0293A3858400
 for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021 20:32:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 0293A3858400
Authentication-Results: sourceware.org;
 dmarc=fail (p=none dis=none) header.from=cygwin.com
Authentication-Results: sourceware.org; spf=fail smtp.mailfrom=cygwin.com
Received: from calimero.vinschen.de ([24.134.7.25]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MNKqC-1n5Kns2Qri-00Oq9C for <cygwin-patches@cygwin.com>; Wed, 10 Nov 2021
 21:32:54 +0100
Received: by calimero.vinschen.de (Postfix, from userid 500)
 id E478FA80A5B; Wed, 10 Nov 2021 21:32:53 +0100 (CET)
From: corinna-cygwin@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH 0/2] Fix a bad case of absolute path handling
Date: Wed, 10 Nov 2021 21:32:51 +0100
Message-Id: <20211110203253.2933679-1-corinna-cygwin@cygwin.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:GC2/wZMGxJ4EGGxjHj0CcGyzUQ9lu052cU6D8xesGU43FVjRsVj
 0l/H0G23p463AVPFT2QjpOD38Ab5u3HqArbpoMTjXVGHVzGJwsR6/ZRNCifU6ahiK8MEheX
 A462IUrypIEnKwxP7WaIO8CwrSleLyHVRu1H9TfgAYtSA9jEjT5Vro/3bl0ukdxdoZshRji
 vuKxq2oBBOsqPtqUEyOOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9zYeWg2KQ/o=:0/v1HmiNCmjrWDlTonK914
 CFau9ezDkOjJfo0cQKpKgSyQ2PWFIxoVN5KXtUw0TOOW2EbApRO2klz5t0BV9YAvRJZcE3zhd
 SFYVy9URZ4/wAQf9dv6TAL6uE2O66EAgGm7YHU3X2fuC7Wj7YCTP7tiNspwDyK1L6IkIpVI3q
 CMQF2vXzUBMqZ3H9cvHzxWDHRQjxZ9tZgXvjJPSopQKs1soNygLCY5dxxe/XDzjKejFPAAl40
 DR1Jahhh4QJ3CeWuWQMzzNVHAeK/T/gWReiQCQgyJcZ6tKXMoaV79PBJVb56bzeEcnCf5AQnl
 gCxYjBrtIiVyBq7Sez+i1Nm35mQgjXCpNV3JcfuncwylaK3j7lWkRW0wC4UhqhKIGRWbcurf1
 2OtZPZJq0q1Gdi4xPOoLrHpIuplzLpf9n/OvlgU4Fk3HjdHyFqGPD3lorM0J0ONgIa2aFCxaw
 KgIc5t8bhbi4SSBnoShKMJhWbU+WPEMWjXvn1XX0kDwQ79QQF2LIxh/oCKQT+PtVUyqAKFrIS
 4/KhoMiYZftVaOxjdkncJr5uNxnkg1q9RLeekfsVC7dDAstQ628Oczit7ePXxCDM69erm9jf6
 H83hXug/usDB8cmBu26UquHoVIsN3HaW0KmpVwvfqWGJW2MtygLFC6wzpRFYR5CPZw6jEKyxi
 JEtyCGMwAYdltzpTPA2cEne2oL4ATwNll1W+/8SdDlGNtX00plN4KXKcY93QErELClz0mpDnd
 w49iEDylY0LVACFT
X-Spam-Status: No, score=-49.2 required=5.0 tests=BAYES_00, JMQ_SPF_NEUTRAL,
 KAM_DMARC_NONE, KAM_DMARC_STATUS, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE,
 SPF_NEUTRAL, TXREP autolearn=no autolearn_force=no version=3.4.4
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
X-List-Received-Date: Wed, 10 Nov 2021 20:32:57 -0000

From: Corinna Vinschen <corinna@vinschen.de>

As I told Takashi in PM, I will try to more often send patches to the
cygwin-patches ML before pushing them, so there's a chance to chime in.

This patch series is supposed to address the `rm -rf' problem reported
in https://cygwin.com/pipermail/cygwin/2021-November/249837.html

It was always frustrating, having to allow DOS drive letter paths for
backward compatibility.  This here is another case of ambiguity,
triggered by the `isabspath' macro handling "X:" as absolute path, even
without the trailing slash or backslash.

Check out the 2nd patch for a more detailed description.

While at it, I wonder if we might have a chance to fix these ambiguities
in a better way.  For instance, consider this:

  $ mkdir -p test/c:
  $ cd test

As non-admin:

  $ touch c:/foo
  touch: cannot touch 'c:/foo': Permission denied

As admin, even worse:

  $ touch c:/foo
  $ ls /cygdrive/c/foo
  foo

As long as we support DOS paths as input, I have a hard time to see how
to fix this, but maybe we can at least minimize the ambiguity somehow.


Corinna


Corinna Vinschen (2):
  Cygwin: drop unused isabspath_u and iswabspath macros
  Cygwin: introduce isabspath_strict macro

 winsup/cygwin/syscalls.cc |  2 +-
 winsup/cygwin/winsup.h    | 20 ++++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

-- 
2.31.1

