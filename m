Return-Path: <cygwin-patches-return-3912-listarch-cygwin-patches=sources.redhat.com@cygwin.com>
Received: (qmail 6890 invoked by alias); 26 May 2003 18:35:33 -0000
Mailing-List: contact cygwin-patches-help@cygwin.com; run by ezmlm
Precedence: bulk
List-Subscribe: <mailto:cygwin-patches-subscribe@cygwin.com>
List-Post: <mailto:cygwin-patches@cygwin.com>
List-Archive: <http://sources.redhat.com/ml/cygwin-patches/>
List-Help: <mailto:cygwin-patches-help@cygwin.com>, <http://sources.redhat.com/ml/#faqs>
Sender: cygwin-patches-owner@cygwin.com
Received: (qmail 6878 invoked from network); 26 May 2003 18:35:33 -0000
Date: Mon, 26 May 2003 18:35:00 -0000
From: Christopher Faylor <cgf@redhat.com>
To: cygwin-patches@cygwin.com
Subject: Re: df and ls for root directories on Win9X
Message-ID: <20030526183531.GB16861@redhat.com>
Reply-To: cygwin-patches@cygwin.com
Mail-Followup-To: cygwin-patches@cygwin.com
References: <Pine.GSO.4.44.0305261207090.26092-100000@slinky.cs.nyu.edu> <Pine.GSO.4.44.0305261208430.26092-100000@slinky.cs.nyu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.44.0305261208430.26092-100000@slinky.cs.nyu.edu>
User-Agent: Mutt/1.4.1i
X-SW-Source: 2003-q2/txt/msg00139.txt.bz2

On Mon, May 26, 2003 at 12:09:01PM -0400, Igor Pechtchanski wrote:
>On Mon, 26 May 2003, Igor Pechtchanski wrote:
>
>> On Mon, 26 May 2003, Christopher Faylor wrote:
>>
>> > On Sun, May 25, 2003 at 05:54:32PM -0400, Pierre A. Humblet wrote:
>> > >At 12:48 PM 5/25/2003 -0400, Christopher Faylor wrote:
>> > >>On Sun, May 25, 2003 at 11:19:01AM +0200, Corinna Vinschen wrote:
>> > >>>On Fri, May 23, 2003 at 06:34:23PM -0400, Pierre A. Humblet wrote:
>> > >>>> 2003-05-23  Pierre Humblet  <pierre.humblet@ieee.org>
>> > >>>>
>> > >>>> 	* autoload.cc (GetDiskFreeSpaceEx): Add.
>> > >>>> 	* syscalls.cc (statfs): Call full_path.root_dir() instead of
>> > >>>> 	rootdir(full_path). Use GetDiskFreeSpaceEx when available and
>> > >>>> 	report space available in addition to free space.
>> > >>>> 	* fhandler_disk_file.cc (fhandler_disk_file::fstat_by_name):
>> > >>>> 	Do not call FindFirstFile for disk root directories.
>> > >>>
>> > >>>Applied.
>> > >>
>> > >>Um.  I am still reviewing the fstat_by_name stuff.  I will be making
>> > >>changes to this.
>> > >>
>> > >I hope you find a more elegant way to determine when it's a root directory.
>> >
>> > The previous code obviously went out of its way to handle a special
>> > case.  It was not a "bug" that it filled out an array and changed "c:\"
>> > to "c:\*".
>> >
>> > I'm away from my computer now so I can't easily check to see what you
>> > did but it looks like you made the root directory always assume today's
>> > date.
>> >
>> > I also had a problem with this:
>> > +  else if (pc->isdir () && strlen (*pc) <= strlen (pc->root_dir ()))
>> >
>> > Isn't the strlen check just a more expensive and less clear way of doing
>> > a strcmp?  i.e.,
>> >
>> > +  else if (pc->isdir () && strcmp (*pc, pc->root_dir () == 0)
>> >
>> > ?
>> >
>> > cgf
>>
>> Wouldn't you need an stricmp in that case?  Since the comparison is '<='
>
>s/stricmp/strncmp/

Yes, you'd need strncmp.

cgf
