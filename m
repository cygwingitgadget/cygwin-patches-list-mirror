From: "Norman Vine" <nhv@cape.com>
To: "'Robert Collins'" <robert.collins@itdomain.com.au>, <cygwin@cygwin.com>
Cc: <cygwin-patches@cygwin.com>
Subject: RE: hang in pthread_cond_signal
Date: Fri, 15 Jun 2001 05:07:00 -0000
Message-id: <00a301c0f591$ad2acbe0$a300a8c0@nhv>
References: <03cb01c0f529$7b826020$0200a8c0@lifelesswks>
X-SW-Source: 2001-q2/msg00312.html

Robert Collins writes:

 "Greg Smith" <rys@epaibm.rtpnc.epa.gov> wrote:
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
>
>Thanks for the testcase Greg. The attached patch fixes your testcase.

With this patch 'some very simple' Python threading tests seem to work.
But many are still hanging.

Pthreads are still quite foreign to me but hopefully using Greg's test as
a starting point I can pinpoint the other problem areas now.

Thanks

Norman Vine
