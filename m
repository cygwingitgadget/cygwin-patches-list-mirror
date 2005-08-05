Return-Path: <cygwin-patches-return-5605-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2587 invoked by alias); 5 Aug 2005 12:32:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2557 invoked by uid 22791); 5 Aug 2005 12:32:04 -0000
Received: from sccrmhc14.comcast.net (HELO sccrmhc14.comcast.net) (204.127.202.59)
    by sourceware.org (qpsmtpd/0.30-dev) with ESMTP; Fri, 05 Aug 2005 12:32:04 +0000
Received: from [192.168.15.2] (c-65-96-128-135.hsd1.ma.comcast.net[65.96.128.135])
          by comcast.net (sccrmhc14) with SMTP
          id <2005080512320301400d2633e>; Fri, 5 Aug 2005 12:32:03 +0000
Date: Fri, 05 Aug 2005 12:32:00 -0000
From: Mike Gorse <mgorse@alum.wpi.edu>
X-X-Sender: mgorse@mgorse.dhs.org
To: cygwin-patches@cygwin.com
Subject: Re: fix possible segfault creating detached thread (fwd)
Message-ID: <Pine.LNX.4.61.0508050831040.17631@mgorse.dhs.org>
MIME-Version: 1.0
Content-Type: MULTIPART/Mixed; BOUNDARY="8323328-1996556788-1122988814=:6151"
Content-ID: <Pine.LNX.4.61.0508050831041.17631@mgorse.dhs.org>
X-SW-Source: 2005-q3/txt/msg00060.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1996556788-1122988814=:6151
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <Pine.LNX.4.61.0508050831042.17631@mgorse.dhs.org>
Content-length: 471

On Tue, 2 Aug 2005, Corinna Vinschen wrote:

> Can you please review your patch file?  I was unable to apply the patch,
> even when using the -l option:

Pine must be wrapping lines.  I'm resending it as an attachment.

2005-08-05 Michael Gorse <mgorse@alum.wpi.edu>

  * thread.cc (pthread::create(3 args)): Make bool.
  (pthread_null::create): Ditto.
  (pthread::create(4 args)): Check return of inner create rather than
  calling is_good_object().
  * thread.h: Ditto.
--8323328-1996556788-1122988814=:6151
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="pthread.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.61.0508020920140.6151@mgorse.dhs.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="pthread.patch"
Content-length: 3055

SW5kZXg6IHRocmVhZC5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3RocmVhZC5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTkwDQpkaWZmIC11IC1wIC1yMS4x
OTAgdGhyZWFkLmNjDQotLS0gdGhyZWFkLmNjCTYgSnVsIDIwMDUgMjA6MDU6
MDMgLTAwMDAJMS4xOTANCisrKyB0aHJlYWQuY2MJMiBBdWcgMjAwNSAxMzox
NTowNCAtMDAwMA0KQEAgLTQ5MSwxMyArNDkxLDE1IEBAIHB0aHJlYWQ6OnBy
ZWNyZWF0ZSAocHRocmVhZF9hdHRyICpuZXdhdHQNCiAgICAgbWFnaWMgPSAw
Ow0KIH0NCiANCi12b2lkDQorYm9vbA0KIHB0aHJlYWQ6OmNyZWF0ZSAodm9p
ZCAqKCpmdW5jKSAodm9pZCAqKSwgcHRocmVhZF9hdHRyICpuZXdhdHRyLA0K
IAkJIHZvaWQgKnRocmVhZGFyZykNCiB7DQorICBib29sIHJldHZhbDsNCisN
CiAgIHByZWNyZWF0ZSAobmV3YXR0cik7DQogICBpZiAoIW1hZ2ljKQ0KLSAg
ICByZXR1cm47DQorICAgIHJldHVybiBmYWxzZTsNCiANCiAgIGZ1bmN0aW9u
ID0gZnVuYzsNCiAgIGFyZyA9IHRocmVhZGFyZzsNCkBAIC01MTcsNyArNTE5
LDkgQEAgcHRocmVhZDo6Y3JlYXRlICh2b2lkICooKmZ1bmMpICh2b2lkICop
LA0KICAgICAgIHdoaWxlICghY3lndGxzKQ0KIAlsb3dfcHJpb3JpdHlfc2xl
ZXAgKDApOw0KICAgICB9DQorICByZXR2YWwgPSBtYWdpYzsNCiAgIG11dGV4
LnVubG9jayAoKTsNCisgIHJldHVybiByZXR2YWw7DQogfQ0KIA0KIHZvaWQN
CkBAIC0xOTkzLDggKzE5OTcsNyBAQCBwdGhyZWFkOjpjcmVhdGUgKHB0aHJl
YWRfdCAqdGhyZWFkLCBjb25zDQogICAgIHJldHVybiBFSU5WQUw7DQogDQog
ICAqdGhyZWFkID0gbmV3IHB0aHJlYWQgKCk7DQotICAoKnRocmVhZCktPmNy
ZWF0ZSAoc3RhcnRfcm91dGluZSwgYXR0ciA/ICphdHRyIDogTlVMTCwgYXJn
KTsNCi0gIGlmICghaXNfZ29vZF9vYmplY3QgKHRocmVhZCkpDQorICBpZiAo
ISgqdGhyZWFkKS0+Y3JlYXRlIChzdGFydF9yb3V0aW5lLCBhdHRyID8gKmF0
dHIgOiBOVUxMLCBhcmcpKQ0KICAgICB7DQogICAgICAgZGVsZXRlICgqdGhy
ZWFkKTsNCiAgICAgICAqdGhyZWFkID0gTlVMTDsNCkBAIC0zMjYyLDkgKzMy
NjUsMTAgQEAgcHRocmVhZF9udWxsOjp+cHRocmVhZF9udWxsICgpDQogew0K
IH0NCiANCi12b2lkDQorYm9vbA0KIHB0aHJlYWRfbnVsbDo6Y3JlYXRlICh2
b2lkICooKikodm9pZCAqKSwgcHRocmVhZF9hdHRyICosIHZvaWQgKikNCiB7
DQorICByZXR1cm4gdHJ1ZTsNCiB9DQogDQogdm9pZA0KSW5kZXg6IHRocmVh
ZC5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9z
cmMvc3JjL3dpbnN1cC9jeWd3aW4vdGhyZWFkLmgsdg0KcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjEwMA0KZGlmZiAtdSAtcCAtcjEuMTAwIHRocmVhZC5oDQot
LS0gdGhyZWFkLmgJNSBKdWwgMjAwNSAwMzoxNjo0NiAtMDAwMAkxLjEwMA0K
KysrIHRocmVhZC5oCTIgQXVnIDIwMDUgMTM6MTU6MDUgLTAwMDANCkBAIC0z
ODAsNyArMzgwLDcgQEAgcHVibGljOg0KICAgSEFORExFIGNhbmNlbF9ldmVu
dDsNCiAgIHB0aHJlYWRfdCBqb2luZXI7DQogDQotICB2aXJ0dWFsIHZvaWQg
Y3JlYXRlICh2b2lkICooKikodm9pZCAqKSwgcHRocmVhZF9hdHRyICosIHZv
aWQgKik7DQorICB2aXJ0dWFsIGJvb2wgY3JlYXRlICh2b2lkICooKikodm9p
ZCAqKSwgcHRocmVhZF9hdHRyICosIHZvaWQgKik7DQogDQogICBwdGhyZWFk
ICgpOw0KICAgdmlydHVhbCB+cHRocmVhZCAoKTsNCkBAIC00NzMsNyArNDcz
LDcgQEAgY2xhc3MgcHRocmVhZF9udWxsIDogcHVibGljIHB0aHJlYWQNCiAg
IC8qIEZyb20gcHRocmVhZCBUaGVzZSBzaG91bGQgbmV2ZXIgZ2V0IGNhbGxl
ZA0KICAgKiBhcyB0aGUgb2piZWN0IGlzIG5vdCB2ZXJpZnlhYmxlDQogICAq
Lw0KLSAgdm9pZCBjcmVhdGUgKHZvaWQgKigqKSh2b2lkICopLCBwdGhyZWFk
X2F0dHIgKiwgdm9pZCAqKTsNCisgIGJvb2wgY3JlYXRlICh2b2lkICooKiko
dm9pZCAqKSwgcHRocmVhZF9hdHRyICosIHZvaWQgKik7DQogICB2b2lkIGV4
aXQgKHZvaWQgKnZhbHVlX3B0cikgX19hdHRyaWJ1dGVfXyAoKG5vcmV0dXJu
KSk7DQogICBpbnQgY2FuY2VsICgpOw0KICAgdm9pZCB0ZXN0Y2FuY2VsICgp
Ow0K

--8323328-1996556788-1122988814=:6151--
