Return-Path: <cygwin-patches-return-4362-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 22177 invoked by alias); 12 Nov 2003 19:24:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 22168 invoked from network); 12 Nov 2003 19:24:22 -0000
X-Authentication-Warning: eos.vss.fsi.com: ford owned process doing -bs
Date: Wed, 12 Nov 2003 19:24:00 -0000
From: Brian Ford <ford@vss.fsi.com>
X-X-Sender: ford@eos
To: Corinna Vinschen <cygwin-patches@cygwin.com>
Subject: Re: dtable.cc (build_fh_pc): serial port handling
In-Reply-To: <20031112092733.GB7542@cygbert.vinschen.de>
Message-ID: <Pine.GSO.4.56.0311121307230.9584@eos>
References: <Pine.GSO.4.56.0311111612280.9584@eos> <Pine.GSO.4.56.0311111819230.9584@eos>
 <20031112092733.GB7542@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-559023410-1082139223-1068664358=:9584"
Content-ID: <Pine.GSO.4.56.0311121313560.9584@eos>
X-SW-Source: 2003-q4/txt/msg00081.txt.bz2

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

---559023410-1082139223-1068664358=:9584
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-ID: <Pine.GSO.4.56.0311121313561.9584@eos>
Content-length: 1089

Revised patch attached.  I noticed that there was a redundant
cygdrive case too, so I removed it.

2003-11-12  Brian Ford  <ford@vss.fsi.com>

	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
	serial ports.  Remove redundant FH_CYGDRIVE case since it is
	handled by DEV_CYGDRIVE_MAJOR.

Chris,

Do you have a cleanup here planned?  Should I just ignore this stuff for
a while?

FYI, this is the reason I am here:

http://www.cygwin.com/ml/cygwin/2003-10/msg01750.html

He offered to test my tcflush patch, but reported being unable to
open /dev/ttyS0 with the cvs compiled Cygwin.

On Wed, 12 Nov 2003, Corinna Vinschen wrote:

> On Tue, Nov 11, 2003 at 06:25:41PM -0600, Brian Ford wrote:
> > Here is one I think I do understand.
> >
> > 2003-11-11  Brian Ford  <ford@vss.fsi.com>
> >
> >  	* dtable.cc (build_fh_pc): Use DEV_SERIAL_MAJOR to catch all
> > 	serial ports.
> >
>
> This looks right to me.  Chris?
>
> Corinna
>

-- 
Brian Ford
Senior Realtime Software Engineer
VITAL - Visual Simulation Systems
FlightSafety International
Phone: 314-551-8460
Fax:   314-551-8444
---559023410-1082139223-1068664358=:9584
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; NAME="dtable.cc.patch"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.GSO.4.56.0311121312380.9584@eos>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME="dtable.cc.patch"
Content-length: 1375

SW5kZXg6IGR0YWJsZS5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvc3JjL3NyYy93aW5zdXAvY3lnd2luL2R0YWJsZS5jYyx2
DQpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTE5DQpkaWZmIC11IC1wIC1yMS4x
MTkgZHRhYmxlLmNjDQotLS0gZHRhYmxlLmNjCTEgT2N0IDIwMDMgMTI6MzY6
MzkgLTAwMDAJMS4xMTkNCisrKyBkdGFibGUuY2MJMTIgTm92IDIwMDMgMTk6
MDY6NTIgLTAwMDANCkBAIC0zMzksNiArMzM5LDkgQEAgYnVpbGRfZmhfcGMg
KHBhdGhfY29udiYgcGMpDQogICAgICAgY2FzZSBERVZfVEFQRV9NQUpPUjoN
CiAJZmggPSBjbmV3IChmaGFuZGxlcl9kZXZfdGFwZSkgKCk7DQogCWJyZWFr
Ow0KKyAgICAgIGNhc2UgREVWX1NFUklBTF9NQUpPUjoNCisJZmggPSBjbmV3
IChmaGFuZGxlcl9zZXJpYWwpICgpOw0KKwlicmVhazsNCiAgICAgICBkZWZh
dWx0Og0KIAlzd2l0Y2ggKHBjLmRldikNCiAJICB7DQpAQCAtMzQ3LDE3ICsz
NTAsMTEgQEAgYnVpbGRfZmhfcGMgKHBhdGhfY29udiYgcGMpDQogCSAgY2Fz
ZSBGSF9DT05PVVQ6DQogCSAgICBmaCA9IGNuZXcgKGZoYW5kbGVyX2NvbnNv
bGUpICgpOw0KIAkgICAgYnJlYWs7DQotCSAgY2FzZSBGSF9DWUdEUklWRToN
Ci0JICAgIGZoID0gY25ldyAoZmhhbmRsZXJfY3lnZHJpdmUpICgpOw0KLQkg
ICAgYnJlYWs7DQogCSAgY2FzZSBGSF9QVFlNOg0KIAkgICAgZmggPSBjbmV3
IChmaGFuZGxlcl9wdHlfbWFzdGVyKSAoKTsNCiAJICAgIGJyZWFrOw0KIAkg
IGNhc2UgRkhfV0lORE9XUzoNCiAJICAgIGZoID0gY25ldyAoZmhhbmRsZXJf
d2luZG93cykgKCk7DQotCSAgICBicmVhazsNCi0JICBjYXNlIEZIX1NFUklB
TDoNCi0JICAgIGZoID0gY25ldyAoZmhhbmRsZXJfc2VyaWFsKSAoKTsNCiAJ
ICAgIGJyZWFrOw0KIAkgIGNhc2UgRkhfRklGTzoNCiAJICAgIGZoID0gY25l
dyAoZmhhbmRsZXJfZmlmbykgKCk7DQo=

---559023410-1082139223-1068664358=:9584--
