Return-Path: <cygwin-patches-return-2847-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8623 invoked by alias); 21 Aug 2002 01:24:01 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8607 invoked from network); 21 Aug 2002 01:24:00 -0000
Date: Tue, 20 Aug 2002 18:24:00 -0000
From: Joshua Daniel Franklin <joshua@iocc.com>
X-X-Originator: joshua@joshua.iocc.com
Reply-To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: patch for cygserver
Message-ID: <Pine.CYG.4.44.0208202020220.1628-200000@joshua.iocc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-235956108-1029892892=:1628"
X-SW-Source: 2002-q3/txt/msg00295.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-235956108-1029892892=:1628
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 913

In my personal opinion, all of the exe's in the cygwin package
should support (at a minimum) the GNU --help and --version options.
With that in mind, here is a patch for cygserver.cc that shoehorns them
in.

Now, I understand that cygserver is in a rather volitile state and it
very well may be better for one of the people who are actually working
on cygserver to create their own similar patch instead of using this
one. I only ask that it be done sometime, since AFAIK there is absolutely
no documentation (other than the mailing list) for cygserver. I would be
happy to create some if someone could give me a good rundown of what
all is/is not supported at this time. Unfortunately my limited understanding
of IPC might make this more trouble than it is worth.

ChangeLog:

2002-08-20  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>

	* cygserver.cc (usage): New function.
	(print_version): New function.

---559023410-235956108-1029892892=:1628
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygserver.cc-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0208202021320.1628@joshua.iocc.com>
Content-Description: 
Content-Disposition: attachment; filename="cygserver.cc-patch"
Content-length: 3360

LS0tIGN5Z3NlcnZlci5jYy1vcmlnCTIwMDItMDgtMTggMTA6NTc6MDYuMDAw
MDAwMDAwIC0wNTAwDQorKysgY3lnc2VydmVyLmNjCTIwMDItMDgtMTggMTE6
MDk6MjQuMDAwMDAwMDAwIC0wNTAwDQpAQCAtNDQ5LDYgKzQ0OSw0MCBAQCBz
dHJ1Y3Qgb3B0aW9uIGxvbmdvcHRzW10gPSB7DQogDQogY2hhciBvcHRzW10g
PSAicyI7DQogDQorc3RhdGljIHZvaWQNCit1c2FnZSAoRklMRSAqd2hlcmUg
PSBzdGRlcnIpDQorew0KKyAgZnByaW50ZiAod2hlcmUgLCAiIg0KKyAgICAg
ICAgIlVzYWdlOiBjeWdzZXJ2ZXIgWy1zXVxuIg0KKyAgICAgICAgIiAtcywg
LS1zaHV0ZG93biAgc2h1dGRvd24gY3lnc2VydmVyXG4iDQorICAgICAgICAi
IC1oLCAtLWhlbHAgICAgICBvdXRwdXQgdXNhZ2UgaW5mb3JtYXRpb24gYW5k
IGV4aXRcbiINCisgICAgICAgICIgLXYsIC0tdmVyc2lvbiAgIG91dHB1dCB2
ZXJzaW9uIGluZm9ybWF0aW9uIGFuZCBleGl0XG4iDQorICAgICAgICAiIik7
DQorICBleGl0ICh3aGVyZSA9PSBzdGRlcnIgPyAxIDogMCk7DQorfQ0KKw0K
K3N0YXRpYyB2b2lkDQorcHJpbnRfdmVyc2lvbiAoKQ0KK3sNCisgIGNoYXIg
dmVyc2lvblsyMDBdOw0KKyAgLyogQ3lnd2luIGRsbCByZWxlYXNlICovDQor
ICBzbnByaW50ZiAodmVyc2lvbiwgMjAwLCAiJWQuJWQuJWQoJWQuJWQvJWQv
JWQpLSglZC4lZC4lZC4lZCkgJXMiLA0KKwkJIGN5Z3dpbl92ZXJzaW9uLmRs
bF9tYWpvciAvIDEwMDAsDQorCQkgY3lnd2luX3ZlcnNpb24uZGxsX21ham9y
ICUgMTAwMCwNCisJCSBjeWd3aW5fdmVyc2lvbi5kbGxfbWlub3IsDQorCQkg
Y3lnd2luX3ZlcnNpb24uYXBpX21ham9yLA0KKwkJIGN5Z3dpbl92ZXJzaW9u
LmFwaV9taW5vciwNCisJCSBjeWd3aW5fdmVyc2lvbi5zaGFyZWRfZGF0YSwN
CisJCSBDWUdXSU5fU0VSVkVSX1ZFUlNJT05fTUFKT1IsDQorCQkgQ1lHV0lO
X1NFUlZFUl9WRVJTSU9OX0FQSSwNCisJCSBDWUdXSU5fU0VSVkVSX1ZFUlNJ
T05fTUlOT1IsDQorCQkgQ1lHV0lOX1NFUlZFUl9WRVJTSU9OX1BBVENILA0K
KwkJIGN5Z3dpbl92ZXJzaW9uLm1vdW50X3JlZ2lzdHJ5LA0KKwkJIGN5Z3dp
bl92ZXJzaW9uLmRsbF9idWlsZF9kYXRlKTsNCisgIHNldGJ1ZiAoc3Rkb3V0
LCBOVUxMKTsNCisgIHByaW50ZiAoIkN5Z3dpbiBJUEMgZGFlbW9uIHZlcnNp
b24gJXNcbiIsIHZlcnNpb24pOw0KK30NCisNCiBpbnQNCiBtYWluIChpbnQg
YXJnYywgY2hhciAqKmFyZ3YpDQogew0KQEAgLTQ1OCw5ICs0OTIsMTQgQEAg
bWFpbiAoaW50IGFyZ2MsIGNoYXIgKiphcmd2KQ0KICAgd2hpbGUgKChpID0g
Z2V0b3B0X2xvbmcgKGFyZ2MsIGFyZ3YsIG9wdHMsIGxvbmdvcHRzLCBOVUxM
KSkgIT0gRU9GKQ0KICAgICBzd2l0Y2ggKGkpDQogICAgICAgew0KKyAgICAg
IGNhc2UgJ2gnOg0KKyAgICAgIAl1c2FnZSAoc3Rkb3V0KTsNCiAgICAgICBj
YXNlICdzJzoNCiAJc2h1dGRvd24gPSAxOw0KIAlicmVhazsNCisgICAgICBj
YXNlICd2JzoNCisgICAgICAJcHJpbnRfdmVyc2lvbiAoKTsNCisJZXhpdCAo
MCk7DQogICAgICAgZGVmYXVsdDoNCiAJYnJlYWs7DQogICAgICAgIC8qTk9U
UkVBQ0hFRCovDQpAQCAtNDg3LDIzICs1MjYsOSBAQCBtYWluIChpbnQgYXJn
YywgY2hhciAqKmFyZ3YpDQogICAgICAgZXhpdCgwKTsNCiAgICAgfQ0KIA0K
LSAgY2hhciB2ZXJzaW9uWzIwMF07DQotICAvKiBDeWd3aW4gZGxsIHJlbGVh
c2UgKi8NCi0gIHNucHJpbnRmICh2ZXJzaW9uLCAyMDAsICIlZC4lZC4lZCgl
ZC4lZC8lZC8lZCktKCVkLiVkLiVkLiVkKSAlcyIsDQotCQkgY3lnd2luX3Zl
cnNpb24uZGxsX21ham9yIC8gMTAwMCwNCi0JCSBjeWd3aW5fdmVyc2lvbi5k
bGxfbWFqb3IgJSAxMDAwLA0KLQkJIGN5Z3dpbl92ZXJzaW9uLmRsbF9taW5v
ciwNCi0JCSBjeWd3aW5fdmVyc2lvbi5hcGlfbWFqb3IsDQotCQkgY3lnd2lu
X3ZlcnNpb24uYXBpX21pbm9yLA0KLQkJIGN5Z3dpbl92ZXJzaW9uLnNoYXJl
ZF9kYXRhLA0KLQkJIENZR1dJTl9TRVJWRVJfVkVSU0lPTl9NQUpPUiwNCi0J
CSBDWUdXSU5fU0VSVkVSX1ZFUlNJT05fQVBJLA0KLQkJIENZR1dJTl9TRVJW
RVJfVkVSU0lPTl9NSU5PUiwNCi0JCSBDWUdXSU5fU0VSVkVSX1ZFUlNJT05f
UEFUQ0gsDQotCQkgY3lnd2luX3ZlcnNpb24ubW91bnRfcmVnaXN0cnksDQot
CQkgY3lnd2luX3ZlcnNpb24uZGxsX2J1aWxkX2RhdGUpOw0KLSAgc2V0YnVm
IChzdGRvdXQsIE5VTEwpOw0KLSAgcHJpbnRmICgiZGFlbW9uIHZlcnNpb24g
JXMgc3RhcnRpbmcgdXAiLCB2ZXJzaW9uKTsNCisgIHByaW50X3ZlcnNpb24o
KTsNCisgIHByaW50ZiAoInN0YXJ0aW5nIHVwIik7DQorDQogICBpZiAoc2ln
bmFsIChTSUdRVUlULCBoYW5kbGVfc2lnbmFsKSA9PSBTSUdfRVJSKQ0KICAg
ICB7DQogICAgICAgcHJpbnRmICgiXG5jb3VsZCBub3QgaW5zdGFsbCBzaWdu
YWwgaGFuZGxlciAoJWQpLSBhYm9ydGluZyBzdGFydHVwXG4iLCBlcnJubyk7
DQo=

---559023410-235956108-1029892892=:1628--
