Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 by sourceware.org (Postfix) with ESMTPS id 3E944399C003
 for <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 15:11:56 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 3E944399C003
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.201.226] ([89.1.215.248]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N6bfw-1lnrwS3uc2-017zcr for
 <cygwin-patches@cygwin.com>; Fri, 12 Mar 2021 16:11:55 +0100
Date: Fri, 12 Mar 2021 16:11:53 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH 2/2] Allow executing Windows Store's "app execution
 aliases"
Message-ID: <nycvar.QRO.7.76.6.2103121611520.50@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Qgi+PHJWDO4yZ5wwIk3/PE4HAgizsIcAlTHzVrp/5sLBvHSwNH4
 WNaBtoT7uPQA5rzFSN4o1GEuJWDPPcVttf90Ym49jheToKsbKOzP2pIT2Wg23V+JcrqaIJN
 mo6YuvYAxZ1q9nsVaC+EXuNfzJ0Kay00vI7ivzgZr7PHNxZ/C3B0RhHgzKoYlDmthXt6+KT
 aIbJ6lcd8BXxucL+jNKdg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iv+K2+F1zxw=:RcDkKbrdiNw7jY54V4U4lY
 MzHRkFLtw+PRUjU2ZtF3NXoaRbwWGJ7mD59UWgWliouth2NnJkC1I4qAoIlZnhIUc+TLcOoF+
 geHfZ8JZbN9mnj43OmscamBWfpKkvKcQE/7vDXcvehoBpteZzARJqjqlXHDKyxcTEZHSULu0P
 t+TimhzSPZqdaZQk5aQ/fCdAv1sqzEUkkfGG81vJzgNFfoUhzVGa0hwQGTji4MkaKnWCNmXvR
 zRMVbwzDct0EctfqvHnPy5SN/cKc/nD6oGgdzruPCNiFyZr6VwXmrEFLxAX3M2g3sHiIMvMfR
 4IywVb5MNGteEdlTUs86ToTl51LY40DiP+njp+VjioXhjpkCQG/uQ8DCqEodElJdRuhP72ULS
 tPD5ms6fEjMugIln302Zat47Bt23qCbIYzkhMN+3AiVr9O8Xdl4cY+JhcgwZjIjT+TPYh9VdL
 NX3wCBPI8uUVvJ/hBOvrR4wp4K+x7BFfc9O/GzP7RCLj8PXAKd+0xswA8iZwk6x6l35HXFDJ2
 PsFWcfagsCmKJ9c1qhJu5lbyFAlu11FRd+UMrrM/5qBA1PjBoKlCyERYH5X0nTNgfgGFq36A5
 /IzAyHl4bxo2550eLHUOcGsEgCk+X/VfjDV38Bf5Yi3ulWMHqrLwtKMTJtdWb9gUO28WTE/Zm
 BxVODpOvhQGIwGuo1vOo/UX2JMSvJKVEwtfNR2dWEMpnxphmHgd3oFwZHdndIWme58hNzVB9p
 mPNMgxmmB92axyF+lPHaIQHttm+2pYJY79oaFTmu0D/Hvlw0GShESTJ9UfQVFbd/DyBp6e6s7
 5HVEUrRoPLnn9wgws7gs2zQjaG0IJFdrw93Mt2bZ5p9X7s4CwC7FojK2wcX4S85FyzrGlYEr+
 q1OXz9b3j/qYsztYSInSDUODc5vSZUIhx6ZdKL498=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.5 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, GIT_PATCH_0, RCVD_IN_BARRACUDACENTRAL,
 RCVD_IN_DNSWL_LOW, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_PASS,
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
X-List-Received-Date: Fri, 12 Mar 2021 15:11:57 -0000

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
2.30.2

