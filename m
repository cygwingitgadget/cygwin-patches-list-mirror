Return-Path: <SRS0=zmZy=WO=gmx.de=johannes.schindelin@sourceware.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by sourceware.org (Postfix) with ESMTPS id A3E013856942
	for <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 12:21:23 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org A3E013856942
Authentication-Results: sourceware.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=gmx.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org A3E013856942
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=212.227.17.22
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1743078084; cv=none;
	b=NfoR08leuF/e7MKULECFaMGKQ8hHvBsfcsgW03DbySBMlLuFKbsg7R4HsuXfkA1U1C8blkOHB65xvJdMH0D+B86RXdqVvTkN7HRFyaKYQVpCj/3jZSxXpp4weBLSj6gDij5cGZcPNvGXpdT6ruZ84P8xGpCihOIIWr0jgo/GY/A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1743078084; c=relaxed/simple;
	bh=XiLkp+XpYze3Z/q6owYpDeOklYLx0nW18mpRxOKnaGU=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=hXagrEdGnyh/v95tyiFHDe9tXpe5gE7ZHu7jL474NkktfDIlS4s3oJ3c4NIcNzWIl7Q3ys+ldWwizfE2x3O08ZsbV+/lzkD9j6Guvzl7RlnlWdO9TcCGC6wTQXTJqmnUiCUimYLGaksIZopoY2YjN5teIxY+Db/tbdjqFD52qNU=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org A3E013856942
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, secure) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=a2uD6Uw2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743078080; x=1743682880;
	i=johannes.schindelin@gmx.de;
	bh=rYWdFVHYboPFWvWpril053CSRvScNHb9ivLQ0kKAe8w=;
	h=X-UI-Sender-Class:Date:From:To:Subject:Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=a2uD6Uw2QP1vZjp9Y8PQm1SDw5i94eSKGtnAeyMa2rcbMKK0IFfal3dOMr/1hHa2
	 6EsOXz3UAxfZTFvPcxaOyO4GM/GsEHtCj56+9q3xbVXyMUAggjfX//gQ0hPcCaakX
	 Z5T5sVBcnAcWHUjUpfaqNYwadtefoNJ4UEkLsYaq38mo1nCtLF1QeNY6Hxs2dbweH
	 mfm7CLWnsOmoWuCsNqsDfKl1vrBfc3YosOb2OQ+LE0PpXH8VyG4EfJo+/pTKkD4Dx
	 tkt9MFVQOkI9Gt7tYcp/Ied2YZ/q9XAI//2s5nuRaR4MIklP4gMB2Oly4wq3beboL
	 NC4eBa5Y3bog1UZa4w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MYeMt-1tc2Ed0RfP-00JSyC for
 <cygwin-patches@cygwin.com>; Thu, 27 Mar 2025 13:21:20 +0100
Date: Thu, 27 Mar 2025 13:21:19 +0100 (CET)
From: Johannes Schindelin <johannes.schindelin@gmx.de>
To: cygwin-patches@cygwin.com
Subject: [PATCH] Cygwin: pipe: Fix hang due to inadvertent 0-length
 raw_write()
Message-ID: <40a66dcf272eff407794bb94616d5b8ba833fafa.1743076896.git.johannes.schindelin@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fE2QYimPEYM8rUsMctXZGZSnZlwdR/N8aCIko0Ep9Jsrben8Jx8
 j9I2jpWW0rf1UgCn2BSlODejwbL7ZIyqMGkNTRO5yUOJwORuHoqZMts9EGqdC19YnXAaWBX
 MelGT56xp+WAx1saQR3rTtE0ISuLfaKIq5qOZbrVuXfbAzy0fJmoX/Q9hlcF8CiU088OvLy
 Ky1dt8kk8DGz7e3UlUzcQ==
UI-OutboundReport: notjunk:1;M01:P0:S4GjSyAJlW4=;Wrfn7QDDKT2CA7DptuoAkxkjaQ6
 34FLK5YDRELlfN3afXuifAgxn13ajE4ggy9FmjcXgNr4gSEtPfeuo+UIeKNBnPMJ2+Q3xaRak
 Tu3ImhCDqdX96NwtgSfLUKRH9k2hQYG1vs2kOJUxPq+7zApYU3mJek4zzorNmdUcoo5bCrJdU
 +MyNGWJhRNVth9X0jxcTaxvXV1zhP4CcpQ3V3x1ie1Wz3dNBx14y+Po2YdmPnYmNriHefafZt
 GGO4xD87SY1hsU+lIG4PiXiJ6xj1fc4A+KYo80CzeHYSe7jPGaeI0IGQdGoU6R3tmr0HjcxJb
 SVr+wNjiBKvqAy0AE1Qumzn7s3hqF5Wo73H/UME4rz+GNVDKEHNx1gjTHXWVx4SSLnBEwC9Re
 Gg2DGZZ8w3/sbJlpt/RVV++xPZGL6UKBfm5XcRRhGXfnkKaolVm3NVs8UpWD5Hx5X2AqOF34k
 sujsWMi5u/jryx8kC39IG9Llrv3hXMplzfeXidxksURZ8Awu/BrVRpuJdwNqDwjkU1EDZWWAO
 g+PvFjudKjRp3+m/0lOzwSdi8tFBr+IgVeyh9EVX08Chd9NgUv8FoIRSwHV0TzlNBLjW+2n4T
 +lJcvkyyJCMMdB75RoSMiTDCgixky1kB1wrKglD+qPxgW6h82CqU+ZgX3uQsY39U1CRhqCgYy
 RV+sPBKNKDzYXx7gt9rdjprruoM/f5zqWJxpEuUWeKLXCAA9b73clBLejr6kkkcxFy1/JHKXA
 mivFp+1XHImpDkeZ3uT9/UKLvbLkb9qE6eXVlQNuaPNGVbNzo9Qh2eYRMXJmg8M/2ZAXXpvww
 lSDCw4m/M82uTIi5I4rWCEjRPI0XapEG57byhq1Cu7eb/0AiBDb6O67aNeHrMznzXex1JhtLb
 M9aVaUhLxclBNLRojWsyAzW2GbA2e08FAJ6QYSUTVVoZYD1Yru6nVspxIyfHB1b/mIqhfvfex
 BQkGx8aIEKgsKjrPDXKzuEowygBATFVsLI5+6lqno6sjVylzwLh8l5RBprVm1QYw6M9XIvh7f
 nVTvxGCfLP9pBke47QU5hhcClat7OMElyMD/YenT85d1z55a/Qa7/+1o7Jp2QLMgA6UfIK3s6
 8ZbJXF94H9xVVXF44NI7B23dnKj5qQWauOm7RCvs/zhJiviN4nrkj0nQbRTFPap7WKa8lR64m
 ZNNNFsGfta75x/SWJiFQdgB78dHVyCQM4DynMsqgS1f/snPRnczdQAqtzqug5NpH+a9exhAnF
 IxwW+xNnjuLBZX7YMKnTuyxBKsVSiCkW49WuuBh/X1EnFv7m228sRkzYLgqLJ4mfZf0d2a9w1
 0mzF4Eh8LMBR5aI8eGP9YquMyXeUSeWY4SL1MGfDPjyNxP1EfX6X4mPyhwoHdpjAy5nh95MLt
 +7NY2u1aWBDQYEmR6aXvBOnnbeExgy3iVTs3EI2ZJrGcOfg+jA4GZsPUNex3NXTbtumDK0GgT
 fOIwBchuC1YdYae7z8QbJfVerFFXYNZjnwajxmnKdkQ5iztSZ8t+7JvDZw59/jz3biJIlKyjK
 hWu3FAownHXFwXp+3Ko=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-10.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,GIT_PATCH_0,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

It is possible for `NtQueryInformationFile()` to report a 0-length
`InboundQuota` when obtaining `FilePipeLocalInformation`. This seems to
be the case e.g. when a pipe was created on the other side and its quota
information is not available on the client side.

This can lead to a situation where the `avail` variable is set to 0, and
since that is used to cap the number of bytes to send, a 0-length write.
Which hangs forever.

This was observed in the MSYS2 project when building GIMP, and reduced
to a simple test case where a MINGW `ninja.exe` tries to call an MSYS
`bison.exe` and the error message (saying that `bison` wants to have
some input) is not even shown.

Since the minimal pipe buffer size is 4k, let's ensure that it is at
least that, even when `InboundQuota` reports 0.

This fixes https://github.com/msys2/msys2-runtime/issues/270

Fixes: cbfaeba4f7 (Cygwin: pipe: Fix incorrect write length in raw_write()=
)
Helped-by: Corinna Vinschen <corinna@vinschen.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
Published-As: https://github.com/dscho/msys2-runtime/releases/tag/fix-ninj=
a-hang-v1
Fetch-It-Via: git fetch https://github.com/dscho/msys2-runtime fix-ninja-h=
ang-v1

 As per Corinna's request on IRC (thank you _so much_ for your invaluable
 help!), I have specifically verified that this does not regress on
 691afb1f6d (Cygwin: pipe: Fix 'lost connection' issue in scp, 2025-03-05)
 by running this in a loop:

   echo put /tmp/big.file | ./sftp -v -D ./sftp-server sftp://localhost

 (prior to running this on the patched runtime, I verified that it
 reproduces after reverting 691afb1f6d; It took 79 iterations to lose the
 connection, but in the end it did! And with that revert dropped and with
 this here patch applied, it survived 400 iterations without losing the
 connection.)

 winsup/cygwin/fhandler/pipe.cc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/winsup/cygwin/fhandler/pipe.cc b/winsup/cygwin/fhandler/pipe.=
cc
index 3537180024..92fc09de4a 100644
=2D-- a/winsup/cygwin/fhandler/pipe.cc
+++ b/winsup/cygwin/fhandler/pipe.cc
@@ -1158,7 +1158,7 @@ fhandler_pipe::set_pipe_buf_size ()
   status =3D NtQueryInformationFile (get_handle (), &io, &fpli, sizeof fp=
li,
 				   FilePipeLocalInformation);
   if (NT_SUCCESS (status))
-    pipe_buf_size =3D fpli.InboundQuota;
+    pipe_buf_size =3D fpli.InboundQuota < PIPE_BUF ? PIPE_BUF : fpli.Inbo=
undQuota;
 }

 int

base-commit: c1770e171505eb674626c2b7abf3403e6b4b7b79
=2D-
2.49.0.windows.1
