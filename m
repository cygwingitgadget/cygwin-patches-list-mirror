Return-Path: <cygwin-patches-return-4032-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 576 invoked by alias); 2 Aug 2003 11:53:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 567 invoked from network); 2 Aug 2003 11:53:23 -0000
Date: Sat, 02 Aug 2003 11:53:00 -0000
From: Pavel Tsekov <ptsekov@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary179971059825201"
Subject: [PATCH] patch.cc: cygdrive_getmntent () - Unify behaviour with fhandler_cygdrive
X-Priority: 3 (Normal)
X-Authenticated-Sender: #0014308112@gmx.net
X-Authenticated-IP: [217.110.54.115]
Message-ID: <17997.1059825201@www3.gmx.net>
X-Flags: 0001
X-SW-Source: 2003-q3/txt/msg00048.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary179971059825201
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-length: 529

Hello,

Here is a simple patch which makes the behaviour of getmntent () consistent
with
the one of fhandler_cygdrive.

Pavel

2003-08-02  Pavel Tsekov  <ptsekov@gmx.net>

	path.cc (cygdrive_getmntent): Do not skip over drives of
	type DRIVE_REMOVABLE.

-- 
COMPUTERBILD 15/03: Premium-e-mail-Dienste im Test
--------------------------------------------------
1. GMX TopMail - Platz 1 und Testsieger!
2. GMX ProMail - Platz 2 und Preis-Qualitätssieger!
3. Arcor - 4. web.de - 5. T-Online - 6. freenet.de - 7. daybyday - 8. e-Post
--========GMXBoundary179971059825201
Content-Type: text/plain; name="cygdrive_getmntent-path.cc.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="cygdrive_getmntent-path.cc.diff"
Content-length: 842

SW5kZXg6IHBhdGguY2MKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpSQ1MgZmls
ZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vcGF0aC5jYyx2CnJldHJp
ZXZpbmcgcmV2aXNpb24gMS4yNjEKZGlmZiAtdSAtcCAtcjEuMjYxIHBhdGgu
Y2MKLS0tIHBhdGguY2MJMjYgSnVsIDIwMDMgMDQ6NTM6NTkgLTAwMDAJMS4y
NjEKKysrIHBhdGguY2MJMiBBdWcgMjAwMyAxMTo0OToxNSAtMDAwMApAQCAt
MjUzOSw4ICsyNTM5LDcgQEAgY3lnZHJpdmVfZ2V0bW50ZW50ICgpCiAJICBi
cmVhazsKIAogICAgICAgX19zbWFsbF9zcHJpbnRmIChuYXRpdmVfcGF0aCwg
IiVjOlxcIiwgZHJpdmUpOwotICAgICAgaWYgKEdldERyaXZlVHlwZSAobmF0
aXZlX3BhdGgpID09IERSSVZFX1JFTU9WQUJMRSB8fAotCSAgR2V0RmlsZUF0
dHJpYnV0ZXMgKG5hdGl2ZV9wYXRoKSA9PSBJTlZBTElEX0ZJTEVfQVRUUklC
VVRFUykKKyAgICAgIGlmIChHZXRGaWxlQXR0cmlidXRlcyAobmF0aXZlX3Bh
dGgpID09IElOVkFMSURfRklMRV9BVFRSSUJVVEVTKQogCXsKIAkgIGF2YWls
YWJsZV9kcml2ZXMgJj0gfm1hc2s7CiAJICBjb250aW51ZTsK

--========GMXBoundary179971059825201--
