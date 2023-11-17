Return-Path: <SRS0=NTQ+=G6=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id EA28C3858425
	for <cygwin-patches@cygwin.com>; Fri, 17 Nov 2023 17:54:11 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org EA28C3858425
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org EA28C3858425
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700243653; cv=none;
	b=XC3IkMPn+02dkqzMUIBr4afAtuztdXSRCpt+urIBxLrEBm/twjExs7yApNPu12TVG4mYEr8QJTngwI/I1rdnr6YM3Vatp2OVV47OCr2b1VVFto8gQ5NgZSdXDNEl/EvZish+d2wEysuxHMs9C357LPzI3HwSvqcoWyXVwtfI79c=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700243653; c=relaxed/simple;
	bh=uRNcz9WhrNVTJCcPGd8f2LFXaTiBKwI5McnaSFXlvfw=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=kXsG01kuNAdLEk1Bvuy0Xbdg+x1j55gkzPoErNtydKBOgDcKiMuDF04cOMUXcO1Z/TZbHAcQcbuU8sl1ZfuiVdxTzrN29yKoPDwo15Jq3ErJ+IV0tdWCvXaTQb4hPp6bky0p0ECn/dGIGl5fRBF//jegV6OnhBqQkVG0AZB53jA=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
	by mailout07.t-online.de (Postfix) with SMTP id BAFC47E5A
	for <cygwin-patches@cygwin.com>; Fri, 17 Nov 2023 18:53:29 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd82.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r4321-22YLWS0; Fri, 17 Nov 2023 18:53:29 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
Date: Fri, 17 Nov 2023 18:53:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------77D918859DF30D833DFE972A"
X-TOI-EXPURGATEID: 150726::1700243609-F67FB954-4B2BF363/0/0 CLEAN NORMAL
X-TOI-MSGID: 2769bf69-b254-4fd0-a3c8-374798628e81
X-Spam-Status: No, score=-11.7 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------77D918859DF30D833DFE972A
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Nov 17 17:45, Christian Franke wrote:
>> Corinna Vinschen wrote:
>>> On Nov 17 15:39, Christian Franke wrote:
>>>> The last two /dev/disk subdirectories :-)
>>>>
>>>> Note a minor difference: On Linux, empty /dev/disk subdirectories apparently
>>>> never appear. A subdirectory is not listed in /dev/disk if it would be
>>>> empty. Not worth the effort to emulate.
>>> Agreed.  This is really great.  I just pushed your patch.
>>>
>>> However, there's something strange in terms of by-label:
>>>
>>> I have two partitions with labels:
>>>
>>>     $ ls -l /dev/disk/by-label
>>>     total 0
>>>     lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub -> ../../sda3
>>>     lrwxrwxrwx 1 corinna vinschen 0 Nov 17 17:18 blub2 -> ../../sdb2
>>>     $
>>>
>>> Now I change the label of sdb2 to the same "blub" string as on sda3:
>>>
>>>     $ ls -l /dev/disk/by-label
>>>     total 0
>>>     $
>>>
>>> I'd expected to see only one, due to the name collision, but en empty
>>> dir is a bit surprising...  And it may occur more often than not, given
>>> that the default label "New_Volume" probably won't get changed very
>>> often.
>>>
>> This is intentional and inherited from the very first patch, see the loop
>> behind qsort(). If a range of identical names appear, all these entries are
>> removed. If some "random" entry would be kept, it might no longer be the
>> persistent link the user expects. We could possibly add some hash like done
>> for by-id or append a number in such cases later. Need some more time to
>> thing about it....
> I see.  Admittedly, I don't know how Linux handles this either.

A quick test on Debian 12 with by-label suggests that the last duplicate 
wins. Also not very sophisticated :-)
IIRC in the past I've seen in another of these directories (by-id?) that 
'#N' was appended if duplicates occur.


>> I will sent a patch for the new-features doc soon.

Attached.

Christian


--------------77D918859DF30D833DFE972A
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-Document-dev-disk-by-subdirectories.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Cygwin-Document-dev-disk-by-subdirectories.patch"

RnJvbSA1ZDFjODJmMDhlNGIzN2Q2NWFjYzhiZjBjNzZmNzU2NDFkNzYyNjY3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBGcmksIDE3IE5vdiAyMDIzIDE4OjQxOjA4ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBEb2N1bWVudCAvZGV2L2Rpc2svYnktKiBzdWJk
aXJlY3RvcmllcwoKU2lnbmVkLW9mZi1ieTogQ2hyaXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFu
LmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMy41LjAg
fCAxNiArKysrKysrKysrKy0tLS0tCiB3aW5zdXAvZG9jL25ldy1mZWF0dXJlcy54bWwgfCAy
MCArKysrKysrKysrKy0tLS0tLS0tLQogMiBmaWxlcyBjaGFuZ2VkLCAyMiBpbnNlcnRpb25z
KCspLCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL3JlbGVh
c2UvMy41LjAgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy41LjAKaW5kZXggMmQ1OTgxOGI1
Li5hZWUyMWM5NzIgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vcmVsZWFzZS8zLjUuMAor
KysgYi93aW5zdXAvY3lnd2luL3JlbGVhc2UvMy41LjAKQEAgLTE3LDExICsxNywxNyBAQCBX
aGF0J3MgbmV3OgogICBjbGFzcyBleHByZXNzaW9ucywgYW5kIGNvbGxhdGluZyBzeW1ib2xz
IGluIHRoZSBzZWFyY2ggcGF0dGVybiwgaS5lLiwKICAgWzphbG51bTpdLCBbPWE9XSwgWy5h
YS5dLgogCi0tIEludHJvZHVjZSAvZGV2L2Rpc2sgZGlyZWN0b3J5IHdpdGggc3ViZGlyZWN0
b3JpZXMgYnktaWQgYW5kIGJ5LXBhcnR1dWlkLgotICBUaGUgYnktaWQgZGlyZWN0b3J5IHBy
b3ZpZGVzIHN5bWxpbmtzIGZvciBlYWNoIGRpc2sgYW5kIGl0cyBwYXJ0aXRpb25zOgotICBC
VVNUWVBFLVtWRU5ET1JfXVBST0RVQ1RfW1NFUklBTHxIQVNIXVstcGFydE5dIC0+IC4uLy4u
L3NkWFtOXS4KLSAgVGhlIGJ5LXBhcnR1dWlkIGRpcmVjdG9yeSBwcm92aWRlcyBzeW1saW5r
cyBmb3IgZWFjaCBNQlIgYW5kIEdQVCBkaXNrCi0gIHBhcnRpdGlvbjogTUJSX1NFUklBTC1P
RkZTRVQgLT4gLi4vLi4vc2RYTiwgR1BUX0dVSUQgLT4gLi4vLi4vc2RYTi4KKy0gSW50cm9k
dWNlIC9kZXYvZGlzayBkaXJlY3Rvcnkgd2l0aCB2YXJpb3VzIGJ5LSogc3ViZGlyZWN0b3Jp
ZXMgd2hpY2gKKyAgcHJvdmlkZSBzeW1saW5rcyB0byBkaXNrIGFuZCBwYXJ0aXRpb24gcmF3
IGRldmljZXM6CisgIGJ5LWRyaXZlL0RSSVZFX0xFVFRFUiAtPiAgLi4vLi4vc2RYTgorICBi
eS1sYWJlbC9WT0xVTUVfTEFCRUwgLT4gIC4uLy4uL3NkWE4KKyAgYnktaWQvQlVTVFlQRS1b
VkVORE9SX11QUk9EVUNUX1tTRVJJQUx8MHhIQVNIXVstcGFydE5dIC0+IC4uLy4uL3NkWFtO
XQorICBieS1wYXJ0dXVpZC9NQlJfU0VSSUFMLU9GRlNFVCAtPiAuLi8uLi9zZFhOCisgIGJ5
LXBhcnR1dWlkL0dQVF9HVUlEIC0+IC4uLy4uL3NkWE4KKyAgYnktdXVpZC9WT0xVTUVfU0VS
SUFMIC0+IC4uLy4uL3NkWE4KKyAgYnktdm9sdXVpZC9NQlJfU0VSSUFMLU9GRlNFVCAtPiAu
Li8uLi9zZFhOCisgIGJ5LXZvbHV1aWQvVk9MVU1FX0dVSUQgLT4gLi4vLi4vc2RYTgorICBU
aGUgc3ViZGlyZWN0b3JpZXMgYnktZHJpdmUgYW5kIGJ5LXZvbHV1aWQgYXJlIEN5Z3dpbiBz
cGVjaWZpYy4KIAogLSBJbnRyb2R1Y2UgL3Byb2MvY29kZXNldHMgYW5kIC9wcm9jL2xvY2Fs
ZXMgd2l0aCBpbmZvcm1hdGlvbiBvbgogICBzdXBwb3J0ZWQgY29kZXNldHMgYW5kIGxvY2Fs
ZXMgZm9yIGFsbCBpbnRlcmVzdGVkIHBhcnRpZXMuICBMb2NhbGUoMSkKZGlmZiAtLWdpdCBh
L3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVzLnhtbCBiL3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVz
LnhtbAppbmRleCBhOGU4YTc5OTEuLjJjMzFhNGFjYyAxMDA2NDQKLS0tIGEvd2luc3VwL2Rv
Yy9uZXctZmVhdHVyZXMueG1sCisrKyBiL3dpbnN1cC9kb2MvbmV3LWZlYXR1cmVzLnhtbApA
QCAtMzUsMTcgKzM1LDE5IEBAIGNsYXNzIGV4cHJlc3Npb25zLCBhbmQgY29sbGF0aW5nIHN5
bWJvbHMgaW4gdGhlIHNlYXJjaCBwYXR0ZXJuLCBpLmUuLAogPC9wYXJhPjwvbGlzdGl0ZW0+
CiAKIDxsaXN0aXRlbT48cGFyYT4KLUludHJvZHVjZSAvZGV2L2Rpc2sgZGlyZWN0b3J5IHdp
dGggc3ViZGlyZWN0b3JpZXMgYnktaWQgYW5kIGJ5LXBhcnR1dWlkLgotVGhlIGJ5LWlkIGRp
cmVjdG9yeSBwcm92aWRlcyBzeW1saW5rcyBmb3IgZWFjaCBkaXNrIGFuZCBpdHMgcGFydGl0
aW9uczoKK0ludHJvZHVjZSAvZGV2L2Rpc2sgZGlyZWN0b3J5IHdpdGggdmFyaW91cyBieS0q
IHN1YmRpcmVjdG9yaWVzIHdoaWNoCitwcm92aWRlIHN5bWxpbmtzIHRvIGRpc2sgYW5kIHBh
cnRpdGlvbiByYXcgZGV2aWNlczoKICAgPHNjcmVlbj4KLSAgQlVTVFlQRS1bVkVORE9SX11Q
Uk9EVUNUX1tTRVJJQUx8MHhIQVNIXVstcGFydE5dIC0+IC4uLy4uL3NkWFtOXQotICA8L3Nj
cmVlbj4KLVRoZSBieS1wYXJ0dXVpZCBkaXJlY3RvcnkgcHJvdmlkZXMgc3ltbGlua3MgZm9y
IGVhY2ggTUJSIGFuZCBHUFQgZGlzawotcGFydGl0aW9uOgotICA8c2NyZWVuPgotICBNQlJf
U0VSSUFMLU9GRlNFVCAtPiAuLi8uLi9zZFhOCi0gIEdQVF9HVUlEIC0+IC4uLy4uL3NkWE4K
KyAgYnktZHJpdmUvRFJJVkVfTEVUVEVSIC0+ICAuLi8uLi9zZFhOCisgIGJ5LWxhYmVsL1ZP
TFVNRV9MQUJFTCAtPiAgLi4vLi4vc2RYTgorICBieS1pZC9CVVNUWVBFLVtWRU5ET1JfXVBS
T0RVQ1RfW1NFUklBTHwweEhBU0hdWy1wYXJ0Tl0gLT4gLi4vLi4vc2RYW05dCisgIGJ5LXBh
cnR1dWlkL01CUl9TRVJJQUwtT0ZGU0VUIC0+IC4uLy4uL3NkWE4KKyAgYnktcGFydHV1aWQv
R1BUX0dVSUQgLT4gLi4vLi4vc2RYTgorICBieS11dWlkL1ZPTFVNRV9TRVJJQUwgLT4gLi4v
Li4vc2RYTgorICBieS12b2x1dWlkL01CUl9TRVJJQUwtT0ZGU0VUIC0+IC4uLy4uL3NkWE4K
KyAgYnktdm9sdXVpZC9WT0xVTUVfR1VJRCAtPiAuLi8uLi9zZFhOCiAgIDwvc2NyZWVuPgor
VGhlIHN1YmRpcmVjdG9yaWVzIGJ5LWRyaXZlIGFuZCBieS12b2x1dWlkIGFyZSBDeWd3aW4g
c3BlY2lmaWMuCiA8L3BhcmE+PC9saXN0aXRlbT4KIAogPGxpc3RpdGVtPjxwYXJhPgotLSAK
Mi40Mi4xCgo=
--------------77D918859DF30D833DFE972A--
