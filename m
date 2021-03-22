Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by sourceware.org (Postfix) with ESMTPS id 0F177385E455
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 15:51:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 0F177385E455
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N79uI-1lj8MI344C-017XYj for
 <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 16:51:46 +0100
Date: Mon, 22 Mar 2021 16:51:48 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 2/2] Allow executing Windows Store's "app execution aliases"
In-Reply-To: <cover.1616428114.git.johannes.schindelin@gmx.de>
Message-ID: <1c2659f902a45fe957e618d383b47df4e5e0cfb7.1616428115.git.johannes.schindelin@gmx.de>
References: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
 <cover.1616428114.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:XBsLBKQgr0r5kRnmoBM9b+d3mGWsuiPS4Pjkq94Qaz/DNDD3W+J
 cona3DyK//prjBRqPLCpar0PHngDqDBZFB325pR+t6gMiDRlXEbZNzvzCx+F4v2VIU1yJUB
 vU4fn9VbqW+HvvCmxVSy7oDupzmuH6z1n39d7GEi9S/AEyBKB6KvyanbNq9r9cz97MM0ddO
 ndKIRWbUpdw1FYapgGFeg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Vhw0ZeRXVQA=:ITiVRwU8k88qiCBElXfgNl
 X2NsikpMBY3E/nFBmTVD9nKjLV/qovxQz3BP6eXs2AkPU6xTlCWXya/bDuS9jBpI8j3J5cAWD
 Ecj8OMtXBdiRIYFGnngDmqQUKgeZrhySPsacRr301bjEq6to4/qV6yUd355+ABERwOVY5hdVw
 W8oP5qjt/OmRjj5xRV9Vj+CFDEBoRgb59gedwMKE3la1o7o6P3lpQ9d2FPT/rGYzlUlxZoc7S
 WaORxBvCOVURG55z/k3CDH+IO/FQnM7vBnuUb6LfRU8W7M0jVfRVXygZYuq/gf/w4Supe7Kqi
 KpUZMQAVy697MyVSqXc4MAeKWiJ9C4AYJPcRRk/O503FOK58RSyxlQz6N8ngEE7Uoj85+RqoN
 je2QMCrDePkZhRz2WjMi+DBAbpzw9BWqBIbC3w5WPua3zoj7Rxt23KtItRIUDMz/2T5mz94Ah
 881ebYcpuWAtY/opKskham1RSguvtIkypXpjKXbjfKpt4Is9fqdNgYUTm0hI7nzjiPwBeQQe9
 bbyBEHNplUgUX93qXQjNl0t2QAgw3tYyG8bQR5kQuxH2hWq8Tv9Po+2GNB7t1KbVBDikoyrcH
 0egBLrQZSqpvVVtT6T6UkNnzIONm+PjYO0XVTS1KPAiutElCazTOK1e6oY64pe+d73q8IfUEZ
 CGij8trl+kCTUXHWSThzXEHJSdc2vJm/wKecvyAk1NoL4/MPA2Pk2lwGnJIrLRtZZkPxhMeHX
 4sU6QhJdPVnanJkTRfTqWXI38m21eJVzv/yoIpzjTk8EDSF/pbOGsmFpFPpkRduuR7Dew5nfV
 XpgGaVoHg6828dU7Vlp4dUXrawP8zA3J/yD+aS/VM72QzUpeJRRjjiCt0CTfK1IPdfalDKa3/
 RLUOQym36q+AR5KdTOrTDq+1Gu4DrGNfPELt1WCfE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Mon, 22 Mar 2021 15:51:49 -0000

The Windows Store version of Python (and apparently other Windows Store
applications) install a special reparse point called "app execution
alias" into the user's `PATH`.

These applications can be executed without any problem, but they cannot
be read as if they were files. This trips up Cygwin's beautiful logic that
tries to determine whether we're about to execute a Cygwin executable or
not: instead of executing the application, it will fail, saying
"Permission denied".

Let's detect this situation (`NtOpenFile()` helpfully says that this
operation is not supported on this reparse point type), and simply skip
the logic: Windows Store apps are not Cygwin executables (and even if
they were, it is unlikely that they would come with a compatible
`cygwin1.dll` or `msys-2.0.dll`).

This fixes https://github.com/msys2/MSYS2-packages/issues/1943

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 winsup/cygwin/spawn.cc | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/winsup/cygwin/spawn.cc b/winsup/cygwin/spawn.cc
index af177c0f13..ea08f3662e 100644
=2D-- a/winsup/cygwin/spawn.cc
+++ b/winsup/cygwin/spawn.cc
@@ -1166,6 +1166,13 @@ av::setup (const char *prog_arg, path_conv& real_pa=
th, const char *ext,
 			     FILE_SYNCHRONOUS_IO_NONALERT
 			     | FILE_OPEN_FOR_BACKUP_INTENT
 			     | FILE_NON_DIRECTORY_FILE);
+	if (status =3D=3D STATUS_IO_REPARSE_TAG_NOT_HANDLED)
+	  {
+	    /* This is most likely an app execution alias (such as the
+	       Windows Store version of Python, i.e. not a Cygwin program */
+	    real_path.set_cygexec (false);
+	    break;
+	  }
 	if (!NT_SUCCESS (status))
 	  {
 	    /* File is not readable?  Doesn't mean it's not executable.
=2D-
2.31.0

