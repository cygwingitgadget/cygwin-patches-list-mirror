Return-Path: <SRS0=zOcd=YS=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	by sourceware.org (Postfix) with ESMTPS id 91EF63858C2D
	for <cygwin-patches@cygwin.com>; Tue,  3 Jun 2025 07:28:33 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 91EF63858C2D
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 91EF63858C2D
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.21
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1748935714; cv=none;
	b=WbZfkOmzFP8FcS5fJ1XPMKmK7Gu0T2Bdgs4tjmU/cVJfU8icahuYKg6PcMmF1cYfyLOwDz9mp89YVbN2oUUqg+dMWgsFw3oNivkVsEKwZM4os/OFTrnBmiNfmjYFeQXLw4DCZ2YUypuMu3Hz2TKTqXhFy2ymZBX8qSYY3ct/6Ic=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1748935714; c=relaxed/simple;
	bh=AG1Tcwq1vmeb9dtjcrplwR71z41pxc6TTy1ZM4er+qM=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=d/tR+i9wgkuFwZxMJrZ6mL/UQbPYHjvNVd83xuse3NOGlo8AbD24AYh6GQy8VdkfDUOH0Ub9UFibMQQfx4QwyyvNT+UNrSlwTAJlnI4Bfo4IYS0zDj+lNqyFy6gnMdQYg6b3FGmLtopswqK/tRW2Ujuh6ExAFDpfJbFqVzGOIAg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 91EF63858C2D
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=Tc+ANOUt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748935712; x=1749540512;
	i=johannes.schindelin@gmx.de;
	bh=m4ghByPT1r58cqU9quEZsidBoLa96zBgdFZ2sdpOqUM=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Tc+ANOUtwpGpKFEPDYu0w5T8jZH/wn0EeHfKuagmSPlTfI2Q0fhEq0x83gULP8qv
	 xMX2zHWMAiHtCzKDjJ1cRucBO02zLXhjQ64FORtRz47+cRNCLrC6ZZhLPIBIzdgVJ
	 cyV/q8utruuYDlRDL6nilijl2tZKiw+rhIPVMkEDQYclS+VcSNUkDPqtVa8r4IgaI
	 1e/UFTQcLhJXAHBl5YTfzWNNqx7VSnN7BYvY0bZCXTYhgmcV9gwWVS9vXY7UI4X67
	 FWy60yErJgXelN0XURz1aBS3P4eKyHOuYNcrewrhGM254OHtr2OhrWL7g6+ePxHNi
	 S1a4lvcuBmHpf+9Ykg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.83]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oBx-1v7sBG4BFd-017cj0; Tue, 03
 Jun 2025 09:28:32 +0200
Date: Tue, 3 Jun 2025 09:28:29 +0200 (CEST)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
cc: Robert Fensterman <minnmass@gmail.com>
Subject: [PATCH] Cygwin: do retrieve AzureAD users' information again
Message-ID: <d8fb04d38a45dc3fab500a2cd3ea151b8bf62c9c.1748935646.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gZkIPzbb7jnyh4YNbMydWw9GxNHo2LWHL667IzEHS3TfU9Djqb4
 VcjcN5uEzNiknzF2T6313njJfGOC/pUc+AfI03JpOZ5cL8owOsu3j876pPMR4o5B7AcOMKZ
 IDNQbLFsHUdtqMlbcvnTrPHLK/GrrbmlqxdIGKzrtmscQSCIBGYiUCnZOj14HR9KZeNnIuG
 54HsbqHXoecmaS/ofw1QQ==
UI-OutboundReport: notjunk:1;M01:P0:1cEWT8H3w8c=;o40PM951gj7Eu1qOopeYNe0lmzf
 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
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,MALFORMED_FREEMAIL,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

In e04891d67a (Cygwin: fetch_account_from_windows: skip LookupAccountSid
for SIDs known to fail, 2025-04-10), several SIDs acquired a shortcut
where a potentially expensive `LookupAccountSid()` call is avoided for
SIDs that "cannot be resolved".

However, as reported by Robert Fensterman (and independently discovered
by myself), some of the SIDs that received this special shortcut _do_
get resolved by `LookupAccountSid()` calls: AzureAD users' SIDs.

With those SIDs, that newly-introduced shortcut actually does more harm
than good because there is no other way to retrieve the desired
information, resulting in permission problems.

One symptom of this is that `mintty` can no longer access `/dev/ptmx`
and simply errors out with "Error: Could not fork child process: There
are no available terminals (-1)".

Another symptom is that `tmux` is no longer able to create new sessions.
Yet another symptom is new files are unintentionally written with
restricted permissions (copying an `.exe` file, for example, disallows
the copied version to be executed).

The most likely reason why AzureAD SIDs were included in above-mentioned
commit is that special AzureAD _group_ SIDs are not recognized by
`LookupAccountSid()`, as per the code comment for the `azure_grp_sid`
variable. It is plausible that this fact was mistaken to extend to all
AzureAD SIDs, a notion disproved by the counter example of my personal
experience with my own AzureAD user account. Unfortunately, the only way
to find out whether `LookupAccountSid()` works with a given AzureAD SID
or not is to call that function.

To make regular AzureAD user accounts work again, let's just drop the
AzureAD part from that special shortcut.

My understanding of the other SIDs handled by that shortcut (Capability
SIDs, IIS APPPOOL and Samba user/group SIDs) is insufficient to
determine whether they, too, can be resolved by `LookupAccountSid()` in
some cases (and would therefore equally need to be excluded from that
shortcut). At least as far as the Capability SIDs go, I am rather
confident from reading the context (the commit's message, as well as the
report that led to that commit) that the shortcut is safe, and I could
imagine that the same is true for IIS APPPOOL and Samba SIDs. Absent any
further insight, I therefore decided to leave the rest of e04891d67a
(Cygwin: fetch_account_from_windows: skip LookupAccountSid for SIDs
known to fail, 2025-04-10) intact.

Reported-by: Robert Fensterman <minnmass@gmail.com>
Fixes: e04891d67a (Cygwin: fetch_account_from_windows: skip LookupAccountS=
id for SIDs known to fail, 2025-04-10)
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/support-=
azure-ad-users-again-cygwin-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime support-azu=
re-ad-users-again-cygwin-v1

 winsup/cygwin/uinfo.cc | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/winsup/cygwin/uinfo.cc b/winsup/cygwin/uinfo.cc
index 83883f9f65..ffe71ee072 100644
=2D-- a/winsup/cygwin/uinfo.cc
+++ b/winsup/cygwin/uinfo.cc
@@ -1996,10 +1996,6 @@ pwdgrp::fetch_account_from_windows (fetch_user_arg_=
t &arg, cyg_ldap *pldap)
       if (sid_id_auth (sid) =3D=3D 5 /* SECURITY_NT_AUTHORITY */
 	  && sid_sub_auth (sid, 0) =3D=3D SECURITY_APPPOOL_ID_BASE_RID)
 	break;
-      /* AzureAD SIDs */
-      if (sid_id_auth (sid) =3D=3D 12 /* AzureAD ID */
-	  && sid_sub_auth (sid, 0) =3D=3D 1 /* Azure ID base RID */)
-	break;
       /* Samba user/group SIDs */
       if (sid_id_auth (sid) =3D=3D 22)
 	break;

base-commit: 972872c0d396dbf0ce296b8280cee08ce7727b51
=2D-=20
2.49.0.windows.1.9.g16d82dcdbba1
