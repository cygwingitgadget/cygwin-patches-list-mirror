Return-Path: <cygwin-patches-return-4745-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 2316 invoked by alias); 13 May 2004 19:58:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 2304 invoked from network); 13 May 2004 19:58:07 -0000
Date: Thu, 13 May 2004 19:58:00 -0000
From: Brian Ford <ford@vss.fsi.com>
Reply-To: cygwin-patches@cygwin.com
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Fix gethwnd race
In-Reply-To: <20040507032703.GA950@coe.bosbc.com>
Message-ID: <Pine.CYG.4.58.0405131444340.3944@fordpc.vss.fsi.com>
References: <Pine.CYG.4.58.0405061902370.636@fordpc.vss.fsi.com>
 <20040507032703.GA950@coe.bosbc.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-2038630808-1084478280=:3944"
X-SW-Source: 2004-q2/txt/msg00097.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-2038630808-1084478280=:3944
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-length: 1089

On Thu, 6 May 2004, Christopher Faylor wrote:

> Thanks, but, I see that you're using busy loops.  I use those in places
> where I have no choice but to do so or when the potential for a race is
> unlikely.
>
> I don't think that this is really a situation that qualifies for either.
> It seems like a muto is a cleaner choice here.

Sorry for the delay; my free time has been in short supply lately.

I can't seem to make a muto fit this situation cleanly since it would have
to be acquired and released by the same thread.  Maybe I missed something
obvious, but I think the attached patch addresses the root of your
objection to the previous patch.

2004-05-13  Brian Ford  <ford@vss.fsi.com>

	* window.cc (window_started): Make NO_COPY.
	(gethwnd): Fix initialization race.
	(window_init): New function to initialize window_started.
	* winsup.h (window_init): Prototype it.
	* dcrt0.cc (dll_crt0_1): Call it.

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
the best safety device in any aircraft is a well-trained pilot...
---559023410-2038630808-1084478280=:3944
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="gethwnd_blocking.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.CYG.4.58.0405131458000.3944@fordpc.vss.fsi.com>
Content-Description: 
Content-Disposition: attachment; filename="gethwnd_blocking.patch"
Content-length: 3648

SW5kZXg6IHdpbmRvdy5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL3dpbmRvdy5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMzANCmRpZmYgLXUgLXAgLXIxLjMw
IHdpbmRvdy5jYw0KLS0tIHdpbmRvdy5jYwk5IEZlYiAyMDA0IDA0OjA0OjI0
IC0wMDAwCTEuMzANCisrKyB3aW5kb3cuY2MJMTMgTWF5IDIwMDQgMTY6MzQ6
MzMgLTAwMDANCkBAIC03Myw3ICs3MywxMyBAQCBXbmRQcm9jIChIV05EIGh3
bmQsIFVJTlQgdU1zZywgV1BBUkFNIHdQDQogICAgIH0NCiB9DQogDQotc3Rh
dGljIEhBTkRMRSB3aW5kb3dfc3RhcnRlZDsNCitzdGF0aWMgTk9fQ09QWSBI
QU5ETEUgd2luZG93X3N0YXJ0ZWQ7DQorDQordm9pZA0KK3dpbmRvd19pbml0
ICgpDQorew0KKyAgICB3aW5kb3dfc3RhcnRlZCA9IENyZWF0ZUV2ZW50ICgm
c2VjX25vbmVfbmloLCBUUlVFLCBGQUxTRSwgTlVMTCk7DQorfQ0KIA0KIHN0
YXRpYyBEV09SRCBXSU5BUEkNCiBXaW5tYWluIChWT0lEICopDQpAQCAtMTI2
LDE4ICsxMzIsMjkgQEAgV2lubWFpbiAoVk9JRCAqKQ0KIEhXTkQgX19zdGRj
YWxsDQogZ2V0aHduZCAoKQ0KIHsNCi0gIGlmIChvdXJod25kICE9IE5VTEwp
DQotICAgIHJldHVybiBvdXJod25kOw0KKyAgc3RhdGljIE5PX0NPUFkgbG9u
ZyB3aW5kb3dfd2FpdGVyczsNCisgIGxvbmcgd2FpdGVycyA9IEludGVybG9j
a2VkSW5jcmVtZW50ICgmd2luZG93X3dhaXRlcnMpOw0KKyAgSFdORCBod25k
ID0gb3VyaHduZDsNCisNCisgIGlmIChod25kID09IE5VTEwpDQorICAgIHsN
CisgICAgICBpZiAod2FpdGVycyA9PSAxKQ0KKwl7DQorCSAgY3lndGhyZWFk
ICpoID0gbmV3IGN5Z3RocmVhZCAoV2lubWFpbiwgTlVMTCwgIndpbiIpOw0K
KwkgIGgtPnphcF9oICgpOw0KKwl9DQorDQorICAgICAgV2FpdEZvclNpbmds
ZU9iamVjdCAod2luZG93X3N0YXJ0ZWQsIElORklOSVRFKTsNCisgICAgICBo
d25kID0gb3VyaHduZDsNCisgICAgfQ0KKw0KKyAgSEFORExFIHdzOw0KIA0K
LSAgY3lndGhyZWFkICpoOw0KKyAgaWYgKEludGVybG9ja2VkRGVjcmVtZW50
ICgmd2luZG93X3dhaXRlcnMpID09IDAgJiYgaHduZA0KKyAgICAgICYmICh3
cyA9IChIQU5ETEUpIEludGVybG9ja2VkRXhjaGFuZ2UgKChsb25nICopICZ3
aW5kb3dfc3RhcnRlZCwgMCkpKQ0KKyAgICBDbG9zZUhhbmRsZSAod3MpOw0K
IA0KLSAgd2luZG93X3N0YXJ0ZWQgPSBDcmVhdGVFdmVudCAoJnNlY19ub25l
X25paCwgVFJVRSwgRkFMU0UsIE5VTEwpOw0KLSAgaCA9IG5ldyBjeWd0aHJl
YWQgKFdpbm1haW4sIE5VTEwsICJ3aW4iKTsNCi0gIGgtPlNldFRocmVhZFBy
aW9yaXR5IChUSFJFQURfUFJJT1JJVFlfSElHSEVTVCk7DQotICBXYWl0Rm9y
U2luZ2xlT2JqZWN0ICh3aW5kb3dfc3RhcnRlZCwgSU5GSU5JVEUpOw0KLSAg
Q2xvc2VIYW5kbGUgKHdpbmRvd19zdGFydGVkKTsNCi0gIGgtPnphcF9oICgp
Ow0KLSAgcmV0dXJuIG91cmh3bmQ7DQorICByZXR1cm4gaHduZDsNCiB9DQog
DQogZXh0ZXJuICJDIiBpbnQNCkluZGV4OiB3aW5zdXAuaA0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAv
Y3lnd2luL3dpbnN1cC5oLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4xNDMN
CmRpZmYgLXUgLXAgLXIxLjE0MyB3aW5zdXAuaA0KLS0tIHdpbnN1cC5oCTMg
TWF5IDIwMDQgMTE6NTM6MDcgLTAwMDAJMS4xNDMNCisrKyB3aW5zdXAuaAkx
MyBNYXkgMjAwNCAxNjozNDozMyAtMDAwMA0KQEAgLTIxOCw2ICsyMTgsNyBA
QCB2b2lkIGV2ZW50c190ZXJtaW5hdGUgKHZvaWQpOw0KIHZvaWQgX19zdGRj
YWxsIGNsb3NlX2FsbF9maWxlcyAoKTsNCiANCiAvKiBJbnZpc2libGUgd2lu
ZG93IGluaXRpYWxpemF0aW9uL3Rlcm1pbmF0aW9uLiAqLw0KK3ZvaWQgd2lu
ZG93X2luaXQgKHZvaWQpOw0KIEhXTkQgX19zdGRjYWxsIGdldGh3bmQgKHZv
aWQpOw0KIC8qIENoZWNrIGlmIHJ1bm5pbmcgaW4gYSB2aXNpYmxlIHdpbmRv
dyBzdGF0aW9uLiAqLw0KIGV4dGVybiBib29sIGhhc192aXNpYmxlX3dpbmRv
d19zdGF0aW9uICh2b2lkKTsNCkluZGV4OiBkY3J0MC5jYw0KPT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQ0KUkNTIGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAv
Y3lnd2luL2RjcnQwLmNjLHYNCnJldHJpZXZpbmcgcmV2aXNpb24gMS4yMTgN
CmRpZmYgLXUgLXAgLXIxLjIxOCBkY3J0MC5jYw0KLS0tIGRjcnQwLmNjCTEy
IE1hciAyMDA0IDAzOjA5OjI4IC0wMDAwCTEuMjE4DQorKysgZGNydDAuY2MJ
MTMgTWF5IDIwMDQgMTY6MzQ6MzMgLTAwMDANCkBAIC03OTksNiArNzk5LDkg
QEAgZGxsX2NydDBfMSAoY2hhciAqKQ0KICAgLyogQ29ubmVjdCB0byB0dHku
ICovDQogICB0dHlfaW5pdCAoKTsNCiANCisgIC8qIEluaXRpYWxpemUgaGlk
ZGVuIHdpbmRvdyBmb3IgaXRpbWVycy9zb2NrZXRzLiAqLw0KKyAgd2luZG93
X2luaXQgKCk7DQorDQogICBpZiAoIV9fYXJnYykNCiAgICAgew0KICAgICAg
IGNoYXIgKmxpbmUgPSBHZXRDb21tYW5kTGluZUEgKCk7DQo=

---559023410-2038630808-1084478280=:3944--
