Return-Path: <cygwin-patches-return-6952-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 28792 invoked by alias); 10 Feb 2010 21:17:31 -0000
Received: (qmail 28781 invoked by uid 22791); 10 Feb 2010 21:17:30 -0000
X-SWARE-Spam-Status: No, hits=-2.0 required=5.0 	tests=BAYES_00,SARE_MSGID_LONG40,SPF_PASS
X-Spam-Check-By: sourceware.org
Received: from mail-fx0-f214.google.com (HELO mail-fx0-f214.google.com) (209.85.220.214)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 10 Feb 2010 21:17:26 +0000
Received: by fxm6 with SMTP id 6so511797fxm.18         for <cygwin-patches@cygwin.com>; Wed, 10 Feb 2010 13:17:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.239.164.14 with SMTP id r14mr92768hbd.60.1265836643128; Wed,  	10 Feb 2010 13:17:23 -0800 (PST)
Date: Wed, 10 Feb 2010 21:17:00 -0000
Message-ID: <416096c61002101317x6ee2698epaa4ba260af39dcba@mail.gmail.com>
Subject: [PATCH] internal_setlocale tweak
From: Andy Koppe <andy.koppe@gmail.com>
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001485f19a30751567047f458fac
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
X-SW-Source: 2010-q1/txt/msg00068.txt.bz2


--001485f19a30751567047f458fac
Content-Type: text/plain; charset=UTF-8
Content-length: 243

winsup/cygwin/ChangeLog:
	* nlsfuncs.cc (internal_setlocale, initial_setlocale):
	Move check whether charset has changed to internal_setlocale,
	to avoid unnecessary work when invoked via CW_INT_SETLOCALE.

Sufficiently trivial, I hope.

Andy

--001485f19a30751567047f458fac
Content-Type: application/octet-stream; name="int_setlocale.patch"
Content-Disposition: attachment; filename="int_setlocale.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g5im5dcj0
Content-length: 1664

SW5kZXg6IG5sc2Z1bmNzLmNjCj09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL25sc2Z1bmNzLmNj
LHYKcmV0cmlldmluZyByZXZpc2lvbiAxLjIxCmRpZmYgLXUgLXIxLjIxIG5s
c2Z1bmNzLmNjCi0tLSBubHNmdW5jcy5jYwkxMCBGZWIgMjAxMCAxMjoyOToy
NiAtMDAwMAkxLjIxCisrKyBubHNmdW5jcy5jYwkxMCBGZWIgMjAxMCAyMTow
NjoxMyAtMDAwMApAQCAtMTEyOSwxMiArMTEyOSwxNyBAQAogICAvKiBGSVhN
RTogSXQgY291bGQgYmUgbmVjZXNzYXJ5IHRvIGNvbnZlcnQgdGhlIGVudGly
ZSBlbnZpcm9ubWVudCwKIAkgICAgbm90IGp1c3QgUEFUSC4gKi8KICAgdG1w
X3BhdGhidWYgdHA7Ci0gIGNoYXIgKnBhdGggPSBnZXRlbnYgKCJQQVRIIik7
CisgIGNoYXIgKnBhdGg7CiAgIHdjaGFyX3QgKndfcGF0aCA9IE5VTEwsICp3
X2N3ZDsKIAorICAvKiBEb24ndCBkbyBhbnl0aGluZyBpZiB0aGUgY2hhcnNl
dCBoYXNuJ3QgYWN0dWFsbHkgY2hhbmdlZC4gKi8KKyAgaWYgKHN0cmNtcCAo
Y3lnaGVhcC0+bG9jYWxlLmNoYXJzZXQsIF9fbG9jYWxlX2NoYXJzZXQgKCkp
ID09IDApCisgICAgcmV0dXJuOworCiAgIGRlYnVnX3ByaW50ZiAoIkN5Z3dp
biBjaGFyc2V0IGNoYW5nZWQgZnJvbSAlcyB0byAlcyIsCiAJCWN5Z2hlYXAt
PmxvY2FsZS5jaGFyc2V0LCBfX2xvY2FsZV9jaGFyc2V0ICgpKTsKICAgLyog
RmV0Y2ggUEFUSCBhbmQgQ1dEIGFuZCBjb252ZXJ0IHRvIHdjaGFyX3QgaW4g
cHJldmlvdXMgY2hhcnNldC4gKi8KKyAgcGF0aCA9IGdldGVudiAoIlBBVEgi
KTsKICAgaWYgKHBhdGggJiYgKnBhdGgpCS8qICRQQVRIIGNhbiBiZSBwb3Rl
bnRpYWxseSB1bnNldC4gKi8KICAgICB7CiAgICAgICB3X3BhdGggPSB0cC53
X2dldCAoKTsKQEAgLTExNzUsOCArMTE4MCw3IEBACiBpbml0aWFsX3NldGxv
Y2FsZSAoKQogewogICBjaGFyICpyZXQgPSBfc2V0bG9jYWxlX3IgKF9SRUVO
VCwgTENfQ1RZUEUsICIiKTsKLSAgaWYgKHJldCAmJiBjaGVja19jb2RlcGFn
ZSAocmV0KQotICAgICAgJiYgc3RyY21wIChjeWdoZWFwLT5sb2NhbGUuY2hh
cnNldCwgX19sb2NhbGVfY2hhcnNldCAoKSkgIT0gMCkKKyAgaWYgKHJldCAm
JiBjaGVja19jb2RlcGFnZSAocmV0KSkKICAgICBpbnRlcm5hbF9zZXRsb2Nh
bGUgKCk7CiB9CiAK

--001485f19a30751567047f458fac--
