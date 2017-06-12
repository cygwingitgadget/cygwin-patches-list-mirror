Return-Path: <cygwin-patches-return-8777-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 62406 invoked by alias); 12 Jun 2017 20:08:10 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
Received: (qmail 62390 invoked by uid 89); 12 Jun 2017 20:08:09 -0000
Authentication-Results: sourceware.org; auth=none
X-Virus-Found: No
X-Spam-SWARE-Status: No, score=-2.2 required=5.0 tests=AWL,BAYES_00,SPF_PASS autolearn=ham version=3.3.2 spammy=utilize, cygdrive, media, cloud
X-HELO: mail.pismotechnic.com
Received: from mail.pismotechnic.com (HELO mail.pismotechnic.com) (162.218.67.164) by sourceware.org (qpsmtpd/0.93/v0.84-503-g423c35a) with ESMTP; Mon, 12 Jun 2017 20:08:08 +0000
Received: from [10.2.1.30] (c-73-240-197-175.hsd1.or.comcast.net [73.240.197.175])	by mail.pismotechnic.com (Postfix) with ESMTPSA id EDF231614BA	for <cygwin-patches@cygwin.com>; Mon, 12 Jun 2017 13:08:10 -0700 (PDT)
Message-ID: <593EF4A3.8040906@pismotec.com>
Date: Mon, 12 Jun 2017 20:08:00 -0000
From: Joe Lowe <joe@pismotec.com>
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:25.9) Gecko/20160412 FossaMail/25.2.1
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Compatibility improvement to reparse point handling, v2
References: <593B24DD.10209@pismotec.com> <20170612102705.GL13513@calimero.vinschen.de>
In-Reply-To: <20170612102705.GL13513@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------030203070102060902090802"
X-IsSubscribed: yes
X-SW-Source: 2017-q2/txt/msg00048.txt.bz2

This is a multi-part message in MIME format.
--------------030203070102060902090802
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 4219

Corinna, 

I will work through the code and apply your feedback. A few
additional comments below.

On 2017-06-12 03:27, Corinna Vinschen wrote:
> On Jun  9 15:44, Joe Lowe wrote:
>> 2nd pass at reparse point handling patch.
>> [...]
>>   static inline int
>>   readdir_check_reparse_point (POBJECT_ATTRIBUTES attr)
>>   {
>> -  DWORD ret = DT_UNKNOWN;
>> +  int ret = DT_UNKNOWN;
> 
> Given that d_type is an unsigned char type, maybe it would be better to
> change the return type of the function (and `ret') accordingly instead.

The current readdir() behavior in Cygwin for mount points is to
return the INO of the target volume root directory. This behavior
does not match Linux or MacOS. I verified with some test code,
attached, output below.

# Cygwin
joe@dev ~/code/t $ ./a.exe /cygdrive/c/Volumes
# ...
scratch
  d_type             = DT_DIR (4)
  d_ino              = 0x51F2BEF5F00CEBB0
  lstat dev/rdev/ino = 0xBC7144D6 / 0x0 / 0x51F2BEF5F00CEBB0
  stat  dev/rdev/ino = 0xBC7144D6 / 0x0 / 0x51F2BEF5F00CEBB0

# Linux
joe@omega:~/code/t $ ./a.out /media
# ...
scratch
  d_type             = DT_DIR (4)
  d_ino              = 0x480099
  lstat dev/rdev/ino = 0x2A / 0x0 / 0x2
  stat  dev/rdev/ino = 0x2A / 0x0 / 0x2

# MacOS
joe@macdev:~/code/t $ ./a.out /Volumes
# ...
scratch
  d_type             = DT_DIR (4)
  d_ino              = 0xA6F3C8
  lstat dev/rdev/ino = 0x2D000003 / 0x0 / 0x2
  stat  dev/rdev/ino = 0x2D000003 / 0x0 / 0x2

Unless there is some known case where Cygwin needs to behave
differently here than Linux and MacOS, I would like to change
readdir() to always return the INO of the reparse point.

>> @@ -2944,22 +3017,25 @@ restart:
>>   		&= ~FILE_ATTRIBUTE_DIRECTORY;
>>   	      break;
>>   	    }
>> -	  else
>> +	  else if (res == -1)
>>   	    {
>> -	      /* Volume moint point or unrecognized reparse point type.
>> +	      /* Volume moint point or unhandled reparse point.
>>   		 Make sure the open handle is not used in later stat calls.
>>   		 The handle has been opened with the FILE_OPEN_REPARSE_POINT
>>   		 flag, so it's a handle to the reparse point, not a handle
>> -		 to the volumes root dir. */
>> +		 to the reparse point target. */
>>   	      pflags &= ~PC_KEEP_HANDLE;
>> -	      /* Volume mount point:  The filesystem information for the top
>> -		 level directory should be for the volume top level directory,
>> -		 rather than for the reparse point itself.  So we fetch the
>> -		 filesystem information again, but with a NULL handle.
>> -		 This does what we want because fs_info::update opens the
>> -		 handle without FILE_OPEN_REPARSE_POINT. */
>> -	      if (res == -1)
>> -		fs.update (&upath, NULL);
>> +	      /* The filesystem information should be for the target of
>> +		 the reparse point rather than for the reparse point itself.
>> +		 So we fetch the filesystem information again, but with a
>> +		 NULL handle. This does what we want because fs_info::update
>> +		 opens the handle without FILE_OPEN_REPARSE_POINT. */
>> +	      fs.update (&upath, NULL);
>> +	    }
>> +	  else
>> +	    {
>> +	      /* Unknown reparse point type: HSM, dedup, compression, ...
>> +	         Treat as normal directory. */
>>   	    }
> 
> Nothing against reordering the code, but this drops removing
> PC_KEEP_HANDLE from pflags if res == 0, i.e., for unknown reparse
> points.

Changing the handling for unknown (3rd party) reparse tags is
not the primary point of the patch. But the fallback handling
for reparse tags should be to do what most win32 apps would do,
treat as a normal file/directory and open without the
FILE_OPEN_REPARSE_TAG flag.

If an application opens a file/directory without
FILE_OPEN_REPARSE_TAG that is a reparse point, the related
3rd party file system filter can do its job and make things
work. Example, a transparent file compression system extension
would decompress the file and remove the reparse point when
the file is opened for data access. A cloud storage file
system would retrieve the file data from a remote server and
then remove the reparse point.

In practice, I suspect that most 3rd party system extensions
that utilize custom reparse tags resort to hiding their reparse
point data from user mode entirely.


Joe L.


--------------030203070102060902090802
Content-Type: text/plain; charset=windows-1252;
 name="test.c"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.c"
Content-length: 1891

I2RlZmluZSBfTEFSR0VGSUxFX1NPVVJDRQojZGVmaW5lIF9MQVJHRUZJTEU2
NF9TT1VSQ0UKI2RlZmluZSBfRklMRV9PRkZTRVRfQklUUyA2NAojZGVmaW5l
IF9YT1BFTl9TT1VSQ0UKI2RlZmluZSBfWE9QRU5fU09VUkNFX0VYVEVOREVE
CiNkZWZpbmUgX0dOVV9TT1VSQ0UKI2RlZmluZSBfREFSV0lOX0NfU09VUkNF
CiNkZWZpbmUgX19EQVJXSU5fNjRfQklUX0lOT19UIDEKI2luY2x1ZGUgPHN0
ZGludC5oPgojaW5jbHVkZSA8c3RkaW8uaD4KI2luY2x1ZGUgPGRpcmVudC5o
PgojaW5jbHVkZSA8c3lzL3N0YXQuaD4KCmNvbnN0IGNoYXIqIGR0X25hbWUo
IHVuc2lnbmVkIGR0KQp7CiAgICNkZWZpbmUgRFRfKGYpIGNhc2UgZjogcmV0
dXJuICNmOwogICBzd2l0Y2ggKGR0KQogICB7CiAgIERUXyggRFRfQkxLICAg
ICkKICAgRFRfKCBEVF9DSFIgICAgKQogICBEVF8oIERUX0RJUiAgICApCiAg
IERUXyggRFRfRklGTyAgICkKICAgRFRfKCBEVF9MTksgICAgKQogICBEVF8o
IERUX1JFRyAgICApCiAgIERUXyggRFRfU09DSyAgICkKICAgRFRfKCBEVF9V
TktOT1dOKQogICBkZWZhdWx0OiByZXR1cm4gIkRUXz8iOwogICB9CiAgICN1
bmRlZiBEVF8KfQoKaW50IG1haW4oIGludCBhcmdjLCBjaGFyICphcmd2W10p
CnsKICAgRElSKiBkID0gb3BlbmRpciggYXJndlsxXSk7CiAgIHN0cnVjdCBk
aXJlbnQgKmRlOwogICBzdHJ1Y3Qgc3RhdCBzdDEsIHN0MjsKICAgY2hhciBu
YW1lWzEwMDBdOwogICB3aGlsZSAoKGRlID0gcmVhZGRpciggZCkpICE9IE5V
TEwpCiAgIHsKICAgICAgc3ByaW50ZiggbmFtZSwgIiVzLyVzIiwgYXJndlsx
XSwgZGUtPmRfbmFtZSk7CiAgICAgIGxzdGF0KCBuYW1lLCAmc3QxKTsKICAg
ICAgc3RhdCggbmFtZSwgJnN0Mik7CiAgICAgIHByaW50ZigKICAgICAgICAg
IiVzXG4iCiAgICAgICAgICIgIGRfdHlwZSAgICAgICAgICAgICA9ICVzICgl
dSlcbiIKICAgICAgICAgIiAgZF9pbm8gICAgICAgICAgICAgID0gMHglbGxY
XG4iCiAgICAgICAgICIgIGxzdGF0IGRldi9yZGV2L2lubyA9IDB4JWxsWCAv
IDB4JWxsWCAvIDB4JWxsWFxuIgogICAgICAgICAiICBzdGF0ICBkZXYvcmRl
di9pbm8gPSAweCVsbFggLyAweCVsbFggLyAweCVsbFhcbiIKICAgICAgICAg
LAogICAgICAgICBkZS0+ZF9uYW1lLAogICAgICAgICBkdF9uYW1lKCBkZS0+
ZF90eXBlKSwgZGUtPmRfdHlwZSwKICAgICAgICAgKHVpbnQ2NF90KWRlLT5k
X2lubywKICAgICAgICAgKHVpbnQ2NF90KXN0MS5zdF9kZXYsICh1aW50NjRf
dClzdDEuc3RfcmRldiwgKHVpbnQ2NF90KXN0MS5zdF9pbm8sCiAgICAgICAg
ICh1aW50NjRfdClzdDIuc3RfZGV2LCAodWludDY0X3Qpc3QyLnN0X3JkZXYs
ICh1aW50NjRfdClzdDIuc3RfaW5vKTsKICAgfQogICByZXR1cm4gMDsKfQo=

--------------030203070102060902090802--
