Return-Path: <cygwin-patches-return-4036-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7676 invoked by alias); 5 Aug 2003 02:49:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7667 invoked from network); 5 Aug 2003 02:49:14 -0000
Date: Tue, 05 Aug 2003 02:49:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary158751060051753"
Subject: [PATCH] readdir (): Do not set 'errno' if end of dir is encountered
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014308112@gmx.net
X-Authenticated-IP: [217.110.54.82]
Message-ID: <15875.1060051753@www57.gmx.net>
X-Flags: 0001
X-SW-Source: 2003-q3/txt/msg00052.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary158751060051753
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-length: 809

Hello,

Attached is a patch + a testcase. The testcase can be executed with any of
the
following directories:

  /cygdrive
  /proc
  /proc/<PID>
  /proc/registry/HKEY_WHATEVER

2003-08-05  Pavel Tsekov  <ptsekov@gmx.net>

	* fhandler_disk_file.cc (fhandler_cygdrive::readdir): Do not change 'errno'
if
	end of directory condition is encountered as per SUSv2.
	* fhandler_proc.cc (fhandler_proc::readdir): Ditto.
	* fhandler_process (fhandler_process::readdir): Ditto.
	* fhandler_registry (fhandler_registry::readdir): Ditto.

Pavel

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post
--========GMXBoundary158751060051753
Content-Type: application/octet-stream; name="scandir.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="scandir.c"
Content-length: 464

I2luY2x1ZGUgPGRpcmVudC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KCmludCBt
YWluIChpbnQgYXJnYywgY2hhciAqKmFyZ3YpCnsKICBpbnQgaSwgbjsKICBz
dHJ1Y3QgZGlyZW50ICoqZF9lbnRyaWVzOwoKICBpZiAoYXJnYyAhPSAyKQog
ICAgewogICAgICBwcmludGYgKCJVc2FnZTogJXMgRElSXG4iLCBhcmd2WzBd
KTsKICAgICAgZXhpdCAoMSk7CiAgICB9CgogIG4gPSBzY2FuZGlyIChhcmd2
WzFdLCAmZF9lbnRyaWVzLCBOVUxMLCBOVUxMKTsKCiAgZm9yIChpID0gMDsg
aSA8IG47IGkrKykKICAgIHByaW50ZiAoIiVzXG4iLCBkX2VudHJpZXNbaV0t
PmRfbmFtZSk7CgogIGV4aXQgKDApOwp9Cg==

--========GMXBoundary158751060051753
Content-Type: text/plain; name="readdir.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="readdir.patch"
Content-length: 3429

SW5kZXg6IGZoYW5kbGVyX2Rpc2tfZmlsZS5jYwo9PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09ClJDUyBmaWxlOiAvY3ZzL3NyYy9zcmMvd2luc3VwL2N5Z3dpbi9m
aGFuZGxlcl9kaXNrX2ZpbGUuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEu
NTgKZGlmZiAtdSAtcCAtcjEuNTggZmhhbmRsZXJfZGlza19maWxlLmNjCi0t
LSBmaGFuZGxlcl9kaXNrX2ZpbGUuY2MJMjYgSnVsIDIwMDMgMDQ6NTM6NTkg
LTAwMDAJMS41OAorKysgZmhhbmRsZXJfZGlza19maWxlLmNjCTUgQXVnIDIw
MDMgMDI6Mzg6MzYgLTAwMDAKQEAgLTc2OSwxMCArNzY5LDcgQEAgZmhhbmRs
ZXJfY3lnZHJpdmU6OnJlYWRkaXIgKERJUiAqZGlyKQogICBpZiAoIWlzY3ln
ZHJpdmVfcm9vdCAoKSkKICAgICByZXR1cm4gZmhhbmRsZXJfZGlza19maWxl
OjpyZWFkZGlyIChkaXIpOwogICBpZiAoIXBkcml2ZSB8fCAhKnBkcml2ZSkK
LSAgICB7Ci0gICAgICBzZXRfZXJybm8gKEVOTUZJTEUpOwotICAgICAgcmV0
dXJuIE5VTEw7Ci0gICAgfQorICAgIHJldHVybiBOVUxMOwogICBlbHNlIGlm
IChkaXItPl9fZF9wb3NpdGlvbiA+IDEKIAkgICAmJiBHZXRGaWxlQXR0cmli
dXRlcyAocGRyaXZlKSA9PSBJTlZBTElEX0ZJTEVfQVRUUklCVVRFUykKICAg
ICB7CkluZGV4OiBmaGFuZGxlcl9wcm9jLmNjCj09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX3Byb2MuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzQKZGlm
ZiAtdSAtcCAtcjEuMzQgZmhhbmRsZXJfcHJvYy5jYwotLS0gZmhhbmRsZXJf
cHJvYy5jYwkyNiBKdWwgMjAwMyAwNDo1Mzo1OSAtMDAwMAkxLjM0CisrKyBm
aGFuZGxlcl9wcm9jLmNjCTUgQXVnIDIwMDMgMDI6Mzg6MzkgLTAwMDAKQEAg
LTIwNiw3ICsyMDYsNiBAQCBmaGFuZGxlcl9wcm9jOjpyZWFkZGlyIChESVIg
KiBkaXIpCiAJICAgIGRpci0+X19kX3Bvc2l0aW9uKys7CiAJICAgIHJldHVy
biBkaXItPl9fZF9kaXJlbnQ7CiAJICB9Ci0gICAgICBzZXRfZXJybm8gKEVO
TUZJTEUpOwogICAgICAgcmV0dXJuIE5VTEw7CiAgICAgfQogCkluZGV4OiBm
aGFuZGxlcl9wcm9jZXNzLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3By
b2Nlc3MuY2MsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzUKZGlmZiAtdSAt
cCAtcjEuMzUgZmhhbmRsZXJfcHJvY2Vzcy5jYwotLS0gZmhhbmRsZXJfcHJv
Y2Vzcy5jYwk5IEp1bCAyMDAzIDAxOjMzOjA2IC0wMDAwCTEuMzUKKysrIGZo
YW5kbGVyX3Byb2Nlc3MuY2MJNSBBdWcgMjAwMyAwMjozODo0MiAtMDAwMApA
QCAtMTQ3LDEwICsxNDcsNyBAQCBzdHJ1Y3QgZGlyZW50ICoKIGZoYW5kbGVy
X3Byb2Nlc3M6OnJlYWRkaXIgKERJUiAqIGRpcikKIHsKICAgaWYgKGRpci0+
X19kX3Bvc2l0aW9uID49IFBST0NFU1NfTElOS19DT1VOVCkKLSAgICB7Ci0g
ICAgICBzZXRfZXJybm8gKEVOTUZJTEUpOwotICAgICAgcmV0dXJuIE5VTEw7
Ci0gICAgfQorICAgIHJldHVybiBOVUxMOwogICBzdHJjcHkgKGRpci0+X19k
X2RpcmVudC0+ZF9uYW1lLCBwcm9jZXNzX2xpc3RpbmdbZGlyLT5fX2RfcG9z
aXRpb24rK10pOwogICBzeXNjYWxsX3ByaW50ZiAoIiVwID0gcmVhZGRpciAo
JXApICglcykiLCAmZGlyLT5fX2RfZGlyZW50LCBkaXIsCiAJCSAgZGlyLT5f
X2RfZGlyZW50LT5kX25hbWUpOwpJbmRleDogZmhhbmRsZXJfcmVnaXN0cnku
Y2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmlsZTogL2N2cy9zcmMv
c3JjL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcmVnaXN0cnkuY2MsdgpyZXRy
aWV2aW5nIHJldmlzaW9uIDEuMTkKZGlmZiAtdSAtcCAtcjEuMTkgZmhhbmRs
ZXJfcmVnaXN0cnkuY2MKLS0tIGZoYW5kbGVyX3JlZ2lzdHJ5LmNjCTE2IEp1
biAyMDAzIDAzOjI0OjEwIC0wMDAwCTEuMTkKKysrIGZoYW5kbGVyX3JlZ2lz
dHJ5LmNjCTUgQXVnIDIwMDMgMDI6Mzg6NDUgLTAwMDAKQEAgLTMzMSw3ICsz
MzEsOCBAQCByZXRyeToKICAgICB7CiAgICAgICBSZWdDbG9zZUtleSAoKEhL
RVkpIGRpci0+X19kX3UuX19kX2RhdGEuX19oYW5kbGUpOwogICAgICAgZGly
LT5fX2RfdS5fX2RfZGF0YS5fX2hhbmRsZSA9IElOVkFMSURfSEFORExFX1ZB
TFVFOwotICAgICAgc2V0ZXJybm9fZnJvbV93aW5fZXJyb3IgKF9fRklMRV9f
LCBfX0xJTkVfXywgZXJyb3IpOworICAgICAgaWYgKGVycm9yICE9IEVSUk9S
X05PX01PUkVfSVRFTVMpCisJc2V0ZXJybm9fZnJvbV93aW5fZXJyb3IgKF9f
RklMRV9fLCBfX0xJTkVfXywgZXJyb3IpOwogICAgICAgZ290byBvdXQ7CiAg
ICAgfQogCgo=

--========GMXBoundary158751060051753--
