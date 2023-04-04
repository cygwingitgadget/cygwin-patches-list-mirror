Return-Path: <SRS0=8BlN=73=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 7ECA13858434
	for <cygwin-patches@cygwin.com>; Tue,  4 Apr 2023 15:07:43 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7ECA13858434
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680620861; i=johannes.schindelin@gmx.de;
	bh=2+jCq8wZf9SYxD8xnf9o+QXJBTlNfgX3A4uVo2jQCHY=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=E4cU2InAztqz0WGCTaq8KKbl4Bnhl45fRFcfwzyu32KJIqbinOtF05zKICwi0ynkX
	 VWMIxdo4qR480GIK7TiEQzmQQbwkcNHCDxXlP+3LmhRAp1I5ZVtyOUb1zM1vyUSkUp
	 t1FvTQtXDMVo/oDZI/gAv3CP3l9U74OaoR4a/LqbSMuq7j2//btxveOZC3de9ygFGa
	 Rcr5zIWSaSf2B0US7dV2nASi7Q+AH37h290lw2RuBGlyQxWU2Ov3YUUWi8vVRmyUlL
	 9UCW6T1brB4bGGzV8jouT/HgpzU5ipiA0KtqMrh87rOfN201Q7DXuemWvvRVkdc+Pu
	 z1rdpPpmt+dbg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MQeA2-1q5D9H30cw-00Njtw for
 <cygwin-patches@cygwin.com>; Tue, 04 Apr 2023 17:07:41 +0200
Date: Tue, 4 Apr 2023 17:07:40 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v6 0/4] Support deriving the current user's home directory
 via HOME
In-Reply-To: <cover.1680532960.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1680620830.git.johannes.schindelin@gmx.de>
References: <cover.1680532960.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vq6rvcz0pq88kQIb18TV6mZ98w0s+B8cj1bk0n7fJTexbvk7tXc
 hXTE3WZB5LnuCJvqK0xN3aRLRPjsC/HeYlLSOtsgb83SJakrIa+ezSSkECBcBtuja3lI58h
 Xn5tQRWQRQ2hsctqFgNZzJotOPzH4HYR3psHZg5gHoUhYKPPOC/xIMwyPXJHxD43+fhwZDm
 vjvCO/t0nZouy4MGjxJNQ==
UI-OutboundReport: notjunk:1;M01:P0:AFrLXAuGXQg=;2r45KkP6U1nvqEgz3kqIDxs92PC
 KGi2UCpmuuj6OfmoZuwERKMJbaJGgM/leY/iF9UqcdXG2MZ4jbX55kobJcsxLDutDQNeZVmZq
 qbMOSxyLCarjtCA2iC7yHvTW29grvEmgTwi7YZvUUcdSjC35tZRi54XfTn8vV5P+/MmnIekbF
 xShkkIpN2QsqwX/dXMC97t4EJtpU4ZlklM0lEAFOys502k1RY/wscnGZ5UFyv1fTdje9lKrkv
 13C3v+FFqw+POOI1w5W4CJ5lTLlW0HFVeKwWG0lf3koy1ylwvcUgW2tQiyA00vdqFEf71tiU7
 XlqhD8NySeiPCL3MRZSwh927qh4LtC9K+ml10V76Wy9p2L37ik64yJ5NYzsPuVDhDAcf3po+u
 AqrxaWIStzq/O5QUNOMTOLYs4p58QYI0/t5fKs/SMwNzUDS/Xmn4xKWDN5/AjrY7XbAVLjyhS
 U5G/UkWa2j0+q4tYzCzaHFLKUswcQMvDlitHBMyzub65/Lvu0fxBBv7nqXLR49K0qANqG6lS/
 AXbKAIBQA8+YI3d1uKbO8lgZ1QT2U2qYWICg6q7R5p7l1gq/3fKtxp7Hatw5kqDR5mJzsMnD5
 Iu2uVdpb0bud/PRVuLCc7GPoQGuoBBx6/IGbMrXVsjCmfHtnJ+6L92jDIhHb0Y75A26CXs1Sw
 A1c/oG27HMbWC+RW+KtC2vhazi2n6zcmHcn7GcHN3ePqz1HaIrALv8226IfsiZOQRMQzFfNxv
 GolTbiHrxszTqmXZdiM++5VwWI+V++n7M3c83H0t45OlIaAtZ6kVIpvYxVI3e2EtaRwS4yhFV
 tJzqDQ3bU1hyDBJsmEZfDGhzQRRM+/b5juGvC5q7Cimdm/YvLoj8aAxlZSK5iwt6Q5dDZMFLU
 I4IOtETalQCft6k9WB7362eCVd61LTfEAGiNyEtWp/E8ErJ6OLrsXN0Z5Tp/iuHOLY4+FBrSX
 HMWh3Q==
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch series supports Git for Windows' default strategy to
determine the current user's home directory by looking at the
environment variable HOME, falling back to HOMEDRIVE and HOMEPATH, and
if these variables are also unset, to USERPROFILE.

This strategy is a quick method to determine the home directory,
certainly quicker than looking at LDAP, even more so when a domain
controller is unreachable and causes long hangs in Cygwin's startup.

This strategy also allows users to override the home directory easily
(e.g. in case that their real home directory is a network share that is
not all that well handled by some commands such as cmd.exe's cd
command).

NOTE! This iteration presents patches 1 & 2 only for completeness' sake
and for backporting, as they have been applied to Cygwin's main branch
already.

Changes since v5:

- Replaced the third patch by a patch that imitates AzureAD account
  handling also for IIS APPPPOOL ones.

- Added a fourth patch to fix a bug in the first patch (which
  unfortunately was already applied in the buggy form) where _very
  early_ calls to `internal_pwsid ()` would result in completely bogus
  home directory values.

Changes since v4:

- Squashed in Corinna's documentation fixes (read: patch 1 should not be
  applied to Cygwin's main branch, it's presented here for backporting
  purposes).

- Fixed the commit message of the second patch that mistakenly claimed
  that Microsoft accounts would be associated with `/home/SYSTEM`.

- Completely overhauled the commit message of the third patch to motivate
  much better why this fix is needed.

Changes since v3:

- Fixed the bug in v2 where `getenv("HOME")` would convert the value to
  a Unix-y path and the `fetch_home_env()` function would then try to
  convert it _again_.

- Disentangled the logic in `fetch_home_env()` instead of doing
  everything in one big, honking, unreadable `if` condition.

- Commented the code in `fetch_home_env()`.

Changes since v2:

- Using `getenv()` and `cygwin_create_path()` instead of the
  `GetEnvironmentVariableW()`/`cygwin_conv_path()` dance

- Adjusted the documentation to drive home that this only affects the
  _current_ user's home directory

- Using the `PUSER_INFO_3` variant of `get_home()`

- Adjusted the commit messages

- Added another patch, to support "ad-hoc cloud accounts"

Johannes Schindelin (4):
  Allow deriving the current user's home directory via the HOME variable
  Respect `db_home` setting even for SYSTEM/Microsoft accounts
  uinfo: special-case IIS APPPOOL accounts
  Do not rely on `getenv ("HOME")`'s path conversion

 winsup/cygwin/local_includes/cygheap.h |   3 +-
 winsup/cygwin/uinfo.cc                 | 170 +++++++++++++++++++++++--
 winsup/doc/ntsec.xml                   |  20 ++-
 3 files changed, 181 insertions(+), 12 deletions(-)

Range-diff:
1:  e26cae9439 =3D 1:  e26cae9439 Allow deriving the current user's home d=
irectory via the HOME variable
2:  085d4dd8b6 =3D 2:  085d4dd8b6 Respect `db_home` setting even for SYSTE=
M/Microsoft accounts
3:  cf47afceba < -:  ---------- Respect `db_home: env` even when no uid ca=
n be determined
-:  ---------- > 3:  9b79624368 uinfo: special-case IIS APPPOOL accounts
-:  ---------- > 4:  8ac1548b92 Do not rely on `getenv ("HOME")`'s path co=
nversion

base-commit: a9a17f5fe51498b182d4a11ac48207b8c7ffe8ec
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/home-env=
-cygwin-v6
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime home-env-cy=
gwin-v6

=2D-
2.40.0.windows.1

