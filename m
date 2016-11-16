Return-Path: <cygwin-patches-return-8652-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 98105 invoked by alias); 16 Nov 2016 14:51:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 98082 invoked by uid 89); 16 Nov 2016 14:51:37 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-1.3 required=5.0 tests=AWL,BAYES_00,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_SPAM,SPF_PASS autolearn=no version=3.3.2 spammy=H*Ad:U*cygwin-patches, HTo:U*cygwin-patches
X-HELO: mail-wm0-f41.google.com
Received: from mail-wm0-f41.google.com (HELO mail-wm0-f41.google.com) (74.125.82.41) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Wed, 16 Nov 2016 14:51:36 +0000
Received: by mail-wm0-f41.google.com with SMTP id g23so244610356wme.1        for <cygwin-patches@cygwin.com>; Wed, 16 Nov 2016 06:51:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;        d=1e100.net; s=20130820;        h=x-gm-message-state:mime-version:in-reply-to:references:from:date         :message-id:subject:to;        bh=FeMdj+8N/sMe9OaOx1IfugfrEak+TIwMGP+MpRAFr7Y=;        b=T0gAwvBYmf/sNSZJXCcwTZI0vj0UsZ4KEqsDSnMhhSShXDzLZc6aU+9+buIkPgjU/3         cbtCbNlghaGxLYxjvSGtSv8vNc6ejRKYm94cN5/HWCKdpc4JfkJtYxeRFqr+ytLpp8kt         smH40VSuKPjxSNy2cVtD6i38QJ61ROfSJ/MpdJ8HpnCvkFymQKmBWFnbFKoXxsnihIvI         MPZ6pdcfdPfCyWFKkz/AEUPZ13d3UUt138Bvpv7WMrQgvUwqeE4xXGVs4zfuvHDc8/pO         6YegY9NQLDIGqaVNCksOZYMTgmAzMFCdNZEQU2CbMOzWP7w1KmTub8l8ST+anbpF/alM         VDxQ==
X-Gm-Message-State: ABUngvc/HgineBLIijLUj6wXx2NIgS9PlvBQxv4AgpO2ixOMBH+DdmdM2k6k982WtakL+0Udk2RKQS05tq2tnA==
X-Received: by 10.28.163.5 with SMTP id m5mr10572655wme.98.1479307894127; Wed, 16 Nov 2016 06:51:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.151.145 with HTTP; Wed, 16 Nov 2016 06:51:33 -0800 (PST)
In-Reply-To: <6f461a14-f503-1aa1-e417-a5b4b24606bc@redhat.com>
References: <CAOTD34ZMkY=Sfp6-8AFDg_Q=7NZB2oS+=QthfWauoboP6=szfg@mail.gmail.com> <20161115145849.GA25086@calimero.vinschen.de> <CAOTD34ajMRiL0RMJTrVvzK8bMwAta3XJ8Pi7sk27ww1B4HLp3Q@mail.gmail.com> <20161115161955.GD25086@calimero.vinschen.de> <CAOTD34Y=YeufL-kYHUsrQg1oWOdk3F_-Z+H6GSiadRXJ9LuRwA@mail.gmail.com> <6f461a14-f503-1aa1-e417-a5b4b24606bc@redhat.com>
From: Erik Bray <erik.m.bray@gmail.com>
Date: Wed, 16 Nov 2016 14:51:00 -0000
Message-ID: <CAOTD34biu0cNj5g7yS0GhUX2zTs6JDpdrvnFJ9knwPZMKJMzGw@mail.gmail.com>
Subject: Re: Return the correct value for sysconf(_SC_PAGESIZE)
To: cygwin-patches@cygwin.com
Content-Type: multipart/mixed; boundary=001a114cde248b435c05416c35f3
X-IsSubscribed: yes
X-SW-Source: 2016-q4/txt/msg00010.txt.bz2


--001a114cde248b435c05416c35f3
Content-Type: text/plain; charset=UTF-8
Content-length: 1543

On Wed, Nov 16, 2016 at 3:01 PM, Eric Blake <eblake@redhat.com> wrote:
> On 11/16/2016 07:56 AM, Erik Bray wrote:
>
>>> There is no good reason to use the non-POSIXy page size.  It doesn't
>>> help you in the least for any pagesize-related functionality.  Mmap
>>> as well as malloc and friends only work with _SC_PAGESIZE sized pages.
>>>
>>> It sounds as if you're looking for a solution for which there's no
>>> problem...
>>
>>
>> FWIW the background here is that I'm working on porting psutil [1] to
>> Cygwin, and trying to accomplish as much as *possible* through the
>> POSIX interfaces without having to fall back on the Windows API.  It's
>> actually a great exercise in what is and isn't possible with Cygwin :)
>>
>> In this case I was trying to compute process memory usage from
>> /proc/<pid>/statm which gives values in page counts, so I need the
>> page size (the actual page size) to compute the values in bytes.
>
> If /proc/<pid>/statm is reporting memory in multiples that are not the
> POSIX _SC_PAGESIZE, that is a bug in the statm file emulation that
> should be fixed there.

So then something like that attached (untested) patch should work,
though it made statm inconsistent with what is reported in
/proc/<pid>/status which reports memory in multiples of page size.  So
that has to be patched as well.

This of course leads to memory reporting that is inconsistent with
what Windows says.  But I guess if that's "normal" in Cygwin (for the
reasons stated by Corinna) then it's an acceptable trade-off?

Thanks,
Erik

--001a114cde248b435c05416c35f3
Content-Type: application/octet-stream; 
	name="0001-statm-should-report-memory-as-multiples-of-allocatio.patch"
Content-Disposition: attachment; 
	filename="0001-statm-should-report-memory-as-multiples-of-allocatio.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivl1pii31
Content-length: 1932

RnJvbSA5ZTVhNGFiOTllZWExMGQxYTY1ZTIyZmJiMTMyNDdmN2FlMzA3ODQw
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiRXJpayBNLiBCcmF5
IiA8ZXJpay5icmF5QGxyaS5mcj4KRGF0ZTogV2VkLCAxNiBOb3YgMjAxNiAx
NTozNjo0MSArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMS8yXSBzdGF0bSBzaG91
bGQgcmVwb3J0IG1lbW9yeSBhcyBtdWx0aXBsZXMgb2YKIGFsbG9jYXRpb25f
Z3JhbnVsYXJpdHkgaW5zdGVhZCBvZiBwYWdlX3NpemUKCnRoYXQgZW5zdXJl
cyB0aGF0IHZhbHVlcyBpbiBzdGF0bSBtdXBsdGlwbGllZCBieSBQT1NJWCBf
U0NfUEFHRVNJWkUgZ2l2ZSB0aGUgY29ycmVjdCB2YWx1ZXMKLS0tCiB3aW5z
dXAvY3lnd2luL2ZoYW5kbGVyX3Byb2Nlc3MuY2MgfCA2ICsrKysrLQogMSBm
aWxlIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoK
ZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcHJvY2Vzcy5j
YyBiL3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcHJvY2Vzcy5jYwppbmRleCAw
MmY3Y2EwLi5jNTY5OGMzIDEwMDY0NAotLS0gYS93aW5zdXAvY3lnd2luL2Zo
YW5kbGVyX3Byb2Nlc3MuY2MKKysrIGIvd2luc3VwL2N5Z3dpbi9maGFuZGxl
cl9wcm9jZXNzLmNjCkBAIC0xMjUxLDEyICsxMjUxLDE2IEBAIGZvcm1hdF9w
cm9jZXNzX3N0YXRtICh2b2lkICpkYXRhLCBjaGFyIComZGVzdGJ1ZikKICAg
X3BpbmZvICpwID0gKF9waW5mbyAqKSBkYXRhOwogICB1bnNpZ25lZCBsb25n
IHZtc2l6ZSA9IDBVTCwgdm1yc3MgPSAwVUwsIHZtdGV4dCA9IDBVTCwgdm1k
YXRhID0gMFVMLAogCQl2bWxpYiA9IDBVTCwgdm1zaGFyZSA9IDBVTDsKKyAg
c2l6ZV90IHBhZ2Vfc2NhbGU7CiAgIGlmICghZ2V0X21lbV92YWx1ZXMgKHAt
PmR3UHJvY2Vzc0lkLCAmdm1zaXplLCAmdm1yc3MsICZ2bXRleHQsICZ2bWRh
dGEsCiAJCSAgICAgICAmdm1saWIsICZ2bXNoYXJlKSkKICAgICByZXR1cm4g
MDsKKworICBwYWdlX3NjYWxlID0gd2luY2FwLmFsbG9jYXRpb25fZ3JhbnVs
YXJpdHkoKSAvIHdpbmNhcC5wYWdlX3NpemUoKTsKICAgZGVzdGJ1ZiA9IChj
aGFyICopIGNyZWFsbG9jX2Fib3J0IChkZXN0YnVmLCA5Nik7CiAgIHJldHVy
biBfX3NtYWxsX3NwcmludGYgKGRlc3RidWYsICIlbGQgJWxkICVsZCAlbGQg
JWxkICVsZCAwXG4iLAotCQkJICB2bXNpemUsIHZtcnNzLCB2bXNoYXJlLCB2
bXRleHQsIHZtbGliLCB2bWRhdGEpOworICAgICAgICAgICAgICB2bXNpemUg
LyBwYWdlX3NjYWxlLCB2bXJzcyAvIHBhZ2Vfc2NhbGUsIHZtc2hhcmUgLyBw
YWdlX3NjYWxlLAorICAgICAgICAgICAgICB2bXRleHQgLyBwYWdlX3NjYWxl
LCB2bWxpYiAvIHBhZ2Vfc2NhbGUsIHZtZGF0YSAvIHBhZ2Vfc2NhbGUpOwog
fQogCiBleHRlcm4gIkMiIHsKLS0gCjIuOC4zCgo=

--001a114cde248b435c05416c35f3
Content-Type: application/octet-stream; 
	name="0002-Use-allocation-granularity-as-the-page_size-in-proc-.patch"
Content-Disposition: attachment; 
	filename="0002-Use-allocation-granularity-as-the-page_size-in-proc-.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ivl1pii92
Content-length: 1452

RnJvbSAxYTY1ZGM1ZWIwNTFiNTYzNWY5NjZkNTVkMzAyYWYzNmQ1MWUzYWJl
IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQpGcm9tOiAiRXJpayBNLiBCcmF5
IiA8ZXJpay5icmF5QGxyaS5mcj4KRGF0ZTogV2VkLCAxNiBOb3YgMjAxNiAx
NTo1MDozNCArMDEwMApTdWJqZWN0OiBbUEFUQ0ggMi8yXSBVc2UgYWxsb2Nh
dGlvbiBncmFudWxhcml0eSBhcyB0aGUgJ3BhZ2Vfc2l6ZScgaW4KIC9wcm9j
LzxwaWQ+L3N0YXR1cyBhcyB3ZWxsLCBmb3IgY29uc2lzdGVuY3kgd2l0aCAv
cHJvYy88cGlkPi9zdGF0bQoKLS0tCiB3aW5zdXAvY3lnd2luL2ZoYW5kbGVy
X3Byb2Nlc3MuY2MgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL2ZoYW5kbGVyX3Byb2Nlc3MuY2MgYi93aW5zdXAvY3lnd2luL2ZoYW5k
bGVyX3Byb2Nlc3MuY2MKaW5kZXggYzU2OThjMy4uNWY1MzBhMiAxMDA2NDQK
LS0tIGEvd2luc3VwL2N5Z3dpbi9maGFuZGxlcl9wcm9jZXNzLmNjCisrKyBi
L3dpbnN1cC9jeWd3aW4vZmhhbmRsZXJfcHJvY2Vzcy5jYwpAQCAtMTIwOCw3
ICsxMjA4LDcgQEAgZm9ybWF0X3Byb2Nlc3Nfc3RhdHVzICh2b2lkICpkYXRh
LCBjaGFyIComZGVzdGJ1ZikKICAgaWYgKCFnZXRfbWVtX3ZhbHVlcyAocC0+
ZHdQcm9jZXNzSWQsICZ2bXNpemUsICZ2bXJzcywgJnZtdGV4dCwgJnZtZGF0
YSwKIAkJICAgICAgICZ2bWxpYiwgJnZtc2hhcmUpKQogICAgIHJldHVybiAw
OwotICB1bnNpZ25lZCBwYWdlX3NpemUgPSB3aW5jYXAucGFnZV9zaXplICgp
OworICB1bnNpZ25lZCBwYWdlX3NpemUgPSB3aW5jYXAuYWxsb2NhdGlvbl9n
cmFudWxhcml0eSAoKTsKICAgdm1zaXplICo9IHBhZ2Vfc2l6ZTsgdm1yc3Mg
Kj0gcGFnZV9zaXplOyB2bWRhdGEgKj0gcGFnZV9zaXplOwogICB2bXRleHQg
Kj0gcGFnZV9zaXplOyB2bWxpYiAqPSBwYWdlX3NpemU7CiAgIC8qIFRoZSBy
ZWFsIHVpZCB2YWx1ZSBmb3IgKnRoaXMqIHByb2Nlc3MgaXMgc3RvcmVkIGF0
IGN5Z2hlYXAtPnVzZXIucmVhbF91aWQKLS0gCjIuOC4zCgo=

--001a114cde248b435c05416c35f3--
