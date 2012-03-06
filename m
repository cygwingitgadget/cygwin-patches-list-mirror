Return-Path: <cygwin-patches-return-7613-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8289 invoked by alias); 6 Mar 2012 17:06:39 -0000
Received: (qmail 8267 invoked by uid 22791); 6 Mar 2012 17:06:37 -0000
X-SWARE-Spam-Status: No, hits=3.5 required=5.0	tests=AWL,BAYES_05,T_RP_MATCHES_RCVD
X-Spam-Check-By: sourceware.org
Received: from mms2.broadcom.com (HELO mms2.broadcom.com) (216.31.210.18)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Tue, 06 Mar 2012 17:06:25 +0000
Received: from [10.16.192.224] by mms2.broadcom.com with ESMTP (Broadcom SMTP Relay (Email Firewall v6.5)); Tue, 06 Mar 2012 09:15:48 -0800
X-Server-Uuid: 72204117-5C29-4314-8910-60DB108979CB
Received: from SJEXCHCAS01.corp.ad.broadcom.com (10.16.192.31) by SJEXCHHUB01.corp.ad.broadcom.com (10.16.192.224) with Microsoft SMTP Server (TLS) id 8.2.247.2; Tue, 6 Mar 2012 09:06:10 -0800
Received: from SJEXCHMB05.corp.ad.broadcom.com ( [fe80::4ccf:d24d:fe6c:9594]) by sjexchcas01.corp.ad.broadcom.com ( [::1]) with mapi id 14.01.0355.002; Tue, 6 Mar 2012 09:06:10 -0800
From: "Piotr Foltyn" <pfoltyn@broadcom.com>
To: "cygwin-patches@cygwin.com" <cygwin-patches@cygwin.com>
Subject: Changing MAXPATHLEN in glob.cc back to 16384
Date: Tue, 06 Mar 2012 17:06:00 -0000
Message-ID: <49D44181BE9446429E0DA767E6813C54F320@SJEXCHMB05.corp.ad.broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=_002_49D44181BE9446429E0DA767E6813C54F320SJEXCHMB05corpadbro_
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q1/txt/msg00036.txt.bz2


--_002_49D44181BE9446429E0DA767E6813C54F320SJEXCHMB05corpadbro_
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-length: 298

Hi,

Revision 1.7 of src/winsup/cygwin/glob.cc reduced maximum allowed path leng=
th from 16384 to 4096 characters. This is unfortunate because some paths us=
ed in my build system can reach 6k characters in length. Attached patch rei=
nstates 16384 characters limit.

--=20
Regards,
Piotr Foltyn


--_002_49D44181BE9446429E0DA767E6813C54F320SJEXCHMB05corpadbro_
Content-Type: application/octet-stream;
 name=maxpathlen.patch
Content-Description: maxpathlen.patch
Content-Disposition: attachment;
 filename=maxpathlen.patch;
 size=537;
 creation-date="Tue, 06 Mar 2012 16:22:44 GMT";
 modification-date="Tue, 06 Mar 2012 16:22:47 GMT"
Content-Transfer-Encoding: base64
Content-length: 728

SW5kZXg6IGN5Z3dpbi9nbG9iLmNjDQo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9jeWd3aW4vZ2xvYi5j
Yyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuNw0KZGlmZiAtdSAtcCAtcjEu
NyBnbG9iLmNjDQotLS0gY3lnd2luL2dsb2IuY2MJMTMgRmViIDIwMTIgMTM6
MTI6MzcgLTAwMDAJMS43DQorKysgY3lnd2luL2dsb2IuY2MJNiBNYXIgMjAx
MiAxNjoyMDoyMCAtMDAwMA0KQEAgLTExMSw2ICsxMTEsOSBAQCBfX0ZCU0RJ
RCgiJEZyZWVCU0Q6IHNyYy9saWIvbGliYy9nZW4vZ2xvDQogI2RlZmluZSBD
Y2hhcihjKQkoaWdub3JlX2Nhc2Vfd2l0aF9nbG9iID8gdG93bG93ZXIgKGMp
IDogKGMpKQ0KICNlbmRpZg0KIA0KKyN1bmRlZiBNQVhQQVRITEVODQorI2Rl
ZmluZSBNQVhQQVRITEVOIDE2Mzg0DQorDQogI2RlZmluZQlET0xMQVIJCSck
Jw0KICNkZWZpbmUJRE9UCQknLicNCiAjZGVmaW5lCUVPUwkJJ1wwJw0K

--_002_49D44181BE9446429E0DA767E6813C54F320SJEXCHMB05corpadbro_--
