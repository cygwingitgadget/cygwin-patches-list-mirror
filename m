Return-Path: <SRS0=7Fjc=72=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by sourceware.org (Postfix) with ESMTPS id E085A3858D37
	for <cygwin-patches@cygwin.com>; Mon,  3 Apr 2023 14:44:55 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org E085A3858D37
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1680533094; i=johannes.schindelin@gmx.de;
	bh=XXi0Ad7cOhRiRhp2Fl9SXxcHNcQUnQ8pdcs/CG35RjU=;
	h=X-UI-Sender-Class:Date:From:To:Subject:In-Reply-To:References;
	b=R0W26cLPwwLr3l9cZtwYo5GkS6WZCDjtuMHFkUUBamu3i8eu1DfEVUvjgdATW/vrO
	 wz0+K8a1XlqC9U3mgAkHCn9ISjzOkg5xEPguue+Esso4Qn3HQOfOUc69xq/KYdOcSa
	 hCIielWRWR7AyngUBcXM2i2EGi1ZnAtOeAdY+bvWVOIbg61E5BJF6QQvtiqa6z6iZ0
	 tOByOlTpz7vEGF2YII0Ay+ptG/8oJLEB/+y7K00snx8pPrMYjQlQIuicy0TFnOItyW
	 LTTK3klmioRO0gTcxnNAZkmJWX6q32x5egDfeoo/S3lcpRFNLF44aNBuINLhy9ZUJC
	 au8+nhGAYJudQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.182]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N2mFi-1qQ0Pi2d1Y-0136M6 for
 <cygwin-patches@cygwin.com>; Mon, 03 Apr 2023 16:44:54 +0200
Date: Mon, 3 Apr 2023 16:44:53 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH v5 0/3] Support deriving the current user's home directory
 via HOME
In-Reply-To: <cover.1679991274.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1680532960.git.johannes.schindelin@gmx.de>
References: <cover.1679991274.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4rbqlyC3Kjngz9DBUXBDj3cyxfiLEhwaUehWiFkUWJxMVNAIU+Z
 K9Gh4W8oU07QpIYa6ywkCyptDYYricXW7/6HLxVOBWUYMprvQqDCW0YjQGNLFLIDuW3cjUq
 0hfBhd1OYwWKxiRKXOGF0/zUGCw/CVNNlz6ux2KI3acUyaHSMp3Jl+r3+KagCi7GyxQHK33
 4qIWQGNBJb8HQVwalhXBg==
UI-OutboundReport: notjunk:1;M01:P0:gnhkMZAIndU=;oYwspM2/uF1vDSlcKvDsvrTDFjv
 GvQYhmFx2tWKRK+S3b92+WmGy2nDxqN49j/ZxA486Imi07CJGxiy67vCsHAQzoEEuruTUQNh7
 2qk1j0rYNe8Q1MOxr8PwLsYdzDSxxKUCYJ45AOApLxivSeK8HdsQdqM23fUaAxw7Ya0pdYm0x
 PcjtX923x/t6mV/smWels1ENYZIUGMmzMwF2bhp+HmhlCBdu6Hjk9XqgBLccpiB71/4HpaCnU
 XVigeG2u0XN6BaIAWzZj5N3gEVuAl7YWp/h5vt0QUoKQEuQXQuNNVGTNXlBdCYDwOmudUV53y
 RAeTziZxB8Ho1qcHKdOeYSMZICEdrfQL0uKAioXx4v5pJqLnNA89BZcausbMRhMjcsSkYoHuB
 +uuh/LnWhRuSqRN31oyF4OW01iUhkVXDtqBiLpKjA6IyscArndpUu58KGt9+GEPVOBSTrG/nX
 qiwDgqxpv7MH9rxyw3ErwuDniLVlSSdwkL675HChP/X7Qb3WQHYHMUUdgq2o1mgMCQM+hASC2
 SG/AnmgR3bHZog6VXZ0yrWyi3mMPBkKlp3/6dnz7hvoP83F/PEYwHQewXdxeqg0GhBA3eIdac
 9HP+DItB4ofOvLubj214bN9J3twMzdrQ/LS7B5HYdQkeekYkojy/ckcLAOnyXOk4KL9OAJYK0
 8sn6AgllX14azcDMD4vb+FLYYN1x8vZLWkX2m9fqjxO14sKC0Wv5eV6kwI+BZOHAa0d1mgo+5
 ZnfA+Y9efnvLfMscpN8qLEBEveAYBi7QU7iiuIFhgNRGtYzIfPSXiYTkaXA4wyP6RcIJ/Yz+G
 A4AJfi4vbEHqGkDx7djq9ANv6V9AGZrk0gL8UI97uZnts6alGVGDWfaIrHb08zi36zPUEfiEc
 MT02m/SridRRawQ9jU4xgrX8dG05sn2Ury/EDu9AdXvf+OpIx+obnQduVZqgPzql4vynybU1j
 skmEC0XXqD6lWCK8QUJykPxy9l0=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This patch mini-series supports Git for Windows' default strategy to
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

Johannes Schindelin (3):
  Allow deriving the current user's home directory via the HOME variable
  Respect `db_home` setting even for SYSTEM/Microsoft accounts
  Respect `db_home: env` even when no uid can be determined

 winsup/cygwin/local_includes/cygheap.h |  3 +-
 winsup/cygwin/uinfo.cc                 | 70 ++++++++++++++++++++++++--
 winsup/doc/ntsec.xml                   | 20 +++++++-
 3 files changed, 88 insertions(+), 5 deletions(-)

Range-diff:
1:  7a074997ea ! 1:  e26cae9439 Allow deriving the current user's home dir=
ectory via the HOME variable
    @@ Commit message
         Of course this scheme needs to be opt-in.  For that reason, it ne=
eds
         to be activated explicitly via `db_home: env` in `/etc/nsswitch.c=
onf`.

    +    Documentation-fixes-by: Corinna Vinschen <corinna@vinschen.de>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## winsup/cygwin/local_includes/cygheap.h ##
    @@ winsup/cygwin/uinfo.cc: cygheap_pwdgrp::get_gecos (PUSER_INFO_3 ui,=
 cygpsid &sid
      	  if (ui)

      ## winsup/doc/ntsec.xml ##
    +@@ winsup/doc/ntsec.xml: and on non-AD machines.
    + </para>
    +
    + <para>
    +-Four schemata are predefined, two schemata are variable.  The predef=
ined
    ++Five schemata are predefined, two schemata are variable.  The predef=
ined
    + schemata are the following:
    + </para>
    +
     @@ winsup/doc/ntsec.xml: schemata are the following:
      	      See <xref linkend=3D"ntsec-mapping-nsswitch-desc"></xref>
      	      for a more detailed description.</listitem>
        </varlistentry>
     +  <varlistentry>
     +    <term><literal>env</literal></term>
    -+    <listitem>Derives the home directory of the current user from th=
e
    -+	      environment variable <literal>HOME</literal> (falling back to
    -+	      <literal>HOMEDRIVE\HOMEPATH</literal> and
    -+	      <literal>USERPROFILE</literal>, in that order).  This is fast=
er
    -+	      than the <term><literal>windows</literal></term> schema at th=
e
    -+	      expense of determining only the current user's home directory
    -+	      correctly.  This schema is skipped for any other account.
    -+	      </listitem>
    ++    <listitem>Utilizes the user's environment.  This schema is only =
supported
    ++	      for setting the home directory yet.
    ++	      See <xref linkend=3D"ntsec-mapping-nsswitch-home"></xref> for
    ++	      the description.</listitem>
     +  </varlistentry>
      </variablelist>

    @@ winsup/doc/ntsec.xml: of each schema when used with <literal>db_hom=
e:</literal>
     +	      environment variable <literal>HOME</literal> (falling back to
     +	      <literal>HOMEDRIVE\HOMEPATH</literal> and
     +	      <literal>USERPROFILE</literal>, in that order).  This is fast=
er
    -+	      than the <term><literal>windows</literal></term> schema at th=
e
    ++	      than the <literal>windows</literal> schema at the
     +	      expense of determining only the current user's home directory
     +	      correctly.  This schema is skipped for any other account.
     +	      </listitem>
2:  a70c77dc8f ! 2:  085d4dd8b6 Respect `db_home` setting even for SYSTEM/=
Microsoft accounts
    @@ Commit message
         Respect `db_home` setting even for SYSTEM/Microsoft accounts

         We should not blindly set the home directory of the SYSTEM accoun=
t (or
    -    of Microsoft accounts) to /home/SYSTEM, especially not when that =
value
    -    disagrees with what is configured via the `db_home` line in the
    -    `/etc/nsswitch.conf` file.
    +    of Microsoft accounts) to `/home/<name>`, especially
    +    `/etc/nsswitch.conf` defines `db_home: env`, in which case we wan=
t to
    +    respect the `HOME` variable.

         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

3:  4cd6ae7307 ! 3:  cf47afceba Respect `db_home: env` even when no uid ca=
n be determined
    @@ Metadata
      ## Commit message ##
         Respect `db_home: env` even when no uid can be determined

    -    In particular when we cannot figure out a uid for the current use=
r, we
    -    should still respect the `db_home: env` setting. Such a situation=
 occurs
    -    for example when the domain returned by `LookupAccountSid()` is n=
ot our
    -    machine name and at the same time our machine is no domain member=
: In
    -    that case, we have nobody to ask for the POSIX offset necessary t=
o come
    -    up with the uid.
    +    When we cannot figure out a uid for the current user, we should s=
till
    +    respect the `db_home: env` setting.

    -    It is important that even in such cases, the `HOME` environment v=
ariable
    -    can be used to override the home directory, e.g. when Git for Win=
dows is
    -    used by an account that was generated on the fly, e.g. for transi=
ent use
    -    in a cloud scenario.
    +    This is particularly important when programs like `ssh` look for =
the
    +    home directory of the usr, the user overrode `HOME` to "help" Cyg=
win
    +    determine where the home directory is. Cygwin should not ignore t=
his.

    -    Reported by David Ebbo.
    +    One situation where we cannot determine a uid is when the domain
    +    returned by `LookupAccountSid()` is not our machine name and at t=
he same
    +    time our machine is no domain member: In that case, we have nobod=
y to
    +    ask for the POSIX offset necessary to come up with the uid.

    +    Azure Web Apps represent such a scenario, which can be verified e=
.g. in
    +    a Kudu console (for details about Kudu consoles, see
    +    https://github.com/projectkudu/kudu/wiki/Kudu-console): the domai=
n is
    +    `IIS APPPOOL`, the account name is the name of the Azure Web App,=
 the
    +    SID starts with 'S-1-5-82-`, and `pwdgrp::fetch_account_from_wind=
ows()`
    +    runs into the code path where "[...] the domain returned by
    +    LookupAccountSid is not our machine name, and if our machine is n=
o
    +    domain member, we lose.  We have nobody to ask for the POSIX offs=
et."
    +
    +    In such a scenario, OpenSSH's `getuid()` call will receive the re=
turn
    +    value -1, and the subsequent `getpwuid()` call (whose return valu=
e's
    +    `pw_dir` is used as home directory) needs to be forced to respect
    +    `db_home: env`, which this here patch does.
    +
    +    Reported-by: David Ebbo <david.ebbo@gmail.com>
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## winsup/cygwin/uinfo.cc ##

base-commit: a9a17f5fe51498b182d4a11ac48207b8c7ffe8ec
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/home-env=
-cygwin-v5
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime home-env-cy=
gwin-v5

=2D-
2.40.0.windows.1

