From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH]: Check modification time on /etc/passwd and /etc/group
Date: Sun, 05 Aug 2001 18:38:00 -0000
Message-id: <20010805213817.B14865@redhat.com>
References: <996843821.24208.3.camel@lifelesswks> <20010803151518.Y23782@cygbert.vinschen.de> <996845317.24251.9.camel@lifelesswks> <20010804215935.N23782@cygbert.vinschen.de> <20010804172101.B4457@redhat.com> <20010805111251.R23782@cygbert.vinschen.de> <20010805122954.B13202@redhat.com> <20010805195959.A27538@cygbert.vinschen.de> <20010805141718.A14056@redhat.com> <20010805215652.U23782@cygbert.vinschen.de>
X-SW-Source: 2001-q3/msg00059.html

On Sun, Aug 05, 2001 at 09:56:52PM +0200, Corinna Vinschen wrote:
>On Sun, Aug 05, 2001 at 02:17:18PM -0400, Christopher Faylor wrote:
>> On Sun, Aug 05, 2001 at 07:59:59PM +0200, Corinna Vinschen wrote:
>> >On Sun, Aug 05, 2001 at 12:29:54PM -0400, Christopher Faylor wrote:
>> >>So, is it worthwhile to make this change?  We might be adding some
>> >>overhead for an infrequent case.
>> >
>> >Hmm, that's a good question.  I would like to see that handled
>> >correctly w/o having to stop and start my services again.  And it's
>> >actually no infrequent case for sysadmins to add users.
>> 
>> I wasn't talking about your change to automatically update /etc/passwd.
>> I think that is valuable.
>> 
>> I was more concerned about spending time to optimize /etc/passwd accesses
>> not actually optimizing anything.
>
>So you would prefer something silmilar to my first solution which
>actually calls `stat()'?

No.  Your last solution was fine.  Calculating the windows path once is,
IMO, fine, too.

I was referring to the goal of either putting the passwd info in the cygheap
or avoiding the use of fopen/fgets/whatever.

cgf
