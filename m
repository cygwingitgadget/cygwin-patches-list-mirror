Return-Path: <cygwin-patches-return-4640-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 8334 invoked by alias); 30 Mar 2004 14:39:35 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8318 invoked from network); 30 Mar 2004 14:39:32 -0000
Date: Tue, 30 Mar 2004 14:39:00 -0000
From: "Thomas Pfaff" <tpfaff@gmx.net>
To: cygwin-patches@cygwin.com
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="========GMXBoundary138591080657571"
Subject: Re: [Dr.Volker.Zell@oracle.com: Re: uxterm from xterm-185-3 and xfontsel crashing when running under cygserver support]
X-Authenticated: #623905
Message-ID: <13859.1080657571@www59.gmx.net>
X-Flags: 0001
X-SW-Source: 2004-q1/txt/msg00130.txt.bz2

This is a MIME encapsulated multipart message -
please use a MIME-compliant e-mail program to open it.

Dies ist eine mehrteilige Nachricht im MIME-Format -
bitte verwenden Sie zum Lesen ein MIME-konformes Mailprogramm.

--========GMXBoundary138591080657571
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-length: 1260

Corinna Vinschen wrote:
> On Mar 30 15:34, Thomas Pfaff wrote:
> > Regardless whether a process is started from a cygwin app or not it will
> > always start at mainCRTStartup. 
> > 
> > When it is started by the SCM however the service_main thread is created
by
> > the SCM. The situation is similar to calling CreateThread instead of
> > pthread_create. The thread will be handled as anonymous since it is not
in the thread
> > list and has not been initialized in thread_init_wrapper.
> 
> Yeah, I just realized this while in the shower.
> 
> > I think the easiest way is to modify pthread::init_mainthread in a way
that
> > it handles such a situation properly and will keep the pthread_self
pointer
> > unchanged after a fork.
> 
> Do you have an appropriate patch?
> 

2004-03-30  Thomas Pfaff  <tpfaff@gmx.net>

	* thread.h (pthread::init_mainthread): Add parameter forked.
	Set forked default to false..
	* thread.cc (MTinterface::fixup_after_fork): Call
	pthread::init_mainthread with forked = true.
	(pthread::init_mainthread): Add parameter forked. Do not change thread self
	pointer when forked.

-- 
+++ NEU bei GMX und erstmalig in Deutschland: TÜV-geprüfter Virenschutz +++
100% Virenerkennung nach Wildlist. Infos: http://www.gmx.net/virenschutz
--========GMXBoundary138591080657571
Content-Type: plain/text; name="init_main.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="init_main.patch"
Content-length: 1997

ZGlmZiAtdXJwIGN5Z3dpbi5vcmcvdGhyZWFkLmNjIGN5Z3dpbi90aHJlYWQu
Y2MKLS0tIGN5Z3dpbi5vcmcvdGhyZWFkLmNjCTIwMDQtMDMtMzAgMTY6MTM6
NTcuNjY0MTE2ODAwICswMjAwCisrKyBjeWd3aW4vdGhyZWFkLmNjCTIwMDQt
MDMtMzAgMTY6MjQ6MTUuMjYxMDA4MDAwICswMjAwCkBAIC0xNTMsNyArMTUz
LDcgQEAgTVRpbnRlcmZhY2U6OmZpeHVwX2FmdGVyX2ZvcmsgKHZvaWQpCiAg
IHB0aHJlYWRfa2V5OjpmaXh1cF9hZnRlcl9mb3JrICgpOwogCiAgIHRocmVh
ZGNvdW50ID0gMDsKLSAgcHRocmVhZDo6aW5pdF9tYWludGhyZWFkICgpOwor
ICBwdGhyZWFkOjppbml0X21haW50aHJlYWQgKHRydWUpOwogCiAgIHB0aHJl
YWQ6OmZpeHVwX2FmdGVyX2ZvcmsgKCk7CiAgIHB0aHJlYWRfbXV0ZXg6OmZp
eHVwX2FmdGVyX2ZvcmsgKCk7CkBAIC0xNjYsMTQgKzE2NiwxOSBAQCBNVGlu
dGVyZmFjZTo6Zml4dXBfYWZ0ZXJfZm9yayAodm9pZCkKIAogLyogc3RhdGlj
IG1ldGhvZHMgKi8KIHZvaWQKLXB0aHJlYWQ6OmluaXRfbWFpbnRocmVhZCAo
KQorcHRocmVhZDo6aW5pdF9tYWludGhyZWFkIChjb25zdCBib29sIGZvcmtl
ZCkKIHsKICAgcHRocmVhZCAqdGhyZWFkID0gZ2V0X3Rsc19zZWxmX3BvaW50
ZXIgKCk7CiAgIGlmICghdGhyZWFkKQogICAgIHsKLSAgICAgIHRocmVhZCA9
IG5ldyBwdGhyZWFkICgpOwotICAgICAgaWYgKCF0aHJlYWQpCi0JYXBpX2Zh
dGFsICgiZmFpbGVkIHRvIGNyZWF0ZSBtYWludGhyZWFkIG9iamVjdCIpOwor
ICAgICAgaWYgKCFmb3JrZWQpCisgICAgICAgIHsKKyAgICAgICAgICB0aHJl
YWQgPSBuZXcgcHRocmVhZCAoKTsKKyAgICAgICAgICBpZiAoIXRocmVhZCkK
KyAgICAgICAgICAgIGFwaV9mYXRhbCAoImZhaWxlZCB0byBjcmVhdGUgbWFp
bnRocmVhZCBvYmplY3QiKTsKKyAgICAgICAgfQorICAgICAgZWxzZQorICAg
ICAgICB0aHJlYWQgPSBwdGhyZWFkX251bGw6OmdldF9udWxsX3B0aHJlYWQg
KCk7CiAgICAgfQogCiAgIHRocmVhZC0+Y3lndGxzID0gJl9teV90bHM7CmRp
ZmYgLXVycCBjeWd3aW4ub3JnL3RocmVhZC5oIGN5Z3dpbi90aHJlYWQuaAot
LS0gY3lnd2luLm9yZy90aHJlYWQuaAkyMDA0LTAzLTMwIDE2OjE0OjEyLjg3
NTk5MDQwMCArMDIwMAorKysgY3lnd2luL3RocmVhZC5oCTIwMDQtMDMtMzAg
MTY6MjQ6MTUuMzUxMTM3NjAwICswMjAwCkBAIC0zNzMsNyArMzczLDcgQEAg
cHVibGljOgogICBwdGhyZWFkICgpOwogICB2aXJ0dWFsIH5wdGhyZWFkICgp
OwogCi0gIHN0YXRpYyB2b2lkIGluaXRfbWFpbnRocmVhZCAoKTsKKyAgc3Rh
dGljIHZvaWQgaW5pdF9tYWludGhyZWFkIChjb25zdCBib29sIGZvcmtlZCA9
IGZhbHNlKTsKICAgc3RhdGljIGJvb2wgaXNfZ29vZF9vYmplY3QocHRocmVh
ZF90IGNvbnN0ICopOwogICBzdGF0aWMgdm9pZCBhdGZvcmtwcmVwYXJlKCk7
CiAgIHN0YXRpYyB2b2lkIGF0Zm9ya3BhcmVudCgpOwo=

--========GMXBoundary138591080657571--
