From: Christopher Faylor <cgf@redhat.com>
To: cygwin-developers@cygwin.com, cygwin-patches@cygwin.com
Subject: Re: muto object.
Date: Sun, 16 Sep 2001 20:05:00 -0000
Message-id: <20010916230553.A6882@redhat.com>
References: <EA18B9FA0FE4194AA2B4CDB91F73C0EF7A2B@itdomain002.itdomain.net.au>
X-SW-Source: 2001-q3/msg00155.html

On Mon, Sep 17, 2001 at 12:22:55PM +1000, Robert Collins wrote:
>Chris, 
>  This update to muto handles threads exiting spontaneously without
>releasing the muto properly. I think it fixes the FIXME you have in
>::release, but as I can't see how release can check for other thread
>activity, it may not have fixed that.

This isn't really an issue for the current implementation since cygwin
doesn't have any threads that die owning mutos.

But you probably know that already.  Yep.  I just read your next message
(how unusually clever of me :-)) and I see where you are going with this.

>The logic it uses is:
>if we fail to wait for the event,
>protect ourselves with recover
>check for the thread having died (should be fast - noop basically) and
>if it has aquire the muto anyway.

>There was also a typo in the destructor that could be causing memory
>leaks within process.

Yeah, that was a stupid typo wasn't it?  I think it would have caused a
handle leak not a memory leak though, right?  Luckily, in the present
situation, muto destructors are only called when the process exits (if
then) so it hasn't been an issue.

I don't think that adding a DuplicateHandle and (potentially) a
CloseHandle is soemthing I'd want to add to a muto, though.
GetCurrentThreadId is a pretty lightweight operation (I think it just
retrieves the thread id from some information on the frame pointer).
DuplicateHandle is a more heavyweight call.  I suspect that it's use
would slow down every acquire operation.  Actually, I think it would end
up being as slow as a mutex in that case.

One thing that I considered doing is registering the current stack
address and then testing to see if the aquirer's stack address was still
around after a timeout.  That obviously isn't foolproof, though.

If we wanted to generalize this then maybe pthread creation could use
a DuplicateHandle to store a thread handle in thread local storage.
Thread local storage should be pretty lightweight, too.  Then acquire
could just use the same handle every time.

Wait.  Nope.  Then you'd just have a handle leak or a handle race if
you closed the handle in pthread_destroy (or whatever it is that gets
rid of a pthread).

Anyway, if you can do timings that verify that a muto + DuplicateHandle
is faster than a mutex then I don't have any problem with your using
the algorithm in pthreads but I don't think I want to deal with the
overhead in cygwin itself.

One other issue is that I always had a problem with muto creation
because if you use normal malloc/free operations they are created prior
to fork_child.  Then they are immediately overwritten by fork/child.
At least I think that is why I used static buffers.  I don't exactly
remember anymore.

One other reason that I used this structure rather than a Win32 provided
mechanism is that the signal handler has to be able to figure out if
the thread that it is about to interrupt owns any locks and either
break the lock or loop until the lock is released.

I don't know how this plays with a real multithreaded application that
uses signals, though.  I suppose that the application would have to
make sure that it dealt with these issues.  In the cygwin DLL I have
more control so I can concentrate all of the muto wait detection in
the cygwin signal handling code itself.

I really wish that Microsoft had given us an open a thread given the
thread id function similar to OpenProcess.  I think I read somewhere
that they actually did have a reason for not doing so but it makes these
kind of situations hard.

Btw, I just checked in your destructor fix.  Thanks.

cgf
