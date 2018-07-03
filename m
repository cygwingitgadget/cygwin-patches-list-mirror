Return-Path: <cygwin-patches-return-9105-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 103221 invoked by alias); 3 Jul 2018 10:18:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 103165 invoked by uid 89); 3 Jul 2018 10:18:13 -0000
Authentication-Results: sourceware.org; auth=none
X-Spam-SWARE-Status: No, score=-1.8 required=5.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_NONE autolearn=ham version=3.3.2 spammy=H*c:HHHH
X-HELO: conssluserg-06.nifty.com
Received: from conssluserg-06.nifty.com (HELO conssluserg-06.nifty.com) (210.131.2.91) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Tue, 03 Jul 2018 10:18:11 +0000
Received: from Express5800-S70 (ntsitm315127.sitm.nt.ngn.ppp.infoweb.ne.jp [125.3.30.127]) (authenticated)	by conssluserg-06.nifty.com with ESMTP id w63AI7R3017231	for <cygwin-patches@cygwin.com>; Tue, 3 Jul 2018 19:18:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w63AI7R3017231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.ne.jp;	s=dec2015msa; t=1530613088;	bh=uUOATAZxgw7S35rmm6Q91r8uSZjfCA4FJiWU/Ght6GY=;	h=Date:From:To:Subject:In-Reply-To:References:From;	b=Sg0T3sAOSVOHhL4ctRmgVO5JiR+5e11VEPLcvHyDk7UVy5I9YYPX0HOZ9IdLDm+sU	 SYrD/batW11P3oKZ/uOONMzOJqQZJfWII517TufzwT67N13rBQ3RSOlJZXJLKKUdgp	 OnQb1orxN7ub96MNGoDF6+9QizR8a6nymRFUKbLg4HF4MqpROz7iAkOPGbVVe1Iw/G	 NGOvB0/d5zbnM30jt6yWTwYW1imUmWU2lL8Es47QUhfyjp/Y1UlB0qL19S8h26Gmut	 57VkfI+FYkerlxQzIy6yflXEDpXUqvlckMOcycrOhnaI9A8qmNU2HzBvKOqYn9RafN	 DLFlEZp7+VG5A==
Date: Tue, 03 Jul 2018 10:18:00 -0000
From: Takashi Yano <takashi.yano@nifty.ne.jp>
To: cygwin-patches@cygwin.com
Subject: Re: perror() changes the orientation of stderr to byte-oriented mode if stderr is not oriented yet.
Message-Id: <20180703191818.5ee7b9c7338deb479d4a774c@nifty.ne.jp>
In-Reply-To: <20180702102838.GB3111@calimero.vinschen.de>
References: <20180627200116.ddd80f78597f8fd3f09d5d4b@nifty.ne.jp>	<20180627125503.GV28757@calimero.vinschen.de>	<20180628201421.8f395c712f2fe5b3504d63f1@nifty.ne.jp>	<20180628183157.GC32575@calimero.vinschen.de>	<20180629213458.a39b9d4114bdf778deed8f49@nifty.ne.jp>	<20180702102838.GB3111@calimero.vinschen.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Multipart=_Tue__3_Jul_2018_19_18_18_+0900_tl1DL.hobcVV/4FL"
X-IsSubscribed: yes
X-SW-Source: 2018-q3/txt/msg00000.txt.bz2

This is a multi-part message in MIME format.

--Multipart=_Tue__3_Jul_2018_19_18_18_+0900_tl1DL.hobcVV/4FL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-length: 487

Hi Corinna,

On Mon, 2 Jul 2018 12:28:38 +0200
Corinna Vinschen wrote:
> > By the way, I have noticed that psignal() and psiginfo() also have the
> > same problem. psignal() belongs to newlib, so the same strategy can
> > be applied. However, what can we do for psiginfo()? Only the FreeBSD
> > route may be the answer...
> 
> I guess the simplest solution is to use the FreeBSD/OpenBSD method
> all the time.

This is for fixing psiginfo().

-- 
Takashi Yano <takashi.yano@nifty.ne.jp>

--Multipart=_Tue__3_Jul_2018_19_18_18_+0900_tl1DL.hobcVV/4FL
Content-Type: application/octet-stream;
 name="0001-Fix-a-bug-of-psiginfo-that-changes-the-orientation-o.patch"
Content-Disposition: attachment;
 filename="0001-Fix-a-bug-of-psiginfo-that-changes-the-orientation-o.patch"
Content-Transfer-Encoding: base64
Content-length: 3416

RnJvbSAwZDU2YzIzY2NkMjUzYWEyOTMwNzgzNzE2NzQzODk2ZWFiYjBjMTM1
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBUYWthc2hpIFlhbm8g
PHRha2FzaGkueWFub0BuaWZ0eS5uZS5qcD4KRGF0ZTogVHVlLCAzIEp1bCAy
MDE4IDE5OjA5OjQ4ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gRml4IGEgYnVn
IG9mIHBzaWdpbmZvKCkgdGhhdCBjaGFuZ2VzIHRoZSBvcmllbnRhdGlvbiBv
Zgogc3RkZXJyLgoKKiBzdHJzaWcuY2MgKHBzaWdpbmZvKTogRml4IHRoZSBw
cm9ibGVtIHRoYXQgcHNpZ2luZm8oKSBjaGFuZ2VzCiAgdGhlIG9yaWVudGF0
aW9uIG9mIHN0ZGVyciB0byBieXRlLW9yaWVudGVkIG1vZGUgaWYgc3RkZXJy
IGlzCiAgbm90IG9yaWVudGVkIHlldC4KLS0tCiB3aW5zdXAvY3lnd2luL3N0
cnNpZy5jYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwg
NiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3N0
cnNpZy5jYyBiL3dpbnN1cC9jeWd3aW4vc3Ryc2lnLmNjCmluZGV4IDY1MDFj
MjdkNy4uNmM3YmRkMzdjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL3N0
cnNpZy5jYworKysgYi93aW5zdXAvY3lnd2luL3N0cnNpZy5jYwpAQCAtMTAs
NiArMTAsNyBAQCBkZXRhaWxzLiAqLwogI2luY2x1ZGUgPGN5Z3Rscy5oPgog
I2luY2x1ZGUgPHN0ZGlvLmg+CiAjaW5jbHVkZSA8c3RyaW5nLmg+CisjaW5j
bHVkZSA8c3lzL3Vpby5oPgogCiBzdHJ1Y3Qgc2lnZGVzYwogewpAQCAtMTQ5
LDEzICsxNTAsMjkgQEAgc3RydG9zaWdubyAoY29uc3QgY2hhciAqbmFtZSkK
ICAgcmV0dXJuIDA7CiB9CiAKKyNkZWZpbmUgQUREKHN0cikgXAoreyBcCisg
IHYtPmlvdl9iYXNlID0gKHZvaWQgKikoc3RyKTsgXAorICB2LT5pb3ZfbGVu
ID0gc3RybGVuICgoY2hhciAqKXYtPmlvdl9iYXNlKTsgXAorICB2ICsrOyBc
CisgIGlvdl9jbnQgKys7IFwKK30KKwogZXh0ZXJuICJDIiB2b2lkCiBwc2ln
aW5mbyAoY29uc3Qgc2lnaW5mb190ICppbmZvLCBjb25zdCBjaGFyICpzKQog
eworICBzdHJ1Y3QgaW92ZWMgaW92WzVdOworICBzdHJ1Y3QgaW92ZWMgKnYg
PSBpb3Y7CisgIGludCBpb3ZfY250ID0gMDsKKyAgY2hhciBidWZbNjRdOwor
CiAgIGlmIChzICE9IE5VTEwgJiYgKnMgIT0gJ1wwJykKLSAgICBmcHJpbnRm
IChzdGRlcnIsICIlczogIiwgcyk7CisgICAgeworICAgICAgQUREIChzKTsK
KyAgICAgIEFERCAoIjogIik7CisgICAgfQogCi0gIGZwcmludGYgKHN0ZGVy
ciwgIiVzIiwgc3Ryc2lnbmFsIChpbmZvLT5zaV9zaWdubykpOworICBBREQg
KHN0cnNpZ25hbCAoaW5mby0+c2lfc2lnbm8pKTsKIAogICBpZiAoaW5mby0+
c2lfc2lnbm8gPiAwICYmIGluZm8tPnNpX3NpZ25vIDwgTlNJRykKICAgICB7
CkBAIC0xNjUsMTAgKzE4MiwxMiBAQCBwc2lnaW5mbyAoY29uc3Qgc2lnaW5m
b190ICppbmZvLCBjb25zdCBjaGFyICpzKQogCSAgY2FzZSBTSUdCVVM6CiAJ
ICBjYXNlIFNJR0ZQRToKIAkgIGNhc2UgU0lHU0VHVjoKLQkgICAgZnByaW50
ZiAoc3RkZXJyLCAiICglZCBbJXBdKSIsIGluZm8tPnNpX2NvZGUsIGluZm8t
PnNpX2FkZHIpOworCSAgICBzbnByaW50ZiAoYnVmLCBzaXplb2YoYnVmKSwK
KwkJICAgICAgIiAoJWQgWyVwXSkiLCBpbmZvLT5zaV9jb2RlLCBpbmZvLT5z
aV9hZGRyKTsKIAkgICAgYnJlYWs7CiAJICBjYXNlIFNJR0NITEQ6Ci0JICAg
IGZwcmludGYgKHN0ZGVyciwgIiAoJWQgJWQgJWQgJXUpIiwgaW5mby0+c2lf
Y29kZSwgaW5mby0+c2lfcGlkLAorCSAgICBzbnByaW50ZiAoYnVmLCBzaXpl
b2YoYnVmKSwKKwkJICAgICAgIiAoJWQgJWQgJWQgJXUpIiwgaW5mby0+c2lf
Y29kZSwgaW5mby0+c2lfcGlkLAogCQkgICAgIGluZm8tPnNpX3N0YXR1cywg
aW5mby0+c2lfdWlkKTsKIAkgICAgYnJlYWs7CiAvKiBGSVhNRTogaW1wbGVt
ZW50IHNpX2JhbmQKQEAgLTE3Nyw5ICsxOTYsMTkgQEAgcHNpZ2luZm8gKGNv
bnN0IHNpZ2luZm9fdCAqaW5mbywgY29uc3QgY2hhciAqcykKIAkgICAgYnJl
YWs7CiAqLwogCSAgZGVmYXVsdDoKLQkgICAgZnByaW50ZiAoc3RkZXJyLCAi
ICglZCAlZCAldSkiLCBpbmZvLT5zaV9jb2RlLCBpbmZvLT5zaV9waWQsIGlu
Zm8tPnNpX3VpZCk7CisJICAgIHNucHJpbnRmIChidWYsIHNpemVvZihidWYp
LAorCQkgICAgICAiICglZCAlZCAldSkiLCBpbmZvLT5zaV9jb2RlLCBpbmZv
LT5zaV9waWQsCisJCSAgICAgIGluZm8tPnNpX3VpZCk7CiAJfQorICAgICAg
QUREIChidWYpOwogICAgIH0KIAotICBmcHJpbnRmIChzdGRlcnIsICJcbiIp
OworI2lmZGVmIF9fU0NMRQorICBBREQgKChzdGRlcnItPl9mbGFncyAmIF9f
U0NMRSkgPyAiXHJcbiIgOiAiXG4iKTsKKyNlbHNlCisgIEFERCAoIlxuIik7
CisjZW5kaWYKKworICBmZmx1c2ggKHN0ZGVycik7CisgIHdyaXRldiAoZmls
ZW5vIChzdGRlcnIpLCBpb3YsIGlvdl9jbnQpOwogfQotLSAKMi4xNy4wCgo=

--Multipart=_Tue__3_Jul_2018_19_18_18_+0900_tl1DL.hobcVV/4FL--
