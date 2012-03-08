Return-Path: <cygwin-patches-return-7616-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30412 invoked by alias); 8 Mar 2012 13:37:24 -0000
Received: (qmail 30324 invoked by uid 22791); 8 Mar 2012 13:37:23 -0000
X-SWARE-Spam-Status: No, hits=-2.2 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,TW_CP
X-Spam-Check-By: sourceware.org
Received: from mail-pw0-f43.google.com (HELO mail-pw0-f43.google.com) (209.85.160.43)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 08 Mar 2012 13:37:10 +0000
Received: by pbcwz12 with SMTP id wz12so1677112pbc.2        for <cygwin-patches@cygwin.com>; Thu, 08 Mar 2012 05:37:09 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.220.129 with SMTP id pw1mr9800387pbc.27.1331213829682; Thu, 08 Mar 2012 05:37:09 -0800 (PST)
Received: by 10.68.74.71 with HTTP; Thu, 8 Mar 2012 05:37:09 -0800 (PST)
Date: Thu, 08 Mar 2012 13:37:00 -0000
Message-ID: <CAKw7uVgatdim4-LuANxwv9UL59jc_EizrEKx6wX4DO1RZ+aKmQ@mail.gmail.com>
Subject: avoid calling strlen() twice in readlink()
From: =?UTF-8?Q?V=C3=A1clav_Zeman?= <vhaisman@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=e89a8ffbaea370362004babb5f8d
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
X-SW-Source: 2012-q1/txt/msg00039.txt.bz2


--e89a8ffbaea370362004babb5f8d
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-length: 209

Hi.

Here is a tiny patch to avoid calling strlen() twice in readlink().

ChangeLog:

2012-03-08  V=C3=A1clav Zeman  <vhaisman@gmail.com>

        * path.cc (readlink): Avoid calling strlen() twice.

--=20
VZ

--e89a8ffbaea370362004babb5f8d
Content-Type: text/plain; charset=US-ASCII; name="path.cc.diff.txt"
Content-Disposition: attachment; filename="path.cc.diff.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gzjubp9b1
Content-length: 594

LS0tIHBhdGguY2MJMjAxMi0wMy0wNyAxODoxMDo0NC4wMDAwMDAwMDAgKzAx
MDAKKysrIHBhdGguY2MJMjAxMi0wMy0wOCAxMzoyODoyOC40NjgyNjY4MDAg
KzAxMDAKQEAgLTI3ODIsNyArMjc4Myw4IEBAIHJlYWRsaW5rIChjb25zdCBj
aGFyICpwYXRoLCBjaGFyICpidWYsIHMKICAgICAgIHJldHVybiAtMTsKICAg
ICB9CiAKLSAgc3NpemVfdCBsZW4gPSBtaW4gKGJ1Zmxlbiwgc3RybGVuIChw
YXRoYnVmLmdldF93aW4zMiAoKSkpOworICBzaXplX3QgcGF0aGJ1Zl9sZW4g
PSBzdHJsZW4gKHBhdGhidWYuZ2V0X3dpbjMyICgpKTsKKyAgc2l6ZV90IGxl
biA9IE1JTiAoYnVmbGVuLCBwYXRoYnVmX2xlbik7CiAgIG1lbWNweSAoYnVm
LCBwYXRoYnVmLmdldF93aW4zMiAoKSwgbGVuKTsKIAogICAvKiBlcnJubyBz
ZXQgYnkgc3ltbGluay5jaGVjayBpZiBlcnJvciAqLwo=

--e89a8ffbaea370362004babb5f8d--
