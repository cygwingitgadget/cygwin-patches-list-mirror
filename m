Return-Path: <cygwin-patches-return-2087-listarch-cygwin-patches=sourceware.cygnus.com@cygwin.com>
Received: (qmail 13977 invoked by alias); 19 Apr 2002 14:42:28 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 13916 invoked from network); 19 Apr 2002 14:42:27 -0000
Date: Fri, 19 Apr 2002 07:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: [PATCH] dtors run twice on dll detach (update)
Message-ID: <20020419144221.GA20693@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <FC169E059D1A0442A04C40F86D9BA7600C5E79@itdomain003.itdomain.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC169E059D1A0442A04C40F86D9BA7600C5E79@itdomain003.itdomain.net.au>
User-Agent: Mutt/1.3.23.1i
X-SW-Source: 2002-q2/txt/msg00071.txt.bz2

On Fri, Apr 19, 2002 at 10:46:28PM +1000, Robert Collins wrote:
>
>
>> -----Original Message-----
>> From: Thomas Pfaff [mailto:tpfaff@gmx.net] 
>> Sent: Wednesday, April 17, 2002 5:08 PM
>
>> > Since i can not judge which function is obsolete (i guess
>> > dll_global_dtors
>> > is) i have attached a small patch that will make sure that 
>> the dtors run
>> > only once.
>
>I'm not sure that either function is obsolete - I'll let Chris/Corinna
>comment on that.. Your patch looked good, and corrected a test case I
>happened to have hanging around, so I've checked this in as an
>appropriate solution. Thanks for the patch.

If one of the functions is obsolete, it should be deleted.  That means
that the patch does *not* look good.  It needs to be reviewed.

That plus the fact that you don't have global checkin privileges for
cygwin == cgf reverts the patch.

cgf
