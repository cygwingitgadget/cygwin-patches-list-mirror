Return-Path: <SRS0=baQu=5R=kmaps.co=evgeny@sourceware.org>
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
	by sourceware.org (Postfix) with ESMTPS id 7AA0E3858D33
	for <cygwin-patches@cygwin.com>; Sun,  9 Nov 2025 21:46:50 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org 7AA0E3858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=kmaps.co
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=kmaps.co
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org 7AA0E3858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=2607:f8b0:4864:20::d34
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1762724810; cv=none;
	b=bLz5MZcAaKCY0GYx1CibahDkv55VjaoUegztAoUuw461IXbyARF669pzCLTUB+6cPiGdnzeCzZd+mdv7vsP7ujI3GKkWzk3qajf686Fwoulm63POtMc8jPMnWjaHiepus1zKQfMjkB5jV+MWD87NG3wXTdgFeyuQyzp62aNeL0A=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1762724810; c=relaxed/simple;
	bh=oRPfFWX/9LpZC4L3n1DQAdfwePTkbTmVzhdVv2y0TF4=;
	h=DKIM-Signature:MIME-Version:From:Date:Message-ID:Subject:To; b=Mx1c7kHZ10PCOGn2lpMeVmxsUHwn0G9wCdyvMTv1yWLwMENjfg+STUy09MQ72UC0AW+A+gdjdYwH95Exik87OsHdTAX1W1PV/1D6ESMquEw30xMiKLxxLolZ7KkLvnvCF8tTzyOjIj1C6Z0szACGVHdWM+030iwm9WsgnEWQqXQ=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org 7AA0E3858D33
Authentication-Results: sourceware.org;
	dkim=pass (2048-bit key, unprotected) header.d=kmaps-co.20230601.gappssmtp.com header.i=@kmaps-co.20230601.gappssmtp.com header.a=rsa-sha256 header.s=20230601 header.b=Id+tLyUV
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-948a023a8f4so14255839f.1
        for <cygwin-patches@cygwin.com>; Sun, 09 Nov 2025 13:46:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kmaps-co.20230601.gappssmtp.com; s=20230601; t=1762724809; x=1763329609; darn=cygwin.com;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+9thFbs6DEF/Drr4pRH/WiRC/wtVglJdSUn/wtnoggM=;
        b=Id+tLyUVkX8MYBLvysOMs17wpru75TKEGMJy2yU9sdXZgDkz+kbq/E2x6VW/n/eROh
         ZGv+by2TLOvl8IXRoCvLGyNr/BzumtEIcbON/qLp1uaWiXkmjMu1tu/Aeq8Nbr/jEDKK
         k+Ia9UePPIQxnY5a8R6jDG5rl1x0oB4CQKxo2UZi3TJjy2uWS1FI8wVfuVVa2RbnjePO
         xIce+rqKedxhM2owUgHFbtikLK3FRurf4Au4cA7cSHT06vThL0WyoKP6G8WunuiuNKPy
         Muveg8WjT1y6pYh9HhsPRTp6AMTHh01ez042bxwhCMil1J/THxjyukY0UjGkthJQazp9
         zndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762724809; x=1763329609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9thFbs6DEF/Drr4pRH/WiRC/wtVglJdSUn/wtnoggM=;
        b=T1Xw1VAD9cdq1DIPg+a2pUVdkxuvVJhcImHMeFoVFV9UREYIvi2tzR1/Q4E+G7RNwm
         1XcLf4IGFlDvAg7GnjqWQBMc/FJbIwc8h22FM8uJDchJM7EziHStEPgluDVYCZou/cbP
         0uNJcrA/ousCrzH6CutLZRIVKLFrplRV+mVVyxQryPBtWf7NmW32YmtMARsuMHmKLTJ4
         5AWcpCXNikOr6jPps2z8WrA7gIOqUX/MFyY6ZSNvIbcrscLyaZ+TUGF1Ff3Qc11qyPOJ
         hYXsTn/W7eCwnQU3PNLaAnrk/3dSqIxeJGItvAOn/hrT/AvqntH+g/saRuRq6p/YCWZ6
         AbCA==
X-Gm-Message-State: AOJu0YwienLRlOlCOnLxmcxoKiYRY/m+13nXpvJzgJBgsF5gk5tOdO/c
	ORpnS/eGuhzP+ETLkLE6+XGc9pa/F3/lzeTOb1aLROXmca1B33XI/QOp/WD+9rN3U51ofMe6WFB
	CQNh/XctKT33lvyw6DHnb8HSM3Z3Pb/WVyC8GOqvzVazchRyjxXtPXbQ=
X-Gm-Gg: ASbGncvnrLLe2odfwg8pYUzPvfpPP6LQ+X+vZAEgAIw82A3C8LE7MJrzU2decQ/kEQo
	4Q52YSDG1gL4WEJZ63BZ3fkB6ZPjkDqhzhdMi/5QSB5lWdP68V/sqrf+4GtHxCY8FnJb+/8yNes
	ZM28iHJDOpkeUK1oHCtsONm5bkkq2CEE8JknLdNQ+O/60MShgs8VO6E4ouosTi9YIh/xmfCrw2X
	0aEp3POhG2iCmWUk+1mv1FyQrlVFZaxT8QAZsjSVV94V+k1vGjeHjxdpKNDMg/SaWR97Qg=
X-Google-Smtp-Source: AGHT+IECvsfeha5jdj1AKMqyIKqqz1ZsW5zOe/2OhV3va7BeEYuSVZBrX29pEgH747u6w5/mzYkalXskvwTciNfVZ3Y=
X-Received: by 2002:a05:6602:29c2:b0:941:15:fb80 with SMTP id
 ca18e2360f4ac-94895fa4ba3mr906180239f.5.1762724809600; Sun, 09 Nov 2025
 13:46:49 -0800 (PST)
MIME-Version: 1.0
References: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
In-Reply-To: <CABd5JDBzuSB2BN0qs4pkHCrCQw3cqLs_OOS7MkzdTBZqph1miQ@mail.gmail.com>
From: Evgeny Karpov <evgeny@kmaps.co>
Date: Sun, 9 Nov 2025 22:46:37 +0100
X-Gm-Features: AWmQ_blMoOnGql67RGzRrScJ1uDcZiyoM1venuoyYXMpQKSAn_kODcrIOzFoehU
Message-ID: <CABd5JDAwxHtbQ3MRasR_nqEPNfB4UF1khYcwOd1kHTkW4txY4A@mail.gmail.com>
Subject: Re: [PATCH] Cygwin: Generalize error handling in gentls_offsets
To: cygwin-patches@cygwin.com
Cc: jon.turney@dronecode.org.uk
Content-Type: multipart/mixed; boundary="0000000000001d1e770643305a6a"
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,DKIM_VALID,GIT_PATCH_0,HTML_MESSAGE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

--0000000000001d1e770643305a6a
Content-Type: multipart/alternative; boundary="0000000000001d1e750643305a68"

--0000000000001d1e750643305a68
Content-Type: text/plain; charset="UTF-8"

>
> It looks like this patch also contains encoding issues.

Here is the correct version.


Regards,
Evgemy

--0000000000001d1e750643305a68--

--0000000000001d1e770643305a6a
Content-Type: text/plain; charset="US-ASCII"; 
	name="0001-Cygwin-Generalize-error-handling-in-gentls_offsets.txt"
Content-Disposition: attachment; 
	filename="0001-Cygwin-Generalize-error-handling-in-gentls_offsets.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_mhs8spkh0>
X-Attachment-Id: f_mhs8spkh0

RnJvbTogRXZnZW55IEthcnBvdiA8ZXZnZW55QGttYXBzLmNvPgpTdWJqZWN0
OiBbUEFUQ0hdIEN5Z3dpbjogR2VuZXJhbGl6ZSBlcnJvciBoYW5kbGluZyBp
biBnZW50bHNfb2Zmc2V0cy5zaAoKVGhlIHBhdGNoIGludHJvZHVjZXMgZXJy
b3IgaGFuZGxpbmcgaW4gZ2VudGxzX29mZnNldHMuc2guCkV4cGxpY2l0IHZh
bGlkYXRpb24gZm9yIHByZXNlbmNlIG9mIGdhd2sgaXMgbm8gbG9uZ2VyIHJl
cXVpcmVkLgotLS0KIHdpbnN1cC9jeWd3aW4vc2NyaXB0cy9nZW50bHNfb2Zm
c2V0cyB8IDEwICsrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvd2luc3Vw
L2N5Z3dpbi9zY3JpcHRzL2dlbnRsc19vZmZzZXRzIGIvd2luc3VwL2N5Z3dp
bi9zY3JpcHRzL2dlbnRsc19vZmZzZXRzCmluZGV4IGJmODRkZDBjYi4uYTM2
NGVhNTdhIDEwMDc1NQotLS0gYS93aW5zdXAvY3lnd2luL3NjcmlwdHMvZ2Vu
dGxzX29mZnNldHMKKysrIGIvd2luc3VwL2N5Z3dpbi9zY3JpcHRzL2dlbnRs
c19vZmZzZXRzCkBAIC00LDE0ICs0LDkgQEAgaW5wdXRfZmlsZT0kMQogb3V0
cHV0X2ZpbGU9JDIKIHRtcF9maWxlPS90bXAvJHtvdXRwdXRfZmlsZX0uJCQK
IAorc2V0IC1lbyBwaXBlZmFpbCAjIGZhaWwgaWYgYW55IGNvbW1hbmQgb3Ig
cGlwZWxpbmUgZmFpbHMKIHRyYXAgInJtIC1mICR7dG1wX2ZpbGV9IiAwIDEg
MiAxNQogCi0jIENoZWNrIGlmIGdhd2sgaXMgYXZhaWxhYmxlCi1pZiAhIGNv
bW1hbmQgLXYgZ2F3ayAmPiAvZGV2L251bGw7IHRoZW4KLSAgICBlY2hvICIk
MDogZ2F3ayBub3QgZm91bmQuIiA+JjIKLSAgICBleGl0IDEKLWZpCi0KICMg
UHJlcHJvY2VzcyBjeWd0bHMuaCBhbmQgZmlsdGVyIG91dCBvbmx5IHRoZSBt
ZW1iZXIgbGluZXMgZnJvbQogIyBjbGFzcyBfY3lndGxzIHRvIGdlbmVyYXRl
IGFuIGlucHV0IGZpbGUgZm9yIHRoZSBjcm9zcyBjb21waWxlcgogIyB0byBn
ZW5lcmF0ZSB0aGUgbWVtYmVyIG9mZnNldHMgZm9yIHRsc29mZnNldHMtJCh0
YXJnZXRfY3B1KS5oLgpAQCAtMjksMTQgKzI0LDEzIEBAIGdhd2sgJwogICB9
CiAgIC9eY2xhc3MgX2N5Z3RscyQvIHsKICAgICAjIE9rLCBidW1wIG1hcmtl
ciwgbmV4dCB3ZSBhcmUgZXhwZWN0aW5nIGEgInB1YmxpYzoiIGxpbmUKLSAg
ICBtYXJrZXI9MTsKKyAgICBpZiAobWFya2VyID09IDApIG1hcmtlcj0xOwog
ICB9CiAgIC9ecHVibGljOi8gewogICAgICMgV2UgYXJlIG9ubHkgaW50ZXJl
c3RlZCBpbiB0aGUgbGluZXMgYmV0d2VlbiB0aGUgZmlyc3QgKG1hcmtlciA9
PSAyKQogICAgICMgYW5kIHRoZSBzZWNvbmQgKG1hcmtlciA9PSAzKSAicHVi
bGljOiIgbGluZSBpbiBjbGFzcyBfY3lndGxzLiAgVGhlc2UKICAgICAjIGFy
ZSB3aGVyZSB0aGUgbWVtYmVycyBhcmUgZGVmaW5lZC4KICAgICBpZiAobWFy
a2VyID4gMCkgKyttYXJrZXI7Ci0gICAgaWYgKG1hcmtlciA+IDIpIGV4aXQ7
CiAgIH0KICAgewogICAgIGlmIChtYXJrZXIgPT0gMiAmJiAkMSAhPSAicHVi
bGljOiIpIHsKLS0gCjIuMzkuNSAoQXBwbGUgR2l0LTE1NCkKCg==

--0000000000001d1e770643305a6a--
