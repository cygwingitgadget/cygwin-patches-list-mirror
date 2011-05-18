Return-Path: <cygwin-patches-return-7377-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28654 invoked by alias); 18 May 2011 06:08:43 -0000
Received: (qmail 28638 invoked by uid 22791); 18 May 2011 06:08:41 -0000
X-SWARE-Spam-Status: No, hits=-2.5 required=5.0	tests=AWL,BAYES_00,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,RFC_ABUSE_POST,T_TO_NO_BRKTS_FREEMAIL
X-Spam-Check-By: sourceware.org
Received: from mail-px0-f179.google.com (HELO mail-px0-f179.google.com) (209.85.212.179)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 18 May 2011 06:08:28 +0000
Received: by pxi2 with SMTP id 2so991044pxi.24        for <cygwin-patches@cygwin.com>; Tue, 17 May 2011 23:08:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.142.166.11 with SMTP id o11mr568550wfe.413.1305698907861; Tue, 17 May 2011 23:08:27 -0700 (PDT)
Received: by 10.142.14.14 with HTTP; Tue, 17 May 2011 23:08:27 -0700 (PDT)
Date: Wed, 18 May 2011 06:08:00 -0000
Message-ID: <BANLkTi=Ri+CfWqakwHk6fOVrVM=4gPTm2A@mail.gmail.com>
Subject: [PATCH] posix.sgml fixes
From: "Yaakov (Cygwin/X)" <yselkowitz@users.sourceforge.net>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=000e0cd2e32896324904a386b71f
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2011-q2/txt/msg00143.txt.bz2


--000e0cd2e32896324904a386b71f
Content-Type: text/plain; charset=ISO-8859-1
Content-length: 78

I have found some more discrepancies in posix.sgml.  Patch attached.


Yaakov

--000e0cd2e32896324904a386b71f
Content-Type: application/octet-stream; name="posix-susv4.patch"
Content-Disposition: attachment; filename="posix-susv4.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gntvd4030
Content-length: 2530

MjAxMS0wNS0xNyAgWWFha292IFNlbGtvd2l0eiAgPHlzZWxrb3dpdHpALi4u
PgoKCSogcG9zaXguc2dtbCAoc3RkLXN1c3Y0KTogUmVtb3ZlIGNocm9vdCwg
ZnV0aW1lcywgaHN0cmVycm9yLgoJKHN0ZC1kZXByZWMpOiBBZGQgY2hyb290
LgoJKHN0ZC1ic2QpOiBBZGQgZnV0aW1lcywgaHN0cmVycm9yLgoJKHN0ZC1u
b3RpbXBsKTogQWRkIGNsb2NrX25hbm9zbGVlcCwgbmV4dHRvd2FyZCwgbmV4
dHRvd2FyZGYuCglSZW1vdmUgaW5pdHN0YXRlLCB3aGljaCBpcyBpbXBsZW1l
bnRlZCBhbmQgbGlzdGVkIGluIHN0ZC1zdXN2NC4KCkluZGV4OiBwb3NpeC5z
Z21sCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNTIGZpbGU6IC9jdnMvc3Jj
L3NyYy93aW5zdXAvY3lnd2luL3Bvc2l4LnNnbWwsdgpyZXRyaWV2aW5nIHJl
dmlzaW9uIDEuNjMKZGlmZiAtdSAtcjEuNjMgcG9zaXguc2dtbAotLS0gcG9z
aXguc2dtbAkxNSBNYXkgMjAxMSAxODo0OTozOSAtMDAwMAkxLjYzCisrKyBw
b3NpeC5zZ21sCTE3IE1heSAyMDExIDAxOjU4OjMyIC0wMDAwCkBAIC04NSw3
ICs4NSw2IEBACiAgICAgY2hkaXIKICAgICBjaG1vZAogICAgIGNob3duCi0g
ICAgY2hyb290CQkJKHNlZSBjaGFwdGVyICJJbXBsZW1lbnRhdGlvbiBOb3Rl
cyIpCiAgICAgY2ltYWcKICAgICBjaW1hZ2YKICAgICBjbGVhcmVycgpAQCAt
MjYwLDcgKzI1OSw2IEBACiAgICAgZnR3CiAgICAgZnVubG9ja2ZpbGUKICAg
ICBmdXRpbWVucwotICAgIGZ1dGltZXMKICAgICBmd2lkZQogICAgIGZ3cHJp
bnRmCiAgICAgZndyaXRlCkBAIC0zMzEsNyArMzI5LDYgQEAKICAgICBoY3Jl
YXRlCiAgICAgaGRlc3Ryb3kKICAgICBoc2VhcmNoCi0gICAgaHN0cmVycm9y
CiAgICAgaHRvbmwKICAgICBodG9ucwogICAgIGh5cG90CkBAIC05ODMsNiAr
OTgwLDcgQEAKICAgICBmdHNfc2V0CiAgICAgZnRzX3NldF9jbGllbnRwdHIK
ICAgICBmdW5vcGVuCisgICAgZnV0aW1lcwogICAgIGdhbW1hCiAgICAgZ2Ft
bWFfcgogICAgIGdhbW1hZgpAQCAtOTk0LDYgKzk5Miw3IEBACiAgICAgZ2V0
cHJvZ25hbWUKICAgICBnZXR1c2Vyc2hlbGwKICAgICBoZXJyb3IKKyAgICBo
c3RyZXJyb3IKICAgICBpbmV0X2F0b24KICAgICBpbmV0X21ha2VhZGRyCiAg
ICAgaW5ldF9uZXRvZgpAQCAtMTIxOSw2ICsxMjE4LDcgQEAKICAgICBiY21w
CQkJKFBPU0lYLjEtMjAwMSwgU1VTdjMpCiAgICAgYmNvcHkJCQkoU1VTdjMp
CiAgICAgYnplcm8JCQkoU1VTdjMpCisgICAgY2hyb290CQkJKFNVU3YyKSAo
c2VlIGNoYXB0ZXIgIkltcGxlbWVudGF0aW9uIE5vdGVzIikKICAgICBjbG9j
a19zZXRyZXMJCShRTlgsIFZ4V29ya3MpIChzZWUgY2hhcHRlciAiSW1wbGVt
ZW50YXRpb24gTm90ZXMiKQogICAgIGN1c2VyaWQJCQkoUE9TSVguMS0xOTg4
LCBTVVN2MikKICAgICBlY3Z0CQkJKFNVU3YzKQpAQCAtMTI5NCw2ICsxMjk0
LDcgQEAKICAgICBjZWlsbAogICAgIGNleHBsCiAgICAgY2ltYWdsCisgICAg
Y2xvY2tfbmFub3NsZWVwCiAgICAgY2xvZ2wKICAgICBjb25qbAogICAgIGNv
cHlzaWdubApAQCAtMTMzNSw3ICsxMzM2LDYgQEAKICAgICBnZXRwbXNnCiAg
ICAgaHlwb3RsCiAgICAgaWxvZ2JsCi0gICAgaW5pdHN0YXRlCiAgICAgaXNh
bG51bV9sCiAgICAgaXNhbHBoYV9sCiAgICAgaXNhc3RyZWFtCkBAIC0xMzc4
LDYgKzEzNzgsOCBAQAogICAgIG5lYXJieWludGwKICAgICBuZXdsb2NhbGUK
ICAgICBuZXh0YWZ0ZXJsCisgICAgbmV4dHRvd2FyZAorICAgIG5leHR0b3dh
cmRmCiAgICAgbmV4dHRvd2FyZGwKICAgICBwb3NpeF9tZW1fb2Zmc2V0CiAg
ICAgcG9zaXhfc3Bhd25bLi4uXQo=

--000e0cd2e32896324904a386b71f--
