Return-Path: <cygwin-patches-return-3056-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 18457 invoked by alias); 16 Oct 2002 17:50:08 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 18439 invoked from network); 16 Oct 2002 17:50:05 -0000
Date: Wed, 16 Oct 2002 10:50:00 -0000
From: Joshua Daniel Franklin <joshua@iocc.com>
X-X-Sender: joshua@world-9t3igycu7
Reply-To: Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
To: cygwin-patches@cygwin.com
Subject: User's Guide DLL building patch
Message-ID: <Pine.CYG.4.44.0210161239430.636-200000@world-9t3igycu7>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-265199476-1034790407=:636"
X-SW-Source: 2002-q4/txt/msg00007.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-265199476-1034790407=:636
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 445

Here is a patch suggested some time ago by Gerrit to
make the process of building a dll more clear:

http://sources.redhat.com/ml/cygwin/2002-08/msg01224.html

I have changed it to C instead of C++ and also added a remark
in the "Linking to DLLs" section about building your own
import lib.

ChangeLog (this is in the doc subdir):

2002-10-16  Joshua Daniel Franklin <joshuadfranklin@yahoo.com>
	* dll.sgml: Clarify discussion of building dlls.

---559023410-265199476-1034790407=:636
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dll.sgml-patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.44.0210161246470.636@world-9t3igycu7>
Content-Description: 
Content-Disposition: attachment; filename="dll.sgml-patch"
Content-length: 3156

LS0tIGRsbC5zZ21sLW9yaWcJMjAwMi0xMC0xNSAyMjo0ODoyOS4wMDAwMDAw
MDAgLTA1MDANCisrKyBkbGwuc2dtbAkyMDAyLTEwLTE1IDIzOjMxOjQ3LjAw
MDAwMDAwMCAtMDUwMA0KQEAgLTM5LDE5ICszOSwxOCBAQCBGb3IgdGhpcyBl
eGFtcGxlLCB3ZSdsbCB1c2UgYSBzaW5nbGUgZmlsDQogPGZpbGVuYW1lPm15
ZGxsLmM8L2ZpbGVuYW1lPiBmb3IgdGhlIGNvbnRlbnRzIG9mIHRoZSBkbGwN
CiAoPGZpbGVuYW1lPm15ZGxsLmRsbDwvZmlsZW5hbWU+KS48L3BhcmE+DQog
DQotPHBhcmE+Tm93IGNvbXBpbGUgZXZlcnl0aGluZyB0byBvYmplY3RzOjwv
cGFyYT4NCi0NCi08c2NyZWVuPmdjYyAtYyBteXByb2cuYw0KLWdjYyAtYyBt
eWRsbC5jPC9zY3JlZW4+DQotDQogPHBhcmE+Rm9ydHVuYXRlbHksIHdpdGgg
dGhlIGxhdGVzdCBnY2MgYW5kIGJpbnV0aWxzIHRoZSBwcm9jZXNzIGZvciBi
dWlsZGluZyBhIGRsbA0KIGlzIG5vdyBwcmV0dHkgc2ltcGxlLiBTYXkgeW91
IHdhbnQgdG8gYnVpbGQgdGhpcyBtaW5pbWFsIGZ1bmN0aW9uIGluIG15ZGxs
LmM6PC9wYXJhPg0KIA0KLTxzY3JlZW4+aW50IFdJTkFQSQ0KLW15ZGxsX2lu
aXQoSEFORExFIGgsIERXT1JEIHJlYXNvbiwgdm9pZCAqZm9vKQ0KKzxzY3Jl
ZW4+DQorI2luY2x1ZGUgJmx0O3N0ZGlvLmgmZ3Q7DQorDQoraW50DQoraGVs
bG8oKQ0KIHsNCi0gIHJldHVybiAxOw0KLX08L3NjcmVlbj4NCisgIHByaW50
ZiAoIkhlbGxvIFdvcmxkIVxuIik7DQorfSAgDQorPC9zY3JlZW4+DQogDQog
PHBhcmE+Rmlyc3QgY29tcGlsZSBteWRsbC5jIHRvIG9iamVjdCBjb2RlOjwv
cGFyYT4NCiANCkBAIC02MSw3ICs2MCwyNiBAQCBteWRsbF9pbml0KEhBTkRM
RSBoLCBEV09SRCByZWFzb24sIHZvaWQgDQogDQogPHNjcmVlbj5nY2MgLXNo
YXJlZCAtbyBteWRsbC5kbGwgbXlkbGwubzwvc2NyZWVuPg0KIA0KLTxwYXJh
PlRoYXQncyBpdCEgSG93ZXZlciwgaWYgeW91IGFyZSBidWlsZGluZyBhIGRs
bCBhcyBhbiBleHBvcnQgbGlicmFyeSwNCis8cGFyYT4NCitUaGF0J3MgaXQh
IFRvIGZpbmlzaCB1cCB0aGUgZXhhbXBsZSwgeW91IGNhbiBub3cgbGluayB0
byB0aGUNCitkbGwgd2l0aCBhIHNpbXBsZSBwcm9ncmFtOg0KKzwvcGFyYT4N
CisNCis8c2NyZWVuPg0KK2ludCANCittYWluICgpDQorew0KKyAgaGVsbG8g
KCk7DQorfSAgDQorPC9zY3JlZW4+DQorDQorPHBhcmE+DQorVGhlbiBsaW5r
IHRvIHlvdXIgZGxsIHdpdGggYSBjb21tYW5kIGxpa2U6DQorPC9wYXJhPg0K
Kw0KKzxzY3JlZW4+Z2NjIC1vIG15cHJvZyBteXByb2cuY2EgLUwuLyAtbG15
ZGxsPC9zY3JlZW4+DQorDQorPHBhcmE+SG93ZXZlciwgaWYgeW91IGFyZSBi
dWlsZGluZyBhIGRsbCBhcyBhbiBleHBvcnQgbGlicmFyeSwNCiB5b3Ugd2ls
bCBwcm9iYWJseSB3YW50IHRvIHVzZSB0aGUgY29tcGxldGUgc3ludGF4Ojwv
cGFyYT4NCiANCiA8c2NyZWVuPmdjYyAtc2hhcmVkIC1vIGN5ZyR7bW9kdWxl
fS5kbGwgXA0KQEAgLTgwLDkgKzk4LDEwIEBAIGxpbmsgYWdhaW5zdCwgZS5n
ICctbHBuZyAtbHogLUwvdXNyL2xvY2ENCiA8c2VjdDIgaWQ9ImRsbC1saW5r
Ij48dGl0bGU+TGlua2luZyBBZ2FpbnN0IERMTHM8L3RpdGxlPg0KIA0KIDxw
YXJhPklmIHlvdSBoYXZlIGFuIGV4aXN0aW5nIERMTCBhbHJlYWR5LCB5b3Ug
bmVlZCB0byBidWlsZCBhDQotQ3lnd2luLWNvbXBhdGlibGUgaW1wb3J0IGxp
YnJhcnkgKFRoZSBzdXBwbGllZCBvbmVzIHNob3VsZCB3b3JrLCBidXQNCi15
b3UgbWlnaHQgbm90IGhhdmUgdGhlbSkgdG8gbGluayBhZ2FpbnN0LiAgVW5m
b3J0dW5hdGVseSwgdGhlcmUgaXMgbm90DQoteWV0IGFueSB0b29sIHRvIGRv
IHRoaXMgYXV0b21hdGljYWxseS4gIEhvd2V2ZXIsIHlvdSBjYW4gZ2V0IG1v
c3Qgb2YNCitDeWd3aW4tY29tcGF0aWJsZSBpbXBvcnQgbGlicmFyeS4gIElm
IHlvdSBoYXZlIHRoZSBzb3VyY2UgdG8gY29tcGlsZQ0KK3RoZSBETEwsIHNl
ZSA8WHJlZiBMaW5rZW5kPSJkbGwtYnVpbGQiPiBmb3IgZGV0YWlscyBvbiBo
YXZpbmcgDQorPGZpbGVuYW1lPmdjYzwvZmlsZW5hbWU+IGJ1aWxkIG9uZSBm
b3IgeW91LiAgSWYgeW91IGRvIG5vdCBoYXZlIHRoZQ0KK3NvdXJjZSBvciBh
IHN1cHBsaWVkIHdvcmtpbmcgaW1wb3J0IGxpYnJhcnksIHlvdSBjYW4gZ2V0
IG1vc3Qgb2YNCiB0aGUgd2F5IGJ5IGNyZWF0aW5nIGEgLmRlZiBmaWxlIHdp
dGggdGhlc2UgY29tbWFuZHMgKHlvdSBtaWdodCBuZWVkIHRvDQogZG8gdGhp
cyBpbiA8ZmlsZW5hbWU+YmFzaDwvZmlsZW5hbWU+IGZvciB0aGUgcXVvdGlu
ZyB0byB3b3JrDQogY29ycmVjdGx5KTo8L3BhcmE+DQo=

---559023410-265199476-1034790407=:636--
