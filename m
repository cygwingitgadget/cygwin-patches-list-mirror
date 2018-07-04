Return-Path: <cygwin-patches-return-9109-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 109532 invoked by alias); 4 Jul 2018 13:01:51 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 108951 invoked by uid 89); 4 Jul 2018 13:01:50 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.9 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=Hx-languages-length:827, H*c:HHHH
X-HELO: conssluserg-01.nifty.com
Received: from conssluserg-01.nifty.com (HELO conssluserg-01.nifty.com) (210.131.2.80) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 04 Jul 2018 13:01:42 +0000
Received: from Express5800-S70 (ntsitm315127.sitm.nt.ngn.ppp.infoweb.ne.jp [125.3.30.127]) (authenticated)	by conssluserg-01.nifty.com with ESMTP id w64D1Rhk006737	for <cygwin-patches@cygwin.com>; Wed, 4 Jul 2018 22:01:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com w64D1Rhk006737
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1530709287;	bh=m2EaCD/aFB/FBAQUeG8lnx+4UD93k7OPGsVAMQ5VCGg=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=oDYBV8Q5semox61yjNleo+/FhyGxSa2KDiIlNb32LZmwyGzH8K7fn1JVsLjOiIspm	 ghN47Fp49jl5OhFUltVCMltlI14ocA95qeo+vvoUxCDXgcXsJCzNpheZeKSc9n1QEB	 edyv87Twm9oy2AtdYXiFmzLHSr54fC2ClwWRX5NY3DhVs1whdzS2u9j4iwGkUnuJkv	 HIZ7Zxfo0txOLDu59C3/NApu7dWsEJzz9c0StaZXTZAoJOdKaq3JhG5Rrsor98lRoq	 zQew1PmldqUSIUpA1PGV1RYiDS1NlgfuEeG7p+vsmYJHPRgxgeiea2iPF63FUB7/pq	 paEH7kDOGhLMA==
Date: Wed, 04 Jul 2018 13:01:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: Why /dev/kmsg was deleted from cygwin1.dll in git?
Message-Id: <20180704220138.26b42dc96fb1b49a9dc693d2@nifty.ne.jp>
In-Reply-To: <20180704105420.GN3111@calimero.vinschen.de>
References: <20180704044424.813ee03eff360d6bcb58446b@nifty.ne.jp>	<20180704105420.GN3111@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Wed__4_Jul_2018_22_01_38_+0900_4rBfDPpo2PWHkhFm"
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00004.txt.bz2

This is a multi-part message in MIME format.

--Multipart=_Wed__4_Jul_2018_22_01_38_+0900_4rBfDPpo2PWHkhFm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 776

Hi Corinna,

On Wed, 4 Jul 2018 12:54:20 +0200
Corinna Vinschen wrote:
> On Jul  4 04:44, Takashi Yano wrote:
> > Why was /dev/kmsg deleted from cygwin1.dll in git?
> > Due to this change, syslogd in inetutils package no longer works.
> 
> /dev/kmsg doesn't really give any useful information.  It was never used
> for more than some exception information, but it required a complete
> fhandler class on its own.  I wanted to get rid of the useless code.

I looked into this problem and I realized that the real cause is not the absence of /dev/kmsg but old codes in the connect_syslogd() function in
syslog.cc.

I removed these codes and confirmed that syslogd works again.

I make a patch attached. Could you please have a look?

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Wed__4_Jul_2018_22_01_38_+0900_4rBfDPpo2PWHkhFm
Content-Type: application/octet-stream;
 name="0001-Fix-a-problem-that-connection-to-syslogd-fails.patch"
Content-Disposition: attachment;
 filename="0001-Fix-a-problem-that-connection-to-syslogd-fails.patch"
Content-Transfer-Encoding: base64
Content-length: 2843

RnJvbSBlMjdiODczM2JhOGQxMTEwMDA2YTgzMTY1ZmZhOWQ3ZjBmZjBhNTA3
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8g
PHRha2FzaGkueWFub0BuaWZ0eS5uZS5qcD4KRGF0ZTogV2VkLCA0IEp1bCAy
MDE4IDIwOjU2OjU3ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGEgcHJv
YmxlbSB0aGF0IGNvbm5lY3Rpb24gdG8gc3lzbG9nZCBmYWlscy4KCnN5c2xv
Zy5jYyAoY29ubmVjdF9zeXNsb2dkKTogUmVtb3ZlIHNvbWUgb2xkIGNvZGVz
IHdoaWNoIGRpc3R1cmIgdGhlCmNvbm5lY3Rpb24gdG8gc3lzbG9nZC4KLS0t
CiB3aW5zdXAvY3lnd2luL3N5c2xvZy5jYyB8IDQ2ICsrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCA0MiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL3N5c2xvZy5jYyBiL3dpbnN1cC9jeWd3aW4vc3lz
bG9nLmNjCmluZGV4IDM2NjMzYTQ0Mi4uYTgzOWMxZGNmIDEwMDY0NAotLS0g
YS93aW5zdXAvY3lnd2luL3N5c2xvZy5jYworKysgYi93aW5zdXAvY3lnd2lu
L3N5c2xvZy5jYwpAQCAtMjA5LDUwICsyMDksMTIgQEAgY29ubmVjdF9zeXNs
b2dkICgpCiAgICAgICBpZiAoKGZkID0gY3lnd2luX3NvY2tldCAoQUZfTE9D
QUwsIFNPQ0tfREdSQU0gfCBTT0NLX0NMT0VYRUMsIDApKSA8IDApCiAJcmV0
dXJuOwogICAgICAgaWYgKGN5Z3dpbl9jb25uZWN0IChmZCwgKHN0cnVjdCBz
b2NrYWRkciAqKSAmc3VuLCBzaXplb2Ygc3VuKSA9PSAwKQorCXN5c2xvZ2Rf
aW5pdGVkID0gaW5pdGVkX2RncmFtOworICAgICAgZWxzZQogCXsKLQkgIC8q
Ci0JICAgKiBGSVhNRQotCSAgICoKLQkgICAqIEFzIHNvb24gYXMgQUZfTE9D
QUwgc29ja2V0cyBhcmUgdXNpbmcgcGlwZXMsIHRoaXMgY29kZSBoYXMgdG8K
LQkgICAqIGdvdCBhd2F5LgotCSAgICovCi0KLQkgIC8qIGNvbm5lY3Qgb24g
YSBkZ3JhbSBzb2NrZXQgYWx3YXlzIHN1Y2NlZWRzLiAgV2Ugc3RpbGwgZG9u
J3Qga25vdwotCSAgICAgaWYgc3lzbG9nZCBpcyBhY3R1YWxseSBsaXN0ZW5p
bmcuICovCi0JICBjeWdoZWFwX2ZkZ2V0IGNmZCAoZmQpOwotCSAgZmhhbmRs
ZXJfc29ja2V0X2xvY2FsICpjb25zdCBmaCA9IChmaGFuZGxlcl9zb2NrZXRf
bG9jYWwgKikKLQkJCQkJICAgIGNmZC0+aXNfc29ja2V0ICgpOwotCSAgdG1w
X3BhdGhidWYgdHA7Ci0JICBQTUlCX1VEUFRBQkxFIHRhYiA9IChQTUlCX1VE
UFRBQkxFKSB0cC53X2dldCAoKTsKLQkgIERXT1JEIHNpemUgPSA2NTUzNjsK
LQkgIGJvb2wgZm91bmQgPSBmYWxzZTsKLQkgIHN0cnVjdCBzb2NrYWRkcl9z
dG9yYWdlIHNzdDsKLQkgIGludCBsZW47Ci0KLQkgIGxlbiA9IHNpemVvZiBz
c3Q7Ci0JICA6OmdldHNvY2tuYW1lIChmaC0+Z2V0X3NvY2tldCAoKSwgKHN0
cnVjdCBzb2NrYWRkciAqKSAmc3N0LCAmbGVuKTsKLQkgIHN0cnVjdCBzb2Nr
YWRkcl9pbiAqc2EgPSAoc3RydWN0IHNvY2thZGRyX2luICopICZzc3Q7Ci0K
LQkgIGlmIChHZXRVZHBUYWJsZSAodGFiLCAmc2l6ZSwgRkFMU0UpID09IE5P
X0VSUk9SKQotCSAgICB7Ci0JICAgICAgZm9yIChEV09SRCBpID0gMDsgaSA8
IHRhYi0+ZHdOdW1FbnRyaWVzOyArK2kpCi0JCWlmICh0YWItPnRhYmxlW2ld
LmR3TG9jYWxBZGRyID09IHNhLT5zaW5fYWRkci5zX2FkZHIKLQkJICAgICYm
IHRhYi0+dGFibGVbaV0uZHdMb2NhbFBvcnQgPT0gc2EtPnNpbl9wb3J0KQot
CQkgIHsKLQkJICAgIGZvdW5kID0gdHJ1ZTsKLQkJICAgIGJyZWFrOwotCQkg
IH0KLQkgICAgICBpZiAoIWZvdW5kKQotCQl7Ci0JCSAgLyogTm8gc3lzbG9n
ZCBpcyBsaXN0ZW5pbmcuICovCi0JCSAgY2xvc2UgKGZkKTsKLQkJICByZXR1
cm47Ci0JCX0KLQkgICAgfQotCSAgc3lzbG9nZF9pbml0ZWQgPSBpbml0ZWRf
ZGdyYW07CisJICBjbG9zZSAoZmQpOworCSAgcmV0dXJuOwogCX0KLSAgICAg
IGVsc2UKLQljbG9zZSAoZmQpOwogICAgIH0KICAgc3lzbG9nZF9zb2NrID0g
ZmQ7CiAgIGRlYnVnX3ByaW50ZiAoImZvdW5kIC9kZXYvbG9nLCBmZCA9ICVk
LCB0eXBlID0gJXMiLAotLSAKMi4xNy4wCgo=

--Multipart=_Wed__4_Jul_2018_22_01_38_+0900_4rBfDPpo2PWHkhFm--
