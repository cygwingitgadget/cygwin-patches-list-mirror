Return-Path: <cygwin-patches-return-4724-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4138 invoked by alias); 7 May 2004 00:18:49 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4127 invoked from network); 7 May 2004 00:18:48 -0000
Date: Fri, 07 May 2004 00:18:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: [Patch] Fix gethwnd race
Message-ID: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1158274498-1083889119=:636"
X-SW-Source: 2004-q2/txt/msg00076.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1158274498-1083889119=:636
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 832

Although not the complete rewrite you may have been hoping for, the
attached patch does appear to fix the:

Winmain: Cannot register window class, Win32 error 1410

portion of this bug:

http://www.cygwin.com/ml/cygwin/2004-05/msg00232.html

I still see:

recv: No buffer space available

but have only pursued it to the point of being sure it is unrelated.  I'll
look at it more later if time permits.

2004-05-06  Brian Ford  <ford@vss.fsi.com>

	* window.cc (window_started): Change type to long and make NO_COPY.
	(Winmain): Use InterlockedExchange instead of SetEvent.
	(gethwnd): Fix initialization race using InterlockedExchange
	based state table.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-1158274498-1083889119=:636
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="gethwnd.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0405061918390.636@fordpc.vss.fsi.com>
Content-Description: 
Content-Disposition: attachment; filename="gethwnd.patch"
Content-length: 2562

SW5kZXg6IHdpbmRvdy5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3dpbmRvdy5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzANCmRpZmYgLXUgLXAgLXIxLjMw
IHdpbmRvdy5jYw0KLS0tIHdpbmRvdy5jYwk5IEZlYiAyMDA0IDA0OjA0OjI0
IC0wMDAwCTEuMzANCisrKyB3aW5kb3cuY2MJNyBNYXkgMjAwNCAwMDowMjoz
MSAtMDAwMA0KQEAgLTczLDcgKzczLDcgQEAgV25kUHJvYyAoSFdORCBod25k
LCBVSU5UIHVNc2csIFdQQVJBTSB3UA0KICAgICB9DQogfQ0KIA0KLXN0YXRp
YyBIQU5ETEUgd2luZG93X3N0YXJ0ZWQ7DQorc3RhdGljIE5PX0NPUFkgbG9u
ZyB3aW5kb3dfc3RhcnRlZDsNCiANCiBzdGF0aWMgRFdPUkQgV0lOQVBJDQog
V2lubWFpbiAoVk9JRCAqKQ0KQEAgLTEwNCwxNyArMTA0LDE3IEBAIFdpbm1h
aW4gKFZPSUQgKikNCiAgIC8qIENyZWF0ZSBoaWRkZW4gd2luZG93LiAqLw0K
ICAgb3VyaHduZCA9IENyZWF0ZVdpbmRvdyAoY2xhc3NuYW1lLCBjbGFzc25h
bWUsIFdTX1BPUFVQLCBDV19VU0VERUZBVUxULA0KIAkJCSAgQ1dfVVNFREVG
QVVMVCwgQ1dfVVNFREVGQVVMVCwgQ1dfVVNFREVGQVVMVCwNCi0JCQkgIChI
V05EKSBOVUxMLCAoSE1FTlUpIE5VTEwsIHVzZXJfZGF0YS0+aG1vZHVsZSwN
Ci0JCQkgIChMUFZPSUQpIE5VTEwpOw0KLQ0KLSAgU2V0RXZlbnQgKHdpbmRv
d19zdGFydGVkKTsNCisJCQkgIE5VTEwsIE5VTEwsIHVzZXJfZGF0YS0+aG1v
ZHVsZSwgTlVMTCk7DQogDQogICBpZiAoIW91cmh3bmQpDQogICAgIHsNCiAg
ICAgICBzeXN0ZW1fcHJpbnRmICgiQ2Fubm90IGNyZWF0ZSB3aW5kb3ciKTsN
CisgICAgICBJbnRlcmxvY2tlZEV4Y2hhbmdlICgmd2luZG93X3N0YXJ0ZWQs
IDApOw0KICAgICAgIHJldHVybiBGQUxTRTsNCiAgICAgfQ0KIA0KKyAgSW50
ZXJsb2NrZWRFeGNoYW5nZSAoJndpbmRvd19zdGFydGVkLCAxKTsNCisNCiAg
IC8qIFN0YXJ0IHRoZSBtZXNzYWdlIGxvb3AuICovDQogDQogICB3aGlsZSAo
R2V0TWVzc2FnZSAoJm1zZywgb3VyaHduZCwgMCwgMCkgPT0gVFJVRSkNCkBA
IC0xMjYsMTcgKzEyNiwyMiBAQCBXaW5tYWluIChWT0lEICopDQogSFdORCBf
X3N0ZGNhbGwNCiBnZXRod25kICgpDQogew0KLSAgaWYgKG91cmh3bmQgIT0g
TlVMTCkNCi0gICAgcmV0dXJuIG91cmh3bmQ7DQorICBsb25nIHdzID0gSW50
ZXJsb2NrZWRFeGNoYW5nZSAoJndpbmRvd19zdGFydGVkLCAtMSk7DQogDQot
ICBjeWd0aHJlYWQgKmg7DQorICBpZiAod3MgPT0gMSkNCisgICAgSW50ZXJs
b2NrZWRFeGNoYW5nZSAoJndpbmRvd19zdGFydGVkLCAxKTsNCisgIGVsc2UN
CisgICAgew0KKyAgICAgIGlmICh3cyA9PSAwKQ0KKwl7DQorCSAgY3lndGhy
ZWFkICpoID0gbmV3IGN5Z3RocmVhZCAoV2lubWFpbiwgTlVMTCwgIndpbiIp
Ow0KKwkgIGgtPnphcF9oICgpOw0KKwl9DQorICAgIA0KKyAgICAgIHdoaWxl
ICh3aW5kb3dfc3RhcnRlZCA9PSAtMSkNCisJbG93X3ByaW9yaXR5X3NsZWVw
ICgwKTsNCisgICAgfQ0KIA0KLSAgd2luZG93X3N0YXJ0ZWQgPSBDcmVhdGVF
dmVudCAoJnNlY19ub25lX25paCwgVFJVRSwgRkFMU0UsIE5VTEwpOw0KLSAg
aCA9IG5ldyBjeWd0aHJlYWQgKFdpbm1haW4sIE5VTEwsICJ3aW4iKTsNCi0g
IGgtPlNldFRocmVhZFByaW9yaXR5IChUSFJFQURfUFJJT1JJVFlfSElHSEVT
VCk7DQotICBXYWl0Rm9yU2luZ2xlT2JqZWN0ICh3aW5kb3dfc3RhcnRlZCwg
SU5GSU5JVEUpOw0KLSAgQ2xvc2VIYW5kbGUgKHdpbmRvd19zdGFydGVkKTsN
Ci0gIGgtPnphcF9oICgpOw0KICAgcmV0dXJuIG91cmh3bmQ7DQogfQ0KIA0K

---559023410-1158274498-1083889119=:636--
