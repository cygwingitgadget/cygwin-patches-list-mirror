Return-Path: <cygwin-patches-return-3340-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 20770 invoked by alias); 17 Dec 2002 03:51:15 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 20759 invoked from network); 17 Dec 2002 03:51:14 -0000
Date: Mon, 16 Dec 2002 19:51:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] to_slave pipe is full fix
Message-ID: <20021217035114.GA12993@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20021215144314.A28430@eris.io.com> <20021216170122.G19104@cygbert.vinschen.de> <20021216131554.D30600@hagbard.io.com> <20021216193629.GB19567@redhat.com> <20021216164704.A13198@fnord.io.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216164704.A13198@fnord.io.com>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2002-q4/txt/msg00291.txt.bz2

On Mon, Dec 16, 2002 at 04:47:04PM -0600, Steve O wrote:
>On Mon, Dec 16, 2002 at 02:36:29PM -0500, Christopher Faylor wrote:
>> On Mon, Dec 16, 2002 at 01:15:54PM -0600, Steve O wrote:
>> -             SetEvent (input_available_event);
>> -             ReleaseMutex (input_mutex);
>> -             Sleep (10);
>> -             rc = WaitForSingleObject (input_mutex, INFINITE);
>> +             puts_readahead (p, bytes_left);
>> +             ret = 0;
>> +             break;
>> 
>> Won't this introduce a spinning situation since you are no longer
>> sleeping?  
>
>The 'break;' should pop us out of the loop.  Did I miss a control
>structure?  The idea of the patch at least, was to bail out of a write
>if the pipe is full.  

Ok.  I see what you're doing now.  The puts_readahead is taking the
"overfill" to the pipe.

>> Were we really inappropriately waiting for the input_mutex in
>> this case?
>
>For the case where the application expects the write to not block,
>it seems inappropriate to wait.  For the case where the application
>does a blocking write, the WriteFile should do the blocking and, unless
>there is a problem, write all the bytes.
>
>In fact, looking at it some more, the accept_input while loop is 
>superfluous.  Sorry I missed that.  

Hmm.  You're right.  I didn't notice that.  I was still getting my
head around your changes.  I've applied your patch and reorganized it.

One more question, though.  In accept_input, shouldn't ret be set to
something besides 1 when there is an "error writing to pipe"?

I wonder if there is some other way to do this other than pulling
everything out of the read ahead buffer and then putting it back on
failure.  I guess it doesn't matter since this is an edge condition.

Hmm.  I wonder if the WaitForSingleObject (input_mutex,...) is enough to
make this code thread safe.  I always meant to revisit thread issues here
but maybe Egor helped me out with the introduction of the input_mutex.

Applied.  Thanks.

cgf
