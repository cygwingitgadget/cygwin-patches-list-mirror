Return-Path: <cygwin-patches-return-2629-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 8978 invoked by alias); 11 Jul 2002 13:39:03 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 8964 invoked from network); 11 Jul 2002 13:39:02 -0000
Date: Thu, 11 Jul 2002 06:39:00 -0000
From: Pavel Tsekov <ptsekov@syntrex.com>
Reply-To: Pavel Tsekov <cygwin@cygwin.com>
Organization: Syntrex, Inc.
X-Priority: 3 (Normal)
Message-ID: <2123565024.20020711153844@syntrex.com>
To: cygwin-patches@cygwin.com
Subject: [PATCH] was [BUG]  open(): Opening with flags O_RDONLY | O_APPEND positions the file pointer at the end of the file
In-Reply-To: <20020710190459.L24137@cygbert.vinschen.de>
References: <823876622.20020710153943@syntrex.com>
 <20020710163613.GD10966@redhat.com> <20020710184830.J24137@cygbert.vinschen.de>
 <20020710165014.GB11381@redhat.com> <20020710190459.L24137@cygbert.vinschen.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----------451681B01791DF01"
X-SW-Source: 2002-q3/txt/msg00077.txt.bz2

------------451681B01791DF01
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-length: 2091

Hello Corinna,

Wednesday, July 10, 2002, 7:04:59 PM, you wrote:

>> >> >Still according to the Linux man page and SUSv2, O_APPEND should be
>> >> >taken into account only when writing to the file.
>> >> >
>> >> >Having in mind that fhandler_base::write() calls SetFilePointer
>> >> >before each write, I wonder why fhandler_disk_base::open calls
>> >> >SetFilePointer when it detects O_APPEND ?
>> >> 
>> >> Good question.
>> >
>> >What if
>> >
>> >     fd = open(O_APPEND);
>> >     pos = lseek(fd, 0, SEEK_CUR);

This will likely will fail with EINVAL.

>> >
>> >?  If open() doesn't move the pointer, `pos' is incorrectly set to 0.
>>

The sole purpose of O_APPEND is to make the write-at-end-of-file
operation atomic.

Quote from http://www.opengroup.org/onlinepubs/007908799/xsh/write.html:

"If the O_APPEND flag of the file status flags is set, the file offset
will be set to the end of the file prior to each write and no intervening
file modification operation will occur between changing the file offset
and the write operation."

>> Actually, I'd argue that, in that case, lseek should have some O_APPEND
>> logic of its own.

No, there is no need. Only write() should care about O_APPEND (and it
does).

CV> Just checked the following on Linux:

[snip source]

CV> Output:

CV> pos1: 0
CV> pos2: 382
CV> pos3: 0

CV> So open() doesn't set the pointer.  And lseek() doesn't take O_APPEND
CV> into account either.

bash-2.03$ uname -a
SunOS sparc 5.8 Generic_108528-05 sun4m sparc SUNW,SPARCstation-20
bash-2.03$ ./corinna-test
pos1: 0
pos2: 24168
pos3: 0
bash-2.03$

Cygwin with the attached patch:

$ ./corinna-test.exe
pos1: 0
pos2: 382
pos3: 0


Btw I reported this on the mc-devel list and the MC maintainer
confirmed that they call open () in a wrong way and he checked
a fix for MC:

http://mail.gnome.org/archives/mc-devel/2002-July/msg00035.html


2002-07-11  Pavel Tsekov  <ptsekov@gmx.net>

            * fhandler_disk_file.cc (fhandler_disk_file::open): Don't
            move the file pointer to the end of file if O_APPEND is
            specified in the open flags.
------------451681B01791DF01
Content-Type: application/octet-stream; name="fhandler_disk_file.cc.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="fhandler_disk_file.cc.patch"
Content-length: 586

LS0tIGZoYW5kbGVyX2Rpc2tfZmlsZS5jYwkyMDAyLTA3LTExIDE0OjU4OjM1
LjAwMDAwMDAwMCArMDIwMAorKysgZmhhbmRsZXJfZGlza19maWxlLXBhdGNo
ZWQuY2MJMjAwMi0wNy0xMSAxNToxMToyMS4wMDAwMDAwMDAgKzAyMDAKQEAg
LTM4OSw5ICszODksNiBAQCBmaGFuZGxlcl9kaXNrX2ZpbGU6Om9wZW4gKHBh
dGhfY29udiAqcmVhCiAgICAgICByZXR1cm4gMDsKICAgICB9CiAKLSAgaWYg
KGZsYWdzICYgT19BUFBFTkQpCi0gICAgU2V0RmlsZVBvaW50ZXIgKGdldF9o
YW5kbGUoKSwgMCwgMCwgRklMRV9FTkQpOwotCiAgIHNldF9zeW1saW5rX3Ag
KHJlYWxfcGF0aC0+aXNzeW1saW5rICgpKTsKICAgc2V0X2V4ZWNhYmxlX3Ag
KHJlYWxfcGF0aC0+ZXhlY19zdGF0ZSAoKSk7CiAgIHNldF9zb2NrZXRfcCAo
cmVhbF9wYXRoLT5pc3NvY2tldCAoKSk7Cg==

------------451681B01791DF01--
