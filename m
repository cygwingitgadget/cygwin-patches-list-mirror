Return-Path: <cygwin-patches-return-3255-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 325 invoked by alias); 2 Dec 2002 11:09:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 315 invoked from network); 2 Dec 2002 11:09:42 -0000
Date: Mon, 02 Dec 2002 03:09:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <1551207829817.20021202140826@logos-m.ru>
To: egor duda <cygwin-patches@cygwin.com>
Subject: Re: --enable-runtime-pseudo-reloc support in cygwin, take 3.
In-Reply-To: <1451205547776.20021202133024@logos-m.ru>
References: <20021119072016.23A231BF36@redhat.com>
 <3577371564.20021119120659@logos-m.ru> <1451205547776.20021202133024@logos-m.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------4E162391E18573E"
X-SW-Source: 2002-q4/txt/msg00206.txt.bz2

------------4E162391E18573E
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 315

Hi!

Monday, 02 December, 2002 egor duda deo@logos-m.ru wrote:

ed> 2002-12-02  Egor Duda <deo@logos-m.ru>
ed>         * cygwin/lib/pseudo-reloc.c: New file.

I guess i should put it to the public domain, so that mingw folks can
also use it.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
------------4E162391E18573E
Content-Type: application/octet-stream; name="pseudo-reloc.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="pseudo-reloc.c"
Content-length: 1546

LyogcHNldWRvLXJlbG9jLmMKCiAgIFdyaXR0ZW4gYnkgRWdvciBEdWRhIDxk
ZW9AbG9nb3MtbS5ydT4KICAgVEhJUyBTT0ZUV0FSRSBJUyBOT1QgQ09QWVJJ
R0hURUQKCiAgIFRoaXMgc291cmNlIGNvZGUgaXMgb2ZmZXJlZCBmb3IgdXNl
IGluIHRoZSBwdWJsaWMgZG9tYWluLiBZb3UgbWF5CiAgIHVzZSwgbW9kaWZ5
IG9yIGRpc3RyaWJ1dGUgaXQgZnJlZWx5LgoKICAgVGhpcyBjb2RlIGlzIGRp
c3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQgd2lsbCBiZSB1c2VmdWwg
YnV0CiAgIFdJVEhPVVQgQU5ZIFdBUlJBTlRZLiBBTEwgV0FSUkVOVElFUywg
RVhQUkVTUyBPUiBJTVBMSUVEIEFSRSBIRVJFQlkKICAgRElTQ0xBTUVELiBU
aGlzIGluY2x1ZGVzIGJ1dCBpcyBub3QgbGltaXRlZCB0byB3YXJyZW50aWVz
IG9mCiAgIE1FUkNIQU5UQUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJ
Q1VMQVIgUFVSUE9TRS4KKi8KCiNpbmNsdWRlIDx3aW5kb3dzLmg+CgpleHRl
cm4gY2hhciBfX1JVTlRJTUVfUFNFVURPX1JFTE9DX0xJU1RfXzsKZXh0ZXJu
IGNoYXIgX19SVU5USU1FX1BTRVVET19SRUxPQ19MSVNUX0VORF9fOwpleHRl
cm4gY2hhciBfaW1hZ2VfYmFzZV9fOwoKdHlwZWRlZiBzdHJ1Y3QKICB7CiAg
ICBEV09SRCBhZGRlbmQ7CiAgICBEV09SRCB0YXJnZXQ7CiAgfQpydW50aW1l
X3BzZXVkb19yZWxvYzsKCnZvaWQKZG9fcHNldWRvX3JlbG9jICh2b2lkKiBz
dGFydCwgdm9pZCogZW5kLCB2b2lkKiBiYXNlKQp7CiAgRFdPUkQgcmVsb2Nf
dGFyZ2V0OwogIHJ1bnRpbWVfcHNldWRvX3JlbG9jKiByOwogIGZvciAociA9
IChydW50aW1lX3BzZXVkb19yZWxvYyopIHN0YXJ0OyByIDwgKHJ1bnRpbWVf
cHNldWRvX3JlbG9jKikgZW5kOyByKyspCiAgICB7CiAgICAgIHJlbG9jX3Rh
cmdldCA9IChEV09SRCkgYmFzZSArIHItPnRhcmdldDsKICAgICAgKigoRFdP
UkQqKSByZWxvY190YXJnZXQpICs9IHItPmFkZGVuZDsKICAgIH0KfQoKdm9p
ZApfcGVpMzg2X3J1bnRpbWVfcmVsb2NhdG9yICgpCnsKICBkb19wc2V1ZG9f
cmVsb2MgKCZfX1JVTlRJTUVfUFNFVURPX1JFTE9DX0xJU1RfXywKCQkgICAm
X19SVU5USU1FX1BTRVVET19SRUxPQ19MSVNUX0VORF9fLAoJCSAgICZfaW1h
Z2VfYmFzZV9fKTsKfQo=

------------4E162391E18573E--
