Return-Path: <cygwin-patches-return-8902-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62076 invoked by alias); 6 Nov 2017 21:49:57 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62062 invoked by uid 89); 6 Nov 2017 21:49:57 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-18.0 required=5.0 tests=AWL,BAYES_00,FORGED_MUA_MOZILLA,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=corinna-cygwin@cygwin.com, corinnacygwincygwincom, H*c:PHrt, H*c:alternative
X-HELO: sonic305-21.consmr.mail.gq1.yahoo.com
Received: from sonic305-21.consmr.mail.gq1.yahoo.com (HELO sonic305-21.consmr.mail.gq1.yahoo.com) (98.137.64.84) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Nov 2017 21:49:55 +0000
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.gq1.yahoo.com with HTTP; Mon, 6 Nov 2017 21:49:54 +0000
Date: Mon, 06 Nov 2017 21:49:00 -0000
From: "Xiaofeng Liu via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Xiaofeng Liu <liuxf09@yahoo.com>
To: cygwin-patches@cygwin.com, Corinna Vinschen <corinna-cygwin@cygwin.com>
Message-ID: <643282964.3455372.1510004994189@mail.yahoo.com>
In-Reply-To: <20171106202335.GI18070@calimero.vinschen.de>
References: <1363864083.3348449.1509996042945.ref@mail.yahoo.com> <1363864083.3348449.1509996042945@mail.yahoo.com> <20171106202335.GI18070@calimero.vinschen.de>
Subject: Re: PATCH: pread() return non-zero if read beyond end of file
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00032.txt.bz2

 Sorry it keeps failing if I send the git diff in the attachment. I will tr=
y copy the text again.
git diffdiff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fh=
andler_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandle=
r_disk_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @=
@ fhandler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =
=C2=A0 =C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGER off =3D { QuadPart:offse=
t };=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0
+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (!prw_handle && prw_open (false)) goto non_atomic;=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =C2=A0 =C2=A0 =
=C2=A0status =3D NtReadFile (prw_handle, NULL, NULL, NULL, &io, buf, count,

    On Monday, November 6, 2017, 12:23:44 PM PST, Corinna Vinschen <corinna=
-cygwin@cygwin.com> wrote:=20=20
=20
 Hi,

On Nov=C2=A0 6 19:20, Xiaofeng Liu via cygwin-patches wrote:
> pread() return 0 if read beyond end of file in linux, but not zero in cyg=
win.=C2=A0
> I have a small code to show the problem:
> #include <sys/types.h>
> #include <sys/stat.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <stdio.h>
> #include <errno.h>
>=20
> int main()
> {
>=C2=A0 const char* file =3D "/home/xliu/work/exome/a.bam";
>=C2=A0 struct stat st;
>=C2=A0 stat(file, &st);
>=C2=A0 char buf[65536];
>=C2=A0 int fd =3D open(file, O_RDONLY);
>=C2=A0 int ret =3D pread(fd, buf, sizeof buf, st.st_size);
>=C2=A0 fprintf(stderr, "filesize %ld, after eof pread() return =3D %d, err=
no =3D %d\n", st.st_size, ret, errno);
>=C2=A0 lseek(fd, st.st_size, SEEK_SET);
>=C2=A0 ret =3D read(fd, buf, sizeof buf);
>=C2=A0 fprintf(stderr, "filesize %ld, after eof read() return =3D %d, errn=
o =3D %d\n", st.st_size, ret, errno);
> }
> $ ./a.exe
> filesize 6126093048, after eof pread() return =3D 3, errno =3D 0
> filesize 6126093048, after eof read() return =3D 0, errno =3D 0
> The issue is that NtReadFile() return EOF status, but doesn't set io.info=
rmation to 0. As a result, the current pread() implementation could return =
an arbitrary number in the stack.=C2=A0The fix is a one line fix: reset io =
status block.=C2=A0
> diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler=
_disk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_disk=
_file.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fhan=
dler_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGER of=
f =3D { QuadPart:offset };
> +=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!prw_handle && prw_open (false))=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto non=
_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D NtReadFile (prw_handle, NULL,=
 NULL, NULL, &io, buf, count,

your mailer screwed up the patch and so it can't apply.=C2=A0 Can you please
send it as an attachment?

Thanks,
Corinna

--=20
Corinna Vinschen=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 Please, send mails regarding Cygwin to
Cygwin Maintainer=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cy=
gwin AT cygwin DOT com
Red Hat=20=20
