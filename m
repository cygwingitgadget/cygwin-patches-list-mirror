Return-Path: <cygwin-patches-return-4850-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 19036 invoked by alias); 15 Jul 2004 13:44:36 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 19018 invoked from network); 15 Jul 2004 13:44:35 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 15 Jul 2004 13:44:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [RFC] Reference counting on Audio objects for /dev/dsp
Message-ID: <Pine.GSO.4.58.0407150928040.29800@slinky.cs.nyu.edu>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-2022861571-1089899074=:29800"
X-Scanned-By: MIMEDefang 2.39
X-SW-Source: 2004-q3/txt/msg00002.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-2022861571-1089899074=:29800
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1617

Gerd,

I'd really like your comments on this patch.  As I reported before, it
didn't quite work for me, but with the recent problems in testing another
(presumably working) patch, I suspect my test procedure isn't quite
correct anyway.  The patch basically adds a (very problem-specific)
reference count to the Audio object(s), and doesn't delete the shared ones
until all pointers are gone.  It doesn't seem to fix the bash redirection
problem, but does allow the "dsp_dup_close" testcase to run (again, I'd
like your opinion on whether it runs correctly).

The ChangeLog below is just for the record -- as I said, I don't expect
this to be checked in yet.
	Igor
==============================================================================
ChangeLog:
2004-07-06  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* fhandler_dsp.cc (fhandler_dev_dsp::Audio::reference_count_):
	New instance variable.
	(fhandler_dev_dsp::Audio::inc): New function.  Increment the
	reference_count_.
	(fhandler_dev_dsp::Audio::dec): New function.  Decrement the
	reference_count_ and delete if zero.
	(fhandler_dev_dsp::close): Replace delete with a call to dec().
	(fhandler_dev_dsp::dup): Copy audio_in_ and audio_out_ and call
	inc() on each.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski, Ph.D.
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

"I have since come to realize that being between your mentor and his route
to the bathroom is a major career booster."  -- Patrick Naughton
---559023410-2022861571-1089899074=:29800
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="fhandler_dsp-dup.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.58.0407150944340.29800@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="fhandler_dsp-dup.patch"
Content-length: 3193

SW5kZXg6IGZoYW5kbGVyX2RzcC5jYw0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX2RzcC5jYyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzcNCmRpZmYg
LXUgLXAgLXIxLjM3IGZoYW5kbGVyX2RzcC5jYw0KLS0tIGZoYW5kbGVyX2Rz
cC5jYwkyOCBNYXkgMjAwNCAxOTo1MDowNSAtMDAwMAkxLjM3DQorKysgZmhh
bmRsZXJfZHNwLmNjCTE1IEp1bCAyMDA0IDEzOjQwOjM2IC0wMDAwDQpAQCAt
ODAsNyArODAsMTMgQEAgY2xhc3MgZmhhbmRsZXJfZGV2X2RzcDo6QXVkaW8N
CiAgICAgKHVuc2lnbmVkIGNoYXIgKmJ1ZmZlciwgaW50IHNpemVfYnl0ZXMp
Ow0KICAgaW5saW5lIHZvaWQgbG9jayAoKSB7IEVudGVyQ3JpdGljYWxTZWN0
aW9uICgmbG9ja18pOyB9DQogICBpbmxpbmUgdm9pZCB1bmxvY2sgKCkgeyBM
ZWF2ZUNyaXRpY2FsU2VjdGlvbiAoJmxvY2tfKTsgfQ0KKw0KKy8vICBpbmxp
bmUgdm9pZCBpbmMgKHZvaWQpIHsgcmVmZXJlbmNlX2NvdW50XysrOyB9DQor
Ly8gIGlubGluZSB2b2lkIGRlYyAodm9pZCkgeyBpZiAoLS1yZWZlcmVuY2Vf
Y291bnRfID09IDApIGRlbGV0ZSB0aGlzOyB9DQorICB2b2lkIGluYyAodm9p
ZCk7DQorICB2b2lkIGRlYyAodm9pZCk7DQogIHByaXZhdGU6DQorICBEV09S
RCByZWZlcmVuY2VfY291bnRfOyAvKiBIQUNLISEhISBBIHF1aWNrLWFuZC1k
aXJ0eSByZWZlcmVuY2UgY291bnQgKi8NCiAgIERXT1JEIG93bmVyXzsgLyog
UHJvY2VzcyBJRCB3aGVuIHdhdmUgb3BlcmF0aW9uIHN0YXJ0ZWQsIGVsc2Ug
MCAqLw0KICAgQ1JJVElDQUxfU0VDVElPTiBsb2NrXzsNCiB9Ow0KQEAgLTIz
MSw2ICsyMzcsMjAgQEAgZmhhbmRsZXJfZGV2X2RzcDo6QXVkaW86OkF1ZGlv
ICgpDQogICBJbml0aWFsaXplQ3JpdGljYWxTZWN0aW9uICgmbG9ja18pOw0K
ICAgY29udmVydF8gPSAmZmhhbmRsZXJfZGV2X2RzcDo6QXVkaW86OmNvbnZl
cnRfbm9uZTsNCiAgIG93bmVyXyA9IDBMOw0KKyAgcmVmZXJlbmNlX2NvdW50
XyA9IDE7IC8vIEdvaW5nIHRvIGFzc2lnbiByaWdodCBhZnRlciBhbGxvY2F0
aW9uDQorfQ0KKw0KK3ZvaWQgZmhhbmRsZXJfZGV2X2RzcDo6QXVkaW86Omlu
YyAodm9pZCkgew0KKyAgcmVmZXJlbmNlX2NvdW50XysrOw0KKyAgZGVidWdf
cHJpbnRmKCIlMDhwOyByZWZfY291bnQ9JWxkXG4iLCB0aGlzLCByZWZlcmVu
Y2VfY291bnRfKTsNCit9DQorDQordm9pZCBmaGFuZGxlcl9kZXZfZHNwOjpB
dWRpbzo6ZGVjICh2b2lkKSB7DQorICBkZWJ1Z19wcmludGYoIiUwOHA7IHJl
Zl9jb3VudD0lbGRcbiIsIHRoaXMsIHJlZmVyZW5jZV9jb3VudF8tMSk7DQor
ICBpZiAoLS1yZWZlcmVuY2VfY291bnRfID09IDApIHsNCisgICAgZGVidWdf
cHJpbnRmKCItLSBkZWxldGluZ1xuIik7DQorICAgIGRlbGV0ZSB0aGlzOw0K
KyAgfQ0KIH0NCiANCiBmaGFuZGxlcl9kZXZfZHNwOjpBdWRpbzo6fkF1ZGlv
ICgpDQpAQCAtMTIwMiw3ICsxMjIyLDcgQEAgZmhhbmRsZXJfZGV2X2RzcDo6
Y2xvc2UgKHZvaWQpDQogCQkoaW50KWF1ZGlvX2luXywgKGludClhdWRpb19v
dXRfKTsNCiAgIGlmIChhdWRpb19pbl8pDQogICAgIHsNCi0gICAgICBkZWxl
dGUgYXVkaW9faW5fOw0KKyAgICAgIGF1ZGlvX2luXy0+ZGVjICgpOw0KICAg
ICAgIGF1ZGlvX2luXyA9IE5VTEw7DQogICAgIH0NCiAgIGlmIChhdWRpb19v
dXRfKQ0KQEAgLTEyMTIsNyArMTIzMiw3IEBAIGZoYW5kbGVyX2Rldl9kc3A6
OmNsb3NlICh2b2lkKQ0KIAkgLy8gZG8gbm90IHdhaXQgZm9yIGFsbCBwZW5k
aW5nIGF1ZGlvIHRvIGJlIHBsYXllZA0KIAkgYXVkaW9fb3V0Xy0+c3RvcCAo
dHJ1ZSk7DQogICAgICAgIH0NCi0gICAgICBkZWxldGUgYXVkaW9fb3V0XzsN
CisgICAgICBhdWRpb19vdXRfIC0+IGRlYyAoKTsNCiAgICAgICBhdWRpb19v
dXRfID0gTlVMTDsNCiAgICAgfQ0KICAgaWYgKG9wZW5fY291bnQgPiAwKQ0K
QEAgLTEyMzEsNiArMTI1MSw5IEBAIGZoYW5kbGVyX2Rldl9kc3A6OmR1cCAo
ZmhhbmRsZXJfYmFzZSAqIGMNCiAgIGZoYy0+YXVkaW9iaXRzXyA9IGF1ZGlv
Yml0c187DQogICBmaGMtPmF1ZGlvZnJlcV8gPSBhdWRpb2ZyZXFfOw0KICAg
ZmhjLT5hdWRpb2Zvcm1hdF8gPSBhdWRpb2Zvcm1hdF87DQorDQorICBmaGMt
PmF1ZGlvX2luXyA9IGF1ZGlvX2luXzsgaWYgKGF1ZGlvX2luXykgYXVkaW9f
aW5fLT5pbmMgKCk7DQorICBmaGMtPmF1ZGlvX291dF8gPSBhdWRpb19vdXRf
OyBpZiAoYXVkaW9fb3V0XykgYXVkaW9fb3V0Xy0+aW5jICgpOw0KICAgcmV0
dXJuIDA7DQogfQ0KIA0K

---559023410-2022861571-1089899074=:29800--
