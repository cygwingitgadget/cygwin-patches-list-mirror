Return-Path: <cygwin-patches-return-3849-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 3133 invoked by alias); 6 May 2003 14:02:44 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 3118 invoked from network); 6 May 2003 14:02:43 -0000
X-Authentication-Warning: atacama.four-d.de: mail set sender to <tpfaff@gmx.net> using -f
Message-ID: <3EB7C06F.6090709@gmx.net>
Date: Tue, 06 May 2003 14:02:00 -0000
From: Thomas Pfaff <tpfaff@gmx.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] Fix nanosleep
References: <Pine.WNT.4.44.0305061513150.1572-200000@algeria.intern.net> <20030506133450.GB3312@redhat.com>
In-Reply-To: <20030506133450.GB3312@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-SW-Source: 2003-q2/txt/msg00076.txt.bz2

Christopher Faylor wrote:
> I don't know what you're investigating but the basic problem with threads
> and signals is that you can't send a signal to a thread.  I never implemented
> that part of signal delivery.

Indeed you are right:

pthread_kill does not work as expected, instead of sending a signal to 
the specified thread all threads are woken up and the signal handler is 
not called in the context of that particular thread but in the context 
of the main thread. Since all threads are waiting for the same global 
signal_arrived and not for thread specific one it is clear that this 
does not work.

And i would like to know why every thread has its own sigaction 
structure. AFAIK signals are global in the process and not thread 
specific, and only the delivery to a thread can be blocked via 
pthread_sigmask.

Thomas
