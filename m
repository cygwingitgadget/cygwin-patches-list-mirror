Return-Path: <cygwin-patches-return-4751-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7977 invoked by alias); 14 May 2004 00:35:19 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7929 invoked from network); 14 May 2004 00:35:17 -0000
Date: Fri, 14 May 2004 00:35:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: yRe: [Patch] Fix gethwnd race
In-Reply-To: <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
Message-ID: <Pine.CYG.4.58.0405131932470.2344@fordpc.vss.fsi.com>
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
 <20040507032703.GA950@coe.bosbc.com> <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
 <20040513200801.GA8666@coe.bosbc.com> <Pine.CYG.4.58.0405131519060.3944@fordpc.vss.fsi.com>
 <20040513210306.GD11731@coe.bosbc.com> <Pine.CYG.4.58.0405131614030.3944@fordpc.vss.fsi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-44947985-1084494909=:2344"
X-SW-Source: 2004-q2/txt/msg00103.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-44947985-1084494909=:2344
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 569

On Thu, 13 May 2004, Brian Ford wrote:

> On Thu, 13 May 2004, Christopher Faylor wrote:
> > If it does exist, just return it.  No locking required.
>
> Ok, add:
>
> if (ourhwnd)
>   return ourhwnd;
>
> to the beginning of my patch if your worried about the interlocked
> overhead and don't mind a double test.

Revised patch attached that does this; in case it matters.  ChangeLog
unchanged.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-44947985-1084494909=:2344
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="gethwnd_blocking.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0405131935090.2344@fordpc.vss.fsi.com>
Content-Description: 
Content-Disposition: attachment; filename="gethwnd_blocking.patch"
Content-length: 3730

SW5kZXg6IHdpbmRvdy5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3dpbmRvdy5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzANCmRpZmYgLXUgLXAgLXIxLjMw
IHdpbmRvdy5jYw0KLS0tIHdpbmRvdy5jYwk5IEZlYiAyMDA0IDA0OjA0OjI0
IC0wMDAwCTEuMzANCisrKyB3aW5kb3cuY2MJMTQgTWF5IDIwMDQgMDA6Mjk6
MDkgLTAwMDANCkBAIC03Myw3ICs3MywxMyBAQCBXbmRQcm9jIChIV05EIGh3
bmQsIFVJTlQgdU1zZywgV1BBUkFNIHdQDQogICAgIH0NCiB9DQogDQotc3Rh
dGljIEhBTkRMRSB3aW5kb3dfc3RhcnRlZDsNCitzdGF0aWMgTk9fQ09QWSBI
QU5ETEUgd2luZG93X3N0YXJ0ZWQ7DQorDQordm9pZA0KK3dpbmRvd19pbml0
ICgpDQorew0KKyAgICB3aW5kb3dfc3RhcnRlZCA9IENyZWF0ZUV2ZW50ICgm
c2VjX25vbmVfbmloLCBUUlVFLCBGQUxTRSwgTlVMTCk7DQorfQ0KIA0KIHN0
YXRpYyBEV09SRCBXSU5BUEkNCiBXaW5tYWluIChWT0lEICopDQpAQCAtMTI2
LDE4ICsxMzIsMzQgQEAgV2lubWFpbiAoVk9JRCAqKQ0KIEhXTkQgX19zdGRj
YWxsDQogZ2V0aHduZCAoKQ0KIHsNCi0gIGlmIChvdXJod25kICE9IE5VTEwp
DQotICAgIHJldHVybiBvdXJod25kOw0KKyAgSFdORCBod25kID0gb3VyaHdu
ZDsNCisNCisgIGlmIChod25kKQ0KKyAgICByZXR1cm4gaHduZDsNCisNCisg
IHN0YXRpYyBOT19DT1BZIGxvbmcgd2luZG93X3dhaXRlcnM7DQorICBsb25n
IHdhaXRlcnMgPSBJbnRlcmxvY2tlZEluY3JlbWVudCAoJndpbmRvd193YWl0
ZXJzKTsNCisNCisgIGh3bmQgPSBvdXJod25kOw0KKyAgaWYgKGh3bmQgPT0g
TlVMTCkNCisgICAgew0KKyAgICAgIGlmICh3YWl0ZXJzID09IDEpDQorCXsN
CisJICBjeWd0aHJlYWQgKmggPSBuZXcgY3lndGhyZWFkIChXaW5tYWluLCBO
VUxMLCAid2luIik7DQorCSAgaC0+emFwX2ggKCk7DQorCX0NCisNCisgICAg
ICBXYWl0Rm9yU2luZ2xlT2JqZWN0ICh3aW5kb3dfc3RhcnRlZCwgSU5GSU5J
VEUpOw0KKyAgICAgIGh3bmQgPSBvdXJod25kOw0KKyAgICB9DQorDQorICBI
QU5ETEUgd3M7DQogDQotICBjeWd0aHJlYWQgKmg7DQorICBpZiAoSW50ZXJs
b2NrZWREZWNyZW1lbnQgKCZ3aW5kb3dfd2FpdGVycykgPT0gMCAmJiBod25k
DQorICAgICAgJiYgKHdzID0gKEhBTkRMRSkgSW50ZXJsb2NrZWRFeGNoYW5n
ZSAoKGxvbmcgKikgJndpbmRvd19zdGFydGVkLCAwKSkpDQorICAgIENsb3Nl
SGFuZGxlICh3cyk7DQogDQotICB3aW5kb3dfc3RhcnRlZCA9IENyZWF0ZUV2
ZW50ICgmc2VjX25vbmVfbmloLCBUUlVFLCBGQUxTRSwgTlVMTCk7DQotICBo
ID0gbmV3IGN5Z3RocmVhZCAoV2lubWFpbiwgTlVMTCwgIndpbiIpOw0KLSAg
aC0+U2V0VGhyZWFkUHJpb3JpdHkgKFRIUkVBRF9QUklPUklUWV9ISUdIRVNU
KTsNCi0gIFdhaXRGb3JTaW5nbGVPYmplY3QgKHdpbmRvd19zdGFydGVkLCBJ
TkZJTklURSk7DQotICBDbG9zZUhhbmRsZSAod2luZG93X3N0YXJ0ZWQpOw0K
LSAgaC0+emFwX2ggKCk7DQotICByZXR1cm4gb3VyaHduZDsNCisgIHJldHVy
biBod25kOw0KIH0NCiANCiBleHRlcm4gIkMiIGludA0KSW5kZXg6IHdpbnN1
cC5oDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9z
cmMvc3JjL3dpbnN1cC9jeWd3aW4vd2luc3VwLmgsdg0KcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjE0Mw0KZGlmZiAtdSAtcCAtcjEuMTQzIHdpbnN1cC5oDQot
LS0gd2luc3VwLmgJMyBNYXkgMjAwNCAxMTo1MzowNyAtMDAwMAkxLjE0Mw0K
KysrIHdpbnN1cC5oCTE0IE1heSAyMDA0IDAwOjI5OjA5IC0wMDAwDQpAQCAt
MjE4LDYgKzIxOCw3IEBAIHZvaWQgZXZlbnRzX3Rlcm1pbmF0ZSAodm9pZCk7
DQogdm9pZCBfX3N0ZGNhbGwgY2xvc2VfYWxsX2ZpbGVzICgpOw0KIA0KIC8q
IEludmlzaWJsZSB3aW5kb3cgaW5pdGlhbGl6YXRpb24vdGVybWluYXRpb24u
ICovDQordm9pZCB3aW5kb3dfaW5pdCAodm9pZCk7DQogSFdORCBfX3N0ZGNh
bGwgZ2V0aHduZCAodm9pZCk7DQogLyogQ2hlY2sgaWYgcnVubmluZyBpbiBh
IHZpc2libGUgd2luZG93IHN0YXRpb24uICovDQogZXh0ZXJuIGJvb2wgaGFz
X3Zpc2libGVfd2luZG93X3N0YXRpb24gKHZvaWQpOw0KSW5kZXg6IGRjcnQw
LmNjDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09DQpSQ1MgZmlsZTogL2N2cy9z
cmMvc3JjL3dpbnN1cC9jeWd3aW4vZGNydDAuY2Msdg0KcmV0cmlldmluZyBy
ZXZpc2lvbiAxLjIxOA0KZGlmZiAtdSAtcCAtcjEuMjE4IGRjcnQwLmNjDQot
LS0gZGNydDAuY2MJMTIgTWFyIDIwMDQgMDM6MDk6MjggLTAwMDAJMS4yMTgN
CisrKyBkY3J0MC5jYwkxNCBNYXkgMjAwNCAwMDoyOToxMCAtMDAwMA0KQEAg
LTc5OSw2ICs3OTksOSBAQCBkbGxfY3J0MF8xIChjaGFyICopDQogICAvKiBD
b25uZWN0IHRvIHR0eS4gKi8NCiAgIHR0eV9pbml0ICgpOw0KIA0KKyAgLyog
SW5pdGlhbGl6ZSBoaWRkZW4gd2luZG93IGZvciBpdGltZXJzL3NvY2tldHMu
ICovDQorICB3aW5kb3dfaW5pdCAoKTsNCisNCiAgIGlmICghX19hcmdjKQ0K
ICAgICB7DQogICAgICAgY2hhciAqbGluZSA9IEdldENvbW1hbmRMaW5lQSAo
KTsNCg==

---559023410-44947985-1084494909=:2344--
