Return-Path: <SRS0=UMF9=HC=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout07.t-online.de (mailout07.t-online.de [194.25.134.83])
	by sourceware.org (Postfix) with ESMTPS id 9DE543858D33
	for <cygwin-patches@cygwin.com>; Tue, 21 Nov 2023 11:24:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 9DE543858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 9DE543858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.83
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700565887; cv=none;
	b=fyprx/7XTaYk9MIijW3PDfIkSVuoSxz65nFRhJrZOe6FnA+gu0eaLL7Mbc1CtR+WRZSTqfkb0RnAUL/pmjGVDE0jLS5M4RQFGGYc6IVU6iCy9PQVxhfeVnT+j+TFDaFx/trCiJXkNaoGvhpkVpXJVnMz3N7D9oOP3cneI88TRDA=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700565887; c=relaxed/simple;
	bh=X8uz5pAKKhe4exBSCGrSo54fWIfFHTgPF1ccjREw+Ro=;
	h=Subject:From:To:Message-ID:Date:MIME-Version; b=Br06qgZnTp7DkJm2cmNFxb+akkNx7gfVqZPLBc4S4e9NOxFjuR+THNvp+hxZLo+mqGJdf3bQWlYRCX80lhLfR19GBFjbp3HGnDq56UBVnJij5C3hBW6hbBlZo2MukZquEwi3E6Edzq9l+syGj1skz9/57kK4phw9N2qRa01KX3U=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd77.aul.t-online.de (fwd77.aul.t-online.de [10.223.144.103])
	by mailout07.t-online.de (Postfix) with SMTP id 16DC934B4B
	for <cygwin-patches@cygwin.com>; Tue, 21 Nov 2023 12:24:22 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd77.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r5Orc-1MKVvM0; Tue, 21 Nov 2023 12:24:20 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
From: Christian Franke <Christian.Franke@t-online.de>
To: cygwin-patches@cygwin.com
References: <9c82a61c-02f8-a679-90f2-90e853d47e53@t-online.de>
 <ZVeTfEHgbgLJKFpU@calimero.vinschen.de>
 <57fb24ee-cd4c-0b54-6613-40f817e12571@t-online.de>
 <ZVeZhRmrMlbK7qkz@calimero.vinschen.de>
 <d74801f8-45fb-6a66-cc92-8f021f58c53b@t-online.de>
 <ZVfBmQiTGOjx14lW@calimero.vinschen.de>
 <b924c0f6-7ac1-9fa8-f828-0482f1ea5d36@t-online.de>
 <ZVsppVEdC+HW2NE5@calimero.vinschen.de>
 <ZVsrDfTnL6Fy3BfM@calimero.vinschen.de>
 <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
Message-ID: <0ba1c78e-15e6-65a2-eb4d-16ac2495c356@t-online.de>
Date: Tue, 21 Nov 2023 12:24:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
Content-Type: multipart/mixed;
 boundary="------------DC5735A48C3AF764F50FD158"
X-TOI-EXPURGATEID: 150726::1700565860-3EFFA877-167DA32D/0/0 CLEAN NORMAL
X-TOI-MSGID: bdba2975-5de0-4b9b-89e7-002a2e5d5e66
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,BODY_8BITS,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------DC5735A48C3AF764F50FD158
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Christian Franke wrote:
> Corinna Vinschen wrote:
>> On Nov 20 10:40, Corinna Vinschen wrote:
>>> Hi Christian,
>>>
>>> This puzzles me:
>>>
>>> On Nov 17 21:25, Christian Franke wrote:
>>>> @@ -610,7 +607,7 @@ get_by_id_table (by_id_entry * &table, 
>>>> fhandler_dev_disk::dev_disk_location loc)
>>>>     if (!table)
>>>>       return (errno_set ? -1 : 0);
>>>>   -  /* Sort by name and remove duplicates. */
>>>> +  /* Sort by name and mark duplicates. */
>>>>     qsort (table, table_size, sizeof (*table), by_id_compare_name);
>>>>     for (unsigned i = 0; i < table_size; i++)
>>> by_id_compare_name only compars the actual names...
>>>
>>>>       {
>>>> @@ -619,12 +616,13 @@ get_by_id_table (by_id_entry * &table, 
>>>> fhandler_dev_disk::dev_disk_location loc)
>>>>       j++;
>>>>         if (j == i + 1)
>>>>       continue;
>>>> -      /* Duplicate(s) found, remove all entries with this name. */
>>>> -      debug_printf ("removing duplicates %d-%d: '%s'", i, j - 1, 
>>>> table[i].name);
>>>> -      if (j < table_size)
>>>> -    memmove (table + i, table + j, (table_size - j) * sizeof 
>>>> (*table));
>>>> -      table_size -= j - i;
>>>> -      i--;
>>>> +      /* Duplicate(s) found, append "#N" to all entries. This never
>>> ...but the names are identical.  So the *order* within the identically
>>> named entries depends on qsort's reshuffling of table
>>> entries.  Which in turn depends on outside factors like number of table
>>> entries and the ultimate position of the identical entries within the
>>> ordered table.
>>>
>>> Having said that, I don't see how adding ordinals to the names can be
>>> unambiguous.  AFAICS, the numbers may change by just adding another
>>> disk (USB Stick) to the system...
>> Oops, that's not exactly what I was trying to say, sorry.
>>
>> The problem is not adding ordinals to the name, AFAICS, the problem is
>> that the sorting function by_id_compare_name is not up to the task to
>> make sure the order is unambiguous within the entries of identical name.
>
> That's correct, thanks for catching. qsort is not a stable sort. 
> Changing drives outside the duplicate range may also change the order 
> within the range. Could be fixed by a lexicographic compare of {name, 
> drive, part}.
>

Attached.


--------------DC5735A48C3AF764F50FD158
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-dev-disk-Append-N-if-the-same-name-appears-mo.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-dev-disk-Append-N-if-the-same-name-appears-mo.pa";
 filename*1="tch"

RnJvbSA3ZGFmYjg1MjEwZWY3N2VhODc5OGYyMjE2MGY3NzgyYzM5NGVmNWMzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUdWUsIDIxIE5vdiAyMDIzIDEyOjE3OjE0ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiAvZGV2L2Rpc2s6IEFwcGVuZCAnI04nIGlmIHRo
ZSBzYW1lIG5hbWUgYXBwZWFycyBtb3JlCiB0aGFuIG9uY2UKCk5vIGxvbmdlciBkcm9wIHJh
bmdlcyBvZiBpZGVudGljYWwgbGluayBuYW1lcy4gIEFwcGVuZCAnIzAsICMxLCAuLi4nCnRv
IGVhY2ggbmFtZSBpbnN0ZWFkLiAgTm8gbG9uZ2VyIGlnbm9yZSBudWxsIHZvbHVtZSBzZXJp
YWwgbnVtYmVycy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlh
bi5mcmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogd2luc3VwL2N5Z3dpbi9maGFuZGxlci9kZXZf
ZGlzay5jYyB8IDUzICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDMzIGluc2VydGlvbnMoKyksIDIwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXIvZGV2X2Rpc2suY2MgYi93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyL2Rldl9kaXNrLmNjCmluZGV4IGM1ZDcyODE2Zi4uZDEyYWM1MmZhIDEwMDY0NAot
LS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2Rldl9kaXNrLmNjCisrKyBiL3dpbnN1cC9j
eWd3aW4vZmhhbmRsZXIvZGV2X2Rpc2suY2MKQEAgLTY0LDEwICs2NCwxMiBAQCBzYW5pdGl6
ZV9sYWJlbF9zdHJpbmcgKFdDSEFSICpzKQogICAvKiBMaW51eCBkb2VzIG5vdCBza2lwIGxl
YWRpbmcgc3BhY2VzLiAqLwogICByZXR1cm4gc2FuaXRpemVfc3RyaW5nIChzLCBMJ1wwJywg
TCcgJywgTCdfJywgW10gKFdDSEFSIGMpIC0+IGJvb2wKICAgICB7Ci0gICAgICAvKiBMYWJl
bHMgbWF5IGNvbnRhaW4gY2hhcmFjdGVycyBub3QgYWxsb3dlZCBpbiBmaWxlbmFtZXMuCi0J
IExpbnV4IHJlcGxhY2VzIHNwYWNlcyB3aXRoIFx4MjAgd2hpY2ggaXMgbm90IGFuIG9wdGlv
biBoZXJlLiAqLworICAgICAgLyogTGFiZWxzIG1heSBjb250YWluIGNoYXJhY3RlcnMgbm90
IGFsbG93ZWQgaW4gZmlsZW5hbWVzLiAgQWxzbworICAgICAgICAgcmVwbGFjZSAnIycgdG8g
YXZvaWQgdGhhdCBkdXBsaWNhdGUgbWFya2VycyBpbnRyb2R1Y2UgbmV3CisJIGR1cGxpY2F0
ZXMuICBMaW51eCByZXBsYWNlcyBzcGFjZXMgd2l0aCBceDIwIHdoaWNoIGlzIG5vdCBhbgor
CSBvcHRpb24gaGVyZS4gKi8KICAgICAgIHJldHVybiAhKCgwIDw9IGMgJiYgYyA8PSBMJyAn
KSB8fCBjID09IEwnOicgfHwgYyA9PSBMJy8nIHx8IGMgPT0gTCdcXCcKLQkgICAgICB8fCBj
ID09IEwnIicpOworCSAgICAgIHx8IGMgPT0gTCcjJyB8fCBjID09IEwnIicpOwogICAgIH0K
ICAgKTsKIH0KQEAgLTMwNCw4ICszMDYsNyBAQCBwYXJ0aXRpb25fdG9fbGFiZWxfb3JfdXVp
ZChib29sIHV1aWQsIGNvbnN0IFVOSUNPREVfU1RSSU5HICpkcml2ZV91bmFtZSwKICAgY29u
c3QgTlRGU19WT0xVTUVfREFUQV9CVUZGRVIgKm52ZGIgPQogICAgIHJlaW50ZXJwcmV0X2Nh
c3Q8Y29uc3QgTlRGU19WT0xVTUVfREFUQV9CVUZGRVIgKj4oaW9jdGxfYnVmKTsKICAgaWYg
KHV1aWQgJiYgRGV2aWNlSW9Db250cm9sICh2b2xoZGwsIEZTQ1RMX0dFVF9OVEZTX1ZPTFVN
RV9EQVRBLCBudWxscHRyLCAwLAotCQkJICAgICAgIGlvY3RsX2J1ZiwgTlRfTUFYX1BBVEgs
ICZieXRlc19yZWFkLCBudWxscHRyKQotICAgICAgJiYgbnZkYi0+Vm9sdW1lU2VyaWFsTnVt
YmVyLlF1YWRQYXJ0KQorCQkJICAgICAgIGlvY3RsX2J1ZiwgTlRfTUFYX1BBVEgsICZieXRl
c19yZWFkLCBudWxscHRyKSkKICAgICB7CiAgICAgICAvKiBQcmludCB3aXRob3V0IGFueSBz
ZXBhcmF0b3IgYXMgb24gTGludXguICovCiAgICAgICBfX3NtYWxsX3NwcmludGYgKG5hbWUs
ICIlMDE2WCIsIG52ZGItPlZvbHVtZVNlcmlhbE51bWJlci5RdWFkUGFydCk7CkBAIC0zMjcs
MTMgKzMyOCw5IEBAIHBhcnRpdGlvbl90b19sYWJlbF9vcl91dWlkKGJvb2wgdXVpZCwgY29u
c3QgVU5JQ09ERV9TVFJJTkcgKmRyaXZlX3VuYW1lLAogICBGSUxFX0ZTX1ZPTFVNRV9JTkZP
Uk1BVElPTiAqZmZ2aSA9CiAgICAgcmVpbnRlcnByZXRfY2FzdDxGSUxFX0ZTX1ZPTFVNRV9J
TkZPUk1BVElPTiAqPihpb2N0bF9idWYpOwogICBpZiAodXVpZCkKLSAgICB7Ci0gICAgICBp
ZiAoIWZmdmktPlZvbHVtZVNlcmlhbE51bWJlcikKLQlyZXR1cm4gZmFsc2U7Ci0gICAgICAv
KiBQcmludCB3aXRoIHNlcGFyYXRvciBhcyBvbiBMaW51eC4gKi8KLSAgICAgIF9fc21hbGxf
c3ByaW50ZiAobmFtZSwgIiUwNHgtJTA0eCIsIGZmdmktPlZvbHVtZVNlcmlhbE51bWJlciA+
PiAxNiwKLQkJICAgICAgIGZmdmktPlZvbHVtZVNlcmlhbE51bWJlciAmIDB4ZmZmZik7Ci0g
ICAgfQorICAgIC8qIFByaW50IHdpdGggc2VwYXJhdG9yIGFzIG9uIExpbnV4LiAqLworICAg
IF9fc21hbGxfc3ByaW50ZiAobmFtZSwgIiUwNHgtJTA0eCIsIGZmdmktPlZvbHVtZVNlcmlh
bE51bWJlciA+PiAxNiwKKwkJICAgICBmZnZpLT5Wb2x1bWVTZXJpYWxOdW1iZXIgJiAweGZm
ZmYpOwogICBlbHNlCiAgICAgewogICAgICAgLyogTGFiZWwgaXMgbm90IG51bGwgdGVybWlu
YXRlZC4gKi8KQEAgLTM2MSw2ICszNTgsMjAgQEAgYnlfaWRfY29tcGFyZV9uYW1lIChjb25z
dCB2b2lkICphLCBjb25zdCB2b2lkICpiKQogICByZXR1cm4gc3RyY21wIChhcC0+bmFtZSwg
YnAtPm5hbWUpOwogfQogCitzdGF0aWMgaW50CitieV9pZF9jb21wYXJlX25hbWVfZHJpdmVf
cGFydCAoY29uc3Qgdm9pZCAqYSwgY29uc3Qgdm9pZCAqYikKK3sKKyAgY29uc3QgYnlfaWRf
ZW50cnkgKmFwID0gcmVpbnRlcnByZXRfY2FzdDxjb25zdCBieV9pZF9lbnRyeSAqPihhKTsK
KyAgY29uc3QgYnlfaWRfZW50cnkgKmJwID0gcmVpbnRlcnByZXRfY2FzdDxjb25zdCBieV9p
ZF9lbnRyeSAqPihiKTsKKyAgaW50IGNtcCA9IHN0cmNtcCAoYXAtPm5hbWUsIGJwLT5uYW1l
KTsKKyAgaWYgKGNtcCkKKyAgICByZXR1cm4gY21wOworICBjbXAgPSBhcC0+ZHJpdmUgLSBi
cC0+ZHJpdmU7CisgIGlmIChjbXApCisgICAgcmV0dXJuIGNtcDsKKyAgcmV0dXJuIGFwLT5w
YXJ0IC0gYnAtPnBhcnQ7Cit9CisKIHN0YXRpYyBieV9pZF9lbnRyeSAqCiBieV9pZF9yZWFs
bG9jIChieV9pZF9lbnRyeSAqcCwgc2l6ZV90IG4pCiB7CkBAIC02MTAsOCArNjIxLDkgQEAg
Z2V0X2J5X2lkX3RhYmxlIChieV9pZF9lbnRyeSAqICZ0YWJsZSwgZmhhbmRsZXJfZGV2X2Rp
c2s6OmRldl9kaXNrX2xvY2F0aW9uIGxvYykKICAgaWYgKCF0YWJsZSkKICAgICByZXR1cm4g
KGVycm5vX3NldCA/IC0xIDogMCk7CiAKLSAgLyogU29ydCBieSBuYW1lIGFuZCByZW1vdmUg
ZHVwbGljYXRlcy4gKi8KLSAgcXNvcnQgKHRhYmxlLCB0YWJsZV9zaXplLCBzaXplb2YgKCp0
YWJsZSksIGJ5X2lkX2NvbXBhcmVfbmFtZSk7CisgIC8qIFNvcnQgYnkge25hbWUsIGRyaXZl
LCBwYXJ0fSB0byBlbnN1cmUgc3RhYmxlIHNvcnQgb3JkZXIuICovCisgIHFzb3J0ICh0YWJs
ZSwgdGFibGVfc2l6ZSwgc2l6ZW9mICgqdGFibGUpLCBieV9pZF9jb21wYXJlX25hbWVfZHJp
dmVfcGFydCk7CisgIC8qIE1hcmsgZHVwbGljYXRlIG5hbWVzLiAqLwogICBmb3IgKHVuc2ln
bmVkIGkgPSAwOyBpIDwgdGFibGVfc2l6ZTsgaSsrKQogICAgIHsKICAgICAgIHVuc2lnbmVk
IGogPSBpICsgMTsKQEAgLTYxOSwxMiArNjMxLDEzIEBAIGdldF9ieV9pZF90YWJsZSAoYnlf
aWRfZW50cnkgKiAmdGFibGUsIGZoYW5kbGVyX2Rldl9kaXNrOjpkZXZfZGlza19sb2NhdGlv
biBsb2MpCiAJaisrOwogICAgICAgaWYgKGogPT0gaSArIDEpCiAJY29udGludWU7Ci0gICAg
ICAvKiBEdXBsaWNhdGUocykgZm91bmQsIHJlbW92ZSBhbGwgZW50cmllcyB3aXRoIHRoaXMg
bmFtZS4gKi8KLSAgICAgIGRlYnVnX3ByaW50ZiAoInJlbW92aW5nIGR1cGxpY2F0ZXMgJWQt
JWQ6ICclcyciLCBpLCBqIC0gMSwgdGFibGVbaV0ubmFtZSk7Ci0gICAgICBpZiAoaiA8IHRh
YmxlX3NpemUpCi0JbWVtbW92ZSAodGFibGUgKyBpLCB0YWJsZSArIGosICh0YWJsZV9zaXpl
IC0gaikgKiBzaXplb2YgKCp0YWJsZSkpOwotICAgICAgdGFibGVfc2l6ZSAtPSBqIC0gaTsK
LSAgICAgIGktLTsKKyAgICAgIC8qIER1cGxpY2F0ZShzKSBmb3VuZCwgYXBwZW5kICIjTiIg
dG8gYWxsIGVudHJpZXMuICBUaGlzIG5ldmVyCisJIGludHJvZHVjZXMgbmV3IGR1cGxpY2F0
ZXMgYmVjYXVzZSAnIycgbmV2ZXIgb2NjdXJzIGluIHRoZQorCSBvcmlnaW5hbCBuYW1lcy4g
Ki8KKyAgICAgIGRlYnVnX3ByaW50ZiAoIm1hcmsgZHVwbGljYXRlcyAldS0ldSBvZiAnJXMn
IiwgaSwgaiAtIDEsIHRhYmxlW2ldLm5hbWUpOworICAgICAgc2l6ZV90IGxlbiA9IHN0cmxl
biAodGFibGVbaV0ubmFtZSk7CisgICAgICBmb3IgKHVuc2lnbmVkIGsgPSBpOyBrIDwgajsg
aysrKQorCV9fc21hbGxfc3ByaW50ZiAodGFibGVba10ubmFtZSArIGxlbiwgIiMldSIsIGsg
LSBpKTsKICAgICB9CiAKICAgZGVidWdfcHJpbnRmICgidGFibGVfc2l6ZTogJWQiLCB0YWJs
ZV9zaXplKTsKLS0gCjIuNDIuMQoK
--------------DC5735A48C3AF764F50FD158--
