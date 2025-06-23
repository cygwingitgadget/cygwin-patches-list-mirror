Return-Path: <SRS0=7pAn=ZG=SystematicSW.ab.ca=Brian.Inglis@sourceware.org>
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	by sourceware.org (Postfix) with ESMTPS id 5C8B83874537
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 18:39:47 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 5C8B83874537
Authentication-Results: sourceware.org; dmarc=pass (p=none dis=none) header.from=SystematicSW.ab.ca
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=SystematicSW.ab.ca
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 5C8B83874537
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1750703987; cv=none;
	b=mWqsofwEeoKjbOe8BJvEq/vZOvi/yaMRfiN2Pcg93c9vMHYE/Dk6KWIDst/mIh2zx0f79ZWYqCiabrk2XU4qBUCfVxJzM1zXpAYhrs/b2Tg9wlV0fmUC8v7Dt2X0iAC7H4cqbuFZpENWKgGfL0ucpoPgApaaeuG5VfoAvQ9+FfI=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1750703987; c=relaxed/simple;
	bh=5bg9yy6nU89xp7mElWp1t+VJdWcpkS4DQhYuZ12GtEI=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:DKIM-Signature; b=gTL6oU3KH6WRfrf5htPoiEVEN9YWQgIHtef9Ff+6u3yRlluA//clB0NrTZOEk4vfAsh6/qO45qKQxw49PMsQWl62RsVDZrk6aT8PDuUmR5FDGZII1bys7cknTzF4VFKAneyDVJTQsBo9QcCKSzlnlo91I3PE0hwLNsc1D+ATaUs=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 5C8B83874537
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=SystematicSW.ab.ca header.i=@SystematicSW.ab.ca header.a=rsa-sha256 header.s=he header.b=lCbvIePX
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DE00E1A081B
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 18:39:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: Brian.Inglis@SystematicSW.ab.ca) by omf14.hostedemail.com (Postfix) with ESMTPA id 6800E2F
	for <cygwin-patches@cygwin.com>; Mon, 23 Jun 2025 18:39:40 +0000 (UTC)
Content-Type: multipart/mixed; boundary="------------DDQmVrFDZq2vohLmoqLzRLyl"
Message-ID: <b34eac53-be01-4822-9e83-0939c1009af8@SystematicSW.ab.ca>
Date: Mon, 23 Jun 2025 12:39:39 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Brian Inglis <Brian.Inglis@SystematicSW.ab.ca>
Reply-To: cygwin-patches@cygwin.com
Subject: Re: [PATCH v2] Cygwin: winsup/cygwin/include/asm/socket.h: add
 SO_REUSEPORT
Content-Language: en-CA
To: cygwin-patches@cygwin.com
References: <6f703b770ddd29e5c174622ae1570761a8a52a92.1750525279.git.Brian.Inglis@SystematicSW.ab.ca>
 <aFkTbV61qw06knEv@calimero.vinschen.de>
Organization: Systematic Software
In-Reply-To: <aFkTbV61qw06knEv@calimero.vinschen.de>
X-Rspamd-Queue-Id: 6800E2F
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,GIT_PATCH_0,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_VALIDITY_RPBL_BLOCKED,RCVD_IN_VALIDITY_SAFE_BLOCKED,SPF_HELO_PASS,SPF_PASS,TXREP,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: p5as1rxdax8oxqfzs9ji4aospgxgiejt
X-Rspamd-Server: rspamout05
X-Session-Marker: 427269616E2E496E676C69734053797374656D6174696353572E61622E6361
X-Session-ID: U2FsdGVkX184jKJDtNVsXzXiIgUHWVB2i8FVRgfj57c=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=SystematicSW.ab.ca; h=content-type:message-id:date:mime-version:from:reply-to:subject:to:references:in-reply-to; s=he; bh=/C055Wtmqv6WKniAADcW09CfQNWlko9WZUp2zNW4No0=; b=lCbvIePXv8oe+ySezQee++3ei9bwJPTD5ezTpnM14vh/lfPsnQARTtTSrVVPkncSS+40Zb3XcA1IUCutx8cqQ/RcwIy3Q9hntDT6Fg8AGy0Y/E2+snu2Ai7fG96aZ0SZLKFmHVwE8Mz9x+SyKBk8Z8ysHTAyPRlg3eL3j6LGQIFC+/ABWsdTv2Z580ADO6IdK1rDughI1uLNPNywKArKUWtx+quoQ2MrYpNU4AzCxUTihxTKDUnlbRjpE5hfzZHd4+JN1xRo+Cn+OGenPGds7veLmUrYyKaK64o+KthaD5DSV5jytKypTEcA9NlGsWXCVZtOLc2GCnohAJcDcqRXZQ==
X-HE-Tag: 1750703980-567484
X-HE-Meta: U2FsdGVkX19EAHl7Kf5o45ehQxXE3cDKXVuRHfQRdT3LT028fWgFEFCcB3p5axqdD6Mw7UDia+LGJHYW3pkl+5lw9xyUEN5oAFk4h4dvCXnFvIhTZSbGeUKjHrNU4s5vbNZv56r5QbZwbkW7Bkwm2on3i6TcZmJg8PoruS9zYaFXf+y61G/2w9KAITPS2+jiu0pu2+y5fTA4/76lf8CmYnEIBURVKSsYlp/2g6jqEC2/ffdFAyGdnJ/f78tinvkY9v4d/YtHbTovuSP8pl5YHlxewxFrec/AumDZkLchXyUliL1q0CCAq8xfYThfq2gMGAo0tbmprT8I7cbNxVeNGfGc3WnifX0zGjt60vOc7/7M8exhh7R3ww8iXbhI30ZK+x87ORqQ+f0iVPX/telPFfMcT/XIsRJQ0ehO4O1jENQgNrdF1w/kRxsWayKqj+gA4agbmN7v+hTsuDo2hHcL+M2oa/7AK/JC/fzTjpMs38AvqRr2yH3d0GLTweUSdMU9dOHNZR8/Kf2giJNXjyievXAbFzUZ8hqSVzKzm1EFA5imLcZssRE9rWoSwp+sBqrTc5Fe/lb6KHE=
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------DDQmVrFDZq2vohLmoqLzRLyl
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025-06-23 02:42, Corinna Vinschen wrote:
> Hi Brian,
> 
> On Jun 21 11:02, Brian Inglis wrote:
>> SO_REUSEPORT is defined in BSDs, Solaris, and Linux (since 3.9).
>> It is not available in Windows but S.O. articles suggest
> 
> S.O.?
> 
> -v, please?

Hi Corinna,

Stack Overflow (added dots to distinguish that abbrev from SockOpt).

> If there's this articel, it might be a good idea to add a link to it
> in the commit message.

Might have made the above abbrev more obvious:

https://stackoverflow.com/questions/13637121/so-reuseport-is-not-defined-on-windows-7#comment18710480_13638757

Other articles spend a lot of time discussing their opinions of whether there 
are subtle or drastic differences between SO_REUSEADDR and SO_REUSEPORT 
implmentations across available platforms, so don't add much to that.

[One generated answer suggested SO_EXCLUSIVEADDRUSE rather than SO_REUSEPORT, 
but gave the definition of both identically, except for the words "do not" in 
the former, suggesting that the so-called "language model" excluded semantics!]

-- 
Take care. Thanks, Brian Inglis              Calgary, Alberta, Canada

La perfection est atteinte                   Perfection is achieved
non pas lorsqu'il n'y a plus rien à ajouter  not when there is no more to add
mais lorsqu'il n'y a plus rien à retrancher  but when there is no more to cut
                                 -- Antoine de Saint-Exupéry
--------------DDQmVrFDZq2vohLmoqLzRLyl
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-winsup-cygwin-include-asm-socket.h-add-SO_REUSEPORT.patch"
Content-Disposition: attachment;
 filename*0="0001-Cygwin-winsup-cygwin-include-asm-socket.h-add-SO_REUSEP";
 filename*1="ORT.patch"
Content-Transfer-Encoding: base64

RnJvbSA2ZjcwM2I3NzBkZGQyOWU1YzE3NDYyMmFlMTU3MDc2MWE4YTUyYTkyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpNZXNzYWdlLUlEOiA8NmY3MDNiNzcwZGRkMjllNWMxNzQ2MjJh
ZTE1NzA3NjFhOGE1MmE5Mi4xNzUwNTI1Mjc5LmdpdC5Ccmlhbi5JbmdsaXNAU3lzdGVtYXRp
Y1NXLmFiLmNhPgpGcm9tOiBCcmlhbiBJbmdsaXMgPEJyaWFuLkluZ2xpc0BTeXN0ZW1hdGlj
U1cuYWIuY2E+CkJjYzogQnJpYW4gSW5nbGlzIDxCcmlhbi5JbmdsaXNAU2hhdy5jYT4KVG86
IEN5Z3dpbiBQYXRjaGVzIDxjeWd3aW4tcGF0Y2hlc0BjeWd3aW4uY29tPgpEYXRlOiBTYXQs
IDIxIEp1biAyMDI1IDEwOjU2OjI5IC0wNjAwClN1YmplY3Q6IFtQQVRDSCB2Ml0gQ3lnd2lu
OiB3aW5zdXAvY3lnd2luL2luY2x1ZGUvYXNtL3NvY2tldC5oOiBhZGQgU09fUkVVU0VQT1JU
Ck9yZ2FuaXphdGlvbjogU3lzdGVtYXRpYyBTb2Z0d2FyZQoKU09fUkVVU0VQT1JUIGlzIGRl
ZmluZWQgaW4gQlNEcywgU29sYXJpcywgYW5kIExpbnV4IChzaW5jZSAzLjkpLgpJdCBpcyBu
b3QgYXZhaWxhYmxlIGluIFdpbmRvd3MgYnV0IFN0YWNrIE92ZXJmbG93IGFydGljbGVzIHN1
Z2dlc3QKU09fUkVVU0VBRERSfFNPX0JST0FEQ0FTVCB3b3JrcyBzaW1pbGFybHkgb24gV2lu
ZG93cywgc28gZGVmaW5lIGFzIHN1Y2g6Cmh0dHBzOi8vc3RhY2tvdmVyZmxvdy5jb20vcXVl
c3Rpb25zLzEzNjM3MTIxL3NvLXJldXNlcG9ydC1pcy1ub3QtZGVmaW5lZC1vbi13aW5kb3dz
LTcjY29tbWVudDE4NzEwNDgwXzEzNjM4NzU3ClJlcXVpcmVkIHRvIGJ1aWxkIG5naHR0cDIg
MS42Ni4KClNpZ25lZC1vZmYtYnk6IEJyaWFuIEluZ2xpcyA8QnJpYW4uSW5nbGlzQFN5c3Rl
bWF0aWNTVy5hYi5jYT4KLS0tCiB3aW5zdXAvY3lnd2luL2luY2x1ZGUvYXNtL3NvY2tldC5o
IHwgMyArKysKIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQg
YS93aW5zdXAvY3lnd2luL2luY2x1ZGUvYXNtL3NvY2tldC5oIGIvd2luc3VwL2N5Z3dpbi9p
bmNsdWRlL2FzbS9zb2NrZXQuaAppbmRleCAyNzZkZjNhMGI1ZmQuLmQ2NWRjNDFhMGQ1ZCAx
MDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9pbmNsdWRlL2FzbS9zb2NrZXQuaAorKysgYi93
aW5zdXAvY3lnd2luL2luY2x1ZGUvYXNtL3NvY2tldC5oCkBAIC03Miw1ICs3Miw4IEBAIGRl
dGFpbHMuICovCiAjZGVmaW5lIFNPX0VSUk9SICAgICAgICAweDEwMDcgICAgICAgICAgLyog
Z2V0IGVycm9yIHN0YXR1cyBhbmQgY2xlYXIgKi8KICNkZWZpbmUgU09fVFlQRSAgICAgICAg
IDB4MTAwOCAgICAgICAgICAvKiBnZXQgc29ja2V0IHR5cGUgKi8KIAorI2RlZmluZSBTT19S
RVVTRVBPUlQgIChTT19SRVVTRUFERFIgfCBTT19CUk9BRENBU1QpCisJCQkJLyogYWxsb3cg
bG9jYWwgcG9ydCByZXVzZSAtIHN5bnRoIG9uIFdpbmRvd3MgKi8KKwogI2VuZGlmIC8qIF9B
U01fU09DS0VUX0ggKi8KIAotLSAKMi40NS4xCgo=

--------------DDQmVrFDZq2vohLmoqLzRLyl--
