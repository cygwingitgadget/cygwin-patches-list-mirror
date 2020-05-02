Return-Path: <Johannes.Schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by sourceware.org (Postfix) with ESMTPS id 20DC1385DC1B
 for <cygwin-patches@cygwin.com>; Sat,  2 May 2020 13:03:37 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 20DC1385DC1B
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: sourceware.org;
 spf=pass smtp.mailfrom=Johannes.Schindelin@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1588424615;
 bh=ZbW7yjECPfHRHumSeFMEoXJrEsfYQB+/xXBVsVW2L+Y=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=e+j54Z96oIJuKw4NA/LJ9my8QdpnWUg107DIKzQMDiFkECfffN9SAmWpgMhoeHYuV
 8vAQv6xagNyaqeKq4bzXBVl7VgfP8Pl+v0Fb7cPKwmrK1tNBFQC7RF+94gTyMCR+y0
 +LqbyB+qvNOlKJ6tS9jAyGG4SNCwArdoV5Jq29dQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.30] ([89.1.214.117]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1jJpB12KG8-00B85R for
 <cygwin-patches@cygwin.com>; Sat, 02 May 2020 15:03:35 +0200
Date: Sat, 2 May 2020 15:03:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH] setup_pseudoconsole(): handle missing/incorrect helper
 gracefully
Message-ID: <nycvar.QRO.7.76.6.2005021459560.18039@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qWBFwSlYBOEqXX0lXCFHlkizHijkE4tUOKLFuiW2a2ETJIMvEbQ
 GH2rQSDcOGBMMJEMcK9y3t2Mq/uVFw/WcO3qwMoVkRBB/zuGRRmkPzdFuQZVsec17wKuqKq
 xjBZ5NDAo/yZc1JZmoQ00l22JpW0C3A1Pb/1NCsHswRoybqUG14qme+pNAsWsKZmA0BNaeS
 7HHI7qVDaFXqc4VvjjUNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PLgIPSvqrxw=:3xl6/whWwA4c2+GHCJcmyn
 f1S2Xqic5lfr6j3Qi05rdazld69WPSNg1t/o/1wMzPAHzfxzAw4eXlKrntOOkHOdc5guPBi6/
 fp9698FrOaFHHJkLecWYczzQL6dY+mZm7iSvRTv5Hewoh0PuX94ZN1tm5iDDHrZvB53Vl1aAm
 v/eJ4ZxSp3yYc0izf50187DCLIK1Di363zZRndjXPOmr+VStQbnQvCxHm3NHieI425RWMIvS/
 5dz2d/iUgHjdUV7o1wExJACO9kx9eq8OsCi4ceCloARJfCdody4x8xon1lDCQBxMeyzanPHPj
 x13Oka2hyhUgQnaUP0zuYOE5sgIycqkYHU/qGbLKdguOcIIQiU0MA/ybcrHrf+nceifGKB5Ma
 pveDSFNKfC7es/8sVTbPFGklYmRolWe+N4L4YLU2XxFc+AlAEamnRX0AfnKtix52oRhHpUaWx
 J7eFe7EcMdvBVsf8EbCERWmB9Ta6OyHacBWttckLzCzrRY7PzxPB+PnC+oUa1qfkTX+coLJnw
 7Jte9XRMRIgWtZSs899IAKiiB4G+cKhCPpgz0D8WjwZJTDfeQ5Ueoe/HQiXAHrzRSEClLnBwu
 T+KbtmmlLYZ1MFcJeaSRqYzf/DpU9J2YyqDSkERSxlmwY+aRrn0DV0WTow+l9UqFhIb+Q8ed+
 KglLV0chKPk0xqroi4GAltbXb3IOjzlIFc5u0drnDo5xIQ9VyvOJq4ts1GRQp45IU2TT8Zy/h
 SGXLBu7IiuJiZv8lsD8c9d+cUDwxzShR7kGGdBNUYYCrR9lXsKjCIOtXj4ou7lfo7fpT0Mp8L
 ce/YGYiy2LyIzCbkoU6mNwBVKcM/7AD+1zYzN0qLclqWje/VPKPv1AXmyefHGTevmznJkwkpq
 rnoQXY97oFjMLk81xEjPsLxIymDJQ1+eSBLbZtZgNrp+8AM0JILRUwRXxdG/0TOYD3SkgaJgQ
 7uHbXJsQhXH513Xg4TtvVyGNuAMjSiFMa8YyQ7E3w7CDPhSoqVMIvPEJne6Vqi//rLYDlNQTg
 RHCm7DDosL3xiGiMdqcLzMMP5pfE8jEki7YSoKkhxLsLO2akkKBbXH9Rm191MPlJ74GDyM0PS
 aGdaOxXCiy5v0xm+7Z+feZxilH1nktLaTkr7yUFe79rXmHxNgUmLYwBJdS7eYxlkJxuz7amDN
 hiBeZsTfj3/DdWoHcnuwLwGU9t9DYoWx4DiAbiVU8Qn6zy0PwuLeo3C3ijqXBbf9fhMz2qaiG
 yQyT59Ob/kkkNenRY
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-26.8 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, GIT_PATCH_1, GIT_PATCH_2, GIT_PATCH_3,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H4, RCVD_IN_MSPIKE_WL, SPF_HELO_NONE,
 SPF_PASS, TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <http://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <http://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Sat, 02 May 2020 13:03:47 -0000

When `cygwin-console-helper.exe` is either missing, or corresponds to a
different Cygwin runtime, we currently wait forever while setting up
access to the pseudo console, even long after the process is gone that
was supposed to signal that it set up access to the pseudo console.

Let's handle that more gracefully: if the process exited without
signaling, we cannot use the pseudo console. In that case, let's just
fall back to not using it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--

	It took me three days to bisect why my test build of the MSYS2
	runtime hung MinTTY. Three complete days.

	The reason? I missed that `cygwin-console-helper.exe` needs to be
	copied into the test environment, too, not just the DLL.

	In hindsight, it would have been smarter to just attach to the
	hanging process, but then, I thought if MinTTY is hanging, then
	surely GDB will hang, too.

 winsup/cygwin/fhandler_tty.cc | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler_tty.cc b/winsup/cygwin/fhandler_tty.cc
index b2e725d5d..8547ec7c4 100644
=2D-- a/winsup/cygwin/fhandler_tty.cc
+++ b/winsup/cygwin/fhandler_tty.cc
@@ -3496,7 +3496,23 @@ fhandler_pty_master::setup_pseudoconsole ()
 			 TRUE, EXTENDED_STARTUPINFO_PRESENT,
 			 NULL, NULL, &si_helper.StartupInfo, &pi_helper))
       goto cleanup_event_and_pipes;
-    WaitForSingleObject (hello, INFINITE);
+    for (;;)
+      {
+        DWORD wait_result =3D WaitForSingleObject (hello, 500);
+	if (wait_result =3D=3D WAIT_OBJECT_0)
+	  break;
+	if (wait_result !=3D WAIT_TIMEOUT)
+	  goto cleanup_helper_process;
+	DWORD exit_code;
+	if (!GetExitCodeProcess(pi_helper.hProcess, &exit_code))
+	  goto cleanup_helper_process;
+	if (exit_code =3D=3D STILL_ACTIVE)
+	  continue;
+	if (exit_code !=3D 0 ||
+	    WaitForSingleObject (hello, 500) !=3D WAIT_OBJECT_0)
+	  goto cleanup_helper_process;
+	break;
+      }
     CloseHandle (hello);
     CloseHandle (pi_helper.hThread);
     /* Retrieve pseudo console handles */
=2D-
2.26.1.windows.1


