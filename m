From: Christopher Faylor <cgf@redhat.com>
To: cygwin@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: hang in pthread_cond_signal
Date: Thu, 14 Jun 2001 16:53:00 -0000
Message-id: <20010614195350.D13587@redhat.com>
References: <3B290FE5.22678B61@trex.rtpnc.epa.gov> <03cb01c0f529$7b826020$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00306.html

On Fri, Jun 15, 2001 at 09:26:46AM +1000, Robert Collins wrote:
>
>----- Original Message -----
>From: "Greg Smith" <rys@epaibm.rtpnc.epa.gov>
>To: <cygwin@cygwin.com>
>Sent: Friday, June 15, 2001 5:26 AM
>Subject: hang in pthread_cond_signal
>
>
>> I am using the cygwin-src snapshot from June 10.
>>
>> Seems pthread_cond_signal can hang while another thread
>> is waiting on the condition AND a pthread_cond_signal
>> has been previously issued when no one was waiting on the
>> condition.  Below is a testcase that illustrates the
>> problem:
>>
>> Thanks,
>>
>> Greg
>>
>
>Thanks for the testcase Greg. The attached patch fixes your testcase.
>
>Rob
>
>Changelog:
>
>
>Fri June 15 09:25:00  Robert Collins <rbtcollins@hotmail.com>
>
>	* thread.cc (pthread_cond::Signal): Release the condition access
>	variable correctly.

Patch applied.

cgf
