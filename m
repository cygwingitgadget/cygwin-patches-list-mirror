Return-Path: <cygwin-patches-return-1934-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 21143 invoked by alias); 28 Feb 2002 15:18:54 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 21107 invoked from network); 28 Feb 2002 15:18:52 -0000
Date: Thu, 28 Feb 2002 07:29:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Thread.h failure on
Message-ID: <20020228151850.GD19976@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA76008AADB@itdomain003.itdomain.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA76008AADB@itdomain003.itdomain.net.au>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q1/txt/msg00291.txt.bz2

On Fri, Mar 01, 2002 at 02:05:24AM +1100, Robert Collins wrote:
>
>
>> -----Original Message-----
>> From: Christopher Faylor [mailto:cgf@redhat.com] 
>
>
>> Something else is wrong.
>
>Yah, my newlib wasn't new enough.

Hah.  Neither was mine.  I'm still getting some warnings from glob.c, though.

How about these warnings, though, Robert:

/cygnus/src/uberbaum/winsup/cygwin/shm.cc: In function `void* shmat(int, const void*, int)':
/cygnus/src/uberbaum/winsup/cygwin/shm.cc:232: warning: unused variable ` shmid_ds*shm'
/cygnus/src/uberbaum/winsup/cygwin/shm.cc: In function `int shmdt(const void*)':
/cygnus/src/uberbaum/winsup/cygwin/shm.cc:281: warning: control reaches end of non-void function

cgf
