Return-Path: <cygwin-patches-return-9111-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 95261 invoked by alias); 5 Jul 2018 15:29:23 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 95249 invoked by uid 89); 5 Jul 2018 15:29:23 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=usual, guilty, H*c:HHHH, died
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Thu, 05 Jul 2018 15:29:20 +0000
Received: from Express5800-S70 (ntsitm315127.sitm.nt.ngn.ppp.infoweb.ne.jp [125.3.30.127]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id w65FTCck024460	for <cygwin-patches@cygwin.com>; Fri, 6 Jul 2018 00:29:13 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w65FTCck024460
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1530804553;	bh=H2aNX8f6GxOL/qbVdOehX7yE8KPk0NpCjFl0sYJyl8o=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=hVqUpwVGcAa5tVFgLTCoHmY1bEIPPxV8wyR+lFXdmxCeoECi4gejl2UjQzDlx+fWg	 07GmtndP9jRA7ta4roVyY3bS5zPOGedtomVE/voYaQzYB/tdzMj7+bjdVQzy/B/vZd	 TAr0s0bcJT76NlI0r2vI8HnWwbfrXX/Q+tRU3EPLQxapk9U+IXhDnyy27uT0hFPg9C	 y/4hnthWeTfchT7Q4IM+h7fOzUlpGgDy22suKD79vnO/mDUqYDM8LsR3nPRc7BqFtU	 QHCMIkiXz7Z/70JPsl3OOeUM/v1a0t92D7iWVLVxraPyUiUNDSUWEEQBItUwijrLNy	 CZvyj0jj0GrPw==
Date: Thu, 05 Jul 2018 15:29:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Why /dev/kmsg was deleted from cygwin1.dll in git?
Message-Id: <20180706002924.1b29830bd08668a067509508@nifty.ne.jp>
In-Reply-To: <20180704145247.GS3111@calimero.vinschen.de>
References: <20180704044424.813ee03eff360d6bcb58446b@nifty.ne.jp>	<20180704105420.GN3111@calimero.vinschen.de>	<20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp>	<20180704145247.GS3111@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Fri__6_Jul_2018_00_29_24_+0900_GYIhALSdcI4FTyxv"
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00006.txt.bz2

This is a multi-part message in MIME format.

--Multipart=_Fri__6_Jul_2018_00_29_24_+0900_GYIhALSdcI4FTyxv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 2533

Hi Corinna,

On Wed, 4 Jul 2018 16:52:47 +0200
Corinna Vinschen wrote:
> Hang on.  /dev/kmsg was implemented using a mailslot and it was never
> accessible via the syslog(3) interface.  The code you removed has
> nothing to do with /dev/kmsg.

First of all, /dev/kmsg was not guilty. The real culprit is the code
I had removed by the previous patch.

However, the patch I posted was based on mis-understanding regarding
AF_UNIX implementation. I had checked fhandler_socket_unix.cc and
thought cygwin AF_UNIX socket is implemented not using AF_INET socket.
On the other hand, the code, I removed, checks existence of UDP socket
to determine whether syslogd is activated. So I thought this is no
longer correct and should be removed.

As a matter of fact, cygwin AF_UNIX socket usually use fhandler_socket_
local.cc, in which AF_UNIX socket is implemented using AF_INET socket.
That is, the obove understanding was incorrect.

> What the code does is to check if we have a listener on the /dev/msg UDP
> socket, otherwise log data may get lost or, IIRC, the syslog call may
> even hang.  So removing this code sounds like a bad idea.

In the case of syslogd is not activated, /dev/log does not exist.
So connect() results in an error. Therefore log data is directed to 
windows event logging mechanism even without the removed code. In
usual case, no problem happens. However if syslogd is killed by signal
9 or died accidently, /dev/log remains without listener. In this case,
the problem you mentioned may happen.

> Can you please explain *why* removing this code helps and what happens
> if syslogd is not running after removing the code?

OK. First, connect_syslogd() tries to connect to syslogd via /dev/log
which is created by syslogd. However, the code which I removed can not
perform checking existence of syslogd as expected.
Previously, get_inet_addr() is used to get name information of the socket
opened by syslogd. This was working correctly at that time. Currently,
getsockname() is used instead. This does not return name infomation of
the socket on syslogd side but returns that of client side. Since no
listener exists for this socket, it is not listed in the table returned
by GetUdpTable(). Therefore this check results in false.

As a result, current connect_syslogd() code gives up to connect to syslogd.

To fix this, I made a new patch attached. In this patch, get_inet_addr_local()
is used instead of getsockname() as in the past.

I will appreciate any comments.

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Fri__6_Jul_2018_00_29_24_+0900_GYIhALSdcI4FTyxv
Content-Type: application/octet-stream;
 name="0001-Fix-a-problem-that-connection-to-syslogd-fails.patch"
Content-Disposition: attachment;
 filename="0001-Fix-a-problem-that-connection-to-syslogd-fails.patch"
Content-Transfer-Encoding: base64
Content-length: 4954

RnJvbSA3ZjIxMzcxOWQ0M2FmZTA3OWFiZTA2ZTNmYjU5YWM3YWQ3ZWNhYjA4
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8g
PHRha2FzaGkueWFub0BuaWZ0eS5uZS5qcD4KRGF0ZTogVGh1LCA1IEp1bCAy
MDE4IDIzOjQ2OjM0ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGEgcHJv
YmxlbSB0aGF0IGNvbm5lY3Rpb24gdG8gc3lzbG9nZCBmYWlscy4KCiogZmhh
bmRsZXJfc29ja2V0X2xvY2FsLmNjIChnZXRfaW5ldF9hZGRyX2xvY2FsKTog
Q2hhbmdlIHR5cGUgZnJvbQogICdzdGF0aWMgaW50JyB0byAnaW50JyB0byBi
ZSBjYWxsYWJsZSBmcm9tIHN5c2xvZy5jYy4KKiBzeXNsb2cuY2MgKGNvbm5l
Y3Rfc3lzbG9nZCk6IFVzZSBnZXRfaW5ldF9hZGRyX2xvY2FsKCkgaW5zdGVh
ZCBvZgogIGdldHNvY2tuYW1lKCkgdG8gcmV0cmlldmUgbmFtZSBpbmZvcm1h
dGlvbiBvZiB0aGUgc3lzbG9nZCBzb2NrZXQuCi0tLQogd2luc3VwL2N5Z3dp
bi9maGFuZGxlcl9zb2NrZXRfbG9jYWwuY2MgfCAgMiArLQogd2luc3VwL2N5
Z3dpbi9zeXNsb2cuY2MgICAgICAgICAgICAgICAgfCAzNCArKysrKysrKysr
KystLS0tLS0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAxOSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL2ZoYW5kbGVyX3NvY2tldF9sb2NhbC5jYyBiL3dpbnN1cC9jeWd3
aW4vZmhhbmRsZXJfc29ja2V0X2xvY2FsLmNjCmluZGV4IDI3MDVlY2Q3Yi4u
YmZmYjExMmYxIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X3NvY2tldF9sb2NhbC5jYworKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X3NvY2tldF9sb2NhbC5jYwpAQCAtNjgsNyArNjgsNyBAQCBhZGp1c3Rfc29j
a2V0X2ZpbGVfbW9kZSAobW9kZV90IG1vZGUpCiB9CiAKIC8qIGN5Z3dpbiBp
bnRlcm5hbDogbWFwIHNvY2thZGRyIGludG8gaW50ZXJuZXQgZG9tYWluIGFk
ZHJlc3MgKi8KLXN0YXRpYyBpbnQKK2ludAogZ2V0X2luZXRfYWRkcl9sb2Nh
bCAoY29uc3Qgc3RydWN0IHNvY2thZGRyICppbiwgaW50IGlubGVuLAogCSAg
ICAgICBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqb3V0LCBpbnQgKm91dGxl
biwKIAkgICAgICAgaW50ICp0eXBlID0gTlVMTCwgaW50ICpzZWNyZXQgPSBO
VUxMKQpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9zeXNsb2cuY2MgYi93
aW5zdXAvY3lnd2luL3N5c2xvZy5jYwppbmRleCAzNjYzM2E0NDIuLjZhMjk1
NTAxZiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zeXNsb2cuY2MKKysr
IGIvd2luc3VwL2N5Z3dpbi9zeXNsb2cuY2MKQEAgLTE4NiwxMiArMTg2LDE3
IEBAIHN0YXRpYyBlbnVtIHsKIHN0YXRpYyBpbnQgc3lzbG9nZF9zb2NrID0g
LTE7CiBleHRlcm4gIkMiIGludCBjeWd3aW5fc29ja2V0IChpbnQsIGludCwg
aW50KTsKIGV4dGVybiAiQyIgaW50IGN5Z3dpbl9jb25uZWN0IChpbnQsIGNv
bnN0IHN0cnVjdCBzb2NrYWRkciAqLCBpbnQpOworZXh0ZXJuIGludCBnZXRf
aW5ldF9hZGRyX2xvY2FsIChjb25zdCBzdHJ1Y3Qgc29ja2FkZHIgKiwgaW50
LAorCQkJICBzdHJ1Y3Qgc29ja2FkZHJfc3RvcmFnZSAqLCBpbnQgKiwKKwkJ
CSAgaW50ICogPSBOVUxMLCBpbnQgKiA9IE5VTEwpOwogCiBzdGF0aWMgdm9p
ZAogY29ubmVjdF9zeXNsb2dkICgpCiB7CiAgIGludCBmZDsKICAgc3RydWN0
IHNvY2thZGRyX3VuIHN1bjsKKyAgc3RydWN0IHNvY2thZGRyX3N0b3JhZ2Ug
c3N0OworICBpbnQgbGVuLCB0eXBlOwogCiAgIGlmIChzeXNsb2dkX2luaXRl
ZCAhPSBub3RfaW5pdGVkICYmIHN5c2xvZ2Rfc29jayA+PSAwKQogICAgIGNs
b3NlIChzeXNsb2dkX3NvY2spOwpAQCAtMTk5LDE2ICsyMDQsMTQgQEAgY29u
bmVjdF9zeXNsb2dkICgpCiAgIHN5c2xvZ2Rfc29jayA9IC0xOwogICBzdW4u
c3VuX2ZhbWlseSA9IEFGX0xPQ0FMOwogICBzdHJuY3B5IChzdW4uc3VuX3Bh
dGgsIF9QQVRIX0xPRywgc2l6ZW9mIHN1bi5zdW5fcGF0aCk7Ci0gIGlmICgo
ZmQgPSBjeWd3aW5fc29ja2V0IChBRl9MT0NBTCwgU09DS19TVFJFQU0gfCBT
T0NLX0NMT0VYRUMsIDApKSA8IDApCisgIGlmIChnZXRfaW5ldF9hZGRyX2xv
Y2FsICgoc3RydWN0IHNvY2thZGRyICopICZzdW4sIHNpemVvZiBzdW4sCisJ
CQkgICAmc3N0LCAmbGVuLCAmdHlwZSkpCisgICAgcmV0dXJuOworICBpZiAo
KGZkID0gY3lnd2luX3NvY2tldCAoQUZfTE9DQUwsIHR5cGUgfCBTT0NLX0NM
T0VYRUMsIDApKSA8IDApCiAgICAgcmV0dXJuOwogICBpZiAoY3lnd2luX2Nv
bm5lY3QgKGZkLCAoc3RydWN0IHNvY2thZGRyICopICZzdW4sIHNpemVvZiBz
dW4pID09IDApCi0gICAgc3lzbG9nZF9pbml0ZWQgPSBpbml0ZWRfc3RyZWFt
OwotICBlbHNlCiAgICAgewotICAgICAgY2xvc2UgKGZkKTsKLSAgICAgIGlm
ICgoZmQgPSBjeWd3aW5fc29ja2V0IChBRl9MT0NBTCwgU09DS19ER1JBTSB8
IFNPQ0tfQ0xPRVhFQywgMCkpIDwgMCkKLQlyZXR1cm47Ci0gICAgICBpZiAo
Y3lnd2luX2Nvbm5lY3QgKGZkLCAoc3RydWN0IHNvY2thZGRyICopICZzdW4s
IHNpemVvZiBzdW4pID09IDApCisgICAgICBpZiAodHlwZSA9PSBTT0NLX0RH
UkFNKQogCXsKIAkgIC8qCiAJICAgKiBGSVhNRQpAQCAtMjE5LDE4ICsyMjIs
MTAgQEAgY29ubmVjdF9zeXNsb2dkICgpCiAKIAkgIC8qIGNvbm5lY3Qgb24g
YSBkZ3JhbSBzb2NrZXQgYWx3YXlzIHN1Y2NlZWRzLiAgV2Ugc3RpbGwgZG9u
J3Qga25vdwogCSAgICAgaWYgc3lzbG9nZCBpcyBhY3R1YWxseSBsaXN0ZW5p
bmcuICovCi0JICBjeWdoZWFwX2ZkZ2V0IGNmZCAoZmQpOwotCSAgZmhhbmRs
ZXJfc29ja2V0X2xvY2FsICpjb25zdCBmaCA9IChmaGFuZGxlcl9zb2NrZXRf
bG9jYWwgKikKLQkJCQkJICAgIGNmZC0+aXNfc29ja2V0ICgpOwogCSAgdG1w
X3BhdGhidWYgdHA7CiAJICBQTUlCX1VEUFRBQkxFIHRhYiA9IChQTUlCX1VE
UFRBQkxFKSB0cC53X2dldCAoKTsKIAkgIERXT1JEIHNpemUgPSA2NTUzNjsK
IAkgIGJvb2wgZm91bmQgPSBmYWxzZTsKLQkgIHN0cnVjdCBzb2NrYWRkcl9z
dG9yYWdlIHNzdDsKLQkgIGludCBsZW47Ci0KLQkgIGxlbiA9IHNpemVvZiBz
c3Q7Ci0JICA6OmdldHNvY2tuYW1lIChmaC0+Z2V0X3NvY2tldCAoKSwgKHN0
cnVjdCBzb2NrYWRkciAqKSAmc3N0LCAmbGVuKTsKIAkgIHN0cnVjdCBzb2Nr
YWRkcl9pbiAqc2EgPSAoc3RydWN0IHNvY2thZGRyX2luICopICZzc3Q7CiAK
IAkgIGlmIChHZXRVZHBUYWJsZSAodGFiLCAmc2l6ZSwgRkFMU0UpID09IE5P
X0VSUk9SKQpAQCAtMjQ5LDEwICsyNDQsMTMgQEAgY29ubmVjdF9zeXNsb2dk
ICgpCiAJCSAgcmV0dXJuOwogCQl9CiAJICAgIH0KLQkgIHN5c2xvZ2RfaW5p
dGVkID0gaW5pdGVkX2RncmFtOwogCX0KLSAgICAgIGVsc2UKLQljbG9zZSAo
ZmQpOworICAgICAgc3lzbG9nZF9pbml0ZWQgPSB0eXBlID09IFNPQ0tfREdS
QU0gPyBpbml0ZWRfZGdyYW0gOiBpbml0ZWRfc3RyZWFtOworICAgIH0KKyAg
ZWxzZQorICAgIHsKKyAgICAgIGNsb3NlIChmZCk7CisgICAgICByZXR1cm47
CiAgICAgfQogICBzeXNsb2dkX3NvY2sgPSBmZDsKICAgZGVidWdfcHJpbnRm
ICgiZm91bmQgL2Rldi9sb2csIGZkID0gJWQsIHR5cGUgPSAlcyIsCi0tIAoy
LjE3LjAKCg==

--Multipart=_Fri__6_Jul_2018_00_29_24_+0900_GYIhALSdcI4FTyxv--
