Return-Path: <cygwin-patches-return-2895-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 25875 invoked by alias); 30 Aug 2002 17:48:41 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25824 invoked from network); 30 Aug 2002 17:48:40 -0000
Date: Fri, 30 Aug 2002 10:48:00 -0000
From: egor duda <deo@logos-m.ru>
Reply-To: egor duda <cygwin-patches@cygwin.com>
Organization: deo
X-Priority: 3 (Normal)
Message-ID: <136198673817.20020830214611@logos-m.ru>
To: cygwin-patches@cygwin.com
Subject: Re: [franck.leray@cheops.fr: tcsetattr timeout problem ?]
In-Reply-To: <20020830145541.GB1402@redhat.com>
References: <20020830145541.GB1402@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------3917017C104C2268"
X-SW-Source: 2002-q3/txt/msg00343.txt.bz2

------------3917017C104C2268
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 308

Hi!

Friday, 30 August, 2002 Christopher Faylor cgf@redhat.com wrote:

CF> So, did you put someone up to this, Egor?  :-)

Patch attached. Checking vtime in ready_for_read doesn't look like a
best way to do this, but it seems to work.

Egor.            mailto:deo@logos-m.ru ICQ 5165414 FidoNet 2:5020/496.19
------------3917017C104C2268
Content-Type: application/octet-stream; name="tty-vtime-fix.ChangeLog"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tty-vtime-fix.ChangeLog"
Content-length: 277

MjAwMi0wOC0zMCAgRWdvciBEdWRhIDxkZW9AbG9nb3MtbS5ydT4NCg0KCSog
c2VsZWN0LmNjIChmaGFuZGxlcl90dHlfc2xhdmU6OnJlYWR5X2Zvcl9yZWFk
KTogSWYgdHR5IGlzIHNldA0KCXRvIG5vbmNhbm9uaWNhbCBtb2RlIGFuZCB2
bWluPT0wIGFuZCB2dGltZSA+IDAsIHdhaXQgbm8gbG9uZ2VyIHRoYW4NCgkx
MDAqdnRpbWUgbWlsbGlzZWNvbmRzLg0K

------------3917017C104C2268
Content-Type: application/octet-stream; name="tty-vtime-fix.diff"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="tty-vtime-fix.diff"
Content-length: 1534

SW5kZXg6IHNlbGVjdC5jYw0KPT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KUkNT
IGZpbGU6IC9jdnMvdWJlcmJhdW0vd2luc3VwL2N5Z3dpbi9zZWxlY3QuY2Ms
dg0KcmV0cmlldmluZyByZXZpc2lvbiAxLjc3DQpkaWZmIC11IC1wIC0yIC1y
MS43NyBzZWxlY3QuY2MNCi0tLSBzZWxlY3QuY2MJMTkgQXVnIDIwMDIgMDQ6
NDM6NTggLTAwMDAJMS43Nw0KKysrIHNlbGVjdC5jYwkzMCBBdWcgMjAwMiAx
Nzo0MjowMyAtMDAwMA0KQEAgLTc5Miw0ICs3OTIsNiBAQCBmaGFuZGxlcl90
dHlfc2xhdmU6OnJlYWR5X2Zvcl9yZWFkIChpbnQgDQogew0KICAgSEFORExF
IHc0WzJdOw0KKyAgaW50IHZtaW4sIHZ0aW1lOw0KKyAgRFdPUkQgdGltZV90
b193YWl0ID0gSU5GSU5JVEU7DQogICBpZiAoY3lnaGVhcC0+ZmR0YWIubm90
X29wZW4gKGZkKSkNCiAgICAgew0KQEAgLTgwMiw0ICs4MDQsMTUgQEAgZmhh
bmRsZXJfdHR5X3NsYXZlOjpyZWFkeV9mb3JfcmVhZCAoaW50IA0KICAgICAg
IHJldHVybiAxOw0KICAgICB9DQorDQorICBpZiAoIShnZXRfdHR5cCAoKS0+
dGkuY19sZmxhZyAmIElDQU5PTikpDQorICAgIHsNCisgICAgICB2bWluID0g
Z2V0X3R0eXAgKCktPnRpLmNfY2NbVk1JTl07DQorICAgICAgdnRpbWUgPSBn
ZXRfdHR5cCAoKS0+dGkuY19jY1tWVElNRV07DQorICAgICAgaWYgKHZtaW4g
PT0gMCAmJiB2dGltZSA+IDApIA0KKwl0aW1lX3RvX3dhaXQgPSAxMDAgKiB2
dGltZTsNCisgICAgICBpZiAodGltZV90b193YWl0IDwgaG93bG9uZykNCisJ
aG93bG9uZyA9IHRpbWVfdG9fd2FpdDsNCisgICAgfQ0KKw0KICAgdzRbMF0g
PSBzaWduYWxfYXJyaXZlZDsNCiAgIHc0WzFdID0gaW5wdXRfYXZhaWxhYmxl
X2V2ZW50Ow0KQEAgLTgxNiw0ICs4MjksNiBAQCBmaGFuZGxlcl90dHlfc2xh
dmU6OnJlYWR5X2Zvcl9yZWFkIChpbnQgDQogICAgICAgcmV0dXJuIDA7DQog
ICAgIGRlZmF1bHQ6DQorICAgICAgaWYgKHRpbWVfdG9fd2FpdCAhPSBJTkZJ
TklURSAmJiBob3dsb25nID09IHRpbWVfdG9fd2FpdCkNCisJcmV0dXJuIDE7
DQogICAgICAgaWYgKCFob3dsb25nKQ0KIAlzZXRfc2lnX2Vycm5vIChFQUdB
SU4pOw0K

------------3917017C104C2268--
