Return-Path: <cygwin-patches-return-4337-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 4339 invoked by alias); 3 Nov 2003 07:36:13 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 4303 invoked from network); 3 Nov 2003 07:36:12 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3FA6055D.1070407@gmx.net>
Date: Mon, 03 Nov 2003 07:36:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031013 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix debugger attach for threads
References: <3FA2D012.5060607@gmx.net> <20031031212316.GA8668@redhat.com>
In-Reply-To: <20031031212316.GA8668@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q4/txt/msg00056.txt.bz2

Christopher Faylor wrote:
> On Fri, Oct 31, 2003 at 10:11:46PM +0100, Thomas Pfaff wrote:
> 
>>This patch allows a debugger to attach when an exception occurs in a 
>>thread other than the mainthread.
>>
>>I am not happy about the wait in handle_exceptions, but it works on my 
>>machine. I think that a waitloop until the debugger is attached is 
>>cleaner, but there must be a reason why the debbugging loop is 
>>implemented this way.
> 
> 
> The intent is for an attached debugger to immediately see the location
> that died.  If you loop in the try_to_debug code then it is a pain to
> figure out exactly where the exception occurred.
> 
> I don't understand why this code is needed.  Why do threads need to
> be suspended and resumed specially?
> 

Because otherwise the debugger does not get enough CPU time until the 
debugging counter exceeds the limit and the process terminates before 
the debugger is attached.

If you think that suspending and resuming threads is a dangerous thing 
than i would at least change the condition to

   if (debugging && !being_debugged ())
     {
       /*
        * Give debugger a chance to attach
        */
       LONG prio = GetThreadPriority (GetCurrentThread ());
       SetThreadPriority (GetCurrentThread (), THREAD_PRIORITY_IDLE);
       Sleep (0);
       SetThreadPriority (GetCurrentThread (), prio);
       return 0;
     }

to loop until the debugger is attached.

Thomas
