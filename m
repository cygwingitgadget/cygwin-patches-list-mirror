Return-Path: <SRS0=qvI8=HB=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout08.t-online.de (mailout08.t-online.de [194.25.134.20])
	by sourceware.org (Postfix) with ESMTPS id 08E0E3858019
	for <cygwin-patches@cygwin.com>; Mon, 20 Nov 2023 14:54:10 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 08E0E3858019
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 08E0E3858019
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.20
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1700492051; cv=none;
	b=bVPKMelvUT8PAm6DGMYrw1EBQBug+EqCMqxH1vo+m1EaYRp8auh/VTMQeLRw4wszpZXDPlyJBVIVhaADBpO10mHWWCoyPe6ZfeBR8bOo1bHQSGsh1DbmWdGPBdE1lv7ZWyUC47pgpv26WpKBu/yAieuWh5nBsiOPLmnijRJre+s=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1700492051; c=relaxed/simple;
	bh=8RC8bBJsO2wAD7vm0ftL0ydJAhLW9QyURoiYNOrq3g4=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=fKkw/sqA25QgPPykMqq8f7LLRSNSvPD/OBIewnA6E43dVK23314Ez/rDjM/CbQBiUGG/a3YvT3pD85lYBrtTw/fs9yQwFwWVo8SCpmvtlZtTWZ13zkmp7bwLDLe/CVLmm12luX8sxye8I/3y3tJQy5B+qBrOEizE15PuECqMjO4=
ARC-Authentication-Results: i=1; server2.sourceware.org
Received: from fwd86.aul.t-online.de (fwd86.aul.t-online.de [10.223.144.112])
	by mailout08.t-online.de (Postfix) with SMTP id 80EB421362
	for <cygwin-patches@cygwin.com>; Mon, 20 Nov 2023 15:54:08 +0100 (CET)
Received: from [192.168.2.101] ([91.57.240.134]) by fwd86.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1r55f4-2wpK3k0; Mon, 20 Nov 2023 15:54:07 +0100
Subject: Re: [PATCH] Cygwin: Add /dev/disk/by-label and /dev/disk/by-uuid
 symlinks
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
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <0f8c8b7e-8a67-bc0a-24c3-91d28e2f0972@t-online.de>
Date: Mon, 20 Nov 2023 15:54:06 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.16
MIME-Version: 1.0
In-Reply-To: <ZVsrDfTnL6Fy3BfM@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------FB26D4D365C198263E390F30"
X-TOI-EXPURGATEID: 150726::1700492047-A8B6C92A-57FBE6CC/0/0 CLEAN NORMAL
X-TOI-MSGID: cd1f1e56-6146-4c94-aaa2-c1c4b1c601ca
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_BARRACUDACENTRAL,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------FB26D4D365C198263E390F30
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Nov 20 10:40, Corinna Vinschen wrote:
>> Hi Christian,
>>
>> This puzzles me:
>>
>> On Nov 17 21:25, Christian Franke wrote:
>>> @@ -610,7 +607,7 @@ get_by_id_table (by_id_entry * &table, fhandler_dev_disk::dev_disk_location loc)
>>>     if (!table)
>>>       return (errno_set ? -1 : 0);
>>>   
>>> -  /* Sort by name and remove duplicates. */
>>> +  /* Sort by name and mark duplicates. */
>>>     qsort (table, table_size, sizeof (*table), by_id_compare_name);
>>>     for (unsigned i = 0; i < table_size; i++)
>> by_id_compare_name only compars the actual names...
>>
>>>       {
>>> @@ -619,12 +616,13 @@ get_by_id_table (by_id_entry * &table, fhandler_dev_disk::dev_disk_location loc)
>>>   	j++;
>>>         if (j == i + 1)
>>>   	continue;
>>> -      /* Duplicate(s) found, remove all entries with this name. */
>>> -      debug_printf ("removing duplicates %d-%d: '%s'", i, j - 1, table[i].name);
>>> -      if (j < table_size)
>>> -	memmove (table + i, table + j, (table_size - j) * sizeof (*table));
>>> -      table_size -= j - i;
>>> -      i--;
>>> +      /* Duplicate(s) found, append "#N" to all entries.  This never
>> ...but the names are identical.  So the *order* within the identically
>> named entries depends on qsort's reshuffling of table
>> entries.  Which in turn depends on outside factors like number of table
>> entries and the ultimate position of the identical entries within the
>> ordered table.
>>
>> Having said that, I don't see how adding ordinals to the names can be
>> unambiguous.  AFAICS, the numbers may change by just adding another
>> disk (USB Stick) to the system...
> Oops, that's not exactly what I was trying to say, sorry.
>
> The problem is not adding ordinals to the name, AFAICS, the problem is
> that the sorting function by_id_compare_name is not up to the task to
> make sure the order is unambiguous within the entries of identical name.

That's correct, thanks for catching. qsort is not a stable sort. 
Changing drives outside the duplicate range may also change the order 
within the range. Could be fixed by a lexicographic compare of {name, 
drive, part}.

I'll provide a new patch soon. For now, I attached the unrelated but 
important part of the dropped patch.

Christian


--------------FB26D4D365C198263E390F30
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-dev-disk-by-uuid-Fix-NTFS-serial-number-print.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-dev-disk-by-uuid-Fix-NTFS-serial-number-print.pa";
 filename*1="tch"

RnJvbSA2NGM4YTBlYjNlYWQ5MWRlMzZlZTY1NTE2NDgzZTQwY2Y3ZjQ5NDQ2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBNb24sIDIwIE5vdiAyMDIzIDE1OjQwOjQyICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiAvZGV2L2Rpc2svYnktdXVpZDogRml4IE5URlMg
c2VyaWFsIG51bWJlciBwcmludAogZm9ybWF0CgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4g
RnJhbmtlIDxjaHJpc3RpYW4uZnJhbmtlQHQtb25saW5lLmRlPgotLS0KIHdpbnN1cC9jeWd3
aW4vZmhhbmRsZXIvZGV2X2Rpc2suY2MgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyL2Rldl9kaXNrLmNjIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxlci9kZXZfZGlzay5j
YwppbmRleCAwMTZiNGM3YmMuLmM1ZDcyODE2ZiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dp
bi9maGFuZGxlci9kZXZfZGlzay5jYworKysgYi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyL2Rl
dl9kaXNrLmNjCkBAIC0zMDgsNyArMzA4LDcgQEAgcGFydGl0aW9uX3RvX2xhYmVsX29yX3V1
aWQoYm9vbCB1dWlkLCBjb25zdCBVTklDT0RFX1NUUklORyAqZHJpdmVfdW5hbWUsCiAgICAg
ICAmJiBudmRiLT5Wb2x1bWVTZXJpYWxOdW1iZXIuUXVhZFBhcnQpCiAgICAgewogICAgICAg
LyogUHJpbnQgd2l0aG91dCBhbnkgc2VwYXJhdG9yIGFzIG9uIExpbnV4LiAqLwotICAgICAg
X19zbWFsbF9zcHJpbnRmIChuYW1lLCAiJTE2WCIsIG52ZGItPlZvbHVtZVNlcmlhbE51bWJl
ci5RdWFkUGFydCk7CisgICAgICBfX3NtYWxsX3NwcmludGYgKG5hbWUsICIlMDE2WCIsIG52
ZGItPlZvbHVtZVNlcmlhbE51bWJlci5RdWFkUGFydCk7CiAgICAgICBOdENsb3NlKHZvbGhk
bCk7CiAgICAgICByZXR1cm4gdHJ1ZTsKICAgICB9Ci0tIAoyLjQyLjEKCg==
--------------FB26D4D365C198263E390F30--
