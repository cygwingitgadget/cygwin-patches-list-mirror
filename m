Return-Path: <cygwin-patches-return-4279-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 25525 invoked by alias); 30 Sep 2003 17:46:39 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 25516 invoked from network); 30 Sep 2003 17:46:38 -0000
Date: Tue, 30 Sep 2003 17:46:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: New program: cygtweak
Message-ID: <20030930174638.GA30878@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030930121609.GA2022@cygbert.vinschen.de> <Pine.GSO.4.56.0309301058290.3193@slinky.cs.nyu.edu> <20030930150956.GE20635@redhat.com> <Pine.GSO.4.56.0309301112320.3193@slinky.cs.nyu.edu> <20030930154434.GK20635@redhat.com> <Pine.GSO.4.56.0309301146400.3193@slinky.cs.nyu.edu> <20030930155833.GA29428@redhat.com> <Pine.GSO.4.56.0309301238100.3193@slinky.cs.nyu.edu> <20030930170717.GC29428@redhat.com> <Pine.GSO.4.56.0309301313410.3193@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.56.0309301313410.3193@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q3/txt/msg00295.txt.bz2

On Tue, Sep 30, 2003 at 01:20:44PM -0400, Igor Pechtchanski wrote:
>On Tue, 30 Sep 2003, Christopher Faylor wrote:
>
>> On Tue, Sep 30, 2003 at 12:40:58PM -0400, Igor Pechtchanski wrote:
>> >Close enough.
>> >So, are we jump-starting the car, or replacing the battery? ;-)
>>
>> I'm just hoping for someone to come up with a creative name for
>> the car.
>
>"cygferrari"? ;-)
>
>Seriously, though...  "cygprogopts"?  "cygoverride"?  Come to think of it,
>"cygoptions" works pretty well, especially if we plan to add other
>functionality, such as setting heap_chunk_in_mb & co.  Are there other
>(undocumented) options that need this kind of control?  Do we want them
>all controlled from one script, or from a set of scripts?  Would it make
>sense for the script to act based on a name through which it was invoked,
>as well as command line parameters (and provide symlinks with these
>names)?

I didn't think of heap_chunk_in_mb but that makes sense, too.  AFAIK,
there aren't any other options.

>Also, should this script be in /usr/sbin instead?

Logically maybe, but from the standpoint of the cygwin community trying
to use it, I don't know.

cgf
