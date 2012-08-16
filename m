Return-Path: <cygwin-patches-return-7701-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 13276 invoked by alias); 16 Aug 2012 12:12:16 -0000
Received: (qmail 13255 invoked by uid 22791); 16 Aug 2012 12:12:14 -0000
X-SWARE-Spam-Status: No, hits=-3.4 required=5.0	tests=BAYES_00,KHOP_THREADED,RCVD_IN_DNSWL_NONE,RCVD_IN_HOSTKARMA_YE,SPF_HELO_PASS
X-Spam-Check-By: sourceware.org
Received: from moutng.kundenserver.de (HELO moutng.kundenserver.de) (212.227.17.9)    by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Thu, 16 Aug 2012 12:12:01 +0000
Received: from [10.255.170.24] ([62.159.77.186])	by mrelayeu.kundenserver.de (node=mrbap4) with ESMTP (Nemesis)	id 0LZfCu-1TOv9X3IlQ-00lUYJ; Thu, 16 Aug 2012 14:11:59 +0200
Message-ID: <502CE384.8050709@towo.net>
Date: Thu, 16 Aug 2012 12:12:00 -0000
From: Thomas Wolff <towo@towo.net>
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: /dev/clipboard pasting with small read() buffer
References: <502ABB77.2080502@towo.net> <20120816093334.GB20051@calimero.vinschen.de>
In-Reply-To: <20120816093334.GB20051@calimero.vinschen.de>
Content-Type: multipart/mixed; boundary="------------060802020009000007010407"
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
X-SW-Source: 2012-q3/txt/msg00022.txt.bz2

This is a multi-part message in MIME format.
--------------060802020009000007010407
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-length: 3110

Hi Corinna,

On 16.08.2012 11:33, Corinna Vinschen wrote:
> Hi Thomas,
>
> thanks for the patch.   I have a few minor nits:
>
> On Aug 14 22:56, Thomas Wolff wrote:
>> --- sav/fhandler_clipboard.cc	2012-07-08 02:36:47.000000000 +0200
>> +++ ./fhandler_clipboard.cc	2012-08-14 18:25:14.903255600 +0200
>> ...
> See (*) below.
>
>> ...
>> +	  char * _ptr = (char *) ptr;
>> +	  size_t _len = len;
> I would prefer to have local variable names here which don't just
> differ by a leading underscore.  It's a bit confusing.  What about,
> say, tmp_ptr/tmp_len, or use_ptr/use_len or something like that?
tmp_OK

>> +	  char cprabuf [8 + 1];	/* need this length for surrogates */
>> +	  if (len < 8)
>> +	    {
>> +	      _ptr = cprabuf;
>> +	      _len = 8;
>> +	    }
> 8?  Why 8?  The size appears to be rather artificial.  The code should
> use MB_CUR_MAX instead.
MB_CUR_MAX does not work because its value is 1 at this point
(after adding #include <stdlib.h> anyway).
I guess that's because it changes its value after setlocale().
To avoid interference with application invocation of setlocale(),
however, it must not be called here (with which parameters anyway...).

So the maximum length of all encodings needs to be used here which
would be 4 (UTF-8, EUC-TW, GB 18030) if there were not the surrogate
pairs of UTF-16.
Since a single surrogate can be encoded with 3 UTF-8 bytes, I tried
6 to host two of them but it didn't work. So I increased to 8
which seemed to work; I may have been mislead, however, since another
test case now shows that the patch does not always work with surrogates.
It only works if the non-BMP character (the surrogate pair) does not
extend over the border of two blocks of multiple size of these internal
small buffers..., meaning e.g. if the buffer size is 8 and a non-BMP
character starts at byte 7 of the clipboard, it will fail (only the
second surrogate will be pasted).
I don't know what to do about this right now; maybe some tweak
of sys_wcstombs would help, it should perhaps convert to non-surrogate
UTF-8 first before any other buffering considerations.

--- Actually, having written all this, I just notice that surrogate pairs
don't work with the "old" code either (using a larger caller buffer)
whenever the character is not block-aligned as described above.
So maybe for the current patch, 4 would indeed be good, while the
surrogate problem should be fixed in sys_wcstombs.
Update attached.

>> ...
>> +	      /* If using read-ahead buffer, copy to class read-ahead buffer
>> +	         and deliver first byte. */
>> +	      if (_ptr == cprabuf)
>> +		{
>> +		  puts_readahead (cprabuf, ret);
>> +		  * (char *) ptr = get_readahead ();
>> +		  ret = 1;
> (*) Ok, that works, but wouldn't it be more efficient to do that in
> a tiny loop along the lines of
>
> 		  int x;
> 		  ret = 0;
>                    while (ret < len && (x = get_readahead ()) >= 0)
> 		    ptr++ = x;
> 		    ret++;
>
> ?
I can add it if you prefer; I just didn't think it's worth the effort 
and concerning efficiency, after that prior trial-and-error 
count-down-loop...

------
Thomas

--------------060802020009000007010407
Content-Type: text/plain; charset=windows-1252;
 name="clipboard-small-buffer.patch.2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="clipboard-small-buffer.patch.2"
Content-length: 0


--------------060802020009000007010407--
