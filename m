Return-Path: <cygwin-patches-return-3843-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4721 invoked by alias); 1 May 2003 22:50:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4709 invoked from network); 1 May 2003 22:50:10 -0000
X-Authentication-Warning: slinky.cs.nyu.edu: pechtcha owned process doing -bs
Date: Thu, 01 May 2003 22:50:00 -0000
From: Igor Pechtchanski <pechtcha@cs.nyu.edu>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [PATCH] cygcheck parsing of id output
Message-ID: <Pine.GSO.4.44.0305011823430.25128-200000@slinky.cs.nyu.edu>
Importance: Normal
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-2022861571-1051829410=:25128"
X-SW-Source: 2003-q2/txt/msg00070.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-2022861571-1051829410=:25128
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1188

Hi,

The attached patch allows cygcheck to handle spaces, commas, and
*matching* parentheses in user and group names in the "id" output.
There's some code sharing in parsing the user and group names, but that
could be refactored in a later cleanup.

One issue that also came up is the old "run a cygwin program from a
non-cygwin program from an xterm" issue -- when running cygcheck from an
xterm, id pops up a separate window and cygcheck gets no output from id...
I'm not sure how to fix this.  One thing that comes to mind is making
cygcheck aware of Cygwin ptys, but I don't know how hard that would be...
	Igor
==============================================================================
ChangeLog:
2003-05-01  Igor Pechtchanski  <pechtcha@cs.nyu.edu>

	* cygcheck.cc (pretty_id): Parse id output without
	using strtok.
	(match_paren): New static function.

-- 
				http://cs.nyu.edu/~pechtcha/
      |\      _,,,---,,_		pechtcha@cs.nyu.edu
ZZZzz /,`.-'`'    -.  ;-;;,_		igor@watson.ibm.com
     |,4-  ) )-,_. ,\ (  `'-'		Igor Pechtchanski
    '---''(_/--'  `-'\_) fL	a.k.a JaguaR-R-R-r-r-r-.-.-.  Meow!

Knowledge is an unending adventure at the edge of uncertainty.
  -- Leto II

---559023410-2022861571-1051829410=:25128
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="cygcheck-id-output.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.44.0305011850100.25128@slinky.cs.nyu.edu>
Content-Description: 
Content-Disposition: attachment; filename="cygcheck-id-output.patch"
Content-length: 5539

SW5kZXg6IGN5Z2NoZWNrLmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpS
Q1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC91dGlscy9jeWdjaGVjay5j
Yyx2DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzQNCmRpZmYgLXUgLXAgLXIx
LjM0IGN5Z2NoZWNrLmNjDQotLS0gY3lnY2hlY2suY2MJMjYgQXByIDIwMDMg
MjE6NTI6MDMgLTAwMDAJMS4zNA0KKysrIGN5Z2NoZWNrLmNjCTEgTWF5IDIw
MDMgMjI6MzU6MTcgLTAwMDANCkBAIC03NjEsNiArNzYxLDIyIEBAIHNjYW5f
cmVnaXN0cnkgKFJlZ0luZm8gKiBwcmV2LCBIS0VZIGhLZXkNCiAgIGZyZWUg
KHN1YmtleV9uYW1lKTsNCiB9DQogDQorLyogSWYgKnN0cj09JygnLCByZXR1
cm5zIGEgcG9pbnRlciB0byBtYXRjaGluZyBwYXJlbnRoZXNpcyBvciBOVUxM
IGlmIG5vbmUuICovDQorc3RhdGljIGNoYXIgKm1hdGNoX3BhcmVuKGNoYXIg
KnN0cikNCit7DQorICBjaGFyICpwID0gc3RyOw0KKyAgaW50IHBjb3VudCA9
IDE7DQorICBpZiAoKnAgIT0gJygnKSByZXR1cm4gTlVMTDsNCisgIGZvciAo
cCsrOyAqcDsgcCsrKQ0KKyAgICB7DQorICAgICAgaWYgKCpwID09ICcoJykg
cGNvdW50Kys7DQorICAgICAgaWYgKCpwID09ICcpJykgcGNvdW50LS07DQor
ICAgICAgaWYgKHBjb3VudCA9PSAwKSBicmVhazsNCisgICAgfQ0KKyAgaWYg
KCEqcCkgcmV0dXJuIE5VTEw7DQorICByZXR1cm4gcDsNCit9DQorDQogdm9p
ZA0KIHByZXR0eV9pZCAoY29uc3QgY2hhciAqcywgY2hhciAqY3lnd2luLCBz
aXplX3QgY3lnbGVuKQ0KIHsNCkBAIC03ODQsMjAgKzgwMCw5MSBAQCBwcmV0
dHlfaWQgKGNvbnN0IGNoYXIgKnMsIGNoYXIgKmN5Z3dpbiwgDQogDQogICBj
aGFyIGJ1ZlsxNjM4NF07DQogICBmZ2V0cyAoYnVmLCBzaXplb2YgKGJ1Ziks
IGYpOw0KLSAgY2hhciAqdWlkID0gc3RydG9rIChidWYsICIgIikgKyBzaXpl
b2YgKCJ1aWQ9IikgLSAxOw0KLSAgY2hhciAqZ2lkID0gc3RydG9rIChOVUxM
LCAiICIpICsgc2l6ZW9mICgiZ2lkPSIpIC0gMTsNCisgIGlmICghKmJ1ZikN
CisgICAgew0KKyAgICAgIHByaW50ZigiVW5hYmxlIHRvIHBhcnNlIGlkIG91
dHB1dDogbm8gb3V0cHV0XG4iKTsNCisgICAgICByZXR1cm47DQorICAgIH0N
CisgIGNoYXIgKnVpZCA9IGJ1ZjsNCisgIGNoYXIgKnAgPSB1aWQgKyBzaXpl
b2YoInVpZD0iKSAtIDE7DQorICBpZiAoc3RybmNtcCh1aWQsICJ1aWQ9Iiwg
cCAtIHVpZCkgfHwgIWlzZGlnaXQoKnApKQ0KKyAgICB7DQorICAgICAgcHJp
bnRmKCJVbmFibGUgdG8gcGFyc2UgaWQgb3V0cHV0OiBubyB1aWQ9IHBhcnQ7
IGZ1bGwgb3V0cHV0IGlzXG4lc1xuIiwgdWlkKTsNCisgICAgICByZXR1cm47
DQorICAgIH0NCisgIHVpZCA9IHA7DQorICBmb3IgKDsgKnAgJiYgaXNkaWdp
dCgqcCk7IHArKykNCisgICAgOw0KKyAgaWYgKCpwICE9ICcoJykNCisgICAg
ew0KKyAgICAgIHByaW50ZigiVW5hYmxlIHRvIHBhcnNlIGlkIG91dHB1dDog
bm8gdWlkIG5hbWU7IGZ1bGwgb3V0cHV0IGlzXG4lc1xuIiwgdWlkKTsNCisg
ICAgICByZXR1cm47DQorICAgIH0NCisgIHAgPSBtYXRjaF9wYXJlbihwKTsN
CisgIGlmIChwID09IE5VTEwgfHwgKisrcCAhPSAnICcpDQorICAgIHsNCisg
ICAgICBwcmludGYoIlVuYWJsZSB0byBwYXJzZSBpZCBvdXRwdXQ6IHVpZCBu
YW1lIHBhcmVucyB1bm1hdGNoZWQ7IGZ1bGwgb3V0cHV0IGlzXG4lc1xuIiwg
dWlkKTsNCisgICAgICByZXR1cm47DQorICAgIH0NCisgICpwKysgPSAnXDAn
Ow0KKyAgY2hhciAqZ2lkID0gcDsNCisgIHAgPSBnaWQgKyBzaXplb2YoImdp
ZD0iKSAtIDE7DQorICBpZiAoc3RybmNtcChnaWQsICJnaWQ9IiwgcCAtIGdp
ZCkgfHwgIWlzZGlnaXQoKnApKQ0KKyAgICB7DQorICAgICAgcHJpbnRmKCJV
bmFibGUgdG8gcGFyc2UgaWQgb3V0cHV0OiBubyBnaWQ9IHBhcnQ7IGZ1bGwg
b3V0cHV0IGlzXG4lcyAlc1xuIiwgdWlkLCBnaWQpOw0KKyAgICAgIHJldHVy
bjsNCisgICAgfQ0KKyAgZ2lkID0gcDsNCisgIGZvciAoOyAqcCAmJiBpc2Rp
Z2l0KCpwKTsgcCsrKQ0KKyAgICA7DQorICBpZiAoKnAgIT0gJygnKQ0KKyAg
ICB7DQorICAgICAgcHJpbnRmKCJVbmFibGUgdG8gcGFyc2UgaWQgb3V0cHV0
OiBubyBnaWQgbmFtZTsgZnVsbCBvdXRwdXQgaXNcbiVzICVzXG4iLCB1aWQs
IGdpZCk7DQorICAgICAgcmV0dXJuOw0KKyAgICB9DQorICBwID0gbWF0Y2hf
cGFyZW4ocCk7DQorICBpZiAocCA9PSBOVUxMIHx8ICorK3AgIT0gJyAnKQ0K
KyAgICB7DQorICAgICAgcHJpbnRmKCJVbmFibGUgdG8gcGFyc2UgaWQgb3V0
cHV0OiBnaWQgbmFtZSBwYXJlbnMgdW5tYXRjaGVkOyBmdWxsIG91dHB1dCBp
c1xuJXMgJXNcbiIsIHVpZCwgZ2lkKTsNCisgICAgICByZXR1cm47DQorICAg
IH0NCisgICpwKysgPSAnXDAnOw0KKyAgY2hhciAqZ3JwID0gcDsNCisgIHAg
PSBncnAgKyBzaXplb2YoImdyb3Vwcz0iKSAtIDE7DQorICBpZiAoc3RybmNt
cChncnAsICJncm91cHM9IiwgcCAtIGdycCkgfHwgIWlzZGlnaXQoKnApKQ0K
KyAgICB7DQorICAgICAgcHJpbnRmKCJVbmFibGUgdG8gcGFyc2UgaWQgb3V0
cHV0OiBubyBncm91cHM9IHBhcnQ7IGZ1bGwgb3V0cHV0IGlzXG4lcyAlcyAl
c1xuIiwgdWlkLCBnaWQsIGdycCk7DQorICAgICAgcmV0dXJuOw0KKyAgICB9
DQogICBjaGFyICoqbmc7DQogICBzaXplX3Qgc3ogPSAwOw0KLSAgZm9yIChu
ZyA9IGdyb3VwczsgKCpuZyA9IHN0cnRvayAoTlVMTCwgIiwiKSk7IG5nKysp
DQorICBmb3IgKG5nID0gZ3JvdXBzOyBpc2RpZ2l0KCpwKTsgbmcrKykNCiAg
ICAgew0KLSAgICAgIGNoYXIgKnAgPSBzdHJjaHIgKCpuZywgJ1xuJyk7DQot
ICAgICAgaWYgKHApDQotCSpwID0gJ1wwJzsNCi0gICAgICBpZiAobmcgPT0g
Z3JvdXBzKQ0KLQkqbmcgKz0gc2l6ZW9mICgiZ3JvdXBzPSIpIC0gMTsNCi0g
ICAgICBzaXplX3QgbGVuID0gc3RybGVuICgqbmcpOw0KKyAgICAgICpuZyA9
IHA7DQorICAgICAgZm9yICg7ICpwICYmIGlzZGlnaXQoKnApOyBwKyspDQor
CTsNCisgICAgICBpZiAoKnAgIT0gJygnKQ0KKwl7DQorCSAgcHJpbnRmKCJV
bmFibGUgdG8gcGFyc2UgaWQgb3V0cHV0OiBubyBncm91cCBuYW1lOiAlczsg
ZnVsbCBvdXRwdXQgaXNcbiVzICVzICVzIiwgbmcsIHVpZCwgZ2lkLCBncnAp
Ow0KKyAgICAgICAgICBmb3IgKGNoYXIgKipnID0gZ3JvdXBzOyBnICE9IG5n
OyBnKyspDQorCSAgICBwcmludGYoIiVzLCIsIGcpOw0KKwkgIHByaW50Zigi
JXNcbiIsIG5nKTsNCisJICByZXR1cm47DQorCX0NCisgICAgICBwID0gbWF0
Y2hfcGFyZW4ocCk7DQorICAgICAgaWYgKHAgPT0gTlVMTCB8fCAoKisrcCAh
PSAnLCcgJiYgKnAgIT0gJ1xuJyAmJiAqcCkpDQorCXsNCisJICBwcmludGYo
IlVuYWJsZSB0byBwYXJzZSBpZCBvdXRwdXQ6IGdyb3VwIG5hbWUgcGFyZW4g
dW5tYXRjaGVkOiAlczsgZnVsbCBvdXRwdXQgaXNcbiVzICVzICVzIiwgbmcs
IHVpZCwgZ2lkLCBncnApOw0KKyAgICAgICAgICBmb3IgKGNoYXIgKipnID0g
Z3JvdXBzOyBnICE9IG5nOyBnKyspDQorCSAgICBwcmludGYoIiVzLCIsIGcp
Ow0KKwkgIHByaW50ZigiJXNcbiIsIG5nKTsNCisJICByZXR1cm47DQorCX0N
CisgICAgICBzaXplX3QgbGVuID0gcCAtICpuZzsNCiAgICAgICBpZiAoc3og
PCBsZW4pDQogCXN6ID0gbGVuOw0KKyAgICAgIGlmICgqcCkNCisgICAgICAg
ICpwKysgPSAnXDAnOw0KICAgICB9DQogDQogICBwcmludGYgKCJcbiVzIG91
dHB1dCAoJXMpXG4iLCBpZCwgcyk7DQpAQCAtODA3LDcgKzg5NCw2IEBAIHBy
ZXR0eV9pZCAoY29uc3QgY2hhciAqcywgY2hhciAqY3lnd2luLCANCiAgIHN6
ICs9IDE7DQogICBpbnQgbiA9IDgwIC8gKGludCkgc3o7DQogICBzeiA9IC1z
ejsNCi0gIG5nWzBdICs9IHNpemVvZiAoImdyb3Vwcz0iKSAtIDE7DQogICBw
cmludGYgKCJVSUQ6ICUqcyBHSUQ6ICVzXG4iLCBzeiArIChzaXplb2YgKCJV
SUQ6ICIpIC0gMSksIHVpZCwgZ2lkKTsNCiAgIGludCBpID0gMDsNCiAgIGZv
ciAoY2hhciAqKmcgPSBncm91cHM7IGcgPCBuZzsgZysrKQ0K

---559023410-2022861571-1051829410=:25128--
