Return-Path: <cygwin-patches-return-3547-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 23435 invoked by alias); 7 Feb 2003 21:42:11 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 23426 invoked from network); 7 Feb 2003 21:42:11 -0000
Date: Fri, 07 Feb 2003 21:42:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: cygcheck output alignment
Message-ID: <20030207214305.GA12236@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <20030207213038.GB11495@redhat.com> <Pine.GSO.4.44.0302071636470.12312-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0302071636470.12312-100000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.5.1i
X-SW-Source: 2003-q1/txt/msg00196.txt.bz2

On Fri, Feb 07, 2003 at 04:37:51PM -0500, Igor Pechtchanski wrote:
>On Fri, 7 Feb 2003, Christopher Faylor wrote:
>
>> On Fri, Feb 07, 2003 at 10:12:05PM +0100, Corinna Vinschen wrote:
>> >On Fri, Feb 07, 2003 at 02:55:11PM -0500, Igor Pechtchanski wrote:
>> >> 2003-02-07  Igor Pechtchanski <pechtcha@cs.nyu.edu>
>> >>
>> >> 	* dump_setup.cc (dump_setup): Compute the longest
>> >> 	package name and align columns properly.
>> >
>> >Applied.
>>
>> Um.  No wait.  I have a much smaller way of fixing this, I think.
>> cgf
>
>Oops, you're quite right.  For some reason I thought that the string was
>over-allocated conservatively...  Should've changed the printf, as well.

I have no idea what I was thinking when I wrote that code, actually.  Must
have been one of those late-night things.

cgf
