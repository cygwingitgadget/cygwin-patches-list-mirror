Return-Path: <cygwin-patches-return-4648-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23994 invoked by alias); 1 Apr 2004 09:58:52 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23972 invoked from network); 1 Apr 2004 09:58:49 -0000
Date: Thu, 01 Apr 2004 09:58:00 -0000
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary146301080813525"
Subject: [PATCH] thread self handling revised
X-Authenticated: #623905
Message-ID: <14630.1080813525@www21.gmx.net>
X-Flags: 0001
X-SW-Source: 2004-q2/txt/msg00000.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary146301080813525
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-length: 894

Rethinking the changes to pthread::init_mainthread i came to the conclusion
that this stuff can be made simpler and cleaner.
The changes to init_maintread are reverted, the thread self pointer for an
unknown thread is now set in pthread::self.

2004-04-01  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.h (pthread::init_mainthread): Remove parameter forked.
	(pthread::set_tls_self_pointer): New static function.
	* thread.cc (MTinterface::fixup_after_fork): Change call to
	pthread::init_mainthread.
	(pthread::init_mainthread): Remove parameter forked. Simplify
	thread self pointer handling.
	(pthread::self): Set thread self pointer to null_pthread if
	thread has not been initialized.
	(pthread::set_tls_self_pointer): New static function.

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz
--========GMXBoundary146301080813525
Content-Type: plain/text; name="init_main.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="init_main.patch"
Content-length: 3567

ZGlmZiAtdXJwIGN5Z3dpbi5vcmcvdGhyZWFkLmNjIGN5Z3dpbi90aHJlYWQu
Y2MKLS0tIGN5Z3dpbi5vcmcvdGhyZWFkLmNjCTIwMDQtMDQtMDEgMDk6NDQ6
NDQuNzM1NDMyMDAwICswMjAwCisrKyBjeWd3aW4vdGhyZWFkLmNjCTIwMDQt
MDQtMDEgMDk6NDc6MjUuNzU2OTY5NjAwICswMjAwCkBAIC0xNTMsNyArMTUz
LDcgQEAgTVRpbnRlcmZhY2U6OmZpeHVwX2FmdGVyX2ZvcmsgKHZvaWQpCiAg
IHB0aHJlYWRfa2V5OjpmaXh1cF9hZnRlcl9mb3JrICgpOwogCiAgIHRocmVh
ZGNvdW50ID0gMDsKLSAgcHRocmVhZDo6aW5pdF9tYWludGhyZWFkICh0cnVl
KTsKKyAgcHRocmVhZDo6aW5pdF9tYWludGhyZWFkICgpOwogCiAgIHB0aHJl
YWQ6OmZpeHVwX2FmdGVyX2ZvcmsgKCk7CiAgIHB0aHJlYWRfbXV0ZXg6OmZp
eHVwX2FmdGVyX2ZvcmsgKCk7CkBAIC0xNjYsMjMgKzE2NiwxNyBAQCBNVGlu
dGVyZmFjZTo6Zml4dXBfYWZ0ZXJfZm9yayAodm9pZCkKIAogLyogc3RhdGlj
IG1ldGhvZHMgKi8KIHZvaWQKLXB0aHJlYWQ6OmluaXRfbWFpbnRocmVhZCAo
Y29uc3QgYm9vbCBmb3JrZWQpCitwdGhyZWFkOjppbml0X21haW50aHJlYWQg
KCkKIHsKICAgcHRocmVhZCAqdGhyZWFkID0gZ2V0X3Rsc19zZWxmX3BvaW50
ZXIgKCk7CiAgIGlmICghdGhyZWFkKQogICAgIHsKLSAgICAgIGlmIChmb3Jr
ZWQpCi0gICAgICAgIHRocmVhZCA9IHB0aHJlYWRfbnVsbDo6Z2V0X251bGxf
cHRocmVhZCAoKTsKLSAgICAgIGVsc2UKLSAgICAgICAgewotICAgICAgICAg
IHRocmVhZCA9IG5ldyBwdGhyZWFkICgpOwotICAgICAgICAgIGlmICghdGhy
ZWFkKQotICAgICAgICAgICAgYXBpX2ZhdGFsICgiZmFpbGVkIHRvIGNyZWF0
ZSBtYWludGhyZWFkIG9iamVjdCIpOwotICAgICAgICB9CisgICAgICB0aHJl
YWQgPSBuZXcgcHRocmVhZCAoKTsKKyAgICAgIGlmICghdGhyZWFkKQorICAg
ICAgICBhcGlfZmF0YWwgKCJmYWlsZWQgdG8gY3JlYXRlIG1haW50aHJlYWQg
b2JqZWN0Iik7CiAgICAgfQogCi0gIHRocmVhZC0+Y3lndGxzID0gJl9teV90
bHM7Ci0gIF9teV90bHMudGlkID0gdGhyZWFkOworICBzZXRfdGxzX3NlbGZf
cG9pbnRlciAodGhyZWFkKTsKICAgdGhyZWFkLT50aHJlYWRfaWQgPSBHZXRD
dXJyZW50VGhyZWFkSWQgKCk7CiAgIGlmICghRHVwbGljYXRlSGFuZGxlIChH
ZXRDdXJyZW50UHJvY2VzcyAoKSwgR2V0Q3VycmVudFRocmVhZCAoKSwKIAkJ
CUdldEN1cnJlbnRQcm9jZXNzICgpLCAmdGhyZWFkLT53aW4zMl9vYmpfaWQs
CkBAIC0xOTgsOSArMTkyLDEyIEBAIHB0aHJlYWQgKgogcHRocmVhZDo6c2Vs
ZiAoKQogewogICBwdGhyZWFkICp0aHJlYWQgPSBnZXRfdGxzX3NlbGZfcG9p
bnRlciAoKTsKLSAgaWYgKHRocmVhZCkKLSAgICByZXR1cm4gdGhyZWFkOwot
ICByZXR1cm4gcHRocmVhZF9udWxsOjpnZXRfbnVsbF9wdGhyZWFkICgpOwor
ICBpZiAoIXRocmVhZCkKKyAgICB7CisgICAgICB0aHJlYWQgPSBwdGhyZWFk
X251bGw6OmdldF9udWxsX3B0aHJlYWQgKCk7CisgICAgICBzZXRfdGxzX3Nl
bGZfcG9pbnRlciAodGhyZWFkKTsKKyAgICB9CisgIHJldHVybiB0aHJlYWQ7
CiB9CiAKIHB0aHJlYWQgKgpAQCAtMjA5LDYgKzIwNiwxMyBAQCBwdGhyZWFk
OjpnZXRfdGxzX3NlbGZfcG9pbnRlciAoKQogICByZXR1cm4gX215X3Rscy50
aWQ7CiB9CiAKK3ZvaWQKK3B0aHJlYWQ6OnNldF90bHNfc2VsZl9wb2ludGVy
IChwdGhyZWFkICp0aHJlYWQpCit7CisgIHRocmVhZC0+Y3lndGxzID0gJl9t
eV90bHM7CisgIF9teV90bHMudGlkID0gdGhyZWFkOworfQorCiBMaXN0PHB0
aHJlYWQ+IHB0aHJlYWQ6OnRocmVhZHM7CiAKIC8qIG1lbWJlciBtZXRob2Rz
ICovCmRpZmYgLXVycCBjeWd3aW4ub3JnL3RocmVhZC5oIGN5Z3dpbi90aHJl
YWQuaAotLS0gY3lnd2luLm9yZy90aHJlYWQuaAkyMDA0LTA0LTAxIDA5OjQ0
OjM3LjQ3NDk5MjAwMCArMDIwMAorKysgY3lnd2luL3RocmVhZC5oCTIwMDQt
MDQtMDEgMDk6NDU6NDkuMTU4MDY3MjAwICswMjAwCkBAIC0zNzMsNyArMzcz
LDcgQEAgcHVibGljOgogICBwdGhyZWFkICgpOwogICB2aXJ0dWFsIH5wdGhy
ZWFkICgpOwogCi0gIHN0YXRpYyB2b2lkIGluaXRfbWFpbnRocmVhZCAoY29u
c3QgYm9vbCBmb3JrZWQgPSBmYWxzZSk7CisgIHN0YXRpYyB2b2lkIGluaXRf
bWFpbnRocmVhZCAoKTsKICAgc3RhdGljIGJvb2wgaXNfZ29vZF9vYmplY3Qo
cHRocmVhZF90IGNvbnN0ICopOwogICBzdGF0aWMgdm9pZCBhdGZvcmtwcmVw
YXJlKCk7CiAgIHN0YXRpYyB2b2lkIGF0Zm9ya3BhcmVudCgpOwpAQCAtNDQ3
LDkgKzQ0Nyw5IEBAIHByaXZhdGU6CiAgIHZvaWQgcG9wX2FsbF9jbGVhbnVw
X2hhbmRsZXJzICh2b2lkKTsKICAgdm9pZCBwcmVjcmVhdGUgKHB0aHJlYWRf
YXR0ciAqKTsKICAgdm9pZCBwb3N0Y3JlYXRlICgpOwotICB2b2lkIHNldF90
bHNfc2VsZl9wb2ludGVyICgpOwogICBib29sIGNyZWF0ZV9jYW5jZWxfZXZl
bnQgKCk7CiAgIHN0YXRpYyBwdGhyZWFkICpnZXRfdGxzX3NlbGZfcG9pbnRl
ciAoKTsKKyAgc3RhdGljIHZvaWQgc2V0X3Rsc19zZWxmX3BvaW50ZXIgKHB0
aHJlYWQgKik7CiAgIHZvaWQgY2FuY2VsX3NlbGYgKCk7CiAgIERXT1JEIGdl
dF90aHJlYWRfaWQgKCk7CiB9Owo=

--========GMXBoundary146301080813525--
