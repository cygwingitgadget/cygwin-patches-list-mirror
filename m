Return-Path: <SRS0=rY8d=TE=t-online.de=Christian.Franke@sourceware.org>
Received: from mailout02.t-online.de (mailout02.t-online.de [194.25.134.17])
	by sourceware.org (Postfix) with ESMTPS id B50803858D33
	for <cygwin-patches@cygwin.com>; Wed, 11 Dec 2024 11:50:45 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.2 sourceware.org B50803858D33
Authentication-Results: sourceware.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=pass smtp.mailfrom=t-online.de
ARC-Filter: OpenARC Filter v1.0.0 sourceware.org B50803858D33
Authentication-Results: server2.sourceware.org; arc=none smtp.remote-ip=194.25.134.17
ARC-Seal: i=1; a=rsa-sha256; d=sourceware.org; s=key; t=1733917845; cv=none;
	b=i46/bmMs7VrVDkz3hsr3Fdn0SCNsFg8FGdsnBl4waobfS7ptAOQveaKPHkFdORTkdNYgUrTNh5CMNs2fd5Az9KzKcxET86jFlPGrPRjJ2qBX3Sjj1M7R6CdRMKAdtPpDseEr9iwqPF9lXIbaXJDtHIIq8kC/FkKeN8mIMpA0T5o=
ARC-Message-Signature: i=1; a=rsa-sha256; d=sourceware.org; s=key;
	t=1733917845; c=relaxed/simple;
	bh=1Ri2X43kxHwz6gu+EWr2yV+U1F4KE0bOG/DRHCBtE6o=;
	h=Subject:To:From:Message-ID:Date:MIME-Version; b=clTQ4YGUk+1fqEoShM8EPDWs0+r6YApVT1WkPoF69P9ooh45NTNaTwm12U3vRIh1xfFL8Vo5JR6yv6vY8cK2yRrELC9eeP+f+A+ABVa0JEPbaLXB2EY0ADK11dBzI3MQklqQyZ1UixhYD5ogihRIKsDsAaAldpCKjyd7BTIz4Pg=
ARC-Authentication-Results: i=1; server2.sourceware.org
DKIM-Filter: OpenDKIM Filter v2.11.0 sourceware.org B50803858D33
Received: from fwd89.aul.t-online.de (fwd89.aul.t-online.de [10.223.144.115])
	by mailout02.t-online.de (Postfix) with SMTP id 2240B167E
	for <cygwin-patches@cygwin.com>; Wed, 11 Dec 2024 12:50:44 +0100 (CET)
Received: from [192.168.2.103] ([91.57.250.70]) by fwd89.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1tLLEn-2iBbcG0; Wed, 11 Dec 2024 12:50:41 +0100
Subject: Re: [PATCH] Cygwin: sched_setscheduler: accept SCHED_BATCH
To: cygwin-patches@cygwin.com
References: <3a052da3-f60e-1d7a-f741-956926af23da@t-online.de>
 <Z1bEgYIYR43Jn45A@calimero.vinschen.de>
 <9362a9a5-2ec9-0c89-9d2a-5b5f357857ad@t-online.de>
 <14b59939-ef50-60d8-ac6c-bf6c0afb8dac@t-online.de>
 <8e7d7da6-bdca-7b36-fb7f-497b403a4fc1@t-online.de>
 <Z1ic2vQnjnlcJ2A_@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Reply-To: cygwin-patches@cygwin.com
Message-ID: <ae82e449-65b7-3153-517d-f1b8f107439c@t-online.de>
Date: Wed, 11 Dec 2024 12:50:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 SeaMonkey/2.53.19
MIME-Version: 1.0
In-Reply-To: <Z1ic2vQnjnlcJ2A_@calimero.vinschen.de>
Content-Type: multipart/mixed;
 boundary="------------2714DA07575CDBCBD8958522"
X-TOI-EXPURGATEID: 150726::1733917841-44E71A55-2880486E/0/0 CLEAN NORMAL
X-TOI-MSGID: 1a064ad0-2192-4f7d-9a47-dc78d24f0240
X-Spam-Status: No, score=-12.2 required=5.0 tests=BAYES_00,FREEMAIL_FROM,GIT_PATCH_0,KAM_DMARC_STATUS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,TXREP autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on server2.sourceware.org
List-Id: <cygwin-patches.cygwin.com>

This is a multi-part message in MIME format.
--------------2714DA07575CDBCBD8958522
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> Hi Christian,
>
> On Dec 10 15:16, Christian Franke wrote:
>> +  /* Handle SCHED_RESET_ON_FORK flag. */
>> +  if (myself->sched_reset_on_fork)
>> +    {
>> +      bool batch = (myself->sched_policy == SCHED_BATCH);
>> +      bool idle = (myself->sched_policy == SCHED_IDLE);
>> +      bool set_prio = false;
>> +      /* Reset negative nice values to zero. */
>> +      if (myself->nice < 0)
>> +	{
>> +	  child->nice = 0;
>> +	  set_prio = !idle;
>> +	}
>> +      /* Reset realtime policies to SCHED_OTHER. */
>> +      if (!(myself->sched_policy == SCHED_OTHER || batch || idle))
>> +	{
>> +	  child->sched_policy = SCHED_OTHER;
>> +	  set_prio = true;
>> +	}
>> +      /* Adjust Windows priority if required. */
>> +      if (set_prio)
>> +	{
>> +	  HANDLE proc = OpenProcess(PROCESS_SET_INFORMATION |
>> +				    PROCESS_QUERY_LIMITED_INFORMATION,
>> +				    FALSE, child->dwProcessId);
>> +	  if (proc)
>> +	    {
>> +	      set_and_check_winprio(proc, nice_to_winprio(child->nice, batch));
>> +	      CloseHandle(proc);
>> +	    }
>> +	}
>> +    }
>> +  child->sched_reset_on_fork = false;
>> +
> Is it really necessary to go to such length here?  For one thing, we
> have hchild aka pi.hProcess, which should have all access rights on the
> child.  Otherwise, the priority of the child process can be set in the
> dwCreationFlags parameter, called `c_flags' in frok::parent().  See line
> 215 in fork.cc.

A new patch setting c_flags directly is attached.

> In terms of the SCHED_BATCH value, I'm not going to wait much longer.
> If there's no reply on the newlib list tomorrow, I'll push your patch
> with SCHED_BATCH set to 6.
>
>
> Thanks,
> Corinna
>


--------------2714DA07575CDBCBD8958522
Content-Type: text/plain; charset=UTF-8;
 name="0001-Cygwin-sched_setscheduler-accept-SCHED_RESET_ON_FORK.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename*0="0001-Cygwin-sched_setscheduler-accept-SCHED_RESET_ON_FORK.pa";
 filename*1="tch"

RnJvbSA4OWRmZTYyZGRhYTE2MmIzZWI5MTFhNDJiNjM1YWQyNzY5NDcwY2YyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBXZWQsIDExIERlYyAyMDI0IDEyOjQ4OjU4ICswMTAw
ClN1YmplY3Q6IFtQQVRDSF0gQ3lnd2luOiBzY2hlZF9zZXRzY2hlZHVsZXI6IGFjY2VwdCBT
Q0hFRF9SRVNFVF9PTl9GT1JLIGZsYWcKCkFkZCBTQ0hFRF9SRVNFVF9PTl9GT1JLIHRvIDxz
eXMvc2NoZWQuaD4uICBJZiB0aGlzIGZsYWcgaXMgc2V0LCBTQ0hFRF9GSUZPCmFuZCBTQ0hF
RF9SUiBhcmUgcmVzZXQgdG8gU0NIRURfT1RIRVIgYW5kIG5lZ2F0aXZlIG5pY2UgdmFsdWVz
IGFyZSByZXNldCB0bwp6ZXJvIGluIGVhY2ggY2hpbGQgcHJvY2VzcyBjcmVhdGVkIHdpdGgg
Zm9yaygyKS4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBGcmFua2UgPGNocmlzdGlhbi5m
cmFua2VAdC1vbmxpbmUuZGU+Ci0tLQogbmV3bGliL2xpYmMvaW5jbHVkZS9zeXMvc2NoZWQu
aCAgICAgIHwgIDMgKysrCiB3aW5zdXAvY3lnd2luL2ZvcmsuY2MgICAgICAgICAgICAgICAg
fCAzNyArKysrKysrKysrKysrKysrKysrKysrKysrLS0tCiB3aW5zdXAvY3lnd2luL2xvY2Fs
X2luY2x1ZGVzL3BpbmZvLmggfCAgNSArKy0tCiB3aW5zdXAvY3lnd2luL3BpbmZvLmNjICAg
ICAgICAgICAgICAgfCAgMSArCiB3aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAgICAgICAg
ICAgfCAgMyArKysKIHdpbnN1cC9jeWd3aW4vc2NoZWQuY2MgICAgICAgICAgICAgICB8IDEx
ICsrKysrKy0tLQogd2luc3VwL2N5Z3dpbi9zcGF3bi5jYyAgICAgICAgICAgICAgIHwgIDEg
KwogNyBmaWxlcyBjaGFuZ2VkLCA1MiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL25ld2xpYi9saWJjL2luY2x1ZGUvc3lzL3NjaGVkLmggYi9uZXdsaWIv
bGliYy9pbmNsdWRlL3N5cy9zY2hlZC5oCmluZGV4IDY5NzdkM2Q0YS4uOTU1MDlkYmYwIDEw
MDY0NAotLS0gYS9uZXdsaWIvbGliYy9pbmNsdWRlL3N5cy9zY2hlZC5oCisrKyBiL25ld2xp
Yi9saWJjL2luY2x1ZGUvc3lzL3NjaGVkLmgKQEAgLTQ1LDYgKzQ1LDkgQEAgZXh0ZXJuICJD
IiB7CiAjaWYgX19HTlVfVklTSUJMRQogI2RlZmluZSBTQ0hFRF9JRExFICAgICA1CiAjZGVm
aW5lIFNDSEVEX0JBVENIICAgIDYKKworLyogRmxhZyB0byBkcm9wIHJlYWx0aW1lIHBvbGlj
aWVzIGFuZCBuZWdhdGl2ZSBuaWNlIHZhbHVlcyBvbiBmb3JrKCkuICovCisjZGVmaW5lIFND
SEVEX1JFU0VUX09OX0ZPUksgICAgIDB4NDAwMDAwMDAKICNlbmRpZgogCiAvKiBTY2hlZHVs
aW5nIFBhcmFtZXRlcnMgKi8KZGlmZiAtLWdpdCBhL3dpbnN1cC9jeWd3aW4vZm9yay5jYyBi
L3dpbnN1cC9jeWd3aW4vZm9yay5jYwppbmRleCA3ZDk3NmU4ODIuLjQxYTUzMzcwNSAxMDA2
NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9mb3JrLmNjCisrKyBiL3dpbnN1cC9jeWd3aW4vZm9y
ay5jYwpAQCAtMjEyLDcgKzIxMiwzNyBAQCBmcm9rOjpwYXJlbnQgKHZvbGF0aWxlIGNoYXIg
KiB2b2xhdGlsZSBzdGFja19oZXJlKQogICBib29sIGZpeF9pbXBlcnNvbmF0aW9uID0gZmFs
c2U7CiAgIHBpbmZvIGNoaWxkOwogCi0gIGludCBjX2ZsYWdzID0gR2V0UHJpb3JpdHlDbGFz
cyAoR2V0Q3VycmVudFByb2Nlc3MgKCkpOworICAvKiBJbmhlcml0IHNjaGVkdWxpbmcgcGFy
YW1ldGVycyBieSBkZWZhdWx0LiAqLworICBpbnQgY2hpbGRfbmljZSA9IG15c2VsZi0+bmlj
ZTsKKyAgaW50IGNoaWxkX3NjaGVkX3BvbGljeSA9IG15c2VsZi0+c2NoZWRfcG9saWN5Owor
ICBpbnQgY19mbGFncyA9IDA7CisKKyAgLyogSGFuZGxlIFNDSEVEX1JFU0VUX09OX0ZPUksg
ZmxhZy4gKi8KKyAgaWYgKG15c2VsZi0+c2NoZWRfcmVzZXRfb25fZm9yaykKKyAgICB7Cisg
ICAgICBib29sIGJhdGNoID0gKG15c2VsZi0+c2NoZWRfcG9saWN5ID09IFNDSEVEX0JBVENI
KTsKKyAgICAgIGJvb2wgaWRsZSA9IChteXNlbGYtPnNjaGVkX3BvbGljeSA9PSBTQ0hFRF9J
RExFKTsKKyAgICAgIGJvb2wgc2V0X3ByaW8gPSBmYWxzZTsKKyAgICAgIC8qIFJlc2V0IG5l
Z2F0aXZlIG5pY2UgdmFsdWVzIHRvIHplcm8uICovCisgICAgICBpZiAobXlzZWxmLT5uaWNl
IDwgMCkKKwl7CisJICBjaGlsZF9uaWNlID0gMDsKKwkgIHNldF9wcmlvID0gIWlkbGU7CisJ
fQorICAgICAgLyogUmVzZXQgcmVhbHRpbWUgcG9saWNpZXMgdG8gU0NIRURfT1RIRVIuICov
CisgICAgICBpZiAoIShteXNlbGYtPnNjaGVkX3BvbGljeSA9PSBTQ0hFRF9PVEhFUiB8fCBi
YXRjaCB8fCBpZGxlKSkKKwl7CisJICBjaGlsZF9zY2hlZF9wb2xpY3kgPSBTQ0hFRF9PVEhF
UjsKKwkgIHNldF9wcmlvID0gdHJ1ZTsKKwl9CisgICAgICBpZiAoc2V0X3ByaW8pCisJY19m
bGFncyA9IG5pY2VfdG9fd2lucHJpbyAoY2hpbGRfbmljZSwgYmF0Y2gpOworICAgIH0KKwor
ICAvKiBBbHdheXMgcmVxdWVzdCBhIHByaW9yaXR5IGJlY2F1c2Ugb3RoZXJ3aXNlIGFueXRo
aW5nIGFib3ZlCisgICAgIE5PUk1BTF9QUklPUklUWV9DTEFTUyB3b3VsZCBub3QgYmUgaW5o
ZXJpdGVkLiAqLworICBpZiAoIWNfZmxhZ3MpCisgICAgY19mbGFncyA9IEdldFByaW9yaXR5
Q2xhc3MgKEdldEN1cnJlbnRQcm9jZXNzICgpKTsKICAgZGVidWdfcHJpbnRmICgicHJpb3Jp
dHkgY2xhc3MgJWQiLCBjX2ZsYWdzKTsKICAgLyogUGVyIE1TRE4sIHRoaXMgbXVzdCBiZSBz
cGVjaWZpZWQgZXZlbiBpZiBscEVudmlyb25tZW50IGlzIHNldCB0byBOVUxMLAogICAgICBv
dGhlcndpc2UgVU5JQ09ERSBjaGFyYWN0ZXJzIGluIHRoZSBwYXJlbnQgZW52aXJvbm1lbnQg
YXJlIG5vdCBjb3BpZWQKQEAgLTQwMSw4ICs0MzEsOSBAQCBmcm9rOjpwYXJlbnQgKHZvbGF0
aWxlIGNoYXIgKiB2b2xhdGlsZSBzdGFja19oZXJlKQogICAgICAgZ290byBjbGVhbnVwOwog
ICAgIH0KIAotICBjaGlsZC0+bmljZSA9IG15c2VsZi0+bmljZTsKLSAgY2hpbGQtPnNjaGVk
X3BvbGljeSA9IG15c2VsZi0+c2NoZWRfcG9saWN5OworICBjaGlsZC0+bmljZSA9IGNoaWxk
X25pY2U7CisgIGNoaWxkLT5zY2hlZF9wb2xpY3kgPSBjaGlsZF9zY2hlZF9wb2xpY3k7Cisg
IGNoaWxkLT5zY2hlZF9yZXNldF9vbl9mb3JrID0gZmFsc2U7CiAKICAgLyogSW5pdGlhbGl6
ZSB0aGluZ3MgdGhhdCBhcmUgZG9uZSBsYXRlciBpbiBkbGxfY3J0MF8xIHRoYXQgYXJlbid0
IGRvbmUKICAgICAgZm9yIHRoZSBmb3JrZWUuICAqLwpkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9sb2NhbF9pbmNsdWRlcy9waW5mby5oIGIvd2luc3VwL2N5Z3dpbi9sb2NhbF9pbmNs
dWRlcy9waW5mby5oCmluZGV4IDAzZTBjNGQ2MC4uYmU1ZDUzMDIxIDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnd2luL2xvY2FsX2luY2x1ZGVzL3BpbmZvLmgKKysrIGIvd2luc3VwL2N5Z3dp
bi9sb2NhbF9pbmNsdWRlcy9waW5mby5oCkBAIC05Myw4ICs5Myw5IEBAIHB1YmxpYzoKICAg
c3RydWN0IHJ1c2FnZSBydXNhZ2Vfc2VsZjsKICAgc3RydWN0IHJ1c2FnZSBydXNhZ2VfY2hp
bGRyZW47CiAKLSAgaW50IG5pY2U7ICAgICAgICAgIC8qIG5pY2UgdmFsdWUgZm9yIFNDSEVE
X09USEVSLiAqLwotICBpbnQgc2NoZWRfcG9saWN5OyAgLyogU0NIRURfT1RIRVIsIFNDSEVE
X0ZJRk8gb3IgU0NIRURfUlIuICovCisgIGludCBuaWNlOyAgICAgICAgICAvKiBuaWNlIHZh
bHVlIGZvciBTQ0hFRF9PVEhFUiBhbmQgU0NIRURfQkFUQ0guICovCisgIGludCBzY2hlZF9w
b2xpY3k7ICAvKiBTQ0hFRF9PVEhFUi9CQVRDSC9JRExFL0ZJRk8vUlIgKi8KKyAgYm9vbCBz
Y2hlZF9yZXNldF9vbl9mb3JrOyAgLyogdHJ1ZSBpZiBTQ0hFRF9SRVNFVF9PTl9GT1JLIGZs
YWcgd2FzIHNldC4gKi8KIAogICAvKiBOb24temVybyBpZiBwcm9jZXNzIHdhcyBzdG9wcGVk
IGJ5IGEgc2lnbmFsLiAqLwogICBjaGFyIHN0b3BzaWc7CmRpZmYgLS1naXQgYS93aW5zdXAv
Y3lnd2luL3BpbmZvLmNjIGIvd2luc3VwL2N5Z3dpbi9waW5mby5jYwppbmRleCAwNmM5NjZm
MWUuLmZlY2Y3NmViNiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9waW5mby5jYworKysg
Yi93aW5zdXAvY3lnd2luL3BpbmZvLmNjCkBAIC0xMDMsNiArMTAzLDcgQEAgcGluZm9faW5p
dCAoY2hhciAqKmVudnAsIGludCBlbnZjKQogICAgICAgZW52aXJvbl9pbml0IChOVUxMLCAw
KTsJLyogY2FsbCBhZnRlciBteXNlbGYgaGFzIGJlZW4gc2V0IHVwICovCiAgICAgICBteXNl
bGYtPm5pY2UgPSB3aW5wcmlvX3RvX25pY2UgKEdldFByaW9yaXR5Q2xhc3MgKEdldEN1cnJl
bnRQcm9jZXNzICgpKSk7CiAgICAgICBteXNlbGYtPnNjaGVkX3BvbGljeSA9IFNDSEVEX09U
SEVSOworICAgICAgbXlzZWxmLT5zY2hlZF9yZXNldF9vbl9mb3JrID0gZmFsc2U7CiAgICAg
ICBteXNlbGYtPnBwaWQgPSAxOwkJLyogYWx3YXlzIHNldCBsYXN0ICovCiAgICAgICBkZWJ1
Z19wcmludGYgKCJTZXQgbmljZSB0byAlZCIsIG15c2VsZi0+bmljZSk7CiAgICAgfQpkaWZm
IC0tZ2l0IGEvd2luc3VwL2N5Z3dpbi9yZWxlYXNlLzMuNi4wIGIvd2luc3VwL2N5Z3dpbi9y
ZWxlYXNlLzMuNi4wCmluZGV4IDExZjc0NWIyMy4uZDM1YWEzMDM2IDEwMDY0NAotLS0gYS93
aW5zdXAvY3lnd2luL3JlbGVhc2UvMy42LjAKKysrIGIvd2luc3VwL2N5Z3dpbi9yZWxlYXNl
LzMuNi4wCkBAIC02MSw1ICs2MSw4IEBAIFdoYXQgY2hhbmdlZDoKICAgcHJpb3JpdHkgaXMg
c2V0IHRvIElETEVfUFJJT1JJVFlfQ0xBU1MuICBJZiBTQ0hFRF9GSUZPIG9yIFNDSEVEX1JS
IGlzCiAgIHNlbGVjdGVkLCB0aGUgbmljZSB2YWx1ZSBpcyBwcmVzZXJ2ZWQgYW5kIHRoZSBX
aW5kb3dzIHByaW9yaXR5IGlzIHNldAogICBhY2NvcmRpbmcgdG8gdGhlIHJlYWx0aW1lIHBy
aW9yaXR5LgorICBJZiB0aGUgU0NIRURfUkVTRVRfT05fRk9SSyBmbGFnIGlzIHNldCwgU0NI
RURfRklGTyBhbmQgU0NIRURfUlIgYXJlCisgIHJlc2V0IHRvIFNDSEVEX09USEVSIGFuZCBu
ZWdhdGl2ZSBuaWNlIHZhbHVlcyBhcmUgcmVzZXQgdG8gemVybyBpbgorICBlYWNoIGNoaWxk
IHByb2Nlc3MgY3JlYXRlZCB3aXRoIGZvcmsoMikuCiAgIE5vdGU6IFdpbmRvd3MgZG9lcyBu
b3Qgb2ZmZXIgYWx0ZXJuYXRpdmUgc2NoZWR1bGluZyBwb2xpY2llcyBzbwogICB0aGlzIGNv
dWxkIG9ubHkgZW11bGF0ZSBBUEkgYmVoYXZpb3IuCmRpZmYgLS1naXQgYS93aW5zdXAvY3ln
d2luL3NjaGVkLmNjIGIvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYwppbmRleCBlYzYyZWE4M2Mu
LmQ3NWEzNDA0ZiAxMDA2NDQKLS0tIGEvd2luc3VwL2N5Z3dpbi9zY2hlZC5jYworKysgYi93
aW5zdXAvY3lnd2luL3NjaGVkLmNjCkBAIC0xNjIsNyArMTYyLDcgQEAgc2NoZWRfZ2V0c2No
ZWR1bGVyIChwaWRfdCBwaWQpCiAgICAgICBzZXRfZXJybm8gKEVTUkNIKTsKICAgICAgIHJl
dHVybiAtMTsKICAgICB9Ci0gIHJldHVybiBwLT5zY2hlZF9wb2xpY3k7CisgIHJldHVybiBw
LT5zY2hlZF9wb2xpY3kgfCAocC0+c2NoZWRfcmVzZXRfb25fZm9yayA/IFNDSEVEX1JFU0VU
X09OX0ZPUksgOiAwKTsKIH0KIAogLyogZ2V0IHRoZSB0aW1lIHF1YW50dW0gZm9yIHBpZCAq
LwpAQCAtNDI1LDkgKzQyNSwxMSBAQCBpbnQKIHNjaGVkX3NldHNjaGVkdWxlciAocGlkX3Qg
cGlkLCBpbnQgcG9saWN5LAogCQkgICAgY29uc3Qgc3RydWN0IHNjaGVkX3BhcmFtICpwYXJh
bSkKIHsKKyAgaW50IG5ld19wb2xpY3kgPSBwb2xpY3kgJiB+U0NIRURfUkVTRVRfT05fRk9S
SzsKICAgaWYgKCEocGlkID49IDAgJiYgcGFyYW0gJiYKLSAgICAgICgoKHBvbGljeSA9PSBT
Q0hFRF9PVEhFUiB8fCBwb2xpY3kgPT0gU0NIRURfQkFUQ0ggfHwgcG9saWN5ID09IFNDSEVE
X0lETEUpCi0gICAgICAmJiBwYXJhbS0+c2NoZWRfcHJpb3JpdHkgPT0gMCkgfHwgKChwb2xp
Y3kgPT0gU0NIRURfRklGTyB8fCBwb2xpY3kgPT0gU0NIRURfUlIpCisgICAgICAoKChuZXdf
cG9saWN5ID09IFNDSEVEX09USEVSIHx8IG5ld19wb2xpY3kgPT0gU0NIRURfQkFUQ0gKKyAg
ICAgIHx8IG5ld19wb2xpY3kgPT0gU0NIRURfSURMRSkgJiYgcGFyYW0tPnNjaGVkX3ByaW9y
aXR5ID09IDApCisgICAgICB8fCAoKG5ld19wb2xpY3kgPT0gU0NIRURfRklGTyB8fCBuZXdf
cG9saWN5ID09IFNDSEVEX1JSKQogICAgICAgJiYgdmFsaWRfc2NoZWRfcGFyYW1ldGVycyhw
YXJhbSkpKSkpCiAgICAgewogICAgICAgc2V0X2Vycm5vIChFSU5WQUwpOwpAQCAtNDQyLDEz
ICs0NDQsMTQgQEAgc2NoZWRfc2V0c2NoZWR1bGVyIChwaWRfdCBwaWQsIGludCBwb2xpY3ks
CiAgICAgfQogCiAgIGludCBwcmV2X3BvbGljeSA9IHAtPnNjaGVkX3BvbGljeTsKLSAgcC0+
c2NoZWRfcG9saWN5ID0gcG9saWN5OworICBwLT5zY2hlZF9wb2xpY3kgPSBuZXdfcG9saWN5
OwogICBpZiAoc2NoZWRfc2V0cGFyYW1fcGluZm8gKHAsIHBhcmFtKSkKICAgICB7CiAgICAg
ICBwLT5zY2hlZF9wb2xpY3kgPSBwcmV2X3BvbGljeTsKICAgICAgIHJldHVybiAtMTsKICAg
ICB9CiAKKyAgcC0+c2NoZWRfcmVzZXRfb25fZm9yayA9ICEhKHBvbGljeSAmIFNDSEVEX1JF
U0VUX09OX0ZPUkspOwogICByZXR1cm4gMDsKIH0KIApkaWZmIC0tZ2l0IGEvd2luc3VwL2N5
Z3dpbi9zcGF3bi5jYyBiL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MKaW5kZXggN2Y5ZjJkZjY0
Li44MDE2ZjA4NjQgMTAwNjQ0Ci0tLSBhL3dpbnN1cC9jeWd3aW4vc3Bhd24uY2MKKysrIGIv
d2luc3VwL2N5Z3dpbi9zcGF3bi5jYwpAQCAtODAwLDYgKzgwMCw3IEBAIGNoaWxkX2luZm9f
c3Bhd246OndvcmtlciAoY29uc3QgY2hhciAqcHJvZ19hcmcsIGNvbnN0IGNoYXIgKmNvbnN0
ICphcmd2LAogCSAgY2hpbGQtPnN0YXJ0X3RpbWUgPSB0aW1lIChOVUxMKTsgLyogUmVnaXN0
ZXIgY2hpbGQncyBzdGFydGluZyB0aW1lLiAqLwogCSAgY2hpbGQtPm5pY2UgPSBteXNlbGYt
Pm5pY2U7CiAJICBjaGlsZC0+c2NoZWRfcG9saWN5ID0gbXlzZWxmLT5zY2hlZF9wb2xpY3k7
CisJICBjaGlsZC0+c2NoZWRfcmVzZXRfb25fZm9yayA9IGZhbHNlOwogCSAgcG9zdGZvcmsg
KGNoaWxkKTsKIAkgIGlmIChtb2RlICE9IF9QX0RFVEFDSAogCSAgICAgICYmICghY2hpbGQu
cmVtZW1iZXIgKCkgfHwgIWNoaWxkLmF0dGFjaCAoKSkpCi0tIAoyLjQ1LjEKCg==
--------------2714DA07575CDBCBD8958522--
