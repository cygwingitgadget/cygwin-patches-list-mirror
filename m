Return-Path: <Christian.Franke@t-online.de>
Received: from mailout10.t-online.de (mailout10.t-online.de [194.25.134.21])
 by sourceware.org (Postfix) with ESMTPS id 4C4EF3887F5F
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 12:12:08 +0000 (GMT)
DMARC-Filter: OpenDMARC Filter v1.4.1 sourceware.org 4C4EF3887F5F
Authentication-Results: sourceware.org;
 dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: sourceware.org; spf=none smtp.mailfrom=t-online.de
Received: from fwd70.dcpf.telekom.de (fwd70.aul.t-online.de [10.223.144.96])
 by mailout10.t-online.de (Postfix) with SMTP id 4D18AC8CB
 for <cygwin-patches@cygwin.com>; Thu, 14 Jul 2022 14:12:06 +0200 (CEST)
Received: from [192.168.2.102] ([87.187.34.65]) by fwd70.t-online.de
 with (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384 encrypted)
 esmtp id 1oBxhM-0ckFFo0; Thu, 14 Jul 2022 14:12:05 +0200
Subject: Re: [PATCH rebase] Add support for Compact OS compression for Cygwin
To: cygwin-patches@cygwin.com
References: <e281c355-1ea1-eefa-12d8-17f7538edb60@t-online.de>
 <Ys/u2QmY8E1s0hZd@calimero.vinschen.de>
From: Christian Franke <Christian.Franke@t-online.de>
Message-ID: <ae3b7f6f-cb27-3ffa-3b47-300db32ffc25@t-online.de>
Date: Thu, 14 Jul 2022 14:12:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 SeaMonkey/2.53.12
MIME-Version: 1.0
In-Reply-To: <Ys/u2QmY8E1s0hZd@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------72E277F1D67F29BA8E167C2D"
X-TOI-EXPURGATEID: 150726::1657800725-0144B853-F599EFD1/0/0 CLEAN NORMAL
X-TOI-MSGID: d81e1a11-52ef-41d5-afe7-2831e9c557e0
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00, FREEMAIL_FROM,
 GIT_PATCH_0, KAM_DMARC_STATUS, KAM_LAZY_DOMAIN_SECURITY, NICE_REPLY_A,
 RCVD_IN_DNSWL_NONE, RCVD_IN_MSPIKE_H2, SPF_HELO_NONE, SPF_NONE, TXREP,
 T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
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
X-List-Received-Date: Thu, 14 Jul 2022 12:12:11 -0000

This is a multi-part message in MIME format.
--------------72E277F1D67F29BA8E167C2D
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Corinna Vinschen wrote:
> On Jul 14 12:02, Christian Franke wrote:
>> [Sorry if this is the wrong list]
> Yes, in theorie, but no worries.  However...

What is the correct list in theory ?-)

>
>>  From 807ae9fbaef18491f3aa1e94e66dd21eb6748c3e Mon Sep 17 00:00:00 2001
>> From: Christian Franke <christian.franke@t-online.de>
>> Date: Thu, 14 Jul 2022 11:59:50 +0200
>> Subject: [PATCH] Add support for Compact OS compression for Cygwin
>>
>> Preserve compression of manually rebased files.
>> Align compression with Cygwin DLL if database is used.
>> Only check for writability if file needs rebasing to keep
>> compression of unchanged files.
>>
>> Signed-off-by: Christian Franke <christian.franke@t-online.de>
>> ---
>>   rebase.c | 199 +++++++++++++++++++++++++++++++++++++++++++------------
>>   1 file changed, 155 insertions(+), 44 deletions(-)
>>
>> diff --git a/rebase.c b/rebase.c
>> index a403c85..06828bb 100644
>> --- a/rebase.c
>> +++ b/rebase.c
>> @@ -39,6 +39,10 @@
>>   #include <errno.h>
>>   #include "imagehelper.h"
>>   #include "rebase-db.h"
>> +#if defined(__CYGWIN__)
>> +#include <io.h>
>> +#include <versionhelpers.h>
>> +#endif
>>   
>>   BOOL save_image_info ();
>>   BOOL load_image_info ();
>> @@ -48,6 +52,10 @@ void print_image_info ();
>>   BOOL rebase (const char *pathname, ULONG64 *new_image_base, BOOL down_flag);
>>   void parse_args (int argc, char *argv[]);
>>   unsigned long long string_to_ulonglong (const char *string);
>> +#if defined(__CYGWIN__)
>> +static int compactos_get_algorithm (const char *pathname);
>> +static int compactos_compress_file (const char *pathname, int algorithm);
>> +#endif
>>   void usage ();
>>   void help ();
>>   BOOL is_rebaseable (const char *pathname);
>> @@ -259,9 +267,19 @@ main (int argc, char *argv[])
>>         ULONG64 new_image_base = image_base;
>>         for (i = 0; i < img_info_size; ++i)
>>   	{
>> +#if defined(__CYGWIN__)
> Given compactos stuff is a OS thingy and not actually a Cygwin feature,
> why do we need an ifdef CYGWIN?

Mainly because I didn't test on MSYS and other (which ever these are) 
environments. This also requires a recent release of MinGW-w64 headers 
(>=10.0.0) which includes (my) Compact OS patch.


>
>> +	  int compactos_algorithm
>> +	      = compactos_get_algorithm (img_info_list[i].name);
>> +#endif
>>   	  status = rebase (img_info_list[i].name, &new_image_base, down_flag);
>>   	  if (!status)
>>   	    return 2;
>> +#if defined(__CYGWIN__)
>> +	  /* Reapply previous compression. */
>> +	  if (compactos_algorithm >= 0)
>> +	    compactos_compress_file (img_info_list[i].name,
>> +				     compactos_algorithm);
>> +#endif
>>   	}
>>       }
>>     else
>> @@ -269,6 +287,9 @@ main (int argc, char *argv[])
>>         /* Rebase with database support. */
>>         BOOL header;
>>   
>> +#if defined(__CYGWIN__)
>> +      int compactos_algorithm = compactos_get_algorithm ("/bin/cygwin1.dll");
>> +#endif
>>         if (merge_image_info () < 0)
>>   	return 2;
>>         status = TRUE;
>> @@ -279,6 +300,14 @@ main (int argc, char *argv[])
>>   	    status = rebase (img_info_list[i].name, &new_image_base, FALSE);
>>   	    if (status)
>>   	      img_info_list[i].flag.needs_rebasing = 0;
>> +#if defined(__CYGWIN__)
>> +	    /* If Cygwin DLL is compressed, assume setup was used with option
>> +	       --compact-os.  Align compression with Cygwin DLL. */
>> +	    if (compactos_algorithm >= 0
>> +		&& compactos_compress_file (img_info_list[i].name,
>> +					    compactos_algorithm) < 0)
>> +	      compactos_algorithm = -1;
>> +#endif
> This ifdef still makes sense, of course ...

Could possibly also be enhanced to __MSYS__ and msys1.dll.


> ... and on first glance, the
> remainder of the patch LGTM.

Thanks. Attached is an alternative patch with most ifdefs removed.

Thanks,
Christian


--------------72E277F1D67F29BA8E167C2D
Content-Type: text/plain; charset=UTF-8;
 name="0001-Add-support-for-Compact-OS-compression.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-Add-support-for-Compact-OS-compression.patch"

RnJvbSA1ZDI3NDUxMGIzY2FhZmU2ODkyOTAxNGUwMmUzNTFiMTExNTY5Y2Y3IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBDaHJpc3RpYW4gRnJhbmtlIDxjaHJpc3RpYW4uZnJh
bmtlQHQtb25saW5lLmRlPgpEYXRlOiBUaHUsIDE0IEp1bCAyMDIyIDEzOjU0OjEyICswMjAw
ClN1YmplY3Q6IFtQQVRDSF0gQWRkIHN1cHBvcnQgZm9yIENvbXBhY3QgT1MgY29tcHJlc3Np
b24KClByZXNlcnZlIGNvbXByZXNzaW9uIG9mIG1hbnVhbGx5IHJlYmFzZWQgZmlsZXMuCkFs
aWduIGNvbXByZXNzaW9uIHdpdGggQ3lnd2luIERMTCBpZiBkYXRhYmFzZSBpcyB1c2VkLgpP
bmx5IGNoZWNrIGZvciB3cml0YWJpbGl0eSBpZiBmaWxlIG5lZWRzIHJlYmFzaW5nIHRvIGtl
ZXAKY29tcHJlc3Npb24gb2YgdW5jaGFuZ2VkIGZpbGVzLgoKU2lnbmVkLW9mZi1ieTogQ2hy
aXN0aWFuIEZyYW5rZSA8Y2hyaXN0aWFuLmZyYW5rZUB0LW9ubGluZS5kZT4KLS0tCiByZWJh
c2UuYyB8IDE4OSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTQ1IGluc2VydGlvbnMoKyksIDQ0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL3JlYmFzZS5jIGIvcmViYXNlLmMKaW5kZXggYTQw
M2M4NS4uNWNkYTEyMyAxMDA2NDQKLS0tIGEvcmViYXNlLmMKKysrIGIvcmViYXNlLmMKQEAg
LTM3LDggKzM3LDEwIEBACiAjaW5jbHVkZSA8Z2V0b3B0Lmg+CiAjaW5jbHVkZSA8c3RyaW5n
Lmg+CiAjaW5jbHVkZSA8ZXJybm8uaD4KKyNpbmNsdWRlIDxpby5oPgogI2luY2x1ZGUgImlt
YWdlaGVscGVyLmgiCiAjaW5jbHVkZSAicmViYXNlLWRiLmgiCisjaW5jbHVkZSA8dmVyc2lv
bmhlbHBlcnMuaD4gLyogcmVxdWlyZXMgPHdpbmRvd3MuaD4gKi8KIAogQk9PTCBzYXZlX2lt
YWdlX2luZm8gKCk7CiBCT09MIGxvYWRfaW1hZ2VfaW5mbyAoKTsKQEAgLTQ4LDYgKzUwLDgg
QEAgdm9pZCBwcmludF9pbWFnZV9pbmZvICgpOwogQk9PTCByZWJhc2UgKGNvbnN0IGNoYXIg
KnBhdGhuYW1lLCBVTE9ORzY0ICpuZXdfaW1hZ2VfYmFzZSwgQk9PTCBkb3duX2ZsYWcpOwog
dm9pZCBwYXJzZV9hcmdzIChpbnQgYXJnYywgY2hhciAqYXJndltdKTsKIHVuc2lnbmVkIGxv
bmcgbG9uZyBzdHJpbmdfdG9fdWxvbmdsb25nIChjb25zdCBjaGFyICpzdHJpbmcpOworc3Rh
dGljIGludCBjb21wYWN0b3NfZ2V0X2FsZ29yaXRobSAoY29uc3QgY2hhciAqcGF0aG5hbWUp
Oworc3RhdGljIGludCBjb21wYWN0b3NfY29tcHJlc3NfZmlsZSAoY29uc3QgY2hhciAqcGF0
aG5hbWUsIGludCBhbGdvcml0aG0pOwogdm9pZCB1c2FnZSAoKTsKIHZvaWQgaGVscCAoKTsK
IEJPT0wgaXNfcmViYXNlYWJsZSAoY29uc3QgY2hhciAqcGF0aG5hbWUpOwpAQCAtMjU5LDkg
KzI2MywxNSBAQCBtYWluIChpbnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICAgVUxPTkc2
NCBuZXdfaW1hZ2VfYmFzZSA9IGltYWdlX2Jhc2U7CiAgICAgICBmb3IgKGkgPSAwOyBpIDwg
aW1nX2luZm9fc2l6ZTsgKytpKQogCXsKKwkgIGludCBjb21wYWN0b3NfYWxnb3JpdGhtCisJ
ICAgICAgPSBjb21wYWN0b3NfZ2V0X2FsZ29yaXRobSAoaW1nX2luZm9fbGlzdFtpXS5uYW1l
KTsKIAkgIHN0YXR1cyA9IHJlYmFzZSAoaW1nX2luZm9fbGlzdFtpXS5uYW1lLCAmbmV3X2lt
YWdlX2Jhc2UsIGRvd25fZmxhZyk7CiAJICBpZiAoIXN0YXR1cykKIAkgICAgcmV0dXJuIDI7
CisJICAvKiBSZWFwcGx5IHByZXZpb3VzIGNvbXByZXNzaW9uLiAqLworCSAgaWYgKGNvbXBh
Y3Rvc19hbGdvcml0aG0gPj0gMCkKKwkgICAgY29tcGFjdG9zX2NvbXByZXNzX2ZpbGUgKGlt
Z19pbmZvX2xpc3RbaV0ubmFtZSwKKwkJCQkgICAgIGNvbXBhY3Rvc19hbGdvcml0aG0pOwog
CX0KICAgICB9CiAgIGVsc2UKQEAgLTI2OSw2ICsyNzksOSBAQCBtYWluIChpbnQgYXJnYywg
Y2hhciAqYXJndltdKQogICAgICAgLyogUmViYXNlIHdpdGggZGF0YWJhc2Ugc3VwcG9ydC4g
Ki8KICAgICAgIEJPT0wgaGVhZGVyOwogCisjaWYgZGVmaW5lZChfX0NZR1dJTl9fKQorICAg
ICAgaW50IGNvbXBhY3Rvc19hbGdvcml0aG0gPSBjb21wYWN0b3NfZ2V0X2FsZ29yaXRobSAo
Ii9iaW4vY3lnd2luMS5kbGwiKTsKKyNlbmRpZgogICAgICAgaWYgKG1lcmdlX2ltYWdlX2lu
Zm8gKCkgPCAwKQogCXJldHVybiAyOwogICAgICAgc3RhdHVzID0gVFJVRTsKQEAgLTI3OSw2
ICsyOTIsMTQgQEAgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAkgICAgc3RhdHVz
ID0gcmViYXNlIChpbWdfaW5mb19saXN0W2ldLm5hbWUsICZuZXdfaW1hZ2VfYmFzZSwgRkFM
U0UpOwogCSAgICBpZiAoc3RhdHVzKQogCSAgICAgIGltZ19pbmZvX2xpc3RbaV0uZmxhZy5u
ZWVkc19yZWJhc2luZyA9IDA7CisjaWYgZGVmaW5lZChfX0NZR1dJTl9fKQorCSAgICAvKiBJ
ZiBDeWd3aW4gRExMIGlzIGNvbXByZXNzZWQsIGFzc3VtZSBzZXR1cCB3YXMgdXNlZCB3aXRo
IG9wdGlvbgorCSAgICAgICAtLWNvbXBhY3Qtb3MuICBBbGlnbiBjb21wcmVzc2lvbiB3aXRo
IEN5Z3dpbiBETEwuICovCisJICAgIGlmIChjb21wYWN0b3NfYWxnb3JpdGhtID49IDAKKwkJ
JiYgY29tcGFjdG9zX2NvbXByZXNzX2ZpbGUgKGltZ19pbmZvX2xpc3RbaV0ubmFtZSwKKwkJ
CQkJICAgIGNvbXBhY3Rvc19hbGdvcml0aG0pIDwgMCkKKwkgICAgICBjb21wYWN0b3NfYWxn
b3JpdGhtID0gLTE7CisjZW5kaWYKIAkgIH0KICAgICAgIGZvciAoaGVhZGVyID0gRkFMU0Us
IGkgPSAwOyBpIDwgaW1nX2luZm9fc2l6ZTsgKytpKQogCWlmIChpbWdfaW5mb19saXN0W2ld
LmZsYWcuY2Fubm90X3JlYmFzZSA9PSAxKQpAQCAtNTg5LDYgKzYxMCw3IEBAIHNldF9jYW5u
b3RfcmViYXNlIChpbWdfaW5mb190ICppbWcpCiAgICAqIGlzIHNldCB0byAyIG9uIGxvYWRp
bmcgdGhlIGRhdGFiYXNlIGVudHJpZXMgKi8KICAgaWYgKGltZy0+ZmxhZy5jYW5ub3RfcmVi
YXNlIDw9IDEgKQogICAgIHsKKyAgICAgIC8qIFRoaXMgYWxzbyByZW1vdmVzIENvbXBhY3Qg
T1MgY29tcHJlc3Npb24uICovCiAgICAgICBpbnQgZmQgPSBvcGVuIChpbWctPm5hbWUsIE9f
V1JPTkxZKTsKICAgICAgIGlmIChmZCA8IDApCiAJaW1nLT5mbGFnLmNhbm5vdF9yZWJhc2Ug
PSAxOwpAQCAtNzExLDcgKzczMyw3IEBAIG1lcmdlX2ltYWdlX2luZm8gKCkKICAgICAgdG8g
bWF0Y2ggd2l0aCByZWFsaXR5LiAqLwogICBmb3IgKGkgPSAwOyBpIDwgaW1nX2luZm9fcmVi
YXNlX3N0YXJ0OyArK2kpCiAgICAgewotICAgICAgVUxPTkc2NCBjdXJfYmFzZTsKKyAgICAg
IFVMT05HNjQgY3VyX2Jhc2UsIGN1cl9iYXNlX29yaWc7CiAgICAgICBVTE9ORyBjdXJfc2l6
ZSwgc2xvdF9zaXplOwogCiAgICAgICAvKiBGaWxlcyB3aXRoIHRoZSBuZWVkc19yZWJhc2lu
ZyBvciBjYW5ub3RfcmViYXNlIGZsYWdzIHNldCBoYXZlIGJlZW4KQEAgLTczMyw1NSArNzU1
LDYxIEBAIG1lcmdlX2ltYWdlX2luZm8gKCkKIAkgIGNvbnRpbnVlOwogCX0KICAgICAgIHNs
b3Rfc2l6ZSA9IHJvdW5kdXAyIChjdXJfc2l6ZSwgQUxMT0NBVElPTl9TTE9UKTsKLSAgICAg
IGlmIChzZXRfY2Fubm90X3JlYmFzZSAoJmltZ19pbmZvX2xpc3RbaV0pKQotCWltZ19pbmZv
X2xpc3RbaV0uYmFzZSA9IGN1cl9iYXNlOwotICAgICAgZWxzZQorICAgICAgY3VyX2Jhc2Vf
b3JpZyA9IGN1cl9iYXNlOworICAgICAgLyogSWYgdGhlIGZpbGUgaGFzIGJlZW4gcmVpbnN0
YWxsZWQsIHRyeSB0byByZWJhc2UgdG8gdGhlIHNhbWUgYWRkcmVzcworCSBpbiB0aGUgZmly
c3QgcGxhY2UuICovCisgICAgICBpZiAoY3VyX2Jhc2UgIT0gaW1nX2luZm9fbGlzdFtpXS5i
YXNlKQogCXsKLQkgIC8qIElmIHRoZSBmaWxlIGhhcyBiZWVuIHJlaW5zdGFsbGVkLCB0cnkg
dG8gcmViYXNlIHRvIHRoZSBzYW1lIGFkZHJlc3MKLQkgICAgIGluIHRoZSBmaXJzdCBwbGFj
ZS4gKi8KLQkgIGlmIChjdXJfYmFzZSAhPSBpbWdfaW5mb19saXN0W2ldLmJhc2UpCi0JICAg
IHsKLQkgICAgICBpbWdfaW5mb19saXN0W2ldLmZsYWcubmVlZHNfcmViYXNpbmcgPSAxOwot
CSAgICAgIGlmICh2ZXJib3NlKQotCQlmcHJpbnRmIChzdGRlcnIsICJyZWJhc2luZyAlcyBi
ZWNhdXNlIGl0J3MgYmFzZSBoYXMgY2hhbmdlZCAoZHVlIHRvIGJlaW5nIHJlaW5zdGFsbGVk
PylcbiIsIGltZ19pbmZvX2xpc3RbaV0ubmFtZSk7Ci0JICAgICAgLyogU2V0IGN1cl9iYXNl
IHRvIHRoZSBvbGQgYmFzZSB0byBzaW1wbGlmeSBzdWJzZXF1ZW50IHRlc3RzLiAqLwotCSAg
ICAgIGN1cl9iYXNlID0gaW1nX2luZm9fbGlzdFtpXS5iYXNlOwotCSAgICB9Ci0JICAvKiBI
b3dldmVyLCBpZiB0aGUgRExMIGdvdCBiaWdnZXIgYW5kIGRvZXNuJ3QgZml0IGludG8gaXRz
IHNsb3QKLQkgICAgIGFueW1vcmUsIHJlYmFzZSB0aGlzIERMTCBmcm9tIHNjcmF0Y2guICov
Ci0JICBpZiAoaSArIDEgPCBpbWdfaW5mb19yZWJhc2Vfc3RhcnQKLQkgICAgICAmJiBjdXJf
YmFzZSArIHNsb3Rfc2l6ZSArIG9mZnNldCA+IGltZ19pbmZvX2xpc3RbaSArIDFdLmJhc2Up
Ci0JICAgIHsKLQkgICAgICBpbWdfaW5mb19saXN0W2ldLmJhc2UgPSAwOwotCSAgICAgIGlm
ICh2ZXJib3NlKQotCQlmcHJpbnRmIChzdGRlcnIsICJyZWJhc2luZyAlcyBiZWNhdXNlIGl0
IHdvbid0IGZpdCBpbiBpdCdzIG9sZCBzbG90IHdpdGhvdXQgb3ZlcmxhcHBpbmcgbmV4dCBE
TExcbiIsIGltZ19pbmZvX2xpc3RbaV0ubmFtZSk7Ci0JICAgIH0KLQkgIC8qIERvZXMgdGhl
IHByZXZpb3VzIERMTCByZWFjaCBpbnRvIHRoZSBhZGRyZXNzIHNwYWNlIG9mIHRoaXMKLQkg
ICAgIERMTD8gIFRoaXMgaGFwcGVucyBpZiB0aGUgcHJldmlvdXMgRExMIGlzIG5vdCByZWJh
c2VhYmxlLiAqLwotCSAgZWxzZSBpZiAoaSA+IDAgJiYgY3VyX2Jhc2UgPCBpbWdfaW5mb19s
aXN0W2kgLSAxXS5iYXNlCi0JCQkJICAgICAgICsgaW1nX2luZm9fbGlzdFtpIC0gMV0uc2xv
dF9zaXplKQotCSAgICB7Ci0JICAgICAgaW1nX2luZm9fbGlzdFtpXS5iYXNlID0gMDsKLQkg
ICAgICBpZiAodmVyYm9zZSkKLQkJZnByaW50ZiAoc3RkZXJyLCAicmViYXNpbmcgJXMgYmVj
YXVzZSBwcmV2aW91cyBETEwgbm93IG92ZXJsYXBzXG4iLCBpbWdfaW5mb19saXN0W2ldLm5h
bWUpOwotCSAgICB9Ci0JICAvKiBEb2VzIHRoZSBmaWxlIG1hdGNoIHRoZSBiYXNlIGFkZHJl
c3MgcmVxdWlyZW1lbnRzPyAgSWYgbm90LAotCSAgICAgcmViYXNlIGZyb20gc2NyYXRjaC4g
Ki8KLQkgIGVsc2UgaWYgKChkb3duX2ZsYWcgJiYgY3VyX2Jhc2UgKyBzbG90X3NpemUgKyBv
ZmZzZXQgPiBpbWFnZV9iYXNlKQotCQkgICB8fCAoIWRvd25fZmxhZyAmJiBjdXJfYmFzZSA8
IGltYWdlX2Jhc2UpKQotCSAgICB7Ci0JICAgICAgaW1nX2luZm9fbGlzdFtpXS5iYXNlID0g
MDsKLQkgICAgICBpZiAodmVyYm9zZSkKLQkJZnByaW50ZiAoc3RkZXJyLCAicmViYXNpbmcg
JXMgYmVjYXVzZSBpdCdzIGJhc2UgYWRkcmVzcyBpcyBvdXRzaWRlIHRoZSBleHBlY3RlZCBh
cmVhXG4iLCBpbWdfaW5mb19saXN0W2ldLm5hbWUpOwotCSAgICB9CisJICBpbWdfaW5mb19s
aXN0W2ldLmZsYWcubmVlZHNfcmViYXNpbmcgPSAxOworCSAgaWYgKHZlcmJvc2UpCisJICAg
IGZwcmludGYgKHN0ZGVyciwgInJlYmFzaW5nICVzIGJlY2F1c2UgaXQncyBiYXNlIGhhcyBj
aGFuZ2VkIChkdWUgdG8gYmVpbmcgcmVpbnN0YWxsZWQ/KVxuIiwgaW1nX2luZm9fbGlzdFtp
XS5uYW1lKTsKKwkgIC8qIFNldCBjdXJfYmFzZSB0byB0aGUgb2xkIGJhc2UgdG8gc2ltcGxp
Znkgc3Vic2VxdWVudCB0ZXN0cy4gKi8KKwkgIGN1cl9iYXNlID0gaW1nX2luZm9fbGlzdFtp
XS5iYXNlOworCX0KKyAgICAgIC8qIEhvd2V2ZXIsIGlmIHRoZSBETEwgZ290IGJpZ2dlciBh
bmQgZG9lc24ndCBmaXQgaW50byBpdHMgc2xvdAorCSBhbnltb3JlLCByZWJhc2UgdGhpcyBE
TEwgZnJvbSBzY3JhdGNoLiAqLworICAgICAgaWYgKGkgKyAxIDwgaW1nX2luZm9fcmViYXNl
X3N0YXJ0CisJICAmJiBjdXJfYmFzZSArIHNsb3Rfc2l6ZSArIG9mZnNldCA+IGltZ19pbmZv
X2xpc3RbaSArIDFdLmJhc2UpCisJeworCSAgaW1nX2luZm9fbGlzdFtpXS5iYXNlID0gMDsK
KwkgIGlmICh2ZXJib3NlKQorCSAgICBmcHJpbnRmIChzdGRlcnIsICJyZWJhc2luZyAlcyBi
ZWNhdXNlIGl0IHdvbid0IGZpdCBpbiBpdCdzIG9sZCBzbG90IHdpdGhvdXQgb3ZlcmxhcHBp
bmcgbmV4dCBETExcbiIsIGltZ19pbmZvX2xpc3RbaV0ubmFtZSk7CisJfQorICAgICAgLyog
RG9lcyB0aGUgcHJldmlvdXMgRExMIHJlYWNoIGludG8gdGhlIGFkZHJlc3Mgc3BhY2Ugb2Yg
dGhpcworCSBETEw/ICBUaGlzIGhhcHBlbnMgaWYgdGhlIHByZXZpb3VzIERMTCBpcyBub3Qg
cmViYXNlYWJsZS4gKi8KKyAgICAgIGVsc2UgaWYgKGkgPiAwICYmIGN1cl9iYXNlIDwgaW1n
X2luZm9fbGlzdFtpIC0gMV0uYmFzZQorCQkJCSAgICsgaW1nX2luZm9fbGlzdFtpIC0gMV0u
c2xvdF9zaXplKQorCXsKKwkgIGltZ19pbmZvX2xpc3RbaV0uYmFzZSA9IDA7CisJICBpZiAo
dmVyYm9zZSkKKwkgICAgZnByaW50ZiAoc3RkZXJyLCAicmViYXNpbmcgJXMgYmVjYXVzZSBw
cmV2aW91cyBETEwgbm93IG92ZXJsYXBzXG4iLCBpbWdfaW5mb19saXN0W2ldLm5hbWUpOwor
CX0KKyAgICAgIC8qIERvZXMgdGhlIGZpbGUgbWF0Y2ggdGhlIGJhc2UgYWRkcmVzcyByZXF1
aXJlbWVudHM/ICBJZiBub3QsCisJIHJlYmFzZSBmcm9tIHNjcmF0Y2guICovCisgICAgICBl
bHNlIGlmICgoZG93bl9mbGFnICYmIGN1cl9iYXNlICsgc2xvdF9zaXplICsgb2Zmc2V0ID4g
aW1hZ2VfYmFzZSkKKwkgICAgICAgfHwgKCFkb3duX2ZsYWcgJiYgY3VyX2Jhc2UgPCBpbWFn
ZV9iYXNlKSkKKwl7CisJICBpbWdfaW5mb19saXN0W2ldLmJhc2UgPSAwOworCSAgaWYgKHZl
cmJvc2UpCisJICAgIGZwcmludGYgKHN0ZGVyciwgInJlYmFzaW5nICVzIGJlY2F1c2UgaXQn
cyBiYXNlIGFkZHJlc3MgaXMgb3V0c2lkZSB0aGUgZXhwZWN0ZWQgYXJlYVxuIiwgaW1nX2lu
Zm9fbGlzdFtpXS5uYW1lKTsKIAl9Ci0gICAgICAvKiBVbmNvbmRpdGlvbmFsbHkgb3Zlcndy
aXRlIG9sZCB3aXRoIG5ldyBzaXplLiAqLwotICAgICAgaW1nX2luZm9fbGlzdFtpXS5zaXpl
ID0gY3VyX3NpemU7Ci0gICAgICBpbWdfaW5mb19saXN0W2ldLnNsb3Rfc2l6ZSA9IHNsb3Rf
c2l6ZTsKICAgICAgIC8qIE1ha2Ugc3VyZSBhbGwgRExMcyB3aXRoIGJhc2UgYWRkcmVzcyAw
IGhhdmUgdGhlIG5lZWRzX3JlYmFzaW5nCiAJIGZsYWcgc2V0LiAqLwogICAgICAgaWYgKGlt
Z19pbmZvX2xpc3RbaV0uYmFzZSA9PSAwKQogCWltZ19pbmZvX2xpc3RbaV0uZmxhZy5uZWVk
c19yZWJhc2luZyA9IDE7CisgICAgICAvKiBPbmx5IGNoZWNrIGZvciB3cml0YWJpbGl0eSBp
ZiBmaWxlIG5lZWRzIHJlYmFzaW5nIHRvIGtlZXAKKwkgQ29tcGFjdCBPUyBjb21wcmVzc2lv
biBvZiB1bmNoYW5nZWQgZmlsZXMuICBSZXZlcnQgcmViYXNlCisJIGRlY2lzaW9uIGlmIG5v
dCB3cml0ZWFibGUuICovCisgICAgICBpZiAoaW1nX2luZm9fbGlzdFtpXS5mbGFnLm5lZWRz
X3JlYmFzaW5nICYmIHNldF9jYW5ub3RfcmViYXNlICgmaW1nX2luZm9fbGlzdFtpXSkpCisJ
eworCSAgaW1nX2luZm9fbGlzdFtpXS5mbGFnLm5lZWRzX3JlYmFzaW5nID0gMDsKKwkgIGlt
Z19pbmZvX2xpc3RbaV0uYmFzZSA9IGN1cl9iYXNlX29yaWc7CisJICBpZiAodmVyYm9zZSkK
KwkgICAgZnByaW50ZiAoc3RkZXJyLCAicmViYXNpbmcgJXMgZGVmZXJyZWQgYmVjYXVzZSBm
aWxlIGlzIG5vdCB3cml0YWJsZVxuIiwgaW1nX2luZm9fbGlzdFtpXS5uYW1lKTsKKwl9Cisg
ICAgICAvKiBVbmNvbmRpdGlvbmFsbHkgb3ZlcndyaXRlIG9sZCB3aXRoIG5ldyBzaXplLiAq
LworICAgICAgaW1nX2luZm9fbGlzdFtpXS5zaXplID0gY3VyX3NpemU7CisgICAgICBpbWdf
aW5mb19saXN0W2ldLnNsb3Rfc2l6ZSA9IHNsb3Rfc2l6ZTsKICAgICB9CiAgIC8qIFRoZSBy
ZW1haW5kZXIgb2YgdGhlIGZ1bmN0aW9uIGV4cGVjdHMgaW1nX2luZm9fc2l6ZSB0byBiZSA+
IDAuICovCiAgIGlmIChpbWdfaW5mb19zaXplID09IDApCkBAIC0xMzgwLDYgKzE0MDgsNzkg
QEAgc3RyaW5nX3RvX3Vsb25nbG9uZyAoY29uc3QgY2hhciAqc3RyaW5nKQogICByZXR1cm4g
bnVtYmVyOwogfQogCitzdGF0aWMgaW50Citjb21wYWN0b3NfZ2V0X2FsZ29yaXRobSAoY29u
c3QgY2hhciAqcGF0aG5hbWUpCit7CisgIC8qIFJlcXVpcmVzIFdpbjEwLiAqLworICBpZiAo
IUlzV2luZG93czEwT3JHcmVhdGVyICgpKQorICAgIHJldHVybiAtMTsKKworICBpbnQgZmQg
PSBvcGVuIChwYXRobmFtZSwgT19SRE9OTFkpOworICBpZiAoZmQgPT0gLTEpCisgICAgcmV0
dXJuIC0xOworCisgIHN0cnVjdCB7CisgICAgV09GX0VYVEVSTkFMX0lORk8gV29mOworICAg
IEZJTEVfUFJPVklERVJfRVhURVJOQUxfSU5GT19WMSBGaWxlUHJvdmlkZXI7CisgIH0gd2Zw
ID0geyB7MCwgMH0sIHswLCAwLCAwfSB9OworCisgIGludCByYzsKKyAgaWYgKCFEZXZpY2VJ
b0NvbnRyb2wgKChIQU5ETEUpIF9nZXRfb3NmaGFuZGxlIChmZCksCisJCQlGU0NUTF9HRVRf
RVhURVJOQUxfQkFDS0lORywgTlVMTCwgMCwKKwkJCSZ3ZnAsIHNpemVvZih3ZnApLCBOVUxM
LCBOVUxMKSkKKyAgICByYyA9IC0xOworICBlbHNlCisgICAgcmMgPSAod2ZwLldvZi5Qcm92
aWRlciA9PSBXT0ZfUFJPVklERVJfRklMRSA/CisJICB3ZnAuRmlsZVByb3ZpZGVyLkFsZ29y
aXRobSA6IC0xKTsKKworICBjbG9zZSAoZmQpOworICByZXR1cm4gcmM7Cit9CisKK3N0YXRp
YyBpbnQKK2NvbXBhY3Rvc19jb21wcmVzc19maWxlIChjb25zdCBjaGFyICpwYXRobmFtZSwg
aW50IGFsZ29yaXRobSkKK3sKKyAgLyogRG8gbm90IGFwcGx5IHVua25vd24gYWxnb3JpdGht
cy4gKi8KKyAgaWYgKCEoRklMRV9QUk9WSURFUl9DT01QUkVTU0lPTl9YUFJFU1M0SyA8PSBh
bGdvcml0aG0gJiYKKyAgICAgICAgYWxnb3JpdGhtIDw9IEZJTEVfUFJPVklERVJfQ09NUFJF
U1NJT05fWFBSRVNTMTZLKSkKKyAgICByZXR1cm4gMDsKKworICBpbnQgZmQgPSBvcGVuIChw
YXRobmFtZSwgT19SRE9OTFkpOworICBpZiAoZmQgPT0gLTEpCisgICAgcmV0dXJuIC0xOwor
ICBIQU5ETEUgaCA9IChIQU5ETEUpIF9nZXRfb3NmaGFuZGxlIChmZCk7CisKKyAgLyogT2xk
ZXIgdmVyc2lvbnMgb2YgV2luMTAgc2V0IG10aW1lIHRvIGN1cnJlbnQgdGltZS4gKi8KKyAg
RklMRVRJTUUgZnQ7CisgIEJPT0wgZnRfdmFsaWQgPSBHZXRGaWxlVGltZSAoaCwgTlVMTCwg
TlVMTCwgJmZ0KTsKKworICBzdHJ1Y3QgeworICAgIFdPRl9FWFRFUk5BTF9JTkZPIFdvZjsK
KyAgICBGSUxFX1BST1ZJREVSX0VYVEVSTkFMX0lORk9fVjEgRmlsZVByb3ZpZGVyOworICB9
IHdmcDsKKyAgd2ZwLldvZi5WZXJzaW9uID0gV09GX0NVUlJFTlRfVkVSU0lPTjsKKyAgd2Zw
LldvZi5Qcm92aWRlciA9IFdPRl9QUk9WSURFUl9GSUxFOworICB3ZnAuRmlsZVByb3ZpZGVy
LlZlcnNpb24gPSBGSUxFX1BST1ZJREVSX0NVUlJFTlRfVkVSU0lPTjsKKyAgd2ZwLkZpbGVQ
cm92aWRlci5BbGdvcml0aG0gPSBhbGdvcml0aG07CisgIHdmcC5GaWxlUHJvdmlkZXIuRmxh
Z3MgPSAwOworCisgIGludCByYzsKKyAgaWYgKCFEZXZpY2VJb0NvbnRyb2wgKGgsIEZTQ1RM
X1NFVF9FWFRFUk5BTF9CQUNLSU5HLCAmd2ZwLCBzaXplb2Yod2ZwKSwKKwkJCU5VTEwsIDAs
IE5VTEwsIE5VTEwpKQorICAgIHJjID0gKEdldExhc3RFcnJvcigpID09IEVSUk9SX0NPTVBS
RVNTSU9OX05PVF9CRU5FRklDSUFMID8gMCA6IC0xKTsKKyAgZWxzZQorICAgIHJjID0gMTsK
KworICBpZiAoZnRfdmFsaWQpCisgICAgU2V0RmlsZVRpbWUgKGgsIE5VTEwsIE5VTEwsICZm
dCk7CisKKyAgY2xvc2UgKGZkKTsKKyAgaWYgKHZlcmJvc2UpCisgICAgcHJpbnRmICgiJXM6
IENvbXBhY3QgT1MgYWxnb3JpdGhtICVkICVzXG4iLCBwYXRobmFtZSwgYWxnb3JpdGhtLAor
CSAgICAocmMgPCAwID8gIkZBSUxFRCIgOiByYyA9PSAwID8gIm5vdCBhcHBsaWVkICIgOiAi
YXBwbGllZCIpKTsKKyAgcmV0dXJuIHJjOworfQorCiB2b2lkCiB1c2FnZSAoKQogewotLSAK
Mi4zNy4xCgo=
--------------72E277F1D67F29BA8E167C2D--
