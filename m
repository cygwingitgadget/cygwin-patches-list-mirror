Return-Path: <cygwin-patches-return-4779-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 30082 invoked by alias); 21 May 2004 15:23:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 28393 invoked from network); 21 May 2004 15:22:31 -0000
Date: Fri, 21 May 2004 15:23:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [UG Patch] kmem and check_case typo
In-Reply-To: <20040520141221.GA17516@cygbert.vinschen.de>
Message-ID: <Pine.CYG.4.58.0405211012470.3524@fordpc.vss.fsi.com>
References: <20040520141221.GA17516@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-81801366-1085152940=:3524"
X-SW-Source: 2004-q2/txt/msg00131.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-81801366-1085152940=:3524
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 664

On Thu, 20 May 2004, Corinna Vinschen wrote:

> On May 20 09:22, Igor Pechtchanski wrote:
> > BTW, should /dev/kmem work also?
>
> No, only /dev/mem and /dev/port are working.  /dev/kmem is still looking
> for a contributor.

Ok, then shouldn't we apply the following patch to the users guide? (plus
a typo fix)

2004-05-21  Brian Ford  <ford@vss.fsi.com>

	* pathnames.sgml: Remove /dev/kmem from the supported POSIX device
	list.

	* cygwinenv.sgml: Fix typo in check_case description.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-81801366-1085152940=:3524
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="dev_kmem_doc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0405211022200.3524@fordpc.vss.fsi.com>
Content-Description: 
Content-Disposition: attachment; filename="dev_kmem_doc.patch"
Content-length: 1253

SW5kZXg6IHBhdGhuYW1lcy5zZ21sDQo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9kb2MvcGF0aG5hbWVz
LnNnbWwsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjE0DQpkaWZmIC11IC1w
IC1yMS4xNCBwYXRobmFtZXMuc2dtbA0KLS0tIHBhdGhuYW1lcy5zZ21sCTI5
IE1hciAyMDA0IDA4OjA3OjM5IC0wMDAwCTEuMTQNCisrKyBwYXRobmFtZXMu
c2dtbAkyMCBNYXkgMjAwNCAxODo0OTowMSAtMDAwMA0KQEAgLTE3Miw4ICsx
NzIsNyBAQCBDeWd3aW4gc3VwcG9ydHMgdGhlIGZvbGxvd2luZyBkZXZpY2Vz
IGNvDQogPGZpbGVuYW1lPi9kZXYvdHR5PC9maWxlbmFtZT4sIDxmaWxlbmFt
ZT4vZGV2L3R0eW08L2ZpbGVuYW1lPiwgDQogPGZpbGVuYW1lPi9kZXYvdHR5
WDwvZmlsZW5hbWU+LCA8ZmlsZW5hbWU+L2Rldi90dHlTWDwvZmlsZW5hbWU+
LCANCiA8ZmlsZW5hbWU+L2Rldi9waXBlPC9maWxlbmFtZT4sIDxmaWxlbmFt
ZT4vZGV2L3BvcnQ8L2ZpbGVuYW1lPiwgDQotPGZpbGVuYW1lPi9kZXYvcHRt
eDwvZmlsZW5hbWU+LCA8ZmlsZW5hbWU+L2Rldi9rbWVtPC9maWxlbmFtZT4s
DQotPGZpbGVuYW1lPi9kZXYvbWVtPC9maWxlbmFtZT4sDQorPGZpbGVuYW1l
Pi9kZXYvcHRteDwvZmlsZW5hbWU+LCA8ZmlsZW5hbWU+L2Rldi9tZW08L2Zp
bGVuYW1lPiwNCiA8ZmlsZW5hbWU+L2Rldi9yYW5kb208L2ZpbGVuYW1lPiwg
YW5kIDxmaWxlbmFtZT4vZGV2L3VyYW5kb208L2ZpbGVuYW1lPi4NCiBDeWd3
aW4gYWxzbyBoYXMgc2V2ZXJhbCBXaW5kb3dzLXNwZWNpZmljIGRldmljZXM6
DQogPGZpbGVuYW1lPi9kZXYvY29tWDwvZmlsZW5hbWU+ICh0aGUgc2VyaWFs
IHBvcnRzLCBzdGFydGluZyB3aXRoIA0K

---559023410-81801366-1085152940=:3524
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="check_case_doc_typo.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0405211022201.3524@fordpc.vss.fsi.com>
Content-Description: 
Content-Disposition: attachment; filename="check_case_doc_typo.patch"
Content-length: 1033

SW5kZXg6IGN5Z3dpbmVudi5zZ21sDQo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
DQpSQ1MgZmlsZTogL2N2cy9zcmMvc3JjL3dpbnN1cC9kb2MvY3lnd2luZW52
LnNnbWwsdg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjEzDQpkaWZmIC11IC1w
IC1yMS4xMyBjeWd3aW5lbnYuc2dtbA0KLS0tIGN5Z3dpbmVudi5zZ21sCTI3
IE1hciAyMDA0IDA2OjQ4OjExIC0wMDAwCTEuMTMNCisrKyBjeWd3aW5lbnYu
c2dtbAkyMCBNYXkgMjAwNCAyMjoxMDo1MyAtMDAwMA0KQEAgLTI0LDcgKzI0
LDcgQEAgcGlwZSB0byBiaW5hcnkgYnkgZGVmYXVsdC4NCiA8bGlzdGl0ZW0+
DQogPHBhcmE+PGVudmFyPmNoZWNrX2Nhc2U6bGV2ZWw8L2VudmFyPiAtIENv
bnRyb2xzIHRoZSBiZWhhdmlvdXIgb2YNCiBDeWd3aW4gd2hlbiBhIHVzZXIg
dHJpZXMgdG8gb3BlbiBvciBjcmVhdGUgYSBmaWxlIHVzaW5nIGEgY2FzZSBk
aWZmZXJlbnQgZnJvbQ0KLXRoZSBjYXNlIG9mIHRoZSBwYXRoIGFzIGFzdmVk
IG9uIHRoZSBkaXNrLg0KK3RoZSBjYXNlIG9mIHRoZSBwYXRoIGFzIHNhdmVk
IG9uIHRoZSBkaXNrLg0KIDxsaXRlcmFsPmxldmVsPC9saXRlcmFsPiBpcyBv
bmUgb2YgPGxpdGVyYWw+cmVsYXhlZDwvbGl0ZXJhbD4sDQogPGxpdGVyYWw+
YWRqdXN0PC9saXRlcmFsPiBhbmQgPGxpdGVyYWw+c3RyaWN0PC9saXRlcmFs
Pi48L3BhcmE+DQogPGl0ZW1pemVkbGlzdCBNYXJrPSJidWxsZXQiPg0K

---559023410-81801366-1085152940=:3524--
