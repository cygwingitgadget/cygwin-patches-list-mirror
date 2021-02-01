Return-Path: <mara.smetana@gmail.com>
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by sourceware.org (Postfix) with ESMTPS id 837593836C72
 for <cygwin-patches@cygwin.com>; Mon,  1 Feb 2021 21:26:31 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.3.2 sourceware.org 837593836C72
Received: by mail-wr1-x42d.google.com with SMTP id z6so18148602wrq.10
 for <cygwin-patches@cygwin.com>; Mon, 01 Feb 2021 13:26:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=Gdjwz1hEHR8BvF8bfL0+BWV7eSur4PCSIDAbKCuhvsA=;
 b=pTiRt6A6YliD5lbThSz+I/SEfFuN6CYk8AxKvlFJ9Mph0YO0hC3Ju0MwWsSYPXvUmy
 ZnMd+qbdtV/2+7gmgg3ni6If5l24C9T2h6E1hJjuP7vWAr741W7Ki0vea6uHMSGwSA0R
 ttSBy49EgFCb6XYcLiR/95UnLLqvat5wj41ORAxl8IQ7BmaR5hpMXBhvG+JXJPCldfFM
 vQvtVmBA8Ch5o1jhBKa1QK/t3+pvHeMmdrOx+asl7OSfjgPtvJuz6Uos4IcycpY7OXXy
 sI+vKfxH6lAPwUMuX596LKqMf0Ykm/aoDqHRSmXF4UArjFQufOXir9LhMMCwT4Y9DoN4
 QgFA==
X-Gm-Message-State: AOAM530oEQzgCCQ4SVo8BgAwRthC48wFn3e7DVtloMrjgFfVBu8vOMA6
 pxN6RxhP0lyigWWnHkT8p6MBtmbmWNRvIw==
X-Google-Smtp-Source: ABdhPJzgstGP1sORwj8L6PPRk9ZzPIUQGxnYFmXPpl6QMKhW9IuS4V2s8C85XBcAItL6E5+rcrT33w==
X-Received: by 2002:adf:c413:: with SMTP id v19mr20325232wrf.158.1612214790615; 
 Mon, 01 Feb 2021 13:26:30 -0800 (PST)
Received: from [192.168.2.166] ([188.120.201.247])
 by smtp.gmail.com with ESMTPSA id r25sm30528703wrr.64.2021.02.01.13.26.29
 for <cygwin-patches@cygwin.com>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Feb 2021 13:26:30 -0800 (PST)
Subject: Re: fhandler_serial.cc: MARK and SPACE parity for serial port
To: cygwin-patches@cygwin.com
References: <CAGEXLhUUtV-kKxO-jQo4427R=N=Uo1aT_LrHGpc1r55umbb92w@mail.gmail.com>
 <20210128100802.GW4393@calimero.vinschen.de>
 <20210128101429.GX4393@calimero.vinschen.de>
 <4d88d636-8274-5dea-67f8-f224a63b49a9@gmail.com>
 <20210201094009.GD375565@calimero.vinschen.de>
From: Marek Smetana <mara.smetana@gmail.com>
Message-ID: <ff9e2845-7a5c-945c-f742-a79d65ab5909@gmail.com>
Date: Mon, 1 Feb 2021 22:26:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210201094009.GD375565@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------D47AC0DC7DFB0D080BAD40CD"
Content-Language: cs
X-Spam-Status: No, score=-13.0 required=5.0 tests=BAYES_00, DKIM_SIGNED,
 DKIM_VALID, DKIM_VALID_AU, DKIM_VALID_EF, FREEMAIL_FROM, GIT_PATCH_0,
 NICE_REPLY_A, RCVD_IN_DNSWL_NONE, SPF_HELO_NONE, SPF_PASS,
 TXREP autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on
 server2.sourceware.org
X-BeenThere: cygwin-patches@cygwin.com
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Cygwin core component patch submission and discussion
 <cygwin-patches.cygwin.com>
List-Unsubscribe: <https://cygwin.com/mailman/options/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=unsubscribe>
List-Archive: <https://cygwin.com/pipermail/cygwin-patches/>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Help: <mailto:cygwin-patches-request@cygwin.com?subject=help>
List-Subscribe: <https://cygwin.com/mailman/listinfo/cygwin-patches>,
 <mailto:cygwin-patches-request@cygwin.com?subject=subscribe>
X-List-Received-Date: Mon, 01 Feb 2021 21:26:33 -0000

This is a multi-part message in MIME format.
--------------D47AC0DC7DFB0D080BAD40CD
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

I'm Sorry, this is my first patch using the mailing list.

Best regards

Marek


--------------D47AC0DC7DFB0D080BAD40CD
Content-Type: text/plain; charset=UTF-8;
 name="0001-fhandler_serial.cc-MARK-and-SPACE-parity-for-serial-.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-fhandler_serial.cc-MARK-and-SPACE-parity-for-serial-.pa";
 filename*1="tch"

RnJvbSBiZTc3YTI3YmQ0MGRhNTYwNjRmMTJhNzJjMThkNDM0ZGRiNjQwM2RjIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBNYXJlayBTbWV0YW5hIDxtYXJhLnNtZXRhbmFAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDEgRmViIDIwMjEgMjI6MDI6MTQgKzAxMDAKU3ViamVjdDog
W1BBVENIXSBmaGFuZGxlcl9zZXJpYWwuY2M6IE1BUksgYW5kIFNQQUNFIHBhcml0eSBmb3Ig
c2VyaWFsIHBvcnQKCi0tLQogd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9zZXJpYWwuY2MgICAg
fCAxMSArKysrKysrKysrLQogd2luc3VwL2N5Z3dpbi9pbmNsdWRlL3N5cy90ZXJtaW9zLmgg
fCAgMSArCiAyIGZpbGVzIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3NlcmlhbC5jYyBiL3dp
bnN1cC9jeWd3aW4vZmhhbmRsZXJfc2VyaWFsLmNjCmluZGV4IGZkNWI0NTg5OS4uZTAyNTcz
MDJjIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3NlcmlhbC5jYworKysg
Yi93aW5zdXAvY3lnd2luL2ZoYW5kbGVyX3NlcmlhbC5jYwpAQCAtNzI3LDcgKzcyNywxMiBA
QCBmaGFuZGxlcl9zZXJpYWw6OnRjc2V0YXR0ciAoaW50IGFjdGlvbiwgY29uc3Qgc3RydWN0
IHRlcm1pb3MgKnQpCiAgIC8qIC0tLS0tLS0tLS0tLS0tIFNldCBwYXJpdHkgLS0tLS0tLS0t
LS0tLS0tLS0tICovCiAKICAgaWYgKHQtPmNfY2ZsYWcgJiBQQVJFTkIpCi0gICAgc3RhdGUu
UGFyaXR5ID0gKHQtPmNfY2ZsYWcgJiBQQVJPREQpID8gT0REUEFSSVRZIDogRVZFTlBBUklU
WTsKKyAgICB7CisgICAgICBpZih0LT5jX2NmbGFnICYgQ01TUEFSKQorICAgICAgICBzdGF0
ZS5QYXJpdHkgPSAodC0+Y19jZmxhZyAmIFBBUk9ERCkgPyBNQVJLUEFSSVRZIDogU1BBQ0VQ
QVJJVFk7CisgICAgICBlbHNlCisgICAgICAgIHN0YXRlLlBhcml0eSA9ICh0LT5jX2NmbGFn
ICYgUEFST0REKSA/IE9ERFBBUklUWSA6IEVWRU5QQVJJVFk7CisgICAgfQogICBlbHNlCiAg
ICAgc3RhdGUuUGFyaXR5ID0gTk9QQVJJVFk7CiAKQEAgLTEwNjgsNiArMTA3MywxMCBAQCBm
aGFuZGxlcl9zZXJpYWw6OnRjZ2V0YXR0ciAoc3RydWN0IHRlcm1pb3MgKnQpCiAgICAgdC0+
Y19jZmxhZyB8PSAoUEFSRU5CIHwgUEFST0REKTsKICAgaWYgKHN0YXRlLlBhcml0eSA9PSBF
VkVOUEFSSVRZKQogICAgIHQtPmNfY2ZsYWcgfD0gUEFSRU5COworICBpZiAoc3RhdGUuUGFy
aXR5ID09IE1BUktQQVJJVFkpCisgICAgdC0+Y19jZmxhZyB8PSAoUEFSRU5CIHwgUEFST0RE
IHwgQ01TUEFSKTsKKyAgaWYgKHN0YXRlLlBhcml0eSA9PSBTUEFDRVBBUklUWSkKKyAgICB0
LT5jX2NmbGFnIHw9IChQQVJFTkIgfCBDTVNQQVIpOwogCiAgIC8qIC0tLS0tLS0tLS0tLS0t
IFBhcml0eSBlcnJvcnMgLS0tLS0tLS0tLS0tLS0tLS0tICovCiAKZGlmZiAtLWdpdCBhL3dp
bnN1cC9jeWd3aW4vaW5jbHVkZS9zeXMvdGVybWlvcy5oIGIvd2luc3VwL2N5Z3dpbi9pbmNs
dWRlL3N5cy90ZXJtaW9zLmgKaW5kZXggMTdlOGQ4M2EzLi5lNDQ2NWZjYTMgMTAwNjQ0Ci0t
LSBhL3dpbnN1cC9jeWd3aW4vaW5jbHVkZS9zeXMvdGVybWlvcy5oCisrKyBiL3dpbnN1cC9j
eWd3aW4vaW5jbHVkZS9zeXMvdGVybWlvcy5oCkBAIC0yMDYsNiArMjA2LDcgQEAgUE9TSVgg
Y29tbWFuZHMgKi8KIAogI2RlZmluZSBDUlRTWE9GRiAweDA0MDAwCiAjZGVmaW5lIENSVFND
VFMJIDB4MDgwMDAKKyNkZWZpbmUgQ01TUEFSCSAweDQwMDAwMDAwIC8qIE1hcmsgb3Igc3Bh
Y2UgKHN0aWNrKSBwYXJpdHkuICAqLwogCiAvKiBsZmxhZyBiaXRzICovCiAjZGVmaW5lIElT
SUcJMHgwMDAxCi0tIAoyLjMwLjAKCg==
--------------D47AC0DC7DFB0D080BAD40CD--
