From: Chris Faylor <cgf@cygnus.com>
To: cygwin-patches@sourceware.cygnus.com
Subject: Re: preliminary patch for incorporating internationalizing facilities
Date: Wed, 28 Jun 2000 14:14:00 -0000
Message-id: <20000628171354.A31411@cygnus.com>
References: <s1sr99ho8cf.fsf@jaist.ac.jp> <395A676F.F78E67A6@cygnus.com>
X-SW-Source: 2000-q2/msg00117.html

On Wed, Jun 28, 2000 at 11:00:31PM +0200, Corinna Vinschen wrote:
>Kazuhiro Fujieda wrote:
>> diff -u -p -r1.34 path.cc
>> --- path.cc     2000/06/16 23:39:02     1.34
>> +++ path.cc     2000/06/28 17:13:14
>> [...]
>> @@ -1566,7 +1566,7 @@ sort_by_native_name (const void *a, cons
>> 
>>    /* The two paths were the same length, so just determine normal
>>       lexical sorted order. */
>> -  res = strcasecmp (ap->posix_path, bp->posix_path);
>> +  res = strcmp (ap->native_path, bp->native_path);
>
>I don't understand that part. It seems to be a clear mistake that
>the posix paths are compared but why are you using `strcmp' now?
>What's about the case?

I didn't understand this either.  I don't understand the reason
for using strtol rather than atoi either.

cgf
