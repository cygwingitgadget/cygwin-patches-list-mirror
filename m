Return-Path: <cygwin-patches-return-3518-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 7995 invoked by alias); 6 Feb 2003 02:28:24 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 7985 invoked from network); 6 Feb 2003 02:28:24 -0000
Date: Thu, 06 Feb 2003 02:28:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: Implementation of sched_rr_get_interval for NT systems.
Message-ID: <20030206022912.GC14293@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030206012720.V68017-100000@logout.sh.cvut.cz> <Pine.GSO.4.44.0302052042050.672-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0302052042050.672-100000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00167.txt.bz2

On Wed, Feb 05, 2003 at 08:46:12PM -0500, Igor Pechtchanski wrote:
>Vaclav,
>
>On Thu, 6 Feb 2003, Vaclav Haisman wrote:
>
>> Hi,
>> this patch implements sched_rr_get_interval for NT systems. The patch consists
>> of two parts.
>>
>> The first part is detection of NT server systems, NT servers have different
>> time quanta than workstations. Unfortunately the server detection is not
>> perfect because GetVersionEx call with OSVERSIONINFOEX structure is supported
>> only on NT 4 SP6 and newer system. Therefore new is_system wincaps flag
>> defaults to false as I assume that there are more NT workstations than servers.
>>
>> The second part is implementation of sched_rr_get_interval in sched.cc itself.
>> I have used two main sources of informations about time quanta for NT systems.
>> Those sources are two web pages:
>> http://www.microsoft.com/mspress/books/sampchap/4354c.asp
>> http://www.jsifaq.com/SUBH/tip3700/rh3795.htm
>>
>> Vaclav Haisman
>>
>> [snip ChangeLog]
>>
>> Index: cygwin/Makefile.in
>> ===================================================================
>> RCS file: /cvs/src/src/winsup/cygwin/Makefile.in,v
>> retrieving revision 1.114
>> diff -p -c -r1.114 Makefile.in
>> [snip rest of patch]
>
>I'm sure I'm nitpicking, but according to <http://cygwin.com/contrib.html>,
>diffs should be sent in unidiff format with function names (-u and -p).
>Someone please correct me if I'm wrong and this doesn't matter.  Thanks,

You're not wrong and it does matter.

I will give this function more inspection later, but for the future please
submit using the options that Igor specified.

Robert is right that you do need an assignment, too.  This is adding new
functionality.

Thanks for the patch and sorry for the rules.  :-)

cgf
