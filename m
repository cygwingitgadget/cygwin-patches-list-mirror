Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 by sourceware.org (Postfix) with ESMTPS id 7F0003858D3C
 for <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 20:20:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 7F0003858D3C
Authentication-Results: sourceware.org;
 dmarc=pass (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1642450848;
 bh=UrmdmJoh6BgeQLESyGrSddhpUxo9AmjHW0lfjoPq52A=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=iFXIHODIhwH+lCXYkUJCO1UQfmz1a4z0y8hOsjkYDpb9iHKi2oAD1NzIHfFee7NTN
 c0PfnFhlVBju/ydfPXROKarZv0PaQirD5uvEp9DR5NgnVaglvFwMGER5I9koUfa6ak
 zgOeFd2PJczKxar3Uakl4hxwoV3xDYCND9QAPXaw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.174.184] ([89.1.213.181]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MBUm7-1n29Il13fz-00CzRq for
 <cygwin-patches@cygwin.com>; Mon, 17 Jan 2022 21:20:48 +0100
Date: Mon, 17 Jan 2022 21:20:45 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH] path_conv: do not get confused by a directory with `.lnk`
 suffix
Message-ID: <e4230b2bc45903850a4007c6f556bffe1507cc9e.1642450788.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Vm2oSmR960QnoUSrd49CCR4u6MJN6TCg5xeq9b3h3UYQt6bxXua
 QYticbMbrbfIEXjrWWEnE8aee902XTYxUDGc0jVdvrQrua+vrwA7XmKbi8/K7zQY2xDvTo8
 x2J67moPnhIxEWDzCeKBNVic5jFUk77pUDfKR4YeOGU6W+OVXcHe2EJ2dqi1GXfwLkyQIxJ
 9JsdhvoqWEwfdQnKLyW0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T8o5INvAljk=:rSs58mLwQGFiFef9kSUSTn
 C55oecE7dFPzduVkBAqBAqOqRtiolKKoFQj9GjoaPSB+XA7ioD/57PzGJbRi45Iu//k/wFNN3
 +MwngJz34NOZQ0zgRd01X2JoIOo+NzuW+HbldLHvpAGtKirr0Q909FhbpuD2MaUsOTVd5C9NO
 oZBKaTUXbFK44RPs0sNwS0xs08ouLXUkdC6/FjqnEwzzsdtm/LT97L6aMeyVvrLAOJ0N9YAhW
 QD8L1Xvpm7NWsXZIhAOIwZutS8GqSlWeGbtS2bLeBfJ4d1Dmv2ruAr8BYVZ5Iztwf5hugviiZ
 tFKj4nscQcezkYEAkmOKwK5LrKfbvxmPfYbCs9HsH99vAR8lvdHaRKdF4OhFRye/WP7cs0QWK
 KhGv0ZEJktYdmCiwp6wanYxSDXlbY3GZx4QhBI3yQJDVSTP5YddAca9o4cqIBSEMCqk/5H6Mt
 eRxS43Pq/kYrXazq3ukNVQMqkpEJ2mXaEYeo6rOcm50tpHDmqMgZqwW7SaT9aIv8BQVr051C2
 i5RRtAfsdYrmytzQE8krM2x7GRivKpJrL5EebS0C2QLVFTSwcj8Yv2y2q8qH/+9Nvhy4Zi6/x
 eDcaSyV9MiAeoHu9xvdG+U4bXIAnfrKVjTXbQOOQhqPlgSl2waSpqgFUBtzPD5NTk/nxz0Gt7
 vY/2+I2+cC2+a2Q5scYP/glK4/4eAWS2hGVISMpYcxZo0UeWIjZ69f3c+z+8VsR7xzPWrOebg
 s8maZ4/4OplcaAqwJ6TpKy5OVxajLZ2mPTFvfn8lxo9TizoR4aTSdqcRVMfQQgVa+oTgiXIRe
 zM0jbAVFGJ1wu6ZRF55etOShNj7Qhe7VIAfPYVy3YwPv6lxg/IXlKdLD8zRTYAIUtB5m44h2n
 7NzX8BllCDlBTcjghx40rmCwNNpxTRE4+8grSjw34BcJMUupnj/Z+7jI/zzt6m+2kxs9rjIom
 K1+bCLXBgzp2C61oEh0vvFsOoUmF6Y+XsahABcC1VnKE8Jd05lKL5O68GuU+18mBjMeuUy6dr
 Q0LKv3QqtO4faNchFh7hkrAGlACeBri6a6t5UA4ZoSR9AOVpJy2foPe1qC0c3DS9Lvi0Tja05
 vs250b9jXvdDwM=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-11.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H3,
 RCVD_IN_MSPIKE_WL, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.4
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
X-List-Received-Date: Mon, 17 Jan 2022 20:20:52 -0000

When trying to create a directory called `xyz` in the presence of a
directory `xyz.lnk`, the Cygwin runtime errors out with an `ENOENT`.

The root cause is actually a bit deeper: the `symlink_info::check()`
method tries to figure out whether the given path refers to a symbolic
link as emulated via `.lnk` files, but since it is a directory, that is
not the case, and that hypothesis is rejected.

However, the `fileattr` field is not cleared, so that a later
`.exists()` call on the instance mistakenly thinks that the symlink
actually exists. Let's clear that field.

This fixes https://github.com/msys2/msys2-runtime/issues/81

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/dont-con=
fuse-a-xyz.lnk-directory-for-a-lnk-file-cygwin-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime dont-confus=
e-a-xyz.lnk-directory-for-a-lnk-file-cygwin-v1

 winsup/cygwin/path.cc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/winsup/cygwin/path.cc b/winsup/cygwin/path.cc
index 5ab75f1055..87ac2404aa 100644
=2D-- a/winsup/cygwin/path.cc
+++ b/winsup/cygwin/path.cc
@@ -3336,6 +3336,7 @@ restart:
 	 hasn't been found. */
       if (ext_tacked_on && !had_ext && (fileattr & FILE_ATTRIBUTE_DIRECTO=
RY))
 	{
+	  fileattr =3D INVALID_FILE_ATTRIBUTES;
 	  set_error (ENOENT);
 	  continue;
 	}

base-commit: 1dd65a9ede44cafe8a52b8d85becca73d4fd7786
=2D-
2.35.0.rc1.windows.1
