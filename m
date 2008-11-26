Return-Path: <cygwin-patches-return-6358-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 21806 invoked by alias); 26 Nov 2008 23:13:07 -0000
Received: (qmail 21791 invoked by uid 22791); 26 Nov 2008 23:13:07 -0000
X-Spam-Check-By: sourceware.org
Received: from mailout10.t-online.de (HELO mailout10.t-online.de) (194.25.134.21)     by sourceware.org (qpsmtpd/0.43rc1) with ESMTP; Wed, 26 Nov 2008 23:12:25 +0000
Received: from fwd01.aul.t-online.de  	by mailout10.sul.t-online.de with smtp  	id 1L5TYU-0005AW-03; Thu, 27 Nov 2008 00:12:22 +0100
Received: from [10.3.2.2] (XLnhBUZvwhbiuNA76EOZBO+FA0yUM6BqXBJevTXeiT+sy0AH80ZqaD+hJqc3A74gvU@[217.235.226.72]) by fwd01.aul.t-online.de 	with esmtp id 1L5TYO-0g3Njs0; Thu, 27 Nov 2008 00:12:16 +0100
Message-ID: <492DD7D0.6050001@t-online.de>
Date: Wed, 26 Nov 2008 23:13:00 -0000
From: Christian Franke <Christian.Franke@t-online.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.16) Gecko/20080702 SeaMonkey/1.1.11
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [Patch] Add dirent.d_type support to Cygwin 1.7 ?
References: <492DBE7E.7020100@t-online.de> <20081126221012.GA15970@ednor.casa.cgf.cx>
In-Reply-To: <20081126221012.GA15970@ednor.casa.cgf.cx>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: XLnhBUZvwhbiuNA76EOZBO+FA0yUM6BqXBJevTXeiT+sy0AH80ZqaD+hJqc3A74gvU
X-TOI-MSGID: b618bc01-b174-4dfc-a0ec-3aaf96ff5e68
X-IsSubscribed: yes
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Id: <cygwin-patches.cygwin.com>
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sourceware.org/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sourceware.org/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
X-SW-Source: 2008-q4/txt/msg00002.txt.bz2

Christopher Faylor wrote:
> On Wed, Nov 26, 2008 at 10:24:14PM +0100, Christian Franke wrote:
>   
> ...
>>   de->d_ino = 0;
>> +#ifdef _DIRENT_HAVE_D_TYPE
>> +  de->d_type = DT_UNKNOWN;
>> +#endif
>> +  memset (&de->__d_unused1, 0, sizeof (de->__d_unused1));
>> +
>>     
>
> I don't see a need for a conditional here.  If this is added Cygwin
> supports d_type.
>
>   

OK.


> ...
>>
>> +#ifdef _DIRENT_HAVE_D_TYPE
>> +  /* Set d_type if type can be determined from file attributes.
>> +     FILE_ATTRIBUTE_SYSTEM ommitted to leave DT_UNKNOWN for old symlinks.
>> +     For new symlinks, d_type will be reset to DT_UNKNOWN below.  */
>> +  if (attr &&
>> +      !(attr & ~( FILE_ATTRIBUTE_NORMAL
>> +                | FILE_ATTRIBUTE_READONLY
>> +                | FILE_ATTRIBUTE_ARCHIVE
>> +                | FILE_ATTRIBUTE_HIDDEN
>> +                | FILE_ATTRIBUTE_COMPRESSED
>> +                | FILE_ATTRIBUTE_ENCRYPTED
>> +                | FILE_ATTRIBUTE_SPARSE_FILE
>> +                | FILE_ATTRIBUTE_NOT_CONTENT_INDEXED
>> +                | FILE_ATTRIBUTE_DIRECTORY)))
>> +    {
>> +      if (attr & FILE_ATTRIBUTE_DIRECTORY)
>> +        de->d_type = DT_DIR;
>> +      else
>> +        de->d_type = DT_REG;
>> +    }
>> +#endif
>> +
>>     
>
> This is just checking all of the Windows types but none of the Cygwin
> types.  Shouldn't it be checking for devices, fifos, and symlinks?
>   

D_type should only be set to the actual type if this info is available 
at low cost. This is the case for files/dirs, but not for e.g. Cygwin 
symlinks. Therefore, DT_UNKNOWN is returned instead and the app must 
call stat() if this info is required.

To speed up typical 'find' and 'ls -R' operations, it is IMO enough to 
handle the most common filesystem types (for now).


>> diff --git a/winsup/cygwin/include/sys/dirent.h b/winsup/cygwin/include/sys/dirent.h
>> index 41bfcc1..d782e58 100644
>> --- a/winsup/cygwin/include/sys/dirent.h
>> +++ b/winsup/cygwin/include/sys/dirent.h
>> @@ -18,11 +18,17 @@
>>
>> #pragma pack(push,4)
>> #if defined(__INSIDE_CYGWIN__) || defined (__CYGWIN_USE_BIG_TYPES__)
>> +#define _DIRENT_HAVE_D_TYPE
>> struct dirent
>> {
>>   long __d_version;			/* Used internally */
>>   __ino64_t d_ino;
>> +#ifdef _DIRENT_HAVE_D_TYPE
>> +  unsigned char d_type;
>> +  unsigned char __d_unused1[3];
>> +#else
>>   __uint32_t __d_unused1;
>> +#endif
>>     
>
> There is even less reason to define and use _DIRENT_HAVE_D_TYPE here.
>
> Why not just define d_type as a __uint32_t?  We don't need to keep the
> __d_unused1 around.
>
>   

_DIRENT_HAVE_D_TYPE and 'unsigned char d_type' are the same under Linux:
http://www.kernel.org/doc/man-pages/online/pages/man3/readdir.3.html


Christian
