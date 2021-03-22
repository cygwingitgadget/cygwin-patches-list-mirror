Return-Path: <johannes.schindelin@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by sourceware.org (Postfix) with ESMTPS id 10EA3385801D
 for <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 15:51:28 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 10EA3385801D
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MHoRA-1lUMZN1Rqw-00Es2s for
 <cygwin-patches@cygwin.com>; Mon, 22 Mar 2021 16:51:27 +0100
Date: Mon, 22 Mar 2021 16:51:29 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To: cygwin-patches@cygwin.com
Subject: [PATCH v2 0/2] Handle "app execution aliases"
In-Reply-To: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
Message-ID: <cover.1616428114.git.johannes.schindelin@gmx.de>
References: <nycvar.QRO.7.76.6.2103121606540.50@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:A7oXVctvZdEREwI7C/CirnOrqJD7wmPFCMmbx/t54G/AbQExN9Y
 ULNDi8uIljgcWXQlnPAdTY0fdcK/zeOjgbTIqR6MXg8oIyoYcSj9Aw2aRHTEXJxFrHe60aI
 rLWbruOUhMd4qJxjEj8mL4tU+QFOu1gqQsaHHDl53/ZQiLnJb5FAKgDax8WLedKk37l9En7
 9BFL8ArOG3wXS1t6zHCCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TQhVcvwVdCs=:/ZV6O++NU5m+6EQlshr9K4
 m95o7hu6pcGPENV7TGhWCaxH11bFzCpta8t0emi0feYn97xOdwRNKw0VCVQG/bgnwnvtnCTOv
 M+qIpGuZ/KM15phaVwkoHE7amhNRC04t5s84OubdmuwETgCHxFRip5ZxfoWxuHsqIo3Efzeba
 azFsvmbY8UNo0Zj8sh9pc1rB2hHlSOzmRIFdivkBnUs3+BXxZqc/jMvqDBs0w0sLs2UEradNH
 ctk1klYb8wx1hwUyy8Vzg51X15uZzgH57g3lmpG3qSp35os4hwqStN/0FdFdGQD+aWxsBcqyJ
 cy4BXAq/Q69zhhBAu0fGBHJVw0bzuC0gCTUHvF1Hi8GkJayzD1PyKBM9Jkm6c79ZKdYIIzfXW
 9MJWQygdeAy5D1eWEhgPph7CFmYqeOf6oBCs0xYU7Ip5/6ZG/uLcY57czIpvEc06zO9hrkomk
 5lmmIDWrxMoWFvlBzeS7DLLk2nbD0Y/jNnvU4qrk4YUGlvVGbzNYkfuK/gNV2M0IPdbnkjZ07
 oeXMZv8ZsnC7xxUXLagNWS6PhcXWXiKthQW9FKKgUMP9nMilJxqL8UtM9sH2LkFn2EyBuKD5Y
 5T6FxwAaRWuNzZdUbjcGvUmciA14QxOEnHz4Bd9gRquZV5gUrYu1auNbKFtSzM+pm6Hp9WuDE
 wI/01WBfRQtPms/cTolPdHoEbeLqxtyQY1kCE6y/nBYDly0sED4RGXtEcdIP1+YdQUs03AXaC
 ucTPErrWdnacZ1DjXOS7IwkLVbolyeco667cDzBgeXf6gXjPZOhuYh1zO3EVAsqHQSfJeoqGf
 ui5Y55m5vL3JuMirw2TQ2ZmAfYzC3RuD4xH8m7Z/wiNzWlloLv079DsKmyP/YL2OTxHr66shO
 B+wn9tyu8tSlPdMzTW/9Aww59WcFBbO6G55f+O4UE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, FREEMAIL_FROM, RCVD_IN_BARRACUDACENTRAL, RCVD_IN_DNSWL_LOW,
 SPF_HELO_NONE, SPF_PASS, TXREP autolearn=no autolearn_force=no version=3.4.2
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
X-List-Received-Date: Mon, 22 Mar 2021 15:51:31 -0000

When installing e.g. Python via the Windows Store, it is common that the
`python3.exe` entry in the `PATH` is not actually an executable at all,
but an "app executaion alias" (i.e. a special class of reparse point).

These filesystem entries are presented as 0-size files, but they are not
readable, which is why Cygwin has problems to execute them, with the error
message "Permission denied".

This issue has been reported a couple of times in the Git for Windows and
in the MSYS2 project, and even in Cygwin
(https://cygwin.com/pipermail/cygwin/2020-May/244969.html, the thread
devolved into a discussion about Thunderbird vs Outlook before long,
though).

The second patch fixes that, and for good measure, the first patch teaches
Cygwin to treat these reparse points as symbolic links.

Changes since v1:

- Introduce and use `struct _REPARSE_APPEXECLINK_BUFFER`.

Johannes Schindelin (2):
  Treat Windows Store's "app execution aliases" as symbolic links
  Allow executing Windows Store's "app execution aliases"

 winsup/cygwin/path.cc  | 40 ++++++++++++++++++++++++++++++++++++++++
 winsup/cygwin/spawn.cc |  7 +++++++
 2 files changed, 47 insertions(+)

Range-diff against v1:
1:  218dc58e36 ! 1:  529cb4ad54 Treat Windows Store's "app execution alias=
es" as symbolic links
    @@ Commit message
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

      ## winsup/cygwin/path.cc ##
    +@@ winsup/cygwin/path.cc: symlink_info::check_sysfile (HANDLE h)
    +   return res;
    + }
    +
    ++typedef struct _REPARSE_APPEXECLINK_BUFFER
    ++{
    ++  DWORD ReparseTag;
    ++  WORD  ReparseDataLength;
    ++  WORD  Reserved;
    ++  struct {
    ++    DWORD Version;       /* Take member name with a grain of salt. *=
/
    ++    WCHAR Strings[1];    /* Four serialized, NUL-terminated WCHAR st=
rings:
    ++			   - Package ID
    ++			   - Entry Point
    ++			   - Executable Path
    ++			   - Application Type
    ++			   We're only interested in the Executable Path */
    ++  } AppExecLinkReparseBuffer;
    ++} REPARSE_APPEXECLINK_BUFFER,*PREPARSE_APPEXECLINK_BUFFER;
    ++
    + static bool
    + check_reparse_point_string (PUNICODE_STRING subst)
    + {
     @@ winsup/cygwin/path.cc: check_reparse_point_target (HANDLE h, bool =
remote, PREPARSE_DATA_BUFFER rp,
            if (check_reparse_point_string (psymbuf))
      	return PATH_SYMLINK | PATH_REP;
    @@ winsup/cygwin/path.cc: check_reparse_point_target (HANDLE h, bool r=
emote, PREPAR
     +  else if (!remote && rp->ReparseTag =3D=3D IO_REPARSE_TAG_APPEXECLI=
NK)
     +    {
     +      /* App execution aliases are commonly used by Windows Store ap=
ps. */
    -+      WCHAR *buf =3D (WCHAR *)(rp->GenericReparseBuffer.DataBuffer +=
 4);
    -+      DWORD size =3D rp->ReparseDataLength / sizeof(WCHAR), n;
    ++      PREPARSE_APPEXECLINK_BUFFER rpl =3D (PREPARSE_APPEXECLINK_BUFF=
ER) rp;
    ++      WCHAR *buf =3D rpl->Strings;
    ++      DWORD size =3D rp->ReparseDataLength / sizeof (WCHAR), n;
     +
    -+      /*
    -+         It seems that app execution aliases have a payload of four
    ++      /* It seems that app execution aliases have a payload of four
     +	 NUL-separated wide string: package id, entry point, executable
     +	 and application type. We're interested in the executable. */
     +      for (int i =3D 0; i < 3 && size > 0; i++)
    -+        {
    ++	{
     +	  n =3D wcsnlen (buf, size - 1);
     +	  if (i =3D=3D 2 && n > 0 && n < size)
     +	    {
    -+	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof(WCHAR))=
;
    ++	      RtlInitCountedUnicodeString (psymbuf, buf, n * sizeof (WCHAR)=
);
     +	      return PATH_SYMLINK | PATH_REP;
     +	    }
     +	  if (i =3D=3D 2)
2:  647dff4c7a =3D 2:  1c2659f902 Allow executing Windows Store's "app exe=
cution aliases"
=2D-
2.31.0

