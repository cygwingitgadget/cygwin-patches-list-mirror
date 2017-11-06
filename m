Return-Path: <cygwin-patches-return-8900-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 11650 invoked by alias); 6 Nov 2017 19:20:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 11030 invoked by uid 89); 6 Nov 2017 19:20:51 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-19.3 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,GIT_PATCH_0,GIT_PATCH_1,GIT_PATCH_2,GIT_PATCH_3,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,RP_MATCHES_RCVD,SPF_PASS autolearn=ham version=3.3.2 spammy=H*c:PHrt, H*c:alternative, H*x:5.0, H*UA:6.1
X-HELO: sonic317-20.consmr.mail.gq1.yahoo.com
Received: from sonic317-20.consmr.mail.gq1.yahoo.com (HELO sonic317-20.consmr.mail.gq1.yahoo.com) (98.137.66.146) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 06 Nov 2017 19:20:48 +0000
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 6 Nov 2017 19:20:46 +0000
Date: Mon, 06 Nov 2017 19:20:00 -0000
From: "Xiaofeng Liu via cygwin-patches" <cygwin-patches@cygwin.com>
Reply-To: Xiaofeng Liu <liuxf09@yahoo.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Message-ID: <1363864083.3348449.1509996042945@mail.yahoo.com>
Subject: PATCH: pread() return non-zero if read beyond end of file
MIME-Version: 1.0
References: <1363864083.3348449.1509996042945.ref@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-IsSubscribed: yes
X-SW-Source: 2017-q4/txt/msg00030.txt.bz2

pread() return 0 if read beyond end of file in linux, but not zero in cygwi=
n.=C2=A0
I have a small code to show the problem:
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int main()
{
  const char* file =3D "/home/xliu/work/exome/a.bam";
  struct stat st;
  stat(file, &st);
  char buf[65536];
  int fd =3D open(file, O_RDONLY);
  int ret =3D pread(fd, buf, sizeof buf, st.st_size);
  fprintf(stderr, "filesize %ld, after eof pread() return =3D %d, errno =3D=
 %d\n", st.st_size, ret, errno);
  lseek(fd, st.st_size, SEEK_SET);
  ret =3D read(fd, buf, sizeof buf);
  fprintf(stderr, "filesize %ld, after eof read() return =3D %d, errno =3D =
%d\n", st.st_size, ret, errno);
}
$ ./a.exe
filesize 6126093048, after eof pread() return =3D 3, errno =3D 0
filesize 6126093048, after eof read() return =3D 0, errno =3D 0
The issue is that NtReadFile() return EOF status, but doesn't set io.inform=
ation to 0. As a result, the current pread() implementation could return an=
 arbitrary number in the stack.=C2=A0The fix is a one line fix: reset io st=
atus block.=C2=A0
diff --git a/winsup/cygwin/fhandler_disk_file.cc b/winsup/cygwin/fhandler_d=
isk_file.ccindex bc8fead..525cb32 100644--- a/winsup/cygwin/fhandler_disk_f=
ile.cc+++ b/winsup/cygwin/fhandler_disk_file.cc@@ -1525,6 +1525,7 @@ fhandl=
er_disk_file::pread (void *buf, size_t count, off_t offset)=C2=A0 =C2=A0 =
=C2=A0 =C2=A0IO_STATUS_BLOCK io;=C2=A0 =C2=A0 =C2=A0 =C2=A0LARGE_INTEGER of=
f =3D { QuadPart:offset };
+=C2=A0 =C2=A0 =C2=A0 memset(&io, 0, sizeof(io));=C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (!prw_handle && prw_open (false))=C2=A0 =C2=A0 =C2=A0 =C2=A0 goto non=
_atomic;=C2=A0 =C2=A0 =C2=A0 =C2=A0status =3D NtReadFile (prw_handle, NULL,=
 NULL, NULL, &io, buf, count,
